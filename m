Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHXCk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 22:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTHXCk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 22:40:56 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:60331
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262273AbTHXCky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 22:40:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]O18.1int
Date: Sun, 24 Aug 2003 12:46:37 +1000
User-Agent: KMail/1.5.3
Cc: piggin@cyberone.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200308231555.24530.kernel@kolivas.org> <200308240258.33924.kernel@kolivas.org> <20030823144907.6bcce289.akpm@osdl.org>
In-Reply-To: <20030823144907.6bcce289.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241246.38356.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 07:49, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > > >It might help if you or a buddy could get set up with volanomark on an
> > > >
> >  > > OSDL 4-or-8-way so that you can more closely track the effect of
> >  > > your changes on such benchmarks.
> >
> >  Ok here goes.
> >  This is on 8way:
> >
> >  Test4:
> >  Average throughput = 11145 messages per second
> >
> >  Test4-O18.1:
> >  Average throughput = 9860 messages per second
> >
> >  Test3-mm3:
> >  Average throughput = 9788 messages per second
> >
> >
> >  So I grabbed test3-mm3 and started peeling back the patches
> >  and found no change in throughput without _any_ of my Oxint patches
> > applied, and just Ingo's A3 patch:
> >
> >  Test3-mm3-A3
> >  Average throughput = 9889 messages per second
> >
> >
> >  Then finally I removed that patch so there were no interactivity
> > patches: Test3-mm3-ni
> >  Average throughput = 11052 messages per second
>
> Well that was quick, thanks.
>
> Surely the only reason we see more idle time in this sort of workload is
> because of runqueue imbalance: some CPUs are idle while other CPUs have
> more than one runnable process.  That sounds like a bug more than a
> tuning/balancing thing: having no runnable tasks is a sort of binary
> do-something-right-now case.
>
> We should be going across and pullng a task off another CPU synchronously
> as soon as a runqueue is seen to be empty.  The code tries to do that so
> hrm.
>
> Ingo just sent the below patch which is related, but doesn't look like it
> will fix it.  I'll include this in test4-mm1, RSN.

Just for the record I also tried inlining sched_clock and removing the rdtsc 
call entirely (and just getting the value from jiffies) and it made no 
measurable impact on performance.

Con

