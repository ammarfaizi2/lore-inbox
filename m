Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTBQWlq>; Mon, 17 Feb 2003 17:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTBQWlk>; Mon, 17 Feb 2003 17:41:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267622AbTBQWkR>;
	Mon, 17 Feb 2003 17:40:17 -0500
Subject: [PATCH] Fix warnings for NTFS 2.5.61
From: Stephen Hemminger <shemminger@osdl.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-ntfs-dev@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045522197.12949.94.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 14:49:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of the following warnings.

fs/ntfs/attrib.c: In function `find_attr':
fs/ntfs/attrib.c:1187: warning: duplicate `const'
fs/ntfs/unistr.c: In function `ntfs_collate_names':
fs/ntfs/unistr.c:102: warning: duplicate `const'
fs/ntfs/unistr.c:102: warning: duplicate `const'

diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Mon Feb 17 14:16:15 2003
+++ b/fs/ntfs/attrib.c	Mon Feb 17 14:16:15 2003
@@ -1183,7 +1183,8 @@
 			register int rc;
 			
 			rc = memcmp(val, (u8*)a + le16_to_cpu(
-					a->_ARA(value_offset)), min(val_len,
+					a->_ARA(value_offset)), 
+				    	min_t(const u32, val_len,
 					le32_to_cpu(a->_ARA(value_length))));
 			/*
 			 * If @val collates before the current attribute's
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	Mon Feb 17 14:16:15 2003
+++ b/fs/ntfs/unistr.c	Mon Feb 17 14:16:15 2003
@@ -96,10 +96,10 @@
 		const int err_val, const IGNORE_CASE_BOOL ic,
 		const uchar_t *upcase, const u32 upcase_len)
 {
-	u32 cnt, min_len;
+	u32 cnt;
+	const u32 min_len = min_t(const u32, name1_len, name2_len);
 	uchar_t c1, c2;
 
-	min_len = min(name1_len, name2_len);
 	for (cnt = 0; cnt < min_len; ++cnt) {
 		c1 = le16_to_cpu(*name1++);
 		c2 = le16_to_cpu(*name2++);



