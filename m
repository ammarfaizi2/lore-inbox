Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUFYWEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUFYWEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbUFYWEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:04:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51928 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266876AbUFYWEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:04:14 -0400
Date: Sat, 26 Jun 2004 00:04:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: willy@debian.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [2.6 patch] fix arch/i386/pci/Makefile
Message-ID: <20040625220406.GL18303@fs.tum.de>
References: <20040625001513.GB18303@fs.tum.de> <20040624210150.46e68ded.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624210150.46e68ded.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:01:50PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > I got the following compile error in 2.6.7-mm2 (but it doesn't seem to 
> >  be specific to -mm2):
> > ..
> >  drivers/built-in.o(.text+0x6c24a): In function `acpi_pci_root_add':
> >  : undefined reference to `pci_acpi_scan_root'
> >  make: *** [.tmp_vmlinux1] Error 1
> 
> > 
> >  This problem occurs with
> >    CONFIG_ACPI_PCI=y && (CONFIG_X86_VISWS=y || CONFIG_X86_NUMAQ=y)
> > 
> > ....
> >  --- linux-2.6.7-mm2-full/arch/i386/pci/Makefile.old	2004-06-25 02:08:29.000000000 +0200
> >  +++ linux-2.6.7-mm2-full/arch/i386/pci/Makefile	2004-06-25 02:10:36.000000000 +0200
> >  @@ -5,10 +5,11 @@
> >   obj-$(CONFIG_PCI_DIRECT)	+= direct.o
> >   
> >   pci-y				:= fixup.o
> >  -pci-$(CONFIG_ACPI_PCI)		+= acpi.o
> >   pci-y				+= legacy.o irq.o
> >   
> >   pci-$(CONFIG_X86_VISWS)		:= visws.o fixup.o
> >   pci-$(CONFIG_X86_NUMAQ)		:= numa.o irq.o
> >   
> >  +pci-$(CONFIG_ACPI_PCI)		+= acpi.o
> >  +
> 
> This causes my e100 NIC to not work.  Some initcall ordering dependency,
> presumably.  A whole bunch of devices popped up on different IRQs.
> 
> Come to think about it, how can the above patch fix that linkage error
> anyway?

A := overrides all previous := and += .


But Matthew's patch seems to be a better solution.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

