Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVKEIMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVKEIMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 03:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKEIMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 03:12:03 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15881 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751216AbVKEIMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 03:12:02 -0500
Date: Sat, 5 Nov 2005 08:59:15 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>
Subject: Re: Linux-2.4.31-hf8
Message-ID: <20051105075915.GD11266@alpha.home.local>
References: <20051104231815.GA26093@alpha.home.local> <436C5895.3040409@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436C5895.3040409@drugphish.ch>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roberto, Hi Marcelo,

On Sat, Nov 05, 2005 at 08:00:37AM +0100, Roberto Nibali wrote:
> Well, to be honest, Horms just found another IPVS "issue" :). It seems
> we are getting into reviewing 2.4.x IPVS a bit more closely. The problem
> is that if you have setups where the persistency timeout is below the
> IPVS state machine related FIN_WAIT (not TCP state) timeout (currently
> 2*60*HZ) persistent templates will not be invalidated and the timer gets
> re-set if a we still have a valid connection entry hashed. I've first
> noted this somewhat aberrant behaviour in 2.2.x kernels but never got
> around looking at it too closely because in 2.2.x we had a timer mess.
> 
> This issue however is absolutely minor since this buglet has been there
> for ages already and we never received such a bug report. In fact, it
> would be quite unusual to set a persistency timeout below fin_wait in a
> LVS_DR setup for productive environments. And I didn't see it because I
> set the FIN_WAIT to 10*HZ to relax sockets lingering. We can/will queue
> it up, together with a small refcnt change for -hf9 and post 2.4.32.

I have a feeling that we will have a lot of network related fixes post
2.4.32 (IPVS, IPv6, mcast...). Marcelo, perhaps it would be a good idea
to merge them in early 2.4.33-pre1 so that competent users have enough
time to test them ? As Roberto explained it, some of the fixes need
hours or days of testing, and some of them are used by only a bunch of
people around the world.

> I take it you read netdev as well, since we will post those patches
> there.

OK, I will put my nose there.

> I'm delighted to see your -hf kernels since lately I have been
> told off by a couple of kernel maintainers regarding 2.4.x, which we use
> in about 100 of our boxes all over the world, about 300 still run 2.2.x
>   and are slowly migrated to the now stable 2.4.x series. Doing business
> in the finance sector really opts for stability, which is given by 2.4.x.

Working half of my time in the same area, I've been starting to consider
since 2.4.31 that 2.4 is becoming very stable and ready for production use
in those sensible environments. Having small kernels updates which don't
break PaX compatibility every two weeks is also a very good thing when
seeking for enhanced security on servers ;-)

Regards,
Willy

