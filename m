Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUCRPgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUCRPgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:36:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2697
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262698AbUCRPgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:36:43 -0500
Date: Thu, 18 Mar 2004 16:37:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318153731.GG2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <1079623222.4167.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079623222.4167.52.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:20:23AM -0500, Tom Sightler wrote:
> Well, I reported an issue on my laptop several weeks ago where network
> activity via my aironet wireless adapter would use 60-70% of the CPU but
> only when PREEMPT was enabled.  Looking back over the list I see other

sounds like a preempt bug triggering in a softirq, or maybe an SMP bug
triggering in UP.

I certainly agree with Andrew that preempt cannot cause a 60/70%
slowdown with a network card at least (if you do nothing but spinlocking
in a loop then it's possible a 60/70% slowdown instead but the system
time that a wifi card should take is nothing compared to the idle/user
time).

> I'll try to reproduce my issue with current generation kernels (last I
> tested with PREEMPT was 2.6.1) and see if my problem is still there. 
> When I reported the issue last time no one seemed interested so I just
> learned to disable preempt.

This is fine IMHO (even if they are preempt bugs). Except if your
machine is UP, if it's UP it would be better track down the bug, since
it may still happen on a SMP box (I wouldn't be too surprised if wifi
drivers aren't smp safe). I certainly agree with Andrew when he says
preempt is a good debugging knob to debug smp bugs in UP (though I would
leave it off in production UP, like in production SMP).
