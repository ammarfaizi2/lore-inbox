Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUBQJXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 04:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbUBQJXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 04:23:34 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:8718 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264411AbUBQJXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 04:23:33 -0500
Date: Tue, 17 Feb 2004 10:27:33 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Martin Diehl <lists@mdiehl.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <Pine.LNX.4.44.0402170946140.31216-100000@notebook.home.mdiehl.de>
Message-ID: <Pine.LNX.4.44.0402171025260.31216-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Martin Diehl wrote:

> drivers/built-in.o(.text+0x3aa33): In function `set_using_dma':
> : undefined reference to `__ide_dma_off'
> drivers/built-in.o(.text+0x401bc): In function `check_dma_crc':
> : undefined reference to `__ide_dma_off'
> make: *** [.tmp_vmlinux1] Error 1

FWIW, the patch below solved this, but I'm not sure if it's the correct 
fix.

Martin

-----------------------------

--- linux-2.6.3-rc4/drivers/ide/Makefile	Tue Feb 10 18:14:34 2004
+++ v2.6.3-rc4-md-ob/drivers/ide/Makefile	Tue Feb 17 10:24:46 2004
@@ -14,13 +14,13 @@
 obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
 
 ide-core-y += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o ide-probe.o \
-	ide-taskfile.o
+	ide-taskfile.o ide-dma.o
 
 ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
 
 # Core IDE code - must come before legacy
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
-ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
+# ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
 ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o

