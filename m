Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264511AbUDVSFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbUDVSFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUDVSFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:05:33 -0400
Received: from smtp.wp.pl ([212.77.101.160]:38577 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264511AbUDVSF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:05:29 -0400
Date: Thu, 22 Apr 2004 20:05:29 +0200
From: Marek Szuba <scriptkiddie@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] isofs "default NLS charset not used" fix
Message-Id: <20040422200529.6a3c592c.scriptkiddie@wp.pl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__22_Apr_2004_20_05_29_+0200_FL.svpt2msJNFMwT"
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__22_Apr_2004_20_05_29_+0200_FL.svpt2msJNFMwT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello again,

Since nobody has made any suggestions about the behaviour mentioned
above being a feature and not a bug, I took a liberty to fix it - if
changing one constant in one line of C code can be called "fixing".

The attached diff has been made against vanilla 2.6.5 kernel sources. A
bit of context changing will be in order for it to apply to 2.4.26
because of filesystem options structure type having changed; I haven't
looked at 2.2.

Regards,
-- 
MS

--Multipart=_Thu__22_Apr_2004_20_05_29_+0200_FL.svpt2msJNFMwT
Content-Type: text/plain;
 name="isofs-nls-2.6.patch"
Content-Disposition: attachment;
 filename="isofs-nls-2.6.patch"
Content-Transfer-Encoding: quoted-printable

--- linux/fs/isofs/inode.c	Fri Jan  9 11:58:50 2004
+++ linux/fs/isofs/inode-defaultnls.c	Thu Apr 22 18:47:12 2004
@@ -794,7 +794,7 @@
=20
 #ifdef CONFIG_JOLIET
 	if (joliet_level && opt.utf8 =3D=3D 0) {
-		char * p =3D opt.iocharset ? opt.iocharset : "iso8859-1";
+		char * p =3D opt.iocharset ? opt.iocharset : CONFIG_NLS_DEFAULT;
 		sbi->s_nls_iocharset =3D load_nls(p);
 		if (! sbi->s_nls_iocharset) {
 			/* Fail only if explicit charset specified */

--Multipart=_Thu__22_Apr_2004_20_05_29_+0200_FL.svpt2msJNFMwT--
