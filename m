Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTHAG20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275130AbTHAG20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:28:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24550 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270682AbTHAG2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:28:17 -0400
Date: Fri, 1 Aug 2003 08:27:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linas@austin.ibm.com
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <olof@austin.ibm.com>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030731122334.A22900@forte.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0308010825270.20358-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003 linas@austin.ibm.com wrote:

> OK, I looked at removing run_all_timers, it doesn't seem too hard.
> 
> I would need to: 
> -- add TIMER_SOFTIRQ to interrupts.h,
> -- add open_softirq (run_timer_softirq) to timer.c init_timer()
> -- move guts of run_local_timers() to run_timer_softirq()
> -- remove bh locks in above, not yet sure about other locks
> -- remove TIMER_BH everywhere.  Or rather, remove it for those
>    arches that support cpu-local timer interupts (curently x86 & freinds, 
>    soon hopefully ppc64, I attach it below, in case other arches want to 
>    play with this).
> 
> Is that right?

no. In 2.4 there are (and/or can be) all sorts of assumptions about
TIMER_BH being serialized with other bh contexts (eg. the serial bh),
that's why i added the TIMER_BH logic to the 2.4 timer-scalability patch.  
You cannot just remove TIMER_BH. The way we did it in 2.5 was to remove
_all_ bhs and thus all assumptions about serialization. This is not an
option for 2.4 in any case.

	Ingo

