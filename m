Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTCBU5o>; Sun, 2 Mar 2003 15:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTCBU5n>; Sun, 2 Mar 2003 15:57:43 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:47020 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264748AbTCBU5m>; Sun, 2 Mar 2003 15:57:42 -0500
Date: Sun, 2 Mar 2003 22:06:22 +0100
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org, John Weber <weber@sixbit.org>
Subject: Re: [UPDATED PATCH] pcmcia: add bus_type pcmcia_bus_type, struct pcmcia_driver
Message-ID: <20030302210622.GA20572@brodo.de>
References: <20030301213328.GA4480@brodo.de> <3E625D76.8050503@sixbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E625D76.8050503@sixbit.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 02:37:26PM -0500, John Weber wrote:
> Dominik Brodowski wrote:
> >This patch adds a new bus_type pcmcia_bus_type, and registers all pcmcia
> >drivers with this bus within the old register_pccard_driver()
> >function. 
> >
> >Alternatively, a new registration function "pcmcia_register_driver()"
> >(and its counterpart,  "pcmcia_unregister_driver()") can be used --
> >the pcnet_cs.c driver is converted as an example.
> >
> >This updated version fixes the compilation breakage seen with gcc-2.95.3
> >because of incompatible C99 initializers (sorry, Russell). 
> 
> I've applied this patch, and have run the kernel for a few days without 
> problems.

Thanks!

> Do you have an example driver ported to this new api?  I can help 
> convert drivers.
 
That's great. However, this depends on Linus merging my patch. And it may
well be (and I even suggest this) that he takes Russell King's pcmcia/cardbus 
patches first.

The actual changes (in this step of getting rid of cardmgr) are quite few,
the larger ones will follow later:

there's a register_pccard_driver() call and a register_pccard_driver
somewhere in the pcmcia drivers. forget the first parameter (&dev_info most
of the time), the second one becomes the .attach call, the third one the
.detach call in a 

static struct pcmcia_driver dummy_driver = {
	.drv = {
		.name	= "dummy_cs",
	},
	.attach		= dummy_attach,
	.detach		= dummy_detach,
	.owner		= THIS_MODULE,
};

Then replace the {un,}register_pccard_driver() with
pcmcia_{un,}register_driver(&dummy_driver), respectively.

A sample conversion for the drivers/net/pcmcia/pcnet_cs.c driver can be
found within the patch you replied to, btw.

	Dominik
