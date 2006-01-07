Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWAGMnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWAGMnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWAGMnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:43:16 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:40861 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1030428AbWAGMnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:43:16 -0500
Date: Sat, 7 Jan 2006 07:45:44 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys	interface
Message-ID: <20060107124544.GA3972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <20060107083602.GE3184@neo.rr.com> <20060107102554.GC9225@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107102554.GC9225@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 11:25:54AM +0100, Pavel Machek wrote:
> > > I asked for an example.
> > 
> > Look at the ACPI spec, it has several examples...
> > 
> > 1.) most sound cards have more than two states. (once again latency over
> > power savings trade offs)
> 
> What is the latency in typical "most sound card" case?

ACPI requires within 100ms for D1 and D2.  D3 can be longer.

> > 4.) IDE hard drives and other storage media have "sleep", "suspend",
> > etc.
> 
> Yep; but spindown takes 5 seconds, so if you need to reset ide bus or
> not to get it back is driver detail. Plus notice how power consuption
> in sleep and suspend is almost same; motor not running is big deal
> there. Ouch and hdparm already handles these.

5 seconds is more of an upper bound.  My laptop hardrive can do spindown
and spinup in around 1 second.  hdparm doesn't handle the deeper suspend
case (it can enter but not recover).  Kernel level support is required.

> 
> > 6.) many video cards implement D1 and D2 as you've already seen.  This
> > is often more a matter of "we only know how to restore from such and such
> > states"
> 
> Excatly, so "on"/"off" is enough for them.

Not really.  The ACPI spec suggests latency requirements for each state.
If we had better drivers, we might enter a lower latency video card
state when the screen is blanked that's not quite an "off" state.

The ACPI spec also defines intermediate states for input devices,
various display classes, and modems.

-Adam

