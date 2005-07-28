Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVG1S36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVG1S36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVG1S21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:28:27 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:36566 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261693AbVG1S0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:26:12 -0400
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
	the work)
From: Steven Rostedt <rostedt@goodmis.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
	 <1122522328.29823.186.camel@localhost.localdomain>
	 <42E8564B.9070407@yahoo.com.au>
	 <1122551014.29823.205.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>
	 <1122565640.29823.242.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 14:25:40 -0400
Message-Id: <1122575140.29823.258.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 17:34 +0100, Maciej W. Rozycki wrote:
> On Thu, 28 Jul 2005, Steven Rostedt wrote:
> 
> > I've been playing with different approaches, (still all hot cache
> > though), and inspecting the generated code. It's not that the gcc
> > generated code is always better for the normal case. But since it sees
> > more and everything is not hidden in asm, it can optimise what is being
> > used, and how it's used.
> 
>  Since you're considering GCC-generated code for ffs(), ffz() and friends, 
> how about trying __builtin_ffs(), __builtin_clz() and __builtin_ctz() as 
> apropriate?  Reasonably recent GCC may actually be good enough to use the 
> fastest code depending on the processor submodel selected.
> 

OK, I guess when I get some time, I'll start testing all the i386 bitop
functions, comparing the asm with the gcc versions.  Now could someone
explain to me what's wrong with testing hot cache code. Can one
instruction retrieve from memory better than others?  I was trying to
see which whas slower in CPU, but if an algorithm aligns with the cache
or something that is faster, my hot cache testing will not catch that.
But I don't know how to write a test that would test over and over again
something that is not in cache.  It would seem that I would have to find
a way to flush the L1 and L2 cache each time. But it still seems to be
adding too many variables to the equation to get good meaningful
benchmarks.

-- Steve


