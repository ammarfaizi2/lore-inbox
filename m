Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTBGIrb>; Fri, 7 Feb 2003 03:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267744AbTBGIra>; Fri, 7 Feb 2003 03:47:30 -0500
Received: from gate.perex.cz ([194.212.165.105]:62470 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267741AbTBGIr3>;
	Fri, 7 Feb 2003 03:47:29 -0500
Date: Fri, 7 Feb 2003 09:56:30 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PnP model
In-Reply-To: <20030205213426.GF22089@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302070950580.1141-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Adam Belay wrote:

> On Tue, Feb 04, 2003 at 10:49:37AM +0000, Russell King wrote:
> > On Tue, Feb 04, 2003 at 11:18:36AM +0100, Jaroslav Kysela wrote:
> > > I think that legacy devices must be probed after PnP ones, otherwise
> > > you'll get these duplications.
> > 
> > Unfortunately, this isn't easy to do, while keeping stuff like serial
> > consoles working from early at bootup.  Alan Cox definitely does not
> > want to see the serial console initialised any later than it is today,
> > and he's not the only one.
> > 
> > In addition, the "legacy" devices are part of the 8250.c module - they
> > have to be for serial console.  The PNP devices are probed as part of
> > the 8250_pnp.c module, and since 8250_pnp.c depends on 8250.c, the
> > serial PNP ports will _always_ be initialised after the ISA probes.
> >
> 
> I think I have an alternative solution.  If we add support for current
> resource configs and don't reset the cards, we can determine what the
> active configuration was when the serial driver detects the isapnp card.
> Because the device will remain active the resources will not be changed.
> Below is a patch against my previous 5 patches.  This patch also
> contains a few fixes and cleanups.  Could you please test this and let
> me know if it solves the problem.
> 
> Also I noticed that the serial driver legacy probe, independent of my
> changes, sometimes detects the incorrect irq, is proper irq detection
> needed by the serial driver or will it still work properly even if
> that information is detected incorrectly?

> -int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
> +int isapnp_reset = 0;			/* reset all PnP cards (deactivate) */

Please, don't do this. The default value is quite ok. I think that it's
more PnP BIOS problem than ISA PnP one (I don't know about any motherboard
where the standard serial ports are ISA PnP). But the parsing of active
configuration when isapnp_reset == 0 is ok...

> +	for (tmp = 0; tmp < PNP_MAX_PORT && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)

Again, pnp_valid_* macros are your fried. You deleted them from your 
tree during merge.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

