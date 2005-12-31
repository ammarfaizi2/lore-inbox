Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVLaOJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVLaOJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVLaOJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:09:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6412 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751329AbVLaOJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:09:35 -0500
Date: Sat, 31 Dec 2005 15:09:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Miles Lane <miles.lane@gmail.com>, dwmw2@infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: [2.6 patch] MTD_NAND_SHARPSL and MTD_NAND_NANDSIM must be tristate's
Message-ID: <20051231140933.GG3811@stusta.de>
References: <a44ae5cd0512272139q3f7e29enbacf94faddbd75d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0512272139q3f7e29enbacf94faddbd75d2@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 12:39:54AM -0500, Miles Lane wrote:

>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function
> `init_nandsim':nandsim.c:(.text+0x88ba2): undefined reference to
> `nand_flash_ids'
> drivers/built-in.o: In function
> `ns_init_module':nandsim.c:(.init.text+0x7b72): undefined reference to
> `nand_scan'
> :nandsim.c:(.init.text+0x7bb5): undefined reference to `nand_default_bbt'
> drivers/built-in.o: In function
> `ns_cleanup_module':nandsim.c:(.exit.text+0x37b): undefined reference
> to `nand_release'
> make: *** [.tmp_vmlinux1] Error 1
>...

Thanks for your report, a fix is below.

cu
Adrian


<--  snip  -->


MTD_NAND=m and MTD_NAND_SHARPSL=y or MTD_NAND_NANDSIM=y are illegal 
combinations that mustn't be allowed.

This patch fixes this bug by making MTD_NAND_SHARPSL and 
MTD_NAND_NANDSIM tristate's.

Additionally, it fixes some whitespace damage at these options.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-git/drivers/mtd/nand/Kconfig.old	2005-12-31 12:20:12.000000000 +0100
+++ linux-git/drivers/mtd/nand/Kconfig	2005-12-31 12:21:35.000000000 +0100
@@ -178,17 +178,16 @@
 	  Even if you leave this disabled, you can enable BBT writes at module
 	  load time (assuming you build diskonchip as a module) with the module
 	  parameter "inftl_bbt_write=1".
-	  
- config MTD_NAND_SHARPSL
- 	bool "Support for NAND Flash on Sharp SL Series (C7xx + others)"
- 	depends on MTD_NAND && ARCH_PXA
- 
- config MTD_NAND_NANDSIM
- 	bool "Support for NAND Flash Simulator"
- 	depends on MTD_NAND && MTD_PARTITIONS
 
+config MTD_NAND_SHARPSL
+	tristate "Support for NAND Flash on Sharp SL Series (C7xx + others)"
+	depends on MTD_NAND && ARCH_PXA
+
+config MTD_NAND_NANDSIM
+	tristate "Support for NAND Flash Simulator"
+	depends on MTD_NAND && MTD_PARTITIONS
 	help
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
+
 endmenu

