Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbRD1W6S>; Sat, 28 Apr 2001 18:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132892AbRD1W57>; Sat, 28 Apr 2001 18:57:59 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:17894 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S132757AbRD1W5x>; Sat, 28 Apr 2001 18:57:53 -0400
Date: Sat, 28 Apr 2001 16:56:27 -0600
Message-Id: <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        Fabio Riccardi <fabio@chromium.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010428215301.A1052@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> On Sat, Apr 28, 2001 at 05:52:42PM +0200, Ingo Molnar wrote:
> > 
> > On Sat, 28 Apr 2001, Andi Kleen wrote:
> > 
> > > You can also just use the cycle counter directly in most modern CPUs.
> > > It can be read with a single instruction. In fact modern glibc will do
> > > it for you when you use clock_gettime(CLOCK_PROCESS_CPUTIME_ID, ...)
> > 
> > well, it's not reliable while using things like APM, so i'd not recommend
> > to depend on it too much.
> 
> *If* you use APM on your server boxes. Not likely even when it doesn't have more than one CPU
> and it can be checked at runtime.
> 
> I guess glibc could also regularly (every 10 calls or so) call
> regular gettimeofday to recheck synchronization; at least for a web
> server that potential inaccuracy would be acceptable ("best effort")
> and the cost of the system call is 1/10.
> 
> In x86-64 there are special vsyscalls btw to solve this problem that export
> a lockless kernel gettimeofday()

Whatever happened to that hack that was discussed a year or two ago?
The one where (also on IA32) a magic page was set up by the kernel
containing code for fast system calls, and the kernel would write
calibation information to that magic page. The code written there
would use the TSC in conjunction with that calibration data.

There was much discussion about this idea, even Linus was keen on
it. But IIRC, nothing ever happened.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
