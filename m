Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRB0RfV>; Tue, 27 Feb 2001 12:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129674AbRB0RfM>; Tue, 27 Feb 2001 12:35:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58054 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129664AbRB0Rez>;
	Tue, 27 Feb 2001 12:34:55 -0500
Date: Tue, 27 Feb 2001 09:33:29 -0800
From: Greg KH <greg@wirex.com>
To: Dag Brattli <dag@brattli.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] patch-2.4.2-irda1 (irda-usb)
Message-ID: <20010227093329.A10482@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Dag Brattli <dag@brattli.net>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200102270829.IAA46514@tepid.osl.fast.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102270829.IAA46514@tepid.osl.fast.no>; from dag@brattli.net on Tue, Feb 27, 2001 at 08:29:03AM +0000
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 08:29:03AM +0000, Dag Brattli wrote:
> Linus,
> 
> Please apply this patch to your latest Linux-2.4.2 source. Changes:
> 
> o IrDA-USB dongle support [new feature]

I'd recommend that this file be in the /drivers/usb directory, much like
almost all other USB drivers are.

> +/* These are the currently known IrDA USB dongles. Add new dongles here */
> +struct irda_usb_dongle dongles[] = { /* idVendor, idProduct, idCapability */
> +	/* ACTiSYS Corp,  ACT-IR2000U FIR-USB Adapter */
> +	{ 0x9c4, 0x011, IUC_SPEED_BUG | IUC_NO_WINDOW },
> +	/* KC Technology Inc.,  KC-180 USB IrDA Device */
> +	{ 0x50f, 0x180, IUC_SPEED_BUG | IUC_NO_WINDOW },
> +	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
> +	{ 0x8e9, 0x100, IUC_SPEED_BUG | IUC_NO_WINDOW },
> +	{ 0, 0, 0 }, /* The end */
> +};

You should also probably add the following snippet to allow the USB
hotplug functionality to work properly:

static __devinitdata struct usb_device_id id_table [] = {
        { USB_DEVICE(0x09c4, 0x0011) },
        { USB_DEVICE(0x050f, 0x0180) },
        { USB_DEVICE(0x08e9, 0x0100) },
        { }                                     /* Terminating entry */
};
MODULE_DEVICE_TABLE (usb, id_table);		

If IRDA has a class descriptor, can't you just rely on that, and not
have to worry about the individual device vendor and product ids?


> + * This routine is called by the USB subsystem for each new device
> + * in the system. We need to check if the device is ours, and in
> + * this case start handling it.
> + * Note : it might be worth protecting this function by a global
> + * spinlock...
> +static void *irda_usb_probe(struct usb_device *dev, unsigned int ifnum,
> +			   const struct usb_device_id *id)

A spinlock is not needed as the probe functions are called sequentially.


thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
