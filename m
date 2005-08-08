Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVHHI5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVHHI5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVHHI5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:57:24 -0400
Received: from koto.vergenet.net ([210.128.90.7]:1235 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750767AbVHHI5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:57:23 -0400
Date: Mon, 8 Aug 2005 17:57:04 +0900
From: Horms <horms@debian.org>
To: LT-P <LT-P@LT-P.net>, 321442@bugs.debian.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc (drivers/ide/ppc/pmac.c)
Message-ID: <20050808085703.GE18551@verge.net.au>
References: <E1E13vT-0008G7-R1@arda.LT-P.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E13vT-0008G7-R1@arda.LT-P.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 05:15:57PM +0200, LT-P wrote:
> Package: kernel-source-2.6.8
> Version: 2.6.8-16
> Severity: normal
> 
> The kernel-source-2.6.8 sources fail to compile on powerpc (PowerMac 4400).
> 
> ___
> CC      drivers/ide/ide.o
> CC      drivers/ide/ide-default.o
> CC      drivers/ide/ide-io.o
> CC      drivers/ide/ide-iops.o
> CC      drivers/ide/ide-lib.o
> CC      drivers/ide/ide-probe.o
> CC      drivers/ide/ide-taskfile.o
> CC      drivers/ide/ide-dma.o
> CC      drivers/ide/ide-proc.o
> CC      drivers/ide/ppc/pmac.o
> drivers/ide/ppc/pmac.c: Dans la fonction ?? pmac_ide_dma_read ??:
> drivers/ide/ppc/pmac.c:1951: error: `ide_dma_intr' undeclared (first use in this function)
> drivers/ide/ppc/pmac.c:1951: error: (Each undeclared identifier is reported only once
> drivers/ide/ppc/pmac.c:1951: error: for each function it appears in.)
> drivers/ide/ppc/pmac.c: Dans la fonction ?? pmac_ide_dma_write ??:
> drivers/ide/ppc/pmac.c:1982: error: `ide_dma_intr' undeclared (first use in this function)
> drivers/ide/ppc/pmac.c: Dans la fonction ?? pmac_ide_setup_dma ??:
> drivers/ide/ppc/pmac.c:2157: error: `__ide_dma_off_quietly' undeclared (first use in this function)
> drivers/ide/ppc/pmac.c:2158: error: `__ide_dma_on' undeclared (first use in this function)
> drivers/ide/ppc/pmac.c:2167: error: `__ide_dma_verbose' undeclared (first use in this function)
> drivers/ide/ppc/pmac.c:2168: error: `__ide_dma_timeout' undeclared (first use in this function)
> make[3]: *** [drivers/ide/ppc/pmac.o] Error 1
> make[2]: *** [drivers/ide] Error 2
> make[1]: *** [drivers] Error 2

Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolves your
problem. If it does, then the following patch should fix Kconfig
so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_PMAC
to be enabled. It should patch cleanly against Debian's 2.6.8 and
Linus' current Git tree.

-- 
Horms


BLK_DEV_IDEDMA_PCI seems to be needed for BLK_DEV_IDE_PMAC to compile

Signed-off-by: Horms <horms@verge.net.au>


--- a/drivers/ide/Kconfig.orig	2005-08-08 17:48:17.000000000 +0900
+++ b/drivers/ide/Kconfig	2005-08-08 17:48:48.000000000 +0900
@@ -749,8 +749,6 @@
 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
 	  configure the chip to optimum performance.
 
-endif
-
 config BLK_DEV_IDE_PMAC
 	bool "Builtin PowerMac IDE support"
 	depends on PPC_PMAC && IDE=y
@@ -759,6 +757,8 @@
 	  most of the recent Apple Power Macintoshes and PowerBooks.
 	  If unsure, say Y.
 
+endif
+
 config BLK_DEV_IDE_PMAC_ATA100FIRST
 	bool "Probe internal ATA/100 (Kauai) first"
 	depends on BLK_DEV_IDE_PMAC
