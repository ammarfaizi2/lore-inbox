Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbTC1If2>; Fri, 28 Mar 2003 03:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbTC1Iep>; Fri, 28 Mar 2003 03:34:45 -0500
Received: from [131.215.233.56] ([131.215.233.56]:16912 "EHLO bryanr.org")
	by vger.kernel.org with ESMTP id <S262763AbTC1IdL>;
	Fri, 28 Mar 2003 03:33:11 -0500
Date: Fri, 28 Mar 2003 00:31:22 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: Andrew Fleming <afleming@motorola.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] oprofile + ppc750cx perfmon
Message-ID: <20030328083122.GB5317@bryanr.org>
References: <20030327130535.GA1132@bryanr.org> <F0BBB858-6093-11D7-BD8D-000393C30512@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0BBB858-6093-11D7-BD8D-000393C30512@motorola.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 02:37:34PM -0600, Andrew Fleming wrote:
> I'm 99.9% positive that the counters are different.  In my experience, 
> every new microarchitecture has a completely different set of counters. 

yup. a kernel API to wrap all the low-level register config would be
nice but my interest for now is just the ppc750cx. If someone else wants to
build additional ppc32 support into oprofile, my patches could serve as a
basic starting point.

> Earlier on the list, the possibility of using the performance interrupt 
> with the timebase was proposed.

the timebase is simpler but less configurable than the PMCs.
my latest patch runs everything (oprofile+timer_interrupt)
via the timebase--there is no real support yet for the more
sophisticated PMCs.

We can allow for more user configurability by using the timebase
along side PMC interrupts. However, then we have to identify
which counter(s) caused a given interrupt, and that probably means
keeping some past state for the timebase and PMCs. For now, I'm satisfied
with hardcoded 1500 Hz profiling via the timebase; finishing up the syscall
interception is more important.

> [dec/pm switch-over race in v0003]

known issue, I was pondering a solution for a few days. It seems like
the decrementer is not individually maskable or haltable so my v0004
approach is to just do mtspr(SPRN_DEC, 0x7fffffff) upon enabling perfmon
and again inside each pm_irq.

-Bryan
