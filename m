Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284239AbRLAU1s>; Sat, 1 Dec 2001 15:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284238AbRLAU1j>; Sat, 1 Dec 2001 15:27:39 -0500
Received: from webcon.net ([216.187.106.140]:48776 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S284239AbRLAU1a>;
	Sat, 1 Dec 2001 15:27:30 -0500
Date: Sat, 1 Dec 2001 15:27:24 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: David Hinds <dhinds@sonic.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <dhinds@zen.stanford.edu>, <hermes@gibson.dropbear.id.au>
Subject: Re: in-kernel pcmcia oopsing in SMP
In-Reply-To: <20011201120541.B28295@sonic.net>
Message-ID: <Pine.LNX.4.40.0112011513041.2329-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, David Hinds wrote:

> I did fix one major SMP bug in the pcmcia-cs drivers just a couple
> days ago; the beta at http://pcmcia-cs.sourceforge.net/ftp/NEW has the
> fix.  I'm not sure if it is really the same bug you describe, though,
> since no one else has reported the ds module causing an immediate
> oops.

Hmm.. i'll look into that. If it keeps oopsing, i'll send you the dump.

> The standalone drivers are unlikely to help, though, because the
> orinoco_cs driver in the standalone package is virtually identical to
> the one in the current 2.4.* kernel.

True. Actually, they're older. 0.08b seems current.

> Actually, though, you could try the (older) wvlan_cs driver in the
> pcmcia-cs package.  You can do that with your current kernel drivers,
> even.  Unpack the pcmcia-cs package, do "make config", then cd to the
> wireless subdirectory and do a "make" there.  That should build a
> wvlan_cs module that will mesh with your kernel PCMCIA subsystem.  It
> will at least give you another data point.

I've tried the wvlan_cs driver. It works for a few inutes, then gets all
messed up and need to be reset. When it's hosed, iwconfig just dumps out a
lot of garbage, making me think the driver is writing all over itself.
Haven't tried this driver in UP mode.

I've also tried Lucent's binary driver, but it doesn't work at all. It will
allow a single packet to be sent then shuts down the tranceiver and changes
to channel 0 (?!) then needs to be reset before another single packet can be
sent, then shuts down the tranceiver again, etc, etc.. (this happens on
several UP and SMP machines).

> I don't know how to interpret your oops report; you should probably
> also forward the bug to David Gibson, hermes@gibson.dropbear.id.au,
> since he is the orinoco maintainer.

Well, Gibson's the one who suggested the broblem was with the pcmcia system,
and not the orinoco driver! Hmm.... can you say runaround?

Basically, before about 2.4.14, the orinoco driver would go haywire and dump
out lots of errors (Gibson is familiar with them) and need to be manually
reset. On more recent kernels however, instead of the driver crapping out
with errors, the system just hard locks.

Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------


