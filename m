Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTFVIpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFVIpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:45:42 -0400
Received: from smtp03.web.de ([217.72.192.158]:27427 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264083AbTFVIpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:45:41 -0400
Date: Sun, 22 Jun 2003 11:19:11 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [CIFS] Fix compile warning for fs/cifs/cifsfs.c
Message-Id: <20030622111911.33c1d041.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes a compile warning about incompatible types in
fs/cifs/cifsfs.c in cifs_statfs(). This function is called with
a pointer to a struct kstatfs, so let's propagate this type into
the helper function.

René



diff -u ./fs/cifs/cifsproto.h~ ./fs/cifs/cifsproto.h
--- ./fs/cifs/cifsproto.h~	2003-06-22 10:04:00.000000000 +0200
+++ ./fs/cifs/cifsproto.h	2003-06-22 10:52:06.000000000 +0200
@@ -137,7 +137,7 @@
 			const char *old_path, const struct nls_table *nls_codepage, 
 			unsigned int *pnum_referrals, unsigned char ** preferrals);
 extern int CIFSSMBQFSInfo(const int xid, struct cifsTconInfo *tcon,
-			struct statfs *FSData,
+			struct kstatfs *FSData,
 			const struct nls_table *nls_codepage);
 extern int CIFSSMBQFSAttributeInfo(const int xid,
 			struct cifsTconInfo *tcon,
diff -u ./fs/cifs/cifssmb.c~ ./fs/cifs/cifssmb.c
--- ./fs/cifs/cifssmb.c~	2003-06-14 21:18:01.000000000 +0200
+++ ./fs/cifs/cifssmb.c	2003-06-22 10:51:30.000000000 +0200
@@ -1782,7 +1782,7 @@
 
 int
 CIFSSMBQFSInfo(const int xid, struct cifsTconInfo *tcon,
-	       struct statfs *FSData, const struct nls_table *nls_codepage)
+	       struct kstatfs *FSData, const struct nls_table *nls_codepage)
 {
 /* level 0x103 SMB_QUERY_FILE_SYSTEM_INFO */
 	TRANSACTION2_QFSI_REQ *pSMB = NULL;


