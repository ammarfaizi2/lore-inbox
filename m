Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262946AbTCKPVB>; Tue, 11 Mar 2003 10:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbTCKPVB>; Tue, 11 Mar 2003 10:21:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262946AbTCKPVA>;
	Tue, 11 Mar 2003 10:21:00 -0500
Date: Tue, 11 Mar 2003 09:06:54 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Oliver Neukum <oliver@neukum.name>
cc: Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <200303111000.40387.oliver@neukum.name>
Message-ID: <Pine.LNX.4.33.0303110902010.1003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I think it's not easy. I haven't studied the code completely yet, but
> > > e.g. when you attach a device to a driver you also have to get a
> > > reference to the driver.
> >
> > You get a link to the driver, but you can't increment the module count
> > of the driver at that time, as we have to be able to remove a module
> > somehow :)
> 
> That is simple. Export a generic way to disconnect a driver from a device.

It's not that easy - Linux has always supported the operation of being
able to remove a module while it is attached to devices. The reference
count only goes up if a device is opened. 

This means the module refcount must remain at 0, even after it's bound to 
devices. Changing this would require a change in visible behavior, and 
require an extra step by a user to disconnect the driver before they 
unload the module. 


	-pat

