Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSGNUPj>; Sun, 14 Jul 2002 16:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSGNUPj>; Sun, 14 Jul 2002 16:15:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1087 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317066AbSGNUPg>; Sun, 14 Jul 2002 16:15:36 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
References: <20020713003601.GA12118@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jul 2002 14:07:01 -0600
In-Reply-To: <20020713003601.GA12118@kroah.com>
Message-ID: <m1znwuoyze.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> Hi all,
> 
> Well, I've been trying to figure out a way to remove the existing
> pci_find_device(), and other pci_find_* functions from the 2.5 kernel
> without hurting to many things (well, things that people care about.)
> 
> Turns out these are very useful functions, outside of the "old" pci
> framework, and I can't really justify removing them, so they are staying
> for now (or until someone else can think of a replacement...)
> 
> The main reason for wanting to do this, is that any PCI driver that
> relies on using pci_find_* to locate a device to control, will not work
> with the existing PCI hotplug code.  Moving forward, those drivers will
> also not work with the driverfs, struct driver, or the device naming
> code.
> 
> So if you own a PCI driver that does not conform to the "new" PCI api
> (using pci_register_driver() and friends) consider yourself warned.
> Your driver will NOT inherit any of the upcoming changes to the drivers
> tree, which might cause them to break.  Also remember, all of the people
> that are buying hotplug PCI systems for their datacenters will not buy
> your cards :)

I do but it only doesn't use pci_register_driver because that doesn't
work.  

The driver is a mtd map driver.  It knows there is a rom chip behind 
a pci->isa bridge.  And it needs to find the pci->isa bridge to
properly set it up to access the rom chip (enable writes and the
like).  

It isn't a driver for the pci->isa bridge, (I'm not even certain we
have a good model for that).  So it does not use pci_register_driver.

If you can give me a good proposal for how to accomplish that kind of
functionality I would be happy to use the appropriate
xxx_register_driver.

Eric
