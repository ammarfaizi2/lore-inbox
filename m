Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWJHXQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWJHXQz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWJHXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58129 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932109AbWJHXQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:43 -0400
Date: Mon, 9 Oct 2006 01:16:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: [2.6 patch] SSFDC must depend on BLOCK
Message-ID: <20061008231638.GS6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with 
CONFIG_SSFDC=m, CONFIG_BLOCK=n:

<--  snip  -->

...
  CC [M]  drivers/mtd/mtd_blkdevs.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/mtd/mtd_blkdevs.c:40: warning: ‘struct request’ declared inside parameter list
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/mtd/mtd_blkdevs.c:40: warning: its scope is only this definition or declaration, which is probably not what you want
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/mtd/mtd_blkdevs.c: In function ‘do_blktrans_request’:
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/mtd/mtd_blkdevs.c:45: error: dereferencing pointer to incomplete type
...
make[3]: *** [drivers/mtd/mtd_blkdevs.o] Error 1

<--  snip  -->

Bug report by Jesper Juhl.

This patch also removes a pointless "default n" from the SSFDC option.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/mtd/Kconfig.old	2006-10-09 00:56:29.000000000 +0200
+++ linux-2.6/drivers/mtd/Kconfig	2006-10-09 00:57:18.000000000 +0200
@@ -265,8 +265,7 @@
 
 config SSFDC
 	tristate "NAND SSFDC (SmartMedia) read only translation layer"
-	depends on MTD
-	default n
+	depends on MTD && BLOCK
 	help
 	  This enables read only access to SmartMedia formatted NAND
 	  flash. You can mount it with FAT file system.

