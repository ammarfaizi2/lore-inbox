Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWAJNzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWAJNzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWAJNzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:55:22 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:59423 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbWAJNzV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:55:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R9TXOHnBMXpLTg3CRIZe/g9swqeIr0OGLSbZ4bIobILmD0hHVAaovL21da78jkzl97DHSnIgVVemrE4aGx7IEiWARGRPcFJFDR6OF3Fh+EQd9aDZpeWtVHywTmGmo/cC0PtK9cOYEaLUSOzyH4s1fNT93Cmc7lD+BFd9wosZx9M=
Message-ID: <5bdc1c8b0601100555k7538924cx7a17b3e405771691@mail.gmail.com>
Date: Tue, 10 Jan 2006 05:55:20 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <1136900950.6197.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
	 <43C17E50.4060404@stud.feec.vutbr.cz>
	 <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>
	 <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
	 <20060110100517.GA23255@elte.hu>
	 <1136900950.6197.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2006-01-10 at 11:05 +0100, Ingo Molnar wrote:
> > * Mark Knecht <markknecht@gmail.com> wrote:
> >
> > > > cdrecord does run with SCHED_RR/99 when started with proper privileges.
> > >
> > > Ah, then it's likely that this isn't a real problem and it would be
> > > expected to cause an xrun?
> > >
> > > Anyway, it seems strange that the trace doesn't show anything. I
> > > suppose that's because cdrecord just grabs a lot of time at a higher
> > > priority than Jack and Jack ends up not getting serivces at all for
> > > 5-10mS?
> >
> > the tracer will only detect undue delays in the 'highest prio' task in
> > the system - but it cannot detect whether all priorities in the system
> > are given out properly. In this particular case it was cdrecord that had
> > the highest priorities, and the delays you saw in Jackd were due to
> > cdrecord trumping Jackd's priority.
> >
> > One way to make such scenarios easier to notice & debug would be for
> > jackd to warn if there are tasks in the system that have higher
> > priorities. (maybe it could even do it at xrun time, from a lower-prio
> > thread.)
>
> Hmm, this reminds me. This system isn't a SMP machine is it?  SMP has
> threads that run at priority 99 to handle things like swapping tasks
> from one CPU to another.  These will never show up in the tracer since
> they are the highest priority.  But I have seen these threads cause
> latencies in some of my own code.
>
> -- Steve

Steven,
   No, this specific machine is UMP although I do have an HT machine I
use once in awhile that might fall prey to what you are mentioning.

   While I have to agree that *if* cdrecord is running at a higher
priority then Jack would get trumped, I'm not positive yet that we
know that's true in this specific case. I have not yet received any
response from the developer of k3b, and while cdrecord is listed in
the setup of k3b I'm not sure how to test that it is really causing
the specific failure I saw.

NOTE: I'm sure cdrecord probably is causing this. I just don't want to
believe it is without some technical confirmation and assume there's
nothing that could be improved in the kernel.

NOTE 2: This case is pathological as I would never start writing a CD
when doing important audio work that requires zero xruns. I reported
it only to learn more myself.

Thanks,
Mark
