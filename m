Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269406AbRHGUKJ>; Tue, 7 Aug 2001 16:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269411AbRHGUJw>; Tue, 7 Aug 2001 16:09:52 -0400
Received: from ns.suse.de ([213.95.15.193]:48909 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269406AbRHGUJa>;
	Tue, 7 Aug 2001 16:09:30 -0400
Date: Tue, 7 Aug 2001 22:09:40 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Nico Schottelius <nicos@pcsystems.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: cpu not detected(x86)
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE025@orsmsx35.jf.intel.com>
Message-ID: <Pine.LNX.4.30.0108072201560.7230-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Grover, Andrew wrote:

> SpeedStep only drops it to 550 MHz. Any further drops are because of ACPI
> processor power or thermal management throwing off your program, because the
> current Linux gettimeofday code doesn't think the TSC is ever halted.

So how come when under heavy load (Ie, when TSC shouldn't be halted),
it only ever reports 266MHz ? Result of overeager CPU throttling?

> But, it is, when the processor is put into C2 or C3. Any benchmark
> which 1) uses the TSC and 2) does a sleep() will be wrong.

24319201.pdf Intel P3 system programmers guide, page 425.

"The counter is incremented on every processor clock cycle,
 even when the processor is halted by the HLT instruction or
 the external STPCLK# pin"

"The RDTSC instruction reads the time-stamp counter and is
  _guaranteed_ to return a monotonically increasing unique value
 _whenever_ executed, except for 64-bit wraparound".

Has this changed ? Or is this the result of a different mechanism?

> Longer-term, we need to change the kernel to not use the TSC for udelay, but
> to use the PM Timer, if ACPI is going to be monkeying with CPU power states.

A worthwhile idea if one is available, given the number of CPUs with
broken TSCs.

> PS Your system may also be throttling. It throttles in 12.5% increments, so
> that should be borne out in the MHz number if that's what it is doing.

If this is the case, it seems to throttle way too aggressively currently,
which could explain the 266MHz limit.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

