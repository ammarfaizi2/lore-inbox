Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSIYQhy>; Wed, 25 Sep 2002 12:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbSIYQhy>; Wed, 25 Sep 2002 12:37:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45708 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262023AbSIYQhy>;
	Wed, 25 Sep 2002 12:37:54 -0400
Date: Wed, 25 Sep 2002 09:44:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: devicefs & sleep support for IDE
In-Reply-To: <20020923212411.GA19391@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0209250927500.966-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Questions: is it possible that in hwif_register you don't need to
> initialize parent?

Actually, looking at it again, the struct device in hwif_t should probably 
go away. We should initialize the parent device to the struct device in 
the struct pci_dev of the controller; at least for PCI controllers.

For non-PCI controllers, is there anything else that describes the 
controller besides hwif_t ?

> Where is device_put of hwif->gendev? I miss it.

There is none (yet), as there is no driver attached to it. If we remove it 
in favor of the PCI device, then we get it in the pci driver for the 
controller; and we'd need one for non-PCI controllers.

> Ouch. There are actually two devices in struct gendisk. I choosed
> disk_dev. Was it right?

Yes. The other one: 

	struct device *driverfs_dev;

was from the SCSI people. I think they had good intentions, but I'm not 
sure what they were doing in several places (including here).


	-pat

