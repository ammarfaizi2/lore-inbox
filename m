Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135619AbRD1Txv>; Sat, 28 Apr 2001 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135622AbRD1Txl>; Sat, 28 Apr 2001 15:53:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:55495 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135619AbRD1Txf>;
	Sat, 28 Apr 2001 15:53:35 -0400
Date: Sat, 28 Apr 2001 21:53:01 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        Fabio Riccardi <fabio@chromium.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010428215301.A1052@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Apr 28, 2001 at 05:52:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 05:52:42PM +0200, Ingo Molnar wrote:
> 
> On Sat, 28 Apr 2001, Andi Kleen wrote:
> 
> > You can also just use the cycle counter directly in most modern CPUs.
> > It can be read with a single instruction. In fact modern glibc will do
> > it for you when you use clock_gettime(CLOCK_PROCESS_CPUTIME_ID, ...)
> 
> well, it's not reliable while using things like APM, so i'd not recommend
> to depend on it too much.

*If* you use APM on your server boxes. Not likely even when it doesn't have more than one CPU
and it can be checked at runtime.

I guess glibc could also regularly (every 10 calls or so) call regular gettimeofday
to recheck synchronization; at least for a web server that potential inaccuracy would
be acceptable ("best effort") and the cost of the system call is 1/10.

In x86-64 there are special vsyscalls btw to solve this problem that export
a lockless kernel gettimeofday()

-Andi
