Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbTGJUFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbTGJUFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:05:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40846
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266434AbTGJUFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:05:20 -0400
Date: Thu, 10 Jul 2003 22:19:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-ID: <20030710201939.GQ16313@dualathlon.random>
References: <200307060133.15312.bernie@develer.com> <20030710161859.GP16313@dualathlon.random> <20030710163918.GB18697@twiddle.net> <200307102131.45474.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307102131.45474.bernie@develer.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 09:31:45PM +0200, Bernardo Innocenti wrote:
> On Thursday 10 July 2003 18:39, Richard Henderson wrote:
> 
>  > On Thu, Jul 10, 2003 at 06:18:59PM +0200, Andrea Arcangeli wrote:
>  > > On Thu, Jul 10, 2003 at 08:40:19AM -0700, Richard Henderson wrote:
>  > > > On Tue, Jul 08, 2003 at 08:27:26PM +0200, Bernardo Innocenti wrote:
>  > > > > +extern uint32_t __div64_32(uint64_t *dividend, uint32_t
>  > > > > divisor) __attribute_pure__;
>  > > >
>  > > > ...
>  > > >
>  > > > > +		__rem = __div64_32(&(n), __base);	\
>  > > >
>  > > > The pure declaration is very incorrect.  You're writing to N.
>  > >
>  > > now pure sounds more reasonable, I wondered how could gcc keep track
>  > > of the stuff pointed by the parameters (especially if this stuff
>  > > points to other stuff etc.. ;).
> 
>  The compiler could easily tell what memory can be clobbered by a pointer
> by applying type-based aliasing rules. For example, a function taking a
> "char *" can't clobber memory objects declared as "long bar" or
> "struct foo".
> 
>  Without type based alias analysis, the compiler is forced to flush
> all registers containing copies of memory objects before function
> call and reloading values from memory afterwards.

the kernel isn't complaint with the alias analysis, that's why it has to
be turned off (-fnostrict-aliasing) or stuff would break.

> Boy, that's ugly! It's too bad C can't do it the Perl way:
> 
>     (n,rem) = __div64_32(n, base);

or the python way:

	n, rem = __div64_32(n, base)

;)

Andrea
