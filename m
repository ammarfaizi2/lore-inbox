Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUKRPoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUKRPoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUKRPnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:43:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46596 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262475AbUKRPlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:41:15 -0500
Date: Thu, 18 Nov 2004 16:41:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
Message-ID: <20041118154110.GE4943@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc2-mm1:
>...
>  bk-mtd.patch
>...

Ths causes the following compile error:

<--  snip  -->

...
  CC      drivers/mtd/chips/cfi_probe.o
In file included from drivers/mtd/chips/cfi_probe.c:18:
include/linux/mtd/xip.h:77:2: #error "missing IRQ and timer primitives for XIP MTD support"
{standard input}: Assembler messages:
{standard input}:5: Warning: ignoring changed section attributes for .data
make[3]: *** [drivers/mtd/chips/cfi_probe.o] Error 1

<--  snip  -->


Let's put the dependencies from the #error into the Kconfig file:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.10-rc2-mm2-full/drivers/mtd/chips/Kconfig.old	2004-11-18 16:35:40.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/mtd/chips/Kconfig	2004-11-18 16:38:37.000000000 +0100
@@ -274,7 +274,7 @@
 
 config MTD_XIP
 	bool "XIP aware MTD support"
-	depends on !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL
+	depends on !SMP && MTD_CFI_INTELEXT && (ARCH_SA1100 || ARCH_PXA) && EXPERIMENTAL
 	default y if XIP_KERNEL
 	help
 	  This allows MTD support to work with flash memory which is also

