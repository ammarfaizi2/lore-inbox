Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUG2IBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUG2IBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUG2IBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:01:46 -0400
Received: from cachan-4-82-66-238-12.fbx.proxad.net ([82.66.238.12]:50133 "EHLO
	nestor.hd.free.fr") by vger.kernel.org with ESMTP id S262756AbUG2IA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:00:59 -0400
Subject: Re: [patch] IRQ threads
From: Philippe Gerum <rpm@xenomai.org>
To: Bill Huey <bhuey@lnxw.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Karim Yaghmour <karim@opersys.com>,
       Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040728202107.GA6952@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys>
	 <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe>
	 <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe>
	 <20040728202107.GA6952@nietzsche.lynx.com>
Content-Type: text/plain
Message-Id: <1091052203.626.315.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 00:03:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 22:21, Bill Huey wrote:

> With that said, there's really two camps that are emerging in the real
> time Linux field, dual and single kernel. The single kernel work that's
> current being done could very well get Linux to being hard RT, assuming
> that you solve all of the technical problems with things like RCU,
> etc... in 2.6.
> 
> The dual kernels folks would be in less of position to VAR their own
> stuff and sell proprietary products if Linux were to get native hard RT
> performance if you accept that economic criteria. Who knows what the
> actual results will be.

<snip>

> Now that Windriver System (the idiot folks that never understood Linux
> before laying off tons of folks and disbanned the rather famous BSD/OS
> group which I was apart of, etc...) and Red Hat is in the picture, it's
> all starting to cook up.
> 

With the ego power switch and name-calling amplifier lowered to the
minimum, maybe there could be a third approach, like cooperation between
both through a better integration. At least, the signal / noise ratio
would improve...

The hard RT people I know of and work with want to be able 1) to get
microsecond level bounded interrupt latency with no exception to this
rule, and 2) to be able to choose the right level of dispatch latency
on a thread-by-thread basis, from a few microseconds to a few hundreds
of, but in any case _bounded_ and predictable in the worst case. For
this to happen, they are willing to accept stringent limitations
functionaly-wise if need be to obtain the first, but still get access
to the regular Linux programming model and APIs if the second fits
their apps.  They already know how they could mix both properly in
what would look like a single system from the application pov.

For these people, the current undergoing work aimed at improving the
current determinism of the vanilla kernel is everything but a danger:
it's fundamental and very good news, because it could make 2) a
reality sooner or later. However, point 1) remains an issue, and
unless you find a solution for mixing fire and water, i.e. determinism
which requires unfairness by design and throughput seeking fairness on
the average case, you would likely end up considering that the Linux
RT people's radical approach of using a dual-kernel does not make them
uneducated bozos (Ok, except me perhaps, but this is not my point).
To get microsecond level guaranteed interrupt latencies, the problem
is far beyond solving random latency spots here and there: it's an
architectural issue.

To achieve this, we (i.e. the educated ones like Karim helping the
uneducated bozo like myself; yep, this is a teamwork) have come to the
conclusion that we needed a portable infrastructure that allows a
complete prioritization of interrupts, and hw events of interest in
general (e.g. traps/exceptions). Some infrastructure that exposes the
same interface regardless of the platform it runs on. It's called
Adeos, the source code identation is terrible (after 20 years practicing
it, I still
find means to worsen my coding style, funky eh?!) but it's a working
example of such kind of infrastructure. The advantage of such kind of
thin layer is that you can plug any hard real-time core over it. This
layer can remain silent when unused, it can be configured out, it is
just an enabler.  You don't have to put the hell of a havoc in a
stable GPOS core to modify some key architectural characteristics of
the Linux kernel in order to buy hard RT capabilities to everyone,
which could be construed as smashing a squadron of flies with nukes.

> All things to think about.

There is evidence that the GPL side of the hard RT universe does too.
Indeed.

-- 

Philippe.

