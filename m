Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbTCJXv0>; Mon, 10 Mar 2003 18:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262078AbTCJXv0>; Mon, 10 Mar 2003 18:51:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16132 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261928AbTCJXvY>;
	Mon, 10 Mar 2003 18:51:24 -0500
Date: Mon, 10 Mar 2003 15:51:31 -0800
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030310235131.GF13145@kroah.com>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308202101.GA26831@kroah.com> <20030310214443.GA13145@kroah.com> <200303110048.43514.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303110048.43514.oliver@neukum.name>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 12:48:43AM +0100, Oliver Neukum wrote:
> 
> > diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
> > --- a/drivers/base/bus.c	Mon Mar 10 13:52:15 2003
> > +++ b/drivers/base/bus.c	Mon Mar 10 13:52:15 2003
> > @@ -263,14 +263,25 @@
> >  	if (dev->bus->match(dev,drv)) {
> >  		dev->driver = drv;
> >  		if (drv->probe) {
> > -			if ((error = drv->probe(dev))) {
> 
> It seems that the semaphore in bus_add_device() makes this unnecessary.

Hm, yes.  I think you are correct.

So this patch is not needed, and the struct module * can be ripped out
of struct usb_driver too :)

Thanks,

greg k-h
