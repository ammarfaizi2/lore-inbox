Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWIQBrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWIQBrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWIQBrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:47:36 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:41862 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932139AbWIQBrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 11] MBCS: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 115dd6f4c0504afa5662b8624b1c84b2c96e9176
Message-Id: <115dd6f4c0504afa5662.1158455367@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:27 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MBCS: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r abfba7cd6289 -r 115dd6f4c050 drivers/char/mbcs.c
--- a/drivers/char/mbcs.c	Sun Sep 17 02:54:32 2006 +0700
+++ b/drivers/char/mbcs.c	Sat Sep 16 21:00:45 2006 -0400
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mm.h>
+#include <linux/fs.h>
 #include <linux/uio.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -447,15 +448,15 @@ loff_t mbcs_sram_llseek(struct file * fi
 	loff_t newpos;
 
 	switch (whence) {
-	case 0:		/* SEEK_SET */
+	case SEEK_SET:
 		newpos = off;
 		break;
 
-	case 1:		/* SEEK_CUR */
+	case SEEK_CUR:
 		newpos = filp->f_pos + off;
 		break;
 
-	case 2:		/* SEEK_END */
+	case SEEK_END:
 		newpos = MBCS_SRAM_SIZE + off;
 		break;
 


