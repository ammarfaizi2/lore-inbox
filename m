Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbTCKIuF>; Tue, 11 Mar 2003 03:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbTCKIuF>; Tue, 11 Mar 2003 03:50:05 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:62943 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S262865AbTCKIuE> convert rfc822-to-8bit; Tue, 11 Mar 2003 03:50:04 -0500
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: PCI driver module unload race?
Date: Tue, 11 Mar 2003 10:00:40 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <Pine.LNX.4.44.0303110147390.32518-100000@serv> <20030311011532.GH13145@kroah.com>
In-Reply-To: <20030311011532.GH13145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303111000.40387.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. März 2003 02:15 schrieb Greg KH:
> On Tue, Mar 11, 2003 at 02:04:20AM +0100, Roman Zippel wrote:
> > On Mon, 10 Mar 2003, Greg KH wrote:
> > > > It seems that the semaphore in bus_add_device() makes this
> > > > unnecessary.
> > >
> > > Hm, yes.  I think you are correct.
> > >
> > > So this patch is not needed, and the struct module * can be ripped out
> > > of struct usb_driver too :)
> >
> > I think it's not easy. I haven't studied the code completely yet, but
> > e.g. when you attach a device to a driver you also have to get a
> > reference to the driver.
>
> You get a link to the driver, but you can't increment the module count
> of the driver at that time, as we have to be able to remove a module
> somehow :)

That is simple. Export a generic way to disconnect a driver from a device.

> > I think there are more interesting races, e.g. when you create a sysfs
> > symlink, that symlink might also have references to a module.
>
> Yeah, I still think there are some nasty issues with regards to being in
> a sysfs directory, with a open file handle, and the module is removed.
> But I haven't checked stuff like that in a while.
>
> CONFIG_MODULE_UNLOAD, just say no.

That is taking the easy way out.

	Regards
		Oliver

