Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbSJZWOd>; Sat, 26 Oct 2002 18:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbSJZWOc>; Sat, 26 Oct 2002 18:14:32 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:1424 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261618AbSJZWOb>; Sat, 26 Oct 2002 18:14:31 -0400
Date: Sat, 26 Oct 2002 15:20:43 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021026152043.A13850@lucon.org>
References: <3DB88715.7070203@pobox.com> <20021024165631.A22676@lucon.org> <1035540031.13032.3.camel@irongate.swansea.linux.org.uk> <20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBB1150.2030800@pobox.com>; from jgarzik@pobox.com on Sat, Oct 26, 2002 at 06:04:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 06:04:00PM -0400, Jeff Garzik wrote:
> Which is the entire problem.  The kernel compiles and builds just fine 
> right now, without your function.
> 

Without my patch or my function? My patched file has

        if ((pci_probe & PCI_BUS_SORT) && !(pci_probe & PCI_NO_SORT))
                pci_sort_by_bus_slot_func();
#ifdef CONFIG_PCI_BIOS
        else if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
                pcibios_sort();
#endif

That is pci_sort_by_bus_slot_func () will be called if PCI_BUS_SORT is
set. It is independent of whether CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is
set or not, which sets PCI_BUS_SORT. If pci_sort_by_bus_slot_func is
not defined when CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is not set. How can
kernel compile?

> If it is "just not called by default" then it clearly can be removed at 
> compile time when a certain CONFIG_xxx is not defined.

It is controlled by PCI_BUS_SORT, not CONFIG_xxx.

> 
> 
> >>>>WRT the overall idea, I would prefer to see what Linus and Martin Mares 
> >>>>(and Ivan K) thought about it, before merging it.  The x86 PCI code is 
> >>>>very touchy, and your patch has the potential to change driver probe 
> >>>>order for little gain.
> >>>>
> >>>>        
> >>>>
> >>>The whole purpose of my patch is to change PCI driver probe order in
> >>>such a way that is BIOS independent.
> >>>
> >>>      
> >>>
> >>The purpose is irrelevant to the effect on existing drivers and systems 
> >>-- which is unknown.  Making the probe order independent of BIOS 
> >>ordering may very well break drivers and systems that are dependent on 
> >>BIOS ordering.  IOW what looks nice on your system could _likely_ suck 
> >>for others.  That's what I meant by "x86 PCI code is very touchy."
> >>    
> >>
> >
> >That is why CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is off by default and
> >even if it is on, you can still override it by passing "pci=nosort"
> >or "pci=nobussort" to kernel.
> >  
> >
> 
> Sigh.  Repeating, the kernel is still bloated by your sorting function 
> if CONFIG_PCI_SORT_BY_BUS_SLOT is not defined.  The function should go 
> away if CONFIG_PCI_SORT_BY_BUS_SLOT is not defined.

I added pci=nobussort since it might not be safe for all MBs. Then I
added "pci=bussort". I have no problem taking out "pci=bussort". If you
don't want "pci=bussort", please say so. I can provide a new patch which
won't define pci_sort_by_bus_slot_func if CONFIG_PCI_SORT_BY_BUS_SLOT
is not set and won't have "pci=bussort" either.


H.J.
