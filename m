Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRKVOn3>; Thu, 22 Nov 2001 09:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRKVOnT>; Thu, 22 Nov 2001 09:43:19 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:12295 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S279722AbRKVOnG>; Thu, 22 Nov 2001 09:43:06 -0500
Date: Thu, 22 Nov 2001 15:43:05 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Dave Airlie <airlied@skynet.ie>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA and APM/ACPI issue (xircom card problem)
In-Reply-To: <Pine.LNX.4.32.0111221429030.22550-100000@skynet>
Message-ID: <Pine.LNX.4.33.0111221534500.27255-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Dave Airlie wrote:

> > > work..
> >
> > So basically, the problem exists when CONFIG_ACPI=y, right? Can you try to
> > boot the ACPI enabled kernel with acpi=off in the command line?
> 
> okay one kernel with ACPI it doesn't work with ACPI off it does ...
> 2.4.15-pre8

If I got this right, "acpi=off" fixes the problem using a kernel which
otherwise shows the problem. If so, this clearly indicates that ACPI is
the culprit, or, more precisely, probably an _INI method which is executed
by the ACPI interpreter at boot time. Can you mail me (privately) a copy
of your DSDT (cat /proc/acpi/dsdt > file), that's a table provided by the
ACPI BIOS.

> > Which exact error do you get from lspci? Does it give the error on both
> > kernels?
> 
> lspci without ACPI dumps out:
> pcilib: Cannot open /proc/bus/pci/02/00.1
> lspci: Unable to read 64 bytes of configuration space.
> 
> same except 00.1 is 00.7 on the ACPI boot..

That's weird enough, somethings seems wrong with your PCI enumeration. 
Can you recompile your kernel with #define DEBUG instead of #undef DEBUG 
in drivers/pci/pci.c and arch/i386/kernel/pci-i386.h? Then please send the 
boot messages again.

--Kai

