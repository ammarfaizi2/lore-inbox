Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTGCQCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTGCQCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:02:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33747 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264610AbTGCQAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:00:11 -0400
Date: Thu, 3 Jul 2003 18:14:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: [patch] 2.5.74: i2o_scsi.c must include pci.h
Message-ID: <20030703161429.GN282@fs.tum.de>
References: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with 2.5.74:

<--  snip  -->

...
  CC      drivers/message/i2o/i2o_scsi.o
drivers/message/i2o/i2o_scsi.c: In function `i2o_scsi_reply':
drivers/message/i2o/i2o_scsi.c:327: warning: implicit declaration of 
function `pci_unmap_sg'
drivers/message/i2o/i2o_scsi.c:329: warning: implicit declaration of 
function `pci_unmap_single'
drivers/message/i2o/i2o_scsi.c: In function `i2o_scsi_queuecommand':
drivers/message/i2o/i2o_scsi.c:763: warning: implicit declaration of 
function `pci_map_sg'
drivers/message/i2o/i2o_scsi.c:833: warning: implicit declaration of 
function `pci_map_single'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x5e871c): In function `i2o_scsi_reply':
: undefined reference to `pci_unmap_single'
drivers/built-in.o(.text+0x5e873c): In function `i2o_scsi_reply':
: undefined reference to `pci_unmap_sg'
drivers/built-in.o(.text+0x5e9471): In function `i2o_scsi_queuecommand':
: undefined reference to `pci_map_sg'
drivers/built-in.o(.text+0x5e9781): In function `i2o_scsi_queuecommand':
: undefined reference to `pci_map_single'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The fix is simple:


--- linux-2.5.74-not-full/drivers/message/i2o/i2o_scsi.c.old	2003-07-03 17:59:18.000000000 +0200
+++ linux-2.5.74-not-full/drivers/message/i2o/i2o_scsi.c	2003-07-03 18:00:11.000000000 +0200
@@ -49,6 +49,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/prefetch.h>
+#include <linux/pci.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

