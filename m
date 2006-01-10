Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWAJNta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWAJNta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWAJNt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:49:29 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24234 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751073AbWAJNt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:49:29 -0500
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20060110100517.GA23255@elte.hu>
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
	 <43C17E50.4060404@stud.feec.vutbr.cz>
	 <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>
	 <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
	 <20060110100517.GA23255@elte.hu>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 08:49:10 -0500
Message-Id: <1136900950.6197.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 11:05 +0100, Ingo Molnar wrote:
> * Mark Knecht <markknecht@gmail.com> wrote:
> 
> > > cdrecord does run with SCHED_RR/99 when started with proper privileges.
> >
> > Ah, then it's likely that this isn't a real problem and it would be 
> > expected to cause an xrun?
> > 
> > Anyway, it seems strange that the trace doesn't show anything. I 
> > suppose that's because cdrecord just grabs a lot of time at a higher 
> > priority than Jack and Jack ends up not getting serivces at all for 
> > 5-10mS?
> 
> the tracer will only detect undue delays in the 'highest prio' task in 
> the system - but it cannot detect whether all priorities in the system 
> are given out properly. In this particular case it was cdrecord that had 
> the highest priorities, and the delays you saw in Jackd were due to 
> cdrecord trumping Jackd's priority.
> 
> One way to make such scenarios easier to notice & debug would be for 
> jackd to warn if there are tasks in the system that have higher
> priorities. (maybe it could even do it at xrun time, from a lower-prio 
> thread.)

Hmm, this reminds me. This system isn't a SMP machine is it?  SMP has
threads that run at priority 99 to handle things like swapping tasks
from one CPU to another.  These will never show up in the tracer since
they are the highest priority.  But I have seen these threads cause
latencies in some of my own code.

-- Steve


