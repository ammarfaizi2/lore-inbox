Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTCKBP0>; Mon, 10 Mar 2003 20:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262764AbTCKBP0>; Mon, 10 Mar 2003 20:15:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27396 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262394AbTCKBPZ>;
	Mon, 10 Mar 2003 20:15:25 -0500
Date: Mon, 10 Mar 2003 17:15:32 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030311011532.GH13145@kroah.com>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308202101.GA26831@kroah.com> <20030310214443.GA13145@kroah.com> <200303110048.43514.oliver@neukum.name> <20030310235131.GF13145@kroah.com> <Pine.LNX.4.44.0303110147390.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303110147390.32518-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 02:04:20AM +0100, Roman Zippel wrote:
> On Mon, 10 Mar 2003, Greg KH wrote:
> 
> > > It seems that the semaphore in bus_add_device() makes this unnecessary.
> > 
> > Hm, yes.  I think you are correct.
> > 
> > So this patch is not needed, and the struct module * can be ripped out
> > of struct usb_driver too :)
> 
> I think it's not easy. I haven't studied the code completely yet, but e.g. 
> when you attach a device to a driver you also have to get a reference to 
> the driver.

You get a link to the driver, but you can't increment the module count
of the driver at that time, as we have to be able to remove a module
somehow :)

> I think there are more interesting races, e.g. when you create a sysfs 
> symlink, that symlink might also have references to a module.

Yeah, I still think there are some nasty issues with regards to being in
a sysfs directory, with a open file handle, and the module is removed.
But I haven't checked stuff like that in a while.

CONFIG_MODULE_UNLOAD, just say no.

thanks,

greg k-h
