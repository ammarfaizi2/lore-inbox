Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbWJJWlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbWJJWlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbWJJWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62594 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030609AbWJJWiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:46 -0400
To: torvalds@osdl.org
Subject: [PATCH 12/16] isofs endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQFJ-00005C-UR@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:38:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 14:33:09 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/isofs/joliet.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
index 81a90e1..fb8fe7a 100644
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -14,9 +14,9 @@ #include "isofs.h"
  * Convert Unicode 16 to UTF-8 or ASCII.
  */
 static int
-uni16_to_x8(unsigned char *ascii, u16 *uni, int len, struct nls_table *nls)
+uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
 {
-	wchar_t *ip, ch;
+	__be16 *ip, ch;
 	unsigned char *op;
 
 	ip = uni;
@@ -24,8 +24,8 @@ uni16_to_x8(unsigned char *ascii, u16 *u
 
 	while ((ch = get_unaligned(ip)) && len) {
 		int llen;
-		ch = be16_to_cpu(ch);
-		if ((llen = nls->uni2char(ch, op, NLS_MAX_CHARSET_SIZE)) > 0)
+		llen = nls->uni2char(be16_to_cpu(ch), op, NLS_MAX_CHARSET_SIZE);
+		if (llen > 0)
 			op += llen;
 		else
 			*op++ = '?';
@@ -82,7 +82,7 @@ get_joliet_filename(struct iso_directory
 		len = wcsntombs_be(outname, de->name,
 				   de->name_len[0] >> 1, PAGE_SIZE);
 	} else {
-		len = uni16_to_x8(outname, (u16 *) de->name,
+		len = uni16_to_x8(outname, (__be16 *) de->name,
 				  de->name_len[0] >> 1, nls);
 	}
 	if ((len > 2) && (outname[len-2] == ';') && (outname[len-1] == '1')) {
-- 
1.4.2.GIT


