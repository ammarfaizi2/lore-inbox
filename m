Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUKPFyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUKPFyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUKPFyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:54:55 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:22695 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261900AbUKPFyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:54:53 -0500
Date: Tue, 16 Nov 2004 00:52:40 -0500
To: matthieu castet <castet.matthieu@free.fr>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       bjorn.helgaas@hp.com, vojtech@suse.cz
Subject: Re: [PATCH] PNP support for i8042 driver
Message-ID: <20041116055240.GF29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	matthieu castet <castet.matthieu@free.fr>, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com, vojtech@suse.cz
References: <41960AE9.8090409@free.fr> <200411140148.02811.dtor_core@ameritech.net> <41974DFD.5070603@free.fr> <d120d50004111506416237ff1b@mail.gmail.com> <419908B8.10202@free.fr> <d120d500041115122846b9f0fa@mail.gmail.com> <41993320.3010501@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41993320.3010501@free.fr>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 11:52:16PM +0100, matthieu castet wrote:
> Hi,
> 
> Dmitry Torokhov wrote:
> >On Mon, 15 Nov 2004 20:51:20 +0100, matthieu castet
> >>Yes you could do a very ugly hack : set pnp_can_disable(dev) to 0 before
> >> unregister. With that the device won't be disabled (no resource
> >>desalocation), but the device will be mark as not active in pnp layer.
> >>
> >
> >
> > I'd like to release resoures al well (interrupts only really, as 
> ports are
> > always reserved by the system even before PNP is initialized).

They shouldn't be.  PnP detection should occur before the system assumes the
location of a device.  I realize that it can be difficult given the current
state of many drivers.  Still, I think assuming information about a device,
especially if you consider how easy it is to get from ACPI etc., can be
potentially dangerous.

> >I think you need to make an effort to make a PCI device use IRQ12
> >but the idea is that if you don't have a mouse attached (but you do
> >have i8042) and you are short on free interrupts and your HW can
> >use IRQ12 for some other stuff let it have it. That is the reqson why
> >i8042 requests IRQ only when corresponding port is open. No mouse -
> >IRQ is free.
> >
> And what happen if you use irq12 for an other stuff and you plug your 
> mouse and try to use it. The motherboard hasn't desalocated the irq12 
> for mouse, so there will be a big conflict...

I agree.  Disabling the device is fine, but we _really_ should disable the
device with the BIOS before assuming a resource is free.

Thanks,
Adam
