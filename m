Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUKFF3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUKFF3m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 00:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUKFF3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 00:29:41 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:31186 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261321AbUKFF3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 00:29:39 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: [patch] bttv: MODULE_PARM() broke TV
Date: Sat, 6 Nov 2004 14:32:17 +0900
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411061432.17861.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Using both module_param() and MODULE_PARM() in one module broke my
bttv options.

	bttv: Unknown parameter `card'
	bttv: Ignoring new-style parameters in presence of obsolete ones
	...

This patch fixes it, and now I'm watching TV as usual fine.

--- 2.6-mm/drivers/media/video/bttv-cards.c.orig	2004-11-06 13:37:46.000000000 +0900
+++ 2.6-mm/drivers/media/video/bttv-cards.c	2004-11-06 13:42:09.000000000 +0900
@@ -2973,7 +2973,7 @@ static int __devinit pvr_altera_load(str
 /* old 2.4.x way -- via soundcore's mod_firmware_load */
 
 static char *firm_altera = "/usr/lib/video4linux/hcwamc.rbf";
-MODULE_PARM(firm_altera,"s");
+module_param(firm_altera, charp, 0);
 MODULE_PARM_DESC(firm_altera,"WinTV/PVR firmware "
 		 "(driver CD => unzip pvr45xxx.exe => hcwamc.rbf)");
 
--- 2.6-mm/drivers/media/video/bttv-i2c.c.orig	2004-11-06 13:37:53.000000000 +0900
+++ 2.6-mm/drivers/media/video/bttv-i2c.c	2004-11-06 13:53:17.000000000 +0900
@@ -47,9 +47,9 @@ static int detach_inform(struct i2c_clie
 static int i2c_debug = 0;
 static int i2c_hw = 0;
 static int i2c_scan = 0;
-MODULE_PARM(i2c_debug,"i");
-MODULE_PARM(i2c_hw,"i");
-MODULE_PARM(i2c_scan,"i");
+module_param(i2c_debug, int, 0);
+module_param(i2c_hw, int, 0);
+module_param(i2c_scan, int, 0);
 MODULE_PARM_DESC(i2c_scan,"scan i2c bus at insmod time");
 
 /* ----------------------------------------------------------------------- */


