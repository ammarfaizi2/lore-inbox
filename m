Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSKDUXP>; Mon, 4 Nov 2002 15:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbSKDUXP>; Mon, 4 Nov 2002 15:23:15 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:8365 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262712AbSKDUXO>; Mon, 4 Nov 2002 15:23:14 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 4 Nov 2002 12:29:37 -0800
Message-Id: <200211042029.MAA09749@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: RE: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Cc: greg@kroah.com, jgarzik@pobox.com, jung-ik.lee@intel.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

>On Mon, 2002-11-04 at 18:23, Adam J. Richter wrote:
>> 	There is no reason to use __pci_devinit for chipsets that are
>> only soldered into motherboards.  I believe there are only a few of
>> those quirk handlers that CONFIG_PCI_HOTPLUG users really need to
>> retain in their kernels.

>You might be suprised what "motherboard" chips turn up in docking
>stations.My TP600 for example has an IBM southbridge in it.

	What are you advocating?  Do you want all quirk routines
marked __devinit?  Wouldn't you agree at least that if we can
establish that device *cannot* be hot plugged, that its quirk routine
can be __init?

	I see at least three levels of "hardware reality support":

		1. Configurations known to be in use.
		2. Possible configurations of hardware products known to exist
		3. Hardware products not known to exist, based on chips
		   and specs known to exist in other real hardware products.

	Jeff Garzik recently said that he doesn't want to incorporate
hot plugging for arbitrary standard PCI cards until he hears about a
hotplug configuration that uses that card (I'm cc'ing Jeff so he can
correct me if I misunderstand). That would put the kernel at level 1
in the above list.

	You seem to be advocating the third level, but maybe I'm
reading too much into your note.

	For what it's worth, although I think that individual
trade-offs can lead to some drivers being exceptions in one direction
or another, I would prefer level 2 for odd kernel versions so that we
can get reports about things like your TP600's chip set.  I do think
that patches for hotplug support for arbitrary regular PCI card should
be accepted now that there are backplanes that can hot plug them.

	By the way, does your TP600 docking station use one of the
mechanisms that is included by CONFIG_PCI_HOTPLUG or is it compiled in
either way (like CardBus)?

	If:
	- Your docking station were not controlled by CONFIG_PCI_HOTPLUG
	- and your kernel were not configured CONFIG_PCI_HOTPLUG
	- and your docking station needed a quirk routine
	- and the quirk routine were marked with the proposed __pcidevinit 
	- and you were to plug in your station after boot

	...then you would get a kernel segment fault, even if you have
CONFIG_HOTPLUG defined.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
