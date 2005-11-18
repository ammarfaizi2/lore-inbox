Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVKRX6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVKRX6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVKRX6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:58:31 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31661 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751117AbVKRX6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:58:30 -0500
Date: Fri, 18 Nov 2005 18:57:59 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
In-Reply-To: <1132357018.4735.51.camel@cmn3.stanford.edu>
Message-ID: <Pine.LNX.4.58.0511181851370.18873@gandalf.stny.rr.com>
References: <20051115090827.GA20411@elte.hu>  <1132336954.20672.11.camel@cmn3.stanford.edu>
  <1132350882.6874.23.camel@mindpipe>  <1132351533.4735.37.camel@cmn3.stanford.edu>
  <20051118220755.GA3029@elte.hu> <1132352143.6874.31.camel@mindpipe> 
 <Pine.LNX.4.58.0511181725030.17504@gandalf.stny.rr.com>
 <1132357018.4735.51.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Nov 2005, Fernando Lopez-Lezcano wrote:

> > Can it simply be pinned to a cpu?
>
> Is there a way to know in which cpu a process is running? At least Jack
> could ignore timinig issues if the measurement is going to happen in a
> different cpu than the one where the original timestamp was collected.
>

Simple answer? No. At least not meaningfully.

If you do:

cpu = fictitious_get_my_cpu();
if (cpu == last_cpu()) {
	rdtsc(oldtime);
	...
}

There's no guarantee that jack doesn't switch cpu's from when it found out
what CPU it was on to doing the calculation.  So it would be easier to pin
it.

(apt-get schedutils)

man 1 taskset

or if you modify the code:

mn 2 sched_setaffinity

-- Steve



