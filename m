Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSFYQiW>; Tue, 25 Jun 2002 12:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSFYQiV>; Tue, 25 Jun 2002 12:38:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4764 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315606AbSFYQiT>;
	Tue, 25 Jun 2002 12:38:19 -0400
Date: Tue, 25 Jun 2002 09:33:01 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: David Brownell <david-b@pacbell.net>
cc: Nick Bellinger <nickb@attheoffice.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <3D14B2CF.90002@pacbell.net>
Message-ID: <Pine.LNX.4.33.0206250920150.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Jun 2002, David Brownell wrote:

> > On the other hand there is the obvious fact that an iSCSI initiator
> > driver is not attached to a bus, and assuming /root/iSCSI.target/disk1
> > etc, is out of the question.  There is a real need for a solution to
> > handle virtual devices (as stated your previous message) that are not
> > assoicated with any physical connectors.  
> 
> There are those who see the IP stack as a kind of logical bus ... :)
> It's just not tied any specific hardware interface; it's "multipathed" in
> some sense. Linking it to an eth0 entry in $DRIVERFS/root/pci0/00:10.0
> would be wrong, since it can also be accessed through eth2.

It's not wrong, it's just makes life interesting when you want 
accurately represent the presence of the device via both paths, or you 
want to deal with the removal or power management of the bridge device. 
That problem needs to be addressed; soon. 

> Why shouldn't there be a $DRIVERFS/net/ipv4@10.42.135.99/... style
> hookup for iSCSI devices?  Using whatever physical addressing the
> kernel uses there, which I assume wouldn't necessarily be restricted
> to ipv4.  (And not exposing physical network topology -- routing! --
> in driverfs.)

You can very well use driverfs to expose those attributes, and is one of 
the things that we've been discussing at the kernel summit. driverfs will 
take over the world. But, I still think the device is best represented as 
a child of the phsysical network device. 

> On a related topic ... if driverfs is going to be providing a nice unique
> ID for the controller ($DRIVERFS/root/pci0/00:02.0/02:0f.0/03:07.0 for
> Linus' behind-two-bridges case), why are people talking as if the SCSI
> layer's arbitrary "controller number" should still be getting pushed as
> part of user visible names?
> 
> That is, I'd sure hope the standard policy for assigning driverfs names
> would avoid _all_ IDs that are derived from enumeration order.  Otherwise
> it'll be hard to store those names for (re)use by user mode tools.

The bus_id of the device is intended to represent the bus-specific ID of 
the device, and is the name of the driverfs directory. 

The name should user-friendly. It shouldn't be a unique name. Use 
something nice and pretty. If people need/want a UUID, add it to the 
bus-specific or type-specific structure, and export it via driverfs. It 
will eventually make it to the generic structure.

	-pat

