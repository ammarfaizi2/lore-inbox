Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWADEec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWADEec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 23:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWADEec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 23:34:32 -0500
Received: from waste.org ([64.81.244.121]:20398 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S965213AbWADEeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 23:34:31 -0500
Date: Tue, 3 Jan 2006 22:28:23 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, mingo@elte.hu,
       tim@physik3.uni-rostock.de, arjan@infradead.org, torvalds@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060104042822.GA3356@waste.org>
References: <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <43BB0B8B.1000703@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BB0B8B.1000703@mbligh.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 03:40:59PM -0800, Martin J. Bligh wrote:
> It seems odd to me that we're doing this by second-hand effect on
> code size ... the objective of making the code smaller is to make it
> run faster, right? So ... howcome there are no benchmark results
> for this?

Because it's extremely hard to design a benchmark that will show a
significant change one way or the other for single kernel functions
that doesn't also make said functions unusually cache-hot. And part of
the presumed advantage of uninlining is that it leaves icache room for
random other code that you're _not_ benchmarking.

In other words, if it's not a microbenchmark, it generally can't be
measured, directly or indirectly. And if it is a microbenchmark, the
result is known to be biased.

In the rare case of functions that are extremely popular (like
spinlock and friends), we _can_ actually see small improvements in
macrobenchmarks like kernel compiles. So it's fairly reasonable to
assume that reducing icache footprint really does matter more than
cycle count and extrapolate that to other functions.

(Unfortunately, Zwane is an enemy of history and the URL for the
benchmarks he posted for out-of-line spinlock has gone stale.)

-- 
Mathematics is the supreme nostalgia of our time.
