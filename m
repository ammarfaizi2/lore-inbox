Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUAZDT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUAZDT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:19:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18656 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265445AbUAZDTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:19:25 -0500
Date: Mon, 26 Jan 2004 04:19:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: andre@linux-ide.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix two IDE warnings
Message-ID: <20040126031921.GZ513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warnings in 2.4.25-pre7:

<--  snip  -->

...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.25-pre7-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  -I../ 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=siimage  -c -o 
siimage.o siimage.c
siimage.c: In function `pdev_is_sata':
siimage.c:65: warning: control reaches end of non-void function
...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.25-pre7-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  -I../ 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=generic  -c -o 
generic.o generic.c
generic.h:151: warning: `unknown_chipset' defined but not used
...

<--  snip  -->

The patch below (completely stolen from 2.6) fixes these two warnings.

Please apply
Adrian


--- linux-2.4.25-pre7-full/drivers/ide/pci/siimage.c.old	2004-01-26 04:02:58.000000000 +0100
+++ linux-2.4.25-pre7-full/drivers/ide/pci/siimage.c	2004-01-26 04:03:16.000000000 +0100
@@ -62,6 +62,7 @@
 			return 0;
 	}
 	BUG();
+	return 0;
 }
  
 /**
--- linux-2.4.25-pre7-full/drivers/ide/pci/generic.h.old	2004-01-26 04:05:31.000000000 +0100
+++ linux-2.4.25-pre7-full/drivers/ide/pci/generic.h	2004-01-26 04:05:46.000000000 +0100
@@ -148,6 +148,7 @@
 	}
 };
 
+#if 0
 static ide_pci_device_t unknown_chipset[] __devinitdata = {
 	{	/* 0 */
 		.vendor		= 0,
@@ -170,5 +171,6 @@
 	}
 
 };
+#endif
 
 #endif /* IDE_GENERIC_H */
