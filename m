Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272912AbRIRJA4>; Tue, 18 Sep 2001 05:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272926AbRIRJAq>; Tue, 18 Sep 2001 05:00:46 -0400
Received: from ns.ithnet.com ([217.64.64.10]:28942 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272912AbRIRJAe>;
	Tue, 18 Sep 2001 05:00:34 -0400
Date: Tue, 18 Sep 2001 11:00:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm rewrite ready [Re: broken VM in 2.4.10-pre9]
Message-Id: <20010918110048.095af437.skraw@ithnet.com>
In-Reply-To: <20010918004116.A698@athlon.random>
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>
	<9o1dev$23l$1@penguin.transmeta.com>
	<1000722338.14005.0.camel@x153.internalnet>
	<20010916203414.B1315@athlon.random>
	<20010917174037.7e3739b9.skraw@ithnet.com>
	<20010918004116.A698@athlon.random>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001 00:41:16 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> [ CC'ed to l-k with Stephan approval ]
> > - cpu average load is low, during whole test sometimes even below 3
> >   (never saw
> > this before)
> 
> Good.
> 
> I also had another report with very vfs intensive operation going on and
> I suspect this patch will be a good idea (even if it can lead to the
> usual excessive grow of the vfs caches on the long run but the current
> way is probably too aggressive).

Hm, are you sure about this? Here is /proc/meminfo after a night of heavy nfs
action (we are at the server side):

        total:    used:    free:  shared: buffers:  cached:
Mem:  923574272 919187456  4386816        0 39723008 793706496
Swap: 271392768  1417216 269975552
MemTotal:       901928 kB
MemFree:          4284 kB
MemShared:           0 kB
Buffers:         38792 kB
Cached:         775052 kB
SwapCached:         52 kB
Active:         811464 kB
Inactive:         2432 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       901928 kB
LowFree:          4284 kB
SwapTotal:      265032 kB
SwapFree:       263648 kB

You see most mem found its way in the active queue. If you talk about
"aggressive" meaning aggressively aged or even freed, I cannot see it.
I will go on for another day without additional patching and see how things
evolve and how the system behaves in interactive situation.

Ah, another thing to mention. I got some _new_ alloc failures:

Sep 18 04:16:49 admin kernel: nfsd __alloc_pages: 1-order allocation failed
(gfp=0x20/0) from c012de72
Sep 18 04:17:27 admin kernel: nfsd __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012de72
Sep 18 04:21:18 admin kernel: gzip __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012de72

c012de5c T _alloc_pages 
c012de74 t balance_classzone

Hope this helps,
Stephan

