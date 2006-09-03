Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWICWTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWICWTx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWICWTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:19:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15621 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750869AbWICWTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:19:51 -0400
Date: Mon, 4 Sep 2006 00:19:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ysato@users.sourceforge.jp
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/h8300/kernel/setup.c should always #include <asm/pgtable.h>
Message-ID: <20060903221950.GI4416@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with 
CONFIG_BLK_DEV_INITRD=n and -Werror-implicit-function-declaration:

<--  snip  -->

...
  CC      arch/h8300/kernel/setup.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/h8300/kernel/setup.c: In function 'setup_arch':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/h8300/kernel/setup.c:183: error: implicit declaration of function 'paging_init'
make[2]: *** [arch/h8300/kernel/setup.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/arch/h8300/kernel/setup.c.old	2006-09-04 00:07:33.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/h8300/kernel/setup.c	2006-09-04 00:07:42.000000000 +0200
@@ -33,10 +33,7 @@
 
 #include <asm/setup.h>
 #include <asm/irq.h>
-
-#ifdef CONFIG_BLK_DEV_INITRD
 #include <asm/pgtable.h>
-#endif
 
 #if defined(__H8300H__)
 #define CPU "H8/300H"


-- 
VGER BF report: H 0.0185259
