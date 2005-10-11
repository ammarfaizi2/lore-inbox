Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVJKXRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVJKXRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJKXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:17:12 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:19354 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932095AbVJKXRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:17:11 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] 2.6.14-rc4 ACPI/PCI compile problem
Date: Tue, 11 Oct 2005 17:17:01 -0600
User-Agent: KMail/1.8.2
Cc: Adam Litke <agl@us.ibm.com>, linux-kernel@vger.kernel.org
References: <1129069727.27663.8.camel@localhost.localdomain>
In-Reply-To: <1129069727.27663.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510111717.01887.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 October 2005 4:28 pm, Adam Litke wrote:
> Ok I'll admit I've known about this since at least 2.6.14-rc2-git5 but
> it may have been around longer.  Long enough for me to speak up.
> 
> I am getting the following compile errors when building 2.6.14-rc4 for
> i386:
> 
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o(.text+0x235f9): In function `acpi_pci_root_add':
> > /home/aglitke/views/acpi-compile-fix-2.6.14-rc4/current/drivers/acpi/pci_root.c:274: undefined reference to `pci_acpi_scan_root'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make: *** [_all] Error 2

Please try the following patch and confirm whether it works.


[i386 kbuild] Don't clobber pci-y when X86_VISWS or X86_NUMAQ

Previously, enabling CONFIG_X86_VISWS or CONFIG_X86_NUMAQ
clobbered any previous contents of pci-y, because they used
":=" instead of "+=".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -r ed3231e577f5 arch/i386/pci/Makefile
--- a/arch/i386/pci/Makefile	Tue Oct 11 19:03:47 2005
+++ b/arch/i386/pci/Makefile	Tue Oct 11 15:47:09 2005
@@ -8,7 +8,7 @@
 pci-$(CONFIG_ACPI)		+= acpi.o
 pci-y				+= legacy.o irq.o
 
-pci-$(CONFIG_X86_VISWS)		:= visws.o fixup.o
-pci-$(CONFIG_X86_NUMAQ)		:= numa.o irq.o
+pci-$(CONFIG_X86_VISWS)		+= visws.o fixup.o
+pci-$(CONFIG_X86_NUMAQ)		+= numa.o irq.o
 
 obj-y				+= $(pci-y) common.o
