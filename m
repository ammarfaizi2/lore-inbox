Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVBRM2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVBRM2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBRM2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:28:42 -0500
Received: from mx2.mail.ru ([194.67.23.122]:60452 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261351AbVBRM2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:28:22 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] __be'ify include/linux/nbd.h
Date: Fri, 18 Feb 2005 15:28:16 +0200
User-Agent: KMail/1.6.2
Cc: Paul Clements <Paul.Clements@steeleye.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502181528.16976.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings in drivers/block/nbd.c

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-warnings/include/linux/nbd.h
===================================================================
--- linux-warnings/include/linux/nbd.h	(revision 22)
+++ linux-warnings/include/linux/nbd.h	(revision 23)
@@ -68,11 +68,11 @@
  * server. All data are in network byte order.
  */
 struct nbd_request {
-	u32 magic;
-	u32 type;	/* == READ || == WRITE 	*/
+	__be32 magic;
+	__be32 type;	/* == READ || == WRITE 	*/
 	char handle[8];
-	u64 from;
-	u32 len;
+	__be64 from;
+	__be32 len;
 }
 #ifdef __GNUC__
 	__attribute__ ((packed))
@@ -84,8 +84,8 @@
  * it has completed an I/O request (or an error occurs).
  */
 struct nbd_reply {
-	u32 magic;
-	u32 error;		/* 0 = ok, else error	*/
+	__be32 magic;
+	__be32 error;		/* 0 = ok, else error	*/
 	char handle[8];		/* handle you got from request	*/
 };
 #endif
