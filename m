Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269498AbTCDOYa>; Tue, 4 Mar 2003 09:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269499AbTCDOYa>; Tue, 4 Mar 2003 09:24:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269498AbTCDOY2>;
	Tue, 4 Mar 2003 09:24:28 -0500
Date: Tue, 4 Mar 2003 08:10:55 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Greg KH <greg@kroah.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Displaying/modifying PCI device id tables via sysfs
In-Reply-To: <1046753776.12441.92.camel@iguana>
Message-ID: <Pine.LNX.4.33.0303040805000.992-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> then there needs to be a simple way in sysfs to export an attribute
> hierarchy, beneath an object in the kobject hierarchy.  Right now it's
> assumed that each kobject can have multiple attributes, but all are at a
> single level.  Pat, is this hard to do?

It's 1 kobject == 1 sysfs directory. I recommend putting a kobject into 
the ID structure and registering it (by the PCI core) once the driver has 
been registered. Then, create files for each of the static IDs. 

When new IDs are added, I don't see why you need to differentiate between 
them in userspace. Couldn't you have e.g.:

/sys/bus/pci/drivers/3c59x/
`-- id
    |-- 0
    |-- 1
    `-- new_id

Then, when someone writes a new ID, have:

/sys/bus/pci/drivers/3c59x/
`-- id
    |-- 0
    |-- 1
    |-- 2
    `-- new_id

Internally, we of course need to treat them differently, but to the user, 
they're just IDs the driver supports..

	-pat

