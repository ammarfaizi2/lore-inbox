Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRB0USX>; Tue, 27 Feb 2001 15:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129833AbRB0USO>; Tue, 27 Feb 2001 15:18:14 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:45068 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129819AbRB0UR6>; Tue, 27 Feb 2001 15:17:58 -0500
Date: Tue, 27 Feb 2001 20:32:28 GMT
Message-Id: <200102272032.UAA74232@tepid.osl.fast.no>
To: greg@wirex.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        jt@bougret.hpl.hp.com
From: Dag Brattli <dag@brattli.net>
Reply-To: dag@brattli.net
Subject: Re: [patch] patch-2.4.2-irda1 (irda-usb)
X-Mailer: Pygmy (v0.5.0)
In-Reply-To: <20010227093329.A10482@wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001 09:33:29 -0800, Greg KH wrote:
> On Tue, Feb 27, 2001 at 08:29:03AM +0000, Dag Brattli wrote:
> > Linus,
> > 
> > Please apply this patch to your latest Linux-2.4.2 source. Changes:
> > 
> > o IrDA-USB dongle support [new feature]
> 
> I'd recommend that this file be in the /drivers/usb directory, much like
> almost all other USB drivers are.

Yes, but do we want to spread the IrDA code around? The same argument
applies to IrDA device drivers!?

> > +/* These are the currently known IrDA USB dongles. Add new dongles here */
> > +struct irda_usb_dongle dongles[] = { /* idVendor, idProduct, idCapability */
> > +	/* ACTiSYS Corp,  ACT-IR2000U FIR-USB Adapter */
> > +	{ 0x9c4, 0x011, IUC_SPEED_BUG | IUC_NO_WINDOW },
> > +	/* KC Technology Inc.,  KC-180 USB IrDA Device */
> > +	{ 0x50f, 0x180, IUC_SPEED_BUG | IUC_NO_WINDOW },
> > +	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
> > +	{ 0x8e9, 0x100, IUC_SPEED_BUG | IUC_NO_WINDOW },
> > +	{ 0, 0, 0 }, /* The end */
> > +};
> 
> You should also probably add the following snippet to allow the USB
> hotplug functionality to work properly:
> 
> static __devinitdata struct usb_device_id id_table [] = {
>         { USB_DEVICE(0x09c4, 0x0011) },
>         { USB_DEVICE(0x050f, 0x0180) },
>         { USB_DEVICE(0x08e9, 0x0100) },
>         { }                                     /* Terminating entry */
> };
> MODULE_DEVICE_TABLE (usb, id_table);		

OK!

> If IRDA has a class descriptor, can't you just rely on that, and not
> have to worry about the individual device vendor and product ids?

Sorry, some of the dongles don't follow the spec fully, as you can see from
our table. Actually none of them follow the spec, since they are all based
on the same chip which was made before the spec was finished. But there 
should be a new dongle out now which do follow the spec (but we haven't 
got hold of it yet)

> 
> > + * This routine is called by the USB subsystem for each new device
> > + * in the system. We need to check if the device is ours, and in
> > + * this case start handling it.
> > + * Note : it might be worth protecting this function by a global
> > + * spinlock...
> > +static void *irda_usb_probe(struct usb_device *dev, unsigned int ifnum,
> > +			   const struct usb_device_id *id)
> 
> A spinlock is not needed as the probe functions are called sequentially.
> 
> thanks,
> 
> greg k-h

----
Dag Brattli     <dag@brattli.net>
My homepage     http://www.brattli.net/dag/
Try Linux-IrDA: http://irda.sourceforge.net/
Try Pygmy:      http://pygmy.sourceforge.net/

