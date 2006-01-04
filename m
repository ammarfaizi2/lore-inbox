Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWADRQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWADRQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWADRQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:16:39 -0500
Received: from waste.org ([64.81.244.121]:24040 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932174AbWADRQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:16:38 -0500
Date: Wed, 4 Jan 2006 11:10:04 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, mingo@elte.hu,
       tim@physik3.uni-rostock.de, arjan@infradead.org, torvalds@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060104171003.GC3356@waste.org>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <43BB0B8B.1000703@mbligh.org> <20060104042822.GA3356@waste.org> <43BB6255.2030903@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BB6255.2030903@mbligh.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 09:51:17PM -0800, Martin J. Bligh wrote:
> Matt Mackall wrote:
> 
> >On Tue, Jan 03, 2006 at 03:40:59PM -0800, Martin J. Bligh wrote:
> > 
> >
> >>It seems odd to me that we're doing this by second-hand effect on
> >>code size ... the objective of making the code smaller is to make it
> >>run faster, right? So ... howcome there are no benchmark results
> >>for this?
> >>   
> >>
> >
> >Because it's extremely hard to design a benchmark that will show a
> >significant change one way or the other for single kernel functions
> >that doesn't also make said functions unusually cache-hot. And part of
> >the presumed advantage of uninlining is that it leaves icache room for
> >random other code that you're _not_ benchmarking.
> >
> >In other words, if it's not a microbenchmark, it generally can't be
> >measured, directly or indirectly. And if it is a microbenchmark, the
> >result is known to be biased.
> > 
> >
> Well, it's not just one function, is it? It'd seem that if you unlined
> a whole bunch of stuff (according to this theory) then normal
> macro-benchmarks would go faster? Otherwise it's all just rather
> theoretical, is it not?

Yes, if we uninline a big hunk of stuff, we should see results. But
which hunk? Running benchmarks w/ and w/o Ingo's 3 patches should be
educational. As would with -Os.

Also note that there are going to be cases where smaller wins by
orders of magnitude: where it makes the difference between the working
set fitting in cache or RAM or not.
 
> Cool, that sounds good. How much are we talking about?
> I didn't see that in the thread anywhere ... perhaps I just
> missed it, sorry it got long ;-)

The out of line spinlock stuff went by about a year ago. Google for
"zwane spinlock out of line".

-- 
Mathematics is the supreme nostalgia of our time.
