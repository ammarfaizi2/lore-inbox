Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262771AbTCKAyB>; Mon, 10 Mar 2003 19:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262772AbTCKAyB>; Mon, 10 Mar 2003 19:54:01 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:48145 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262771AbTCKAyA>; Mon, 10 Mar 2003 19:54:00 -0500
Date: Tue, 11 Mar 2003 02:04:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <20030310235131.GF13145@kroah.com>
Message-ID: <Pine.LNX.4.44.0303110147390.32518-100000@serv>
References: <20030308104749.A29145@flint.arm.linux.org.uk>
 <20030308202101.GA26831@kroah.com> <20030310214443.GA13145@kroah.com>
 <200303110048.43514.oliver@neukum.name> <20030310235131.GF13145@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Mar 2003, Greg KH wrote:

> > It seems that the semaphore in bus_add_device() makes this unnecessary.
> 
> Hm, yes.  I think you are correct.
> 
> So this patch is not needed, and the struct module * can be ripped out
> of struct usb_driver too :)

I think it's not easy. I haven't studied the code completely yet, but e.g. 
when you attach a device to a driver you also have to get a reference to 
the driver.
I think there are more interesting races, e.g. when you create a sysfs 
symlink, that symlink might also have references to a module.

bye, Roman

