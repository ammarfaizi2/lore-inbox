Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTAUVgF>; Tue, 21 Jan 2003 16:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTAUVgF>; Tue, 21 Jan 2003 16:36:05 -0500
Received: from gate.perex.cz ([194.212.165.105]:16389 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266948AbTAUVgD>;
	Tue, 21 Jan 2003 16:36:03 -0500
Date: Tue, 21 Jan 2003 22:43:43 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2
In-Reply-To: <20030121160228.GH26108@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301212223550.6355-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Adam Belay wrote:

> On Tue, Jan 21, 2003 at 09:09:14PM +0100, Jaroslav Kysela wrote:
> 
> > > the card is not detected by pnp, that problem stays. is that a problem of the pnp layer or is
> > > my toshiba laptop just so damn stupid??
> > 
> > Nope. It's fault of the driver. It scans for a card. Actually, the
> > structure card -> devices is created only by the ISA PnP driver.
> > 
> > I don't see any reason to not group the PnP BIOS devices into one "card", 
> > too. Adam, do you have any comments?
> > 
> 
> I have considered this approach several times.  However, there are the following
> problems with representing the pnpbios devices under one card:
> 
> 1.) If a driver attaches to the pnpbios card all other card-based drivers will
> be unable to use the pnpbios.  One will attach and cause the others to fail.  It
> is possible for the user to have more than one pnpbios sound card but with this
> approach such a user would only be able to use one sound device from the entire
> pnpbios.

I see. I think it's a design problem then. The rule card -> one driver is
bad. We need something between card and device which will take care about
drivers. Unfortunately, this information is dynamic (only driver knows
which devices have to be attached).

I think that we need to discuss this thing very carefully.

> 2.) Doing so would misrepresent the pnpbios topology because it physically
> doesn't have any cards.
> 
> 3.) The opl3sa2 driver doesn't need a card because it is only asking for one
> device anyway.  Using the card interface puts unnecessary overhead on both the
> driver and the pnp layer.

Yes, but IT SHOULD WORK. Although it isn't an most efficient way. (I
personally think that it's better to keep as much IDs as possible to avoid
clashes in future).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

