Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUFYAPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUFYAPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUFYAPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:15:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27623 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265903AbUFYAPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:15:16 -0400
Date: Fri, 25 Jun 2004 02:15:14 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: willy@debian.org
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [2.6 patch] fix arch/i386/pci/Makefile
Message-ID: <20040625001513.GB18303@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.7-mm2 (but it doesn't seem to 
be specific to -mm2):

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x6c24a): In function `acpi_pci_root_add':
: undefined reference to `pci_acpi_scan_root'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

This problem occurs with
  CONFIG_ACPI_PCI=y && (CONFIG_X86_VISWS=y || CONFIG_X86_NUMAQ=y)

The patch below fixes it.

Please apply
Adrian


--- linux-2.6.7-mm2-full/arch/i386/pci/Makefile.old	2004-06-25 02:08:29.000000000 +0200
+++ linux-2.6.7-mm2-full/arch/i386/pci/Makefile	2004-06-25 02:10:36.000000000 +0200
@@ -5,10 +5,11 @@
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
 pci-y				:= fixup.o
-pci-$(CONFIG_ACPI_PCI)		+= acpi.o
 pci-y				+= legacy.o irq.o
 
 pci-$(CONFIG_X86_VISWS)		:= visws.o fixup.o
 pci-$(CONFIG_X86_NUMAQ)		:= numa.o irq.o
 
+pci-$(CONFIG_ACPI_PCI)		+= acpi.o
+
 obj-y				+= $(pci-y) common.o
