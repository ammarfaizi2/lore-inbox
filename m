Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWCJRfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWCJRfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCJRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:35:00 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:16848 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932183AbWCJRfA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:35:00 -0500
Message-Id: <441154B10200003600001501@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 10 Mar 2006 10:28:01 -0700
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

On Fri, 2006-03-10 at 17:11 +0000, Arjan van de Ven  wrote:

> 
> > So in order to be sure I understand, if this PARITY Non-Conformance
> > attribute was "moved" to the per device directory of sysfs
> > (/sys/devices/pci0000:00/0000:00:06.0 for an example), then we would
> > need a userland attribute file created here and then stored in the
> > 'pci_dev' structure 
> 
> yes. Well to some degree I'm not even sure it needs to be exposed to
> userland like this. At least normally the kernel should know this
> internally and automatically. (after all the kernel has the job to
> abstract the hardware for the rest of the system; dealing with broken
> hardware is part of that)

The problem we have run into is latency of the OS keeping up to date
with the characteristics of a device. When I added the scan PCI parity
to bluesmoke/EDAC I made the ago old assumption that hardware vendors
followed the specs, at least in the majority. (Gee, they didn't 25 years
ago so why should they today??). Well it has been trial and error as we
placed bluesmoke on systems with the various cards we use and more than
I expected fail this conformance.

We needed the ability to override in real (people) time on a cluster,
the scanning of non-conforming boards. We cannot wait months for the OS
to catch up with new board. That is why I placed (breaking the model -
sorry about that) the blacklist "close" to the EDAC module.

For these reasons, we needed an access point for userland to override
the attribute of scanning a PCI device for parity. Device drivers won't
necessarily do this themselves. Something outside the kernel might have
to do it with data found after a device has been added to the system.

> 
> 
> > or the mentioned quirk structure. This field then
> > could be set by userland script(s), then EDAC-PCI could example that
> > data in its iteration of pci devices.  Is that correct?
> 
> that sounds way way way too complex. If this is "just" a field in the
> pci device... why would userland need to get involved? Your kernel side
> should be able to see that directly just fine.

The need for userland to actually DO the setting of the attribute
indicating that this device is non-conforming. That would be why

> 
> 
> 
> > If the above is correct, then who would we need to contact for said
> > modification or approval for such? Is that you Greg KH, since you are
> > listed as the PCI SUBSYSTEM maintainer?
> 
> Greg needs to OK the addition to the pci struct, but I don't forsee a
> problem personally since this is a more or less obvious and logical
> thing to add, and useful for more than one architecture

great!  thanks

doug t


