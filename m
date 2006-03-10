Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWCJRD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCJRD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWCJRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:03:56 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:14027 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751200AbWCJRD4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:03:56 -0500
Message-Id: <44114D5702000036000014DE@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 10 Mar 2006 09:56:39 -0700
From: "Doug Thompson" <dthompson@lnxi.com>
To: <arjan@infradead.org>
Cc: <tim@buttersideup.com>, <greg@kroah.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <dsp@llnl.gov>,
       "Doug Thompson" <dthompson@lnxi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 11:40 +0000, Arjan van de Ven  wrote:
> On Fri, 2006-03-10 at 11:06 +0000, Tim Small wrote:
> > Arjan van de Ven wrote:
> > 
> > > It depends on how many PCI devices in your machine you wish to
> > >
> > >>blacklist or whitelist.  The motivation for this feature is that
> > >>certain known badly-designed devices report an endless stream of
> > >>spurious PCI bus parity errors.  We want to skip such devices when
> > >>checking for PCI bus parity errors.
> > >>    
> > >>
> > >
> > >ok so this is actually a per pci device property!
> > >I would suggest moving this property to the pci device itself, not doing
> > >it inside an edac directory.
> > >  
> > >
> > Yes, this seems more sensible to me.  For one thing, I suspect that just 
> > keying on vendor:device is probably too blunt for this and that 
> > blacklisting a particular PCI device revision is a likely requirement, 
> > as well as subsystem vendor/subsystem device.
> 
> and maybe even something as funky as firmware version.
> So it for sure is a per device (not per ID) property, and something that
> needs a global quirk table kind of thing with the option to do per
> driver overrides

Very definitely, this non-conforming misfeature of PCI compliance is a
per PCI device attribute. At the very least it is tied to VENDOR:DEVICE
tuple, and probably a subsystem vendor/device tuple as well. As to
firmware, that is also likely. Mellanox promised a new firmware update
to their board that supposely fixes this issue. Yet, I find no firmware
value in the PCI spec, just the Revision ID, which could be used as
firmware identifier. THis is up to the vendor.

So in order to be sure I understand, if this PARITY Non-Conformance
attribute was "moved" to the per device directory of sysfs
(/sys/devices/pci0000:00/0000:00:06.0 for an example), then we would
need a userland attribute file created here and then stored in the
'pci_dev' structure or the mentioned quirk structure. This field then
could be set by userland script(s), then EDAC-PCI could example that
data in its iteration of pci devices.  Is that correct?

I will admit I have heard of the "quirk" tables in the kernel, but don't
fully understand them.  From what I read here, a PCI device quirk table
would be a parallel structure to the 'struct pci_dev' for a given PCI
device. So every pci_dev structure created, then a quirk table structure
would be created, and in that quirk entry is a PARITY data item. That
data item is exposed into sysfs in the /sys/devices/pci* as the example
above.

An new getter functions would be needed so the EDAC PCI iterator could
'get' the current value of the attribute.

If the above is correct, then who would we need to contact for said
modification or approval for such? Is that you Greg KH, since you are
listed as the PCI SUBSYSTEM maintainer?

thanks

doug t



