Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263741AbTCUSiM>; Fri, 21 Mar 2003 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCUShT>; Fri, 21 Mar 2003 13:37:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7300
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263744AbTCUSgV>; Fri, 21 Mar 2003 13:36:21 -0500
Date: Fri, 21 Mar 2003 19:51:36 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211951.h2LJpaiQ026073@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix fat handling of some weirder variants
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/fat/inode.c linux-2.5.65-ac2/fs/fat/inode.c
--- linux-2.5.65/fs/fat/inode.c	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.65-ac2/fs/fat/inode.c	2003-03-06 23:43:48.000000000 +0000
@@ -939,7 +939,8 @@
 		error = first;
 		goto out_fail;
 	}
-	if (FAT_FIRST_ENT(sb, media) != first) {
+	if (FAT_FIRST_ENT(sb, media) != first
+	    && (media != 0xf8 || FAT_FIRST_ENT(sb, 0xfe) != first)) {
 		if (!silent) {
 			printk(KERN_ERR "FAT: invalid first entry of FAT "
 			       "(0x%x != 0x%x)\n",
