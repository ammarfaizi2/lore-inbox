Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVBESwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVBESwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273002AbVBESwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:52:06 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:63619 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272350AbVBESvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:51:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] PNP support for i8042 driver
Date: Sat, 5 Feb 2005 13:51:18 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Adam Belay <ambx1@neo.rr.com>, bjorn.helgaas@hp.com,
       Vojtech Pavlik <vojtech@ucw.cz>
References: <41960AE9.8090409@free.fr> <20050204182816.GA3573@ucw.cz> <4204CEB5.7000609@free.fr>
In-Reply-To: <4204CEB5.7000609@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051351.19311.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 08:48, matthieu castet wrote:
> Hi,
> 
> Vojtech Pavlik wrote:
> > On Fri, Feb 04, 2005 at 06:37:29PM +0100, matthieu castet wrote:
> > 
> >>Hi,
> >>
> >>Vojtech Pavlik wrote:
> >>
> >>>On Sat, Nov 13, 2004 at 02:23:53PM +0100, matthieu castet wrote:
> >>>
> >>>
> >>>>Hi,
> >>>>this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
> >>>>is try before the pnp driver so if you don't disable ACPI or apply 
> >>>>others pnpacpi patches, it won't change anything.
> >>>>
> >>>>Please review it and apply if possible
> >>>
> >>>
> >>>Ok, my thoughts on this:
> >>>
> >>>	It's OK to keep the device allocated to this driver via the PnP
> >>>       subsystem, and not bother with releasing the code via
> >>>	__initcall.
> >>>
> >>>	I agree that if there is a way to enumerate the device, (like
> >>>	PnP, ACPI or OpenFirmware), we should use that instead of
> >>>	probing and using a platform device for the controller.
> >>>
> >>>	I think that we should drop the ACPI support from i8042, in
> >>>	favor of pnpacpi, because PnP is more generic and if the
> >>>	keyboard device was listed in PnPBIOS instead of ACPI, it'll
> >>>	still work.
> >>>
> >>
> >>Any news about this ?
> > 
> >  
> > Sort of fell off my radar, can you resend?
> > 
> attached 2 versions : the one that kill acpi detection and the one with
> acpi but a complex init.
> 

Hi Matthieu,

I think that we should kill ACPI now that ACPIPNP is available.

I have a concern though - having PNP driver activated means that we
now have i8042 in 2 or 3 places in driver model hierarchy, once as a
platform device and the as kbd and aux PNP devices. I wonder how the
power management will be coordinated - we normally need to reset
controller so BIOS will not be upset and then I need parent for the
KBD and AUX serio ports. Plus I guess PNP system enables and disables
resources so serio suspend/resume calls should be in right order.

With ACPI we don't have this problem at the moment since ACPI drivers
are not integrated into driver model yet.

> PS : I resend it, because, it seem it have failed for Vojtech Pavlik.

Vojtech asked to use his vojtech@ucw.cz address over the weekend as his
suse.sz has problems.

-- 
Dmitry
