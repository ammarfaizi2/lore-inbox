Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSFRBAK>; Mon, 17 Jun 2002 21:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSFRBAI>; Mon, 17 Jun 2002 21:00:08 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:51401 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317258AbSFRA7F>;
	Mon, 17 Jun 2002 20:59:05 -0400
Date: Tue, 18 Jun 2002 02:59:06 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206180059.CAA11576@harpo.it.uu.se>
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.19-pre10] fs/ufs/super.c:ufs_read_super() fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are three obvious errors:
1. When checking minimum fragment size the code references the
   wrong variable (block size).
2. Ditto when checking maximum fragment size.
3. (Minor) If the block size is too small, the wrong variable
   (fragment size) is printed in the error message.

The first two patches are already in the current 2.5 code.

/Mikael

--- linux-2.4.19-pre10/fs/ufs/super.c.~1~	Thu Jun  6 14:40:21 2002
+++ linux-2.4.19-pre10/fs/ufs/super.c	Thu Jun  6 14:50:17 2002
@@ -662,12 +662,12 @@
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize < 512) {
+	if (uspi->s_fsize < 512) {
 		printk(KERN_ERR "ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize > 4096) {
+	if (uspi->s_fsize > 4096) {
 		printk(KERN_ERR "ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
@@ -679,7 +679,7 @@
 	}
 	if (uspi->s_bsize < 4096) {
 		printk(KERN_ERR "ufs_read_super: block size %u is too small\n",
-			uspi->s_fsize);
+			uspi->s_bsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {
