Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTAUUvZ>; Tue, 21 Jan 2003 15:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTAUUvZ>; Tue, 21 Jan 2003 15:51:25 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:35208 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267222AbTAUUvY>;
	Tue, 21 Jan 2003 15:51:24 -0500
Date: Tue, 21 Jan 2003 16:02:28 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2
Message-ID: <20030121160228.GH26108@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@suse.cz>, Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200301212006.01107.daniel.ritz@gmx.ch> <Pine.LNX.4.44.0301212101130.6355-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301212101130.6355-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 09:09:14PM +0100, Jaroslav Kysela wrote:

> > the card is not detected by pnp, that problem stays. is that a problem of the pnp layer or is
> > my toshiba laptop just so damn stupid??
> 
> Nope. It's fault of the driver. It scans for a card. Actually, the
> structure card -> devices is created only by the ISA PnP driver.
> 
> I don't see any reason to not group the PnP BIOS devices into one "card", 
> too. Adam, do you have any comments?
> 

I have considered this approach several times.  However, there are the following
problems with representing the pnpbios devices under one card:

1.) If a driver attaches to the pnpbios card all other card-based drivers will
be unable to use the pnpbios.  One will attach and cause the others to fail.  It
is possible for the user to have more than one pnpbios sound card but with this
approach such a user would only be able to use one sound device from the entire
pnpbios.

2.) Doing so would misrepresent the pnpbios topology because it physically
doesn't have any cards.

3.) The opl3sa2 driver doesn't need a card because it is only asking for one
device anyway.  Using the card interface puts unnecessary overhead on both the
driver and the pnp layer.

4.) The PnP Card Services were designed to support older hardware (pre-pnpbios).
Eventually vendors realized how stupid it was to use more than one device to
perform a single function.  Therefore the opl3sa2 and others do not use several
devices and do not need a card interface.

I propose that we use a different solution...

What if we have the opl3sa2 driver along with the other one device drivers 
use the pnp_driver interface instead of the pnpc_driver.  Jaroslav, Do you
agree with this or would you suggest something else?  If you agree, I'll get
to work on a patch.

Regards,
Adam
