Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWBQH1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWBQH1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWBQH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:27:09 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:18373 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932546AbWBQH1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:27:07 -0500
Date: Fri, 17 Feb 2006 08:26:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nathan Lynch <nathanl@austin.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/4] s390: fix preempt_count of idle thread with cpu hotplug
Message-ID: <20060217072651.GA9230@osiris.boeblingen.de.ibm.com>
References: <20060216071808.GE9241@osiris.boeblingen.de.ibm.com> <43F4BFFC.8050604@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4BFFC.8050604@austin.ibm.com>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Set preempt_count of idle_thread to zero before switching off cpu.
> >Otherwise the preempt_count will be wrong if the cpu is switched on again
> >since the thread will be reused.
> 
> I had a similar discussion back in November, that one about
> /proc/interrupts stats.  Rather than do that all over again below is a cut
> and paste of my reply to that discussion.  The executive summary is I 
> rather like the current behavior as is.
> 
> -------------------------------------------------------------
> 
> > When CPU2 is off-lined, the statistics for CPU2 do not appear
> >(expected). However when you look at the before picture (all CPUs
> >present) and after picture (all cpus present after CPU2 re-added), you
> >see that the original data was returned and has incremented:

Think we're talking about different things. preempt_count is not statistical
stuff. Actually if you have preempt_count != 0 preemption is disabled.
At least on s390 we didn't set this counter to 0 in case of cpu hotplug thus
ending with a preempt_count > 0 if a cpu gets reenabled. Which gives us a lot
of warnings ala "scheduling while atomic: swapper/0x00000001/0".
So this is not a restriction that should be documented somewhere but a bug.

No idea how powerpc deals with this and if there is the same issue. Just
tried to give a hint since cpu hotplug code for powerpc and s390 looks quite
the same.

Heiko
