Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293230AbSBWWZd>; Sat, 23 Feb 2002 17:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293227AbSBWWZN>; Sat, 23 Feb 2002 17:25:13 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:40207 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293229AbSBWWZC>;
	Sat, 23 Feb 2002 17:25:02 -0500
Date: Sat, 23 Feb 2002 15:23:37 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, yodaiken@fsmlabs.com,
        Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223152337.A3577@hq.fsmlabs.com>
In-Reply-To: <3C773C02.93C7753E@zip.com.au>, <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org> <3C781351.DCB40AD3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C781351.DCB40AD3@zip.com.au>; from akpm@zip.com.au on Sat, Feb 23, 2002 at 02:10:25PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 02:10:25PM -0800, Andrew Morton wrote:
> Roman Zippel wrote:
> > 
> > Hi,
> > 
> > yodaiken@fsmlabs.com wrote:
> > 
> > > Right. Without preemption it is safe to do
> > >         c = smp_get_cpuid();
> > >        ...
> > >         x = ++local_cache[c]
> > >        ..
> > >
> > >        y = ++different_local_cache[c];
> > >       ..
> > 
> > Just add:
> >         smp_put_cpuid();
> > 
> > Is that so much worse?
> > 
> 
> ooh.  me likee.

Cool. 
Me likee code with unmatched smp_get_cpuid/smp_put_cpuid.
Much nicer to write
	x = ++local_cache[smp_getcpuid()];
	smp_put_cuid();
than boring old
	x = ++ local_cache[c];

Is this part of some scheme to make the GPL support model actually
pay?


	c = smp_get_cpuid(); // disables preemption

	...
	f(); // oops, me forgotee, this function also references cpuid
	..
	x = ++local_cache[c]; // live dangerously
	smp_put_cpuid(); // G_d knows what that does now.

Oh, wait, I know - reference counts for get_cpuid! How hard can that
be? See how simple it is?  One simple step at a time.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

