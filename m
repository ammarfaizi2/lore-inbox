Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSALF7Z>; Sat, 12 Jan 2002 00:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285048AbSALF7P>; Sat, 12 Jan 2002 00:59:15 -0500
Received: from zero.tech9.net ([209.61.188.187]:6672 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S285023AbSALF7E>;
	Sat, 12 Jan 2002 00:59:04 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Rob Landley <landley@trommello.org>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
	<1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> 
	<20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 01:01:39 -0500
Message-Id: <1010815300.2011.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-11 at 15:22, Rob Landley wrote:

> So the best approach is a combination of the two patches.  SMP-on-UP for 
> everything outside of spinlocks, and then manually yielding locks that cause 
> problems.  Both Robert Love and Andrew Morton have come out in favor of each 
> other's patches on lkml just in the past few days.  The patches work together 
> quite well, and each wants to see the other's patch applied.

Right.  Here is what I want for 2.5 as a _general_ step towards a better
kernel that will yield better performance:

Merge the preemptible kernel patch.  A version is now out for
2.5.2-pre11 with support for Ingo's scheduler:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

Next, make available a tool for profiling kernel latencies.  I have one
available now, preempt-stats, at the above url.  Andrew has some
excellent tools available at his website, too.  Something like this
could even be merged.  Daniel Phillips suggested a passive tool on IRC. 
Preempt-stats works like this.  It is off-by-default and, when enabled,
measures time between lock and unlock, reporting the top 20 worst-cases.

Begin working on the worst-case locks.  Solutions like Andrew's
low-latency and my lock-break are a start.  Better (at least in general)
solutions are to analyze the locks.  Localize them; make them finer
grained.  Analyze the algorithms.  Find the big problems.  Anyone look
at the tty layer lately?  Ugh.  Using the preemptive kernel as a base
and the analysis of the locks as a list of culprits, clean this cruft
up.  This would benefit SMP, too.  Perhaps a better locking construct is
useful.

The immediate result is good; the future is better.

	Robert Love

