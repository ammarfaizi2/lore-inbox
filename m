Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTL1RQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTL1RQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:16:09 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:43994 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S261779AbTL1RQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:16:05 -0500
Date: Sun, 28 Dec 2003 18:15:12 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@surriel.com>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-ID: <20031228171512.GA13031@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@surriel.com>,
	torvalds@osdl.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com> <20031226190045.0f4651f3.akpm@osdl.org> <20031227230757.GA25229@k3.hellgate.ch> <20031227235538.GP22443@holomorphy.com> <20031228112339.GA4847@k3.hellgate.ch> <20031228163528.GK27687@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228163528.GK27687@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 08:35:28 -0800, William Lee Irwin III wrote:
> > the aggregated reference frequency is all that matters. I was merely
> > pointing out how the number of processes referencing a page could affect
> > performance as well. Reference frequency is used as an estimator for
> > the _likelihood_ of a fault in the future, but the potential _impact_
> > of a fault grows with the number of processes that may block on it.
> > It is one possible (though not necessarily the most likely) explanation
> > for the symptoms I see with 2.6.
> 
> I guess caution against LFU is uncontroversial.

My bad. What I said is true for both LRU and LFU (they try to predict
the probability of future references), but I wrote "frequency" because
that happened to be on my mind (for unrelated reasons). The point was
basically: risk = probability * damage

> I'm not convinced what vmstat gets out of 2.4 is entirely comparable to
> what it gets out of 2.6. "blocked" and "running" are collected very

Agreed. OTOH those readings are consistent with other observations I
made. It should even be possible to add up the reported idle times and
receive a ballpark figure for the slowdown compared to a system with
more than enough memory.

> differently in 2.6. iowait shouldn't be collected on 2.4 at all.

True. If 2.4 reports idle time during a compile benchmark, though, it
seems plausible to assume it is IO wait. And if 2.6 takes much longer
than 2.4 to complete, it is due to time spend waiting for I/O (minus
some difference in system overhead) -- the work done in user space is
equal, after all.

> This could probably be addressed by backporting 2.6's reporting methods
> to 2.4 so the two kernels use similar reporting mechanisms.

I don't think it's worth it. It wouldn't tell us anything we don't
already know.

> The oscillation in "free" and "buff" is very unusual. What is this
> box doing?

Oops, sorry. That trace is a few months old and I forgot I had used a
hack to have timestamps in vmstat. The large numbers that are alternating
are jiffies, the smaller numbers are the actual readings.

Roger
