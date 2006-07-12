Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWGLVEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWGLVEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWGLVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:04:52 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:35716
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932261AbWGLVEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:04:51 -0400
Date: Wed, 12 Jul 2006 23:05:45 +0200
From: andrea@cpushare.com
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: Lee Revell <rlrevell@joe-job.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712210545.GB24367@opteron.random>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 11, 2006 at 04:19:35PM -0400, Andrew James Wade wrote:
> But only if SECCOMP code runs, otherwise it's never needed. OTOH, if it
> can't reduce the number of cacheline touches over a tuned seccomp common
> case, there's no benefit either.

Yep.

> I'm not an expert, but I believe I'm using the terminology correctly.

Nobody else answered so you must be right then ;).

> Yes. By necessity any proofs about software must make assumptions that
> aren't quite valid. Such proofs can still be useful of course. I think
> we're in agreement.

We are.

> useful to the attacker. f00f also has very limited security
> implications, as I understand it.

f00f has very limited implications and it would be immediately stopped
from creating further damage (I could even autodetect it with some
clever heuristic). In fact on architectures with the NX bit the stack
can be marked not executable too, so then I could make self-modifying
code impossible, and in turn I would be able to filter out bytecode
reliably on the server. So even if a CPU has a bug not possible to
workaround in the kernel (like with the idt marked readonly) I could
prevent such a bug to be exploited thanks to the NX bit. The only
self-modifying code allowed currently is on the user stack and nothing
else. I didn't bother to enable the NX bit yet because most i686
misses it and there are not (yet) security related bugs that requires
bytecode filtering to be workarounded (and if they will appear, it
means such a cpu will be insecure for multiuser systems on linux
without any hope of software workarounds, only my special seccomp
usage could prevent such a CPU bug to trigger by filtering the
bytecode).

> The various software and hardware caches will open a plethora of
> timing side channels, almost all useless to an attacker in that the
> revealed information is uninteresting/useless. At least I would hope
> so. The downside of security is that it is hard to be sure.

The whole point of the tsc disable was exactly to be sure there are no
timing side channels. If they can't access an accurate source of time
information the very bytecode that attempts to measure the time will
simply get killed instantly.

Measuring time through the network currently is impractical, the rtt is
too huge for that (though perhaps 10 years from now we'll have to
rethink about this).

> Ah, fail safe. Nice property to have. From my observation, userspace
> does appear to have something of that property with regards to cpu
> bugs as well. What I recall from the errata sheets is that many of the
> bugs could only be triggered from privileged code.

Right.

> And that's where fail-safe and simple design comes in. In this
> application an oops is better than a jail-break by orders of

An oops or more generically a system crash.

> magnitude. But then that's why you wrote seccomp instead of using
> ptrace in the first place.

Exactly ;).
