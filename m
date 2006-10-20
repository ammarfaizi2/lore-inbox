Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992423AbWJTCmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992423AbWJTCmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992424AbWJTCmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:42:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:16604 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992423AbWJTCmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:42:38 -0400
Date: Thu, 19 Oct 2006 19:41:57 -0700
From: Greg KH <greg@kroah.com>
To: David Miller <davem@davemloft.net>
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, jesse.barnes@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
Message-ID: <20061020024157.GA6722@kroah.com>
References: <20061019092256.GC5980@devserv.devel.redhat.com> <20061019.022541.85409562.davem@davemloft.net> <XNM1$9$0$4$$3$3$7$A$9002707U4537582f@hitachi.com> <20061019.153228.39159105.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019.153228.39159105.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 03:32:28PM -0700, David Miller wrote:
> From: <eiichiro.oiwa.nm@hitachi.com>
> Date: Thu, 19 Oct 2006 19:49:26 +0900
> 
> > The "0xc0000" is a physical address. The BAR (PCI base address) is also
> > a physcail address. There are no difference.
> 
> Your assertion that the BAR is a physical address is very platform
> specific.  It may be a "physical address in PCI bus space", but
> that has no relation to the first argument passed to ioremap()
> which is defined in a completely different way.
> 
> On many platforms, the BAR of PCI devices are translated into an
> appropriate "ioremap() cookie" in the struct pci_dev resource[] array
> entries, so that they can be used properly as the first argument to
> ioremap().  Only address cookies properly setup by the platform may be
> legally passed into ioremap() as the first argument.  No such setups
> are being made on this raw 0xc0000 address.
> 
> So, as you can see, I/O port and I/O memory space work differently on
> different platforms and this abstraction of the first argument to
> ioremap() is how we provide support for such differences.
> 
> If you try to access 0xc0000 via ioremap() on sparc64, it is going to
> try and access that area non-cacheable which, since 0xc0000 is
> physical RAM, will result in a BUS ERROR and a crash.
> 
> This physical location might be the area for the video ROM on x86,
> x86_64, and perhaps even IA64, but it certainly is not used this way
> on sparc64 systems.
> 
> I really would like to see this regression fixed, or at the very
> least this code protected by X86, X86_64, IA64 conditionals.

I agree.  Eiichiro, care to send me an patch to fix this somehow?  Or do
you want me to just revert it?

thanks,

greg k-h
