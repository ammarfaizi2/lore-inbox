Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268791AbTCCUqC>; Mon, 3 Mar 2003 15:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268792AbTCCUqC>; Mon, 3 Mar 2003 15:46:02 -0500
Received: from smtp9.us.dell.com ([143.166.148.136]:33466 "EHLO
	smtp9.us.dell.com") by vger.kernel.org with ESMTP
	id <S268791AbTCCUp7>; Mon, 3 Mar 2003 15:45:59 -0500
Date: Mon, 3 Mar 2003 14:56:23 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <mochel@osdl.org>
Subject: Re: Displaying/modifying PCI device id tables via sysfs
In-Reply-To: <20030303182553.GG16741@kroah.com>
Message-ID: <20BF5713E14D5B48AA289F72BD372D6803945AB6-100000@AUSXMPC122.aus.amer.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That info is already exported to userspace through the modules.pcimap
> file.

OK.

> > 2) Add new IDs at runtime and have the drivers probe for the new IDs.
> 
> Ick, no.  If a driver really wants to have a user provide new ids on the
> fly, they usually provide a module paramater to do this.

Yes, I've done this kind of thing too with aacraid.  I was hoping to 
generalize the process and build upon the ID table already present.

> A number of the USB drivers do this already (and to be honest, they
> have caused nothing but trouble, as users use that option for new
> devices, that the driver can't control at all due to protocol or
> register location changes.)
> 
> In short, it's not a good idea to allow users to change these values on
> the fly, the driver author usually knows best here :)

Indeed, it only works if simply adding PCI IDs is the only change needed
to support a new device.

Not everyone can run a recent kernel with the most recent IDs in the
driver.  Take for example an distribution release on CD.  It's very hard
to update the kernel running at OS install time to handle a new device,
even if the driver would otherwise handle that device if only it had the
PCI IDs.  This can easily happen if the hardware subsystem vendor/device
IDs change, but the driver has a hard-coded list of IDs to test which
include specific subsystem vendor/device IDs.

Built-in drivers (e.g. IDE today) are even harder - there you can't just
replace a driver module with one built with additional IDs, you've got to
replace the whole kernel.  It would be nice, for the cases where it works, 
to add IDs at runtime and continue, and later upgrade to a newer kernel 
that includes the IDs in the driver source.


Adding IDs to drivers at runtime is definitely a stop-gap measure, and 
only works when drivers don't need other changes, but it solves an 
important subset of the problem space.

DKMS, announced last Friday on lkml, is the next step in this progression.  
It can help driver maintainers build and release driver modules for the
case when driver updates are necessary, but whole kernel updates are not
necessary, or perhaps even possible.

The last step in this progression is the release of whole new kernels,
which include updated device drivers to match.  Certainly we encourage
this from a developer perspective, but it isn't always feasible from a
distributor or customer perspective.


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


