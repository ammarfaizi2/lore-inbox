Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSJZVia>; Sat, 26 Oct 2002 17:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSJZVi3>; Sat, 26 Oct 2002 17:38:29 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:54659 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S261553AbSJZVi3>; Sat, 26 Oct 2002 17:38:29 -0400
Date: Sat, 26 Oct 2002 14:44:41 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021026144441.A13479@lucon.org>
References: <20021024163945.A21961@lucon.org> <3DB88715.7070203@pobox.com> <20021024165631.A22676@lucon.org> <1035540031.13032.3.camel@irongate.swansea.linux.org.uk> <20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBB0A81.6060909@pobox.com>; from jgarzik@pobox.com on Sat, Oct 26, 2002 at 05:34:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 05:34:57PM -0400, Jeff Garzik wrote:
> H. J. Lu wrote:
> 
> >On Sat, Oct 26, 2002 at 05:12:51PM -0400, Jeff Garzik wrote:
> >  
> >
> >>Well, WRT your implementation, the function you add is dead code if your 
> >>new config variable is not set, which is not desireable at all.
> >>    
> >>
> >
> >I am not sure if I understand what you were trying to say. If
> >CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is not set, you should be able to 
> >pass "pci=bussort" to kernel to sort the PCI device by bus, slot and
> >function. Did I miss something?
> >  
> >
> The sorting function you add should be covered by the ifdef you add.

Have you tried? If I did that, the kernel wouldn't even compile. As I
said, when CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC isn't defined, my sorting
function is still available, just not called by default.

> 
> >>WRT the overall idea, I would prefer to see what Linus and Martin Mares 
> >>(and Ivan K) thought about it, before merging it.  The x86 PCI code is 
> >>very touchy, and your patch has the potential to change driver probe 
> >>order for little gain.
> >>
> >>    
> >>
> >
> >The whole purpose of my patch is to change PCI driver probe order in
> >such a way that is BIOS independent.
> >  
> >
> 
> The purpose is irrelevant to the effect on existing drivers and systems 
> -- which is unknown.  Making the probe order independent of BIOS 
> ordering may very well break drivers and systems that are dependent on 
> BIOS ordering.  IOW what looks nice on your system could _likely_ suck 
> for others.  That's what I meant by "x86 PCI code is very touchy."

That is why CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is off by default and
even if it is on, you can still override it by passing "pci=nosort"
or "pci=nobussort" to kernel.



H.J.
