Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSHQAZl>; Fri, 16 Aug 2002 20:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSHQAZl>; Fri, 16 Aug 2002 20:25:41 -0400
Received: from waste.org ([209.173.204.2]:45195 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318883AbSHQAZk>;
	Fri, 16 Aug 2002 20:25:40 -0400
Date: Fri, 16 Aug 2002 19:29:29 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Jon Burgess <Jon_Burgess@eur.3com.com>, henrique@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817002929.GM5418@waste.org>
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <3D5D6621.E33EA4BE@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5D6621.E33EA4BE@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 04:52:49PM -0400, Chris Friesen wrote:
> Oliver Xymoron wrote:
> 
> > There is little to no reliably unpredictable data in network
> > interrupts and the current scheme does not include for the mixing of
> > untrusted sources. It's very likely that an attacker can measure,
> > model, and control such timings down to the resolution of the PCI bus
> > clock on a quiescent system. This is more than good enough to defeat
> > entropy generation on systems without a TSC and given that the bus
> > clock is a multiple of the processor clock, it's likely possible to
> > extend this to TSC-based systems as well.
> 
> > Entropy accounting is very fickle - if you overestimate _at all_, your
> > secret state becomes theoretically predictable. I have some patches
> > that create an API for adding such hard to predict but potentially
> > observable data to the entropy pool without accounting it as actual
> > entropy, as well as cleaning up some other major accounting errors but
> > I'm not quite done testing them.
> 
> The problem is this.  If you have an embedded system that is
> headless, diskless, keyboardless, and mouseless, then your only
> remaining source of any interrupt-based entropy is the network.
> Also, if you add entropy to the pool without accounting it as
> entropy, then how does that help anything?

Yes, you _potentially_ improve the unpredictability of /dev/urandom
without throwing out the guarantees of /dev/random. There is exactly
one difference between urandom and random - guaranteed entropy (ignore
for the moment that it's currently completely buggered, I'm fixing
that.). If you need guaranteed entropy, then you _need_ an
unobservable entropy source. Period. Pretending network interrupts are
unpredictable is just pretending.

> For the general user, network-based interrupts are likely okay.

If that's really true, then /dev/urandom is okay too, _by
definition_. Use it. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
