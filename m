Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262894AbTCKKyw>; Tue, 11 Mar 2003 05:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262895AbTCKKyw>; Tue, 11 Mar 2003 05:54:52 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:10507 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262894AbTCKKyu>; Tue, 11 Mar 2003 05:54:50 -0500
Date: Tue, 11 Mar 2003 12:05:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <20030311011532.GH13145@kroah.com>
Message-ID: <Pine.LNX.4.44.0303111200070.5042-100000@serv>
References: <20030308104749.A29145@flint.arm.linux.org.uk>
 <20030308202101.GA26831@kroah.com> <20030310214443.GA13145@kroah.com>
 <200303110048.43514.oliver@neukum.name> <20030310235131.GF13145@kroah.com>
 <Pine.LNX.4.44.0303110147390.32518-100000@serv> <20030311011532.GH13145@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Mar 2003, Greg KH wrote:

> > I think it's not easy. I haven't studied the code completely yet, but e.g. 
> > when you attach a device to a driver you also have to get a reference to 
> > the driver.
> 
> You get a link to the driver, but you can't increment the module count
> of the driver at that time, as we have to be able to remove a module
> somehow :)

Somehow you have to protect dev->driver, you cannot resolve the driver 
pointer without holding the bus lock or holding a reference. If you don't 
get a reference, any access via this pointer must be done under the bus 
lock.

> Yeah, I still think there are some nasty issues with regards to being in
> a sysfs directory, with a open file handle, and the module is removed.
> But I haven't checked stuff like that in a while.
> 
> CONFIG_MODULE_UNLOAD, just say no.

That's certainly an option, but I'm afraid not too many people will do 
this.

bye, Roman

