Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318074AbSGMAda>; Fri, 12 Jul 2002 20:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSGMAda>; Fri, 12 Jul 2002 20:33:30 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51208 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318074AbSGMAd3>;
	Fri, 12 Jul 2002 20:33:29 -0400
Date: Fri, 12 Jul 2002 17:36:01 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Removal of pci_find_* in 2.5
Message-ID: <20020713003601.GA12118@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 14 Jun 2002 22:21:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Well, I've been trying to figure out a way to remove the existing
pci_find_device(), and other pci_find_* functions from the 2.5 kernel
without hurting to many things (well, things that people care about.)

Turns out these are very useful functions, outside of the "old" pci
framework, and I can't really justify removing them, so they are staying
for now (or until someone else can think of a replacement...)

The main reason for wanting to do this, is that any PCI driver that
relies on using pci_find_* to locate a device to control, will not work
with the existing PCI hotplug code.  Moving forward, those drivers will
also not work with the driverfs, struct driver, or the device naming
code.

So if you own a PCI driver that does not conform to the "new" PCI api
(using pci_register_driver() and friends) consider yourself warned.
Your driver will NOT inherit any of the upcoming changes to the drivers
tree, which might cause them to break.  Also remember, all of the people
that are buying hotplug PCI systems for their datacenters will not buy
your cards :)

thanks,

greg k-h
