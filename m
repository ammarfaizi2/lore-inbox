Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWIDWME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWIDWME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWIDWME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:12:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964987AbWIDWMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:12:02 -0400
Date: Tue, 5 Sep 2006 00:11:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gerg@uclinux.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/m68knommu/kernel/setup.c should always #include <asm/pgtable.h>
Message-ID: <20060904221158.GA9173@stusta.de>
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
  CC      arch/m68knommu/kernel/setup.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c: In function 'setup_arch':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c:268: error: implicit declaration of function 'paging_init'
make[2]: *** [arch/m68knommu/kernel/setup.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c.old	2006-09-05 00:07:42.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c	2006-09-05 00:08:20.000000000 +0200
@@ -36,10 +36,7 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/machdep.h>
-
-#ifdef CONFIG_BLK_DEV_INITRD
 #include <asm/pgtable.h>
-#endif
 
 unsigned long memory_start;
 unsigned long memory_end;

