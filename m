Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUKOOon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUKOOon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUKOOnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:43:01 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:18351 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261614AbUKOOl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:41:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NjNGnqVKg3MePNyipc0Utnya1KPVW6GC/0K318fPcVHSMiEClP4tt8F0KZj34yHelWweq01XANjyUnFkqK0A+5uxdvgOT/jrOY/7qw8tLJ7eukc54XZ82fHatGrz1OqtpHN/xn48uF1II0Hc7SyxEJaPnWCMaMe9nW5AWwgkgvA=
Message-ID: <d120d50004111506416237ff1b@mail.gmail.com>
Date: Mon, 15 Nov 2004 09:41:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] PNP support for i8042 driver
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
In-Reply-To: <41974DFD.5070603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41960AE9.8090409@free.fr>
	 <200411140148.02811.dtor_core@ameritech.net>
	 <41974DFD.5070603@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004 13:22:21 +0100, matthieu castet
<castet.matthieu@free.fr> wrote:
> Dmitry Torokhov wrote:
> 
> 
> > On Saturday 13 November 2004 08:23 am, matthieu castet wrote:
> >
> >>Hi,
> >>this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi
> >>is try before the pnp driver so if you don't disable ACPI or apply
> >>others pnpacpi patches, it won't change anything.
> >>
> >>Please review it and apply if possible
> >>
> >>thanks,
> >>
> >>Matthieu CASTET
> >>
> >>Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
> >>
> >
> > Hi,
> >
> Hi,
> > Do we really need to keep those drivers loaded - i8042 will not
> > be hotplugged and ports are reserved anyway. We are only interested
> > in presence of the keyboard and mouse ports. Can we unregister
> > the drivers (both ACPI and PNP) right after registering and mark
> > all that stuff as __init/__initdata as in the patch below?
> It is better to keep pnp driver loaded because when it unload, the
> resources will be disabled, so for the motherboards that allow it the
> irq won't work anymore, and so the keyboard and mouse won't work...

Is it possible to leave the device in enabled state or enable device
after unloading the driver with PNP? All we need from PNP layer
for i8042 is to verify presence of the KBC, we don't need resource
management.The ports range is already marked as reserved, IRQ
will be requested if needed...

-- 
Dmitry
