Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136660AbREAQy1>; Tue, 1 May 2001 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136659AbREAQyH>; Tue, 1 May 2001 12:54:07 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6378 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136657AbREAQyE>; Tue, 1 May 2001 12:54:04 -0400
Date: Tue, 1 May 2001 10:53:58 -0600
Message-Id: <200105011653.f41Grwm12595@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <20010501104641.C3305@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
	<200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
	<p05100313b70bb73ce962@[207.213.214.37]>
	<200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca>
	<p05100303b70eadd613b0@[207.213.214.37]>
	<200105010127.f411RDP03013@vindaloo.ras.ucalgary.ca>
	<20010501104641.C3305@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
> On Mon, Apr 30, 2001 at 07:27:13PM -0600, Richard Gooch wrote:
> > Then, vendors provide their own PCI fixups, which turn /dev/bus/pci0
> 
> What about /dev/bus/pci/0 or /dev/bus/pci/pci0 instead?
> 
> That way we could hook roots of busses (which are "." nodes, like
> if they where mounted independently) better into /dev/bus.

I'm wary of this, because Linus has stated that the current "struct
pci_dev" is really meant to be a generic thing, and it might change to
"struct dev" (now that we've renamed the old "struct dev" to "struct
netdev").

So, if the bus management code is maintaining some kind of unified
tree, it might not make sense to have a /dev/bus/pci and
/dev/bus/sbus.

> And even implement the thing as a mount point later, if we go the way
> Al Viro suggested and have independent "device filesystems"
> for the subsystems themselves.

As I understand it, Al want to turn every driver into a filesystem,
instead of using an existing FS (devfs). I can't see the point. There
certainly haven't been any technical benefits put forward for this
idea.

I spoke to Linus about this, and he wants to leave the option open for
some drivers to implement their own FS rather than calling into devfs.
He cited iSCSI as a case where this might be useful (since you need to
do something different for readdir() and lookup()). I'll be
experimenting with iSCSI myself, and I'll try out a modification to
devfs which allows a driver to register lookup() and readdir() methods
when calling devfs_mk_dir(). If this can be done sanely, then it would
provide an easier interface than using the VFS to implement a new FS.
So this particular issue remains open.

However, it's my understanding that Linus isn't trying to push
existing drivers, which work well with devfs, into implementing their
own FS. He just wants the option left open for new drivers where a
driver-specific FS makes more sense.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
