Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVJHPpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVJHPpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVJHPpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:45:36 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:30989 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S932143AbVJHPpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:45:35 -0400
From: Felix Oxley <lkml@oxley.org>
To: jffs-dev@axis.com
Subject: [PATCH] intrep.c char -> unsigned char
Date: Sat, 8 Oct 2005 16:45:20 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Sm+RDiAfqN6afPd"
Message-Id: <200510081645.22440.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Sm+RDiAfqN6afPd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,
IANAKH but I believe you need the following patch.
As suggested on the Kernel Janitors To Do list, I have been searching for 
chars > 127.
I only found this one!

If the fix is correct please, ACK and push upstream.

regards,
Felix

--- fs/jffs/intrep.c.orig	2005-10-08 15:47:13.000000000 +0100
+++ fs/jffs/intrep.c	2005-10-08 16:13:16.000000000 +0100
@@ -1969,7 +1969,7 @@ retry:
 		iovec_cnt++;
 
 		if (JFFS_GET_PAD_BYTES(raw_inode->nsize)) {
-			static char allff[3]={255,255,255};
+			static unsigned char allff[3]={255,255,255};
 			/* Add some extra padding if necessary */
 			node_iovec[iovec_cnt].iov_base = allff;
 			node_iovec[iovec_cnt].iov_len =

Signed-off-by: Felix Oxley <lkml@oxley.org>

--Boundary-00=_Sm+RDiAfqN6afPd
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-intrep.c-2.6.13"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-intrep.c-2.6.13"

--- fs/jffs/intrep.c.orig	2005-10-08 15:47:13.000000000 +0100
+++ fs/jffs/intrep.c	2005-10-08 16:13:16.000000000 +0100
@@ -1969,7 +1969,7 @@ retry:
 		iovec_cnt++;
 
 		if (JFFS_GET_PAD_BYTES(raw_inode->nsize)) {
-			static char allff[3]={255,255,255};
+			static unsigned char allff[3]={255,255,255};
 			/* Add some extra padding if necessary */
 			node_iovec[iovec_cnt].iov_base = allff;
 			node_iovec[iovec_cnt].iov_len =

--Boundary-00=_Sm+RDiAfqN6afPd--
