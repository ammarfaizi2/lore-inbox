Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTHaCmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbTHaCmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:42:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61366
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262397AbTHaCmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:42:33 -0400
Date: Sun, 31 Aug 2003 04:42:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831024248.GR24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <200308302218.45779.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308302218.45779.jeffpc@optonline.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 10:18:37PM -0400, Jeff Sipek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 30 August 2003 21:39, Andrea Arcangeli wrote:
> > On Sun, Aug 31, 2003 at 03:05:37AM +0200, Pascal Schmidt wrote:
> > > On Sat, 30 Aug 2003, Larry McVoy wrote:
> > > >> All you have to do is drop the incoming packets if they exceed
> > > >> a certain bandwidth.
> > > >
> > > > If you think we haven't done that, think again.
> > > >
> > > > We're at the wrong end of the pipe to do that, I'm pretty sure that
> > > > what you are describing simply won't work.
> > >
> > > In a way, you're on the right end of the pipe because the system
> > > that does your traffic shaping is part of the general network, viewed
> > > from the machines behind the shaper.
> > >
> > > Dropping the packets means that the sending side, at least if we're
> > > talking TCP, will throttle its sending rate. But, depending on the
> > > distance in hops to the sender, it may take up to a few seconds for
> > > this to kick in. So I guess that's why it doesn't work for your
> > > VoIP case - the senders don't notice fast enough that they should
> > > slow down.
> >
> > that's because you don't limit the bkbits.net to a fixed rate. If you
> > want to give priorities, it won't work well because it takes time to be
> > effective, but if you rate limit hard both ways it has to work, unless
> > you're under syn-flood ;) The downside is that you will waste bandwith
> > (i.e. you will hurt the bkbits.net service even when you don't use
> > voip), but it will work.
> 
> How about giving something to voip as a hard limit and then using some shaper 
> to give it more if needed.

it may take a few secs to rate limit the rest, the old tcp connections
will keep sending packets that will get rejected when voip kicks in,
that's the problem described in the email I answered to with the
solution (i.e.  limit bkbits.net hard). I'm pretty sure that rate
limting bkbits.net hard (like we do with my brother's computer when he
generates heavy traffic) will let voip to work flawlessy, but it has the
downside of limiting the bandwith available to bkbits users even when
nobody place phone calls. Upgrading the current line and using the
software rate limiting with the solution I proposed, or adding a new
line dedicated to bkbits.net, wouldn't be much different in practice (if
it was me I'd choose it only in function of what's more cost effective,
after double checking that my algorithm infact works fine for higher
bandwidth too, I only tested it on 640kbit).

Andrea
