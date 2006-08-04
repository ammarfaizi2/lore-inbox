Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWHDAHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWHDAHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWHDAHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:07:17 -0400
Received: from thunk.org ([69.25.196.29]:33201 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932193AbWHDAHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:07:15 -0400
Date: Thu, 3 Aug 2006 20:07:07 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Miller <davem@davemloft.net>
Cc: mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060804000707.GA15342@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Miller <davem@davemloft.net>, mchan@broadcom.com,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060803201741.GA7894@thunk.org> <20060803.144845.66061203.davem@davemloft.net> <1154647699.3117.26.camel@rh4> <20060803.164311.91310742.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803.164311.91310742.davem@davemloft.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:43:11PM -0700, David Miller wrote:
> From: "Michael Chan" <mchan@broadcom.com>
> Date: Thu, 03 Aug 2006 16:28:19 -0700
> 
> > > eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[0] TSOcap[0]
> > 
> > We'll see if we can do away with the timer-based heartbeat.  That's
> > probably the best solution.
> 
> The tg3 driver is not the only device in the world that requires a
> timer based "ping" to work.  The watchdog drivers and the softlockup
> detector are other instances which require a timer to not be delayed
> an unreasonable amount of time.
> 
> Therefore TG3 is not unique in this regard, and I thus don't think
> it's worthwhile to change tg3 just to accomodate this broken behavior
> of the RT patches.

Removing the timer-based "ping" might be a good thing to do from the
point of view of reducing power utilization of laptops (but hey, I
don't have a tg3 in my laptop, so I won't worry about it a whole lot :-), 
but I agree that in general the RT patches need to be able to
call functions such as tg3_timer() reliably even when under a high
real-time process workload, without needing to use the blunt hammer of
"chrt -f 95 `pidof softirq-timer`".  (Since not all timer callbacks
need to be run at rt prio 95.)

						- Ted
