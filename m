Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270773AbRHNTyD>; Tue, 14 Aug 2001 15:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270759AbRHNTxx>; Tue, 14 Aug 2001 15:53:53 -0400
Received: from fepD.post.tele.dk ([195.41.46.149]:13987 "EHLO
	fepD.post.tele.dk") by vger.kernel.org with ESMTP
	id <S270773AbRHNTxl>; Tue, 14 Aug 2001 15:53:41 -0400
Date: Tue, 14 Aug 2001 16:22:10 +0200
From: Erik Corry <erik@arbat.com>
To: lm@bitmover.com, linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010814162210.A6660@arbat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Larry McVoy" <20010808111844.S23718@work.bitmover.com> wrote:

> Someobdy really ought to take the time to make a cache miss counter program
> that works like /bin/time.  So I could do

> 	$ cachemiss lat_ctx 2
> 	10123 instruction, 22345 data, 50432 TLB flushes

Take a look at http://www.csd.uu.se/~mikpe/linux/perfctr/.

It's a patch to make the performance counters per-program, and
make them easy to control.

There's an example program in there called perfex which does what
you want, though the user interface isn't as simple as the above.
You can do

perfex -e 0x00430046 lat_ctx 2

The last two digits of the -e value are the counter to be printed,
which in this case (Athlon) is the data-TLB misses.  That stuff
is documented in 
http://www.amd.com/products/cpg/athlon/techdocs/pdf/22007.pdf
page 164/180

It would be nice if the patch found it's way into the kernel.

If you have APIC support there is also infrastructure for profiling
based on event-sampling instead of time sampling (sample every 100
cache misses instead of every 100us).  (Sadly my old 0.25um Athlon
has no APIC support).

-- 
Erik Corry erik@arbat.com           Ceterum censeo, Microsoftem esse delendam!
