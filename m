Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSKRNDS>; Mon, 18 Nov 2002 08:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSKRNDS>; Mon, 18 Nov 2002 08:03:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56277 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262667AbSKRNDR>; Mon, 18 Nov 2002 08:03:17 -0500
Date: Mon, 18 Nov 2002 14:10:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compile breakage in drivers/net/arcnet/com20020-pci.c
Message-ID: <20021118131014.GC11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,
 
could you check whether the patch below that does a name -> dev.name to
fix the following compile error in 2.5.48 is correct?

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/arcnet/.com20020-pci.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=com20020_pci -DKBUILD_MODNAME=com20020_pci   -c -o drivers/net/arcnet/com20020-pci.o drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/com20020-pci.c: In function `com20020pci_probe':
drivers/net/arcnet/com20020-pci.c:93: structure has no member named `name'
make[3]: *** [drivers/net/arcnet/com20020-pci.o] Error 1

<--  snip  -->


TIA
Adrian


--- linux-2.5.48/drivers/net/arcnet/com20020-pci.c.old	2002-11-18 14:02:51.000000000 +0100
+++ linux-2.5.48/drivers/net/arcnet/com20020-pci.c	2002-11-18 14:03:06.000000000 +0100
@@ -90,7 +90,7 @@
 	dev->base_addr = ioaddr;
 	dev->irq = pdev->irq;
 	dev->dev_addr[0] = node;
-	lp->card_name = pdev->name;
+	lp->card_name = pdev->dev.name;
 	lp->card_flags = id->driver_data;
 	lp->backplane = backplane;
 	lp->clockp = clockp & 7;
