Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVLaA7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVLaA7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVLaA7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:59:08 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:18152 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751278AbVLaA7H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:59:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jTju4pNf+e+5/D1kk1kW0Oq/Xa8H8MPjfTzDy4dMC0EIKvIIHdRAe3AMVbWhwEWd+oysiokDUt/M9Vd40duHxHEcvLJsn69BMGzZPtLM61kwaBXeOOieQOECFWxGTXAcwxkx7x0Kfa8qXsa3XQYaiC/s2n9dJjrnN8ryjKk4iQg=
Message-ID: <5bdc1c8b0512301659m5d4431bu6915dbe10d9aaa79@mail.gmail.com>
Date: Fri, 30 Dec 2005 16:59:06 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1135990270.31111.46.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1135726300.22744.25.camel@mindpipe>
	 <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com>
	 <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe>
	 <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu>
	 <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu>
	 <1135990270.31111.46.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-12-30 at 09:00 +0100, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > > It seems that debug_smp_processor_id is being called a lot, even
> > > though I have a UP config, which I didn't see with the -rt kernel:
> >
> > do you have CONFIG_DEBUG_PREEMPT enabled? (if yes then disable it)
> >
> > > Was this optimized out on UP before?
> >
> > no, because smp_processor_id() debugging is useful on UP too: it checks
> > whether smp_processor_id() is every called with preemption enabled, and
> > reports such bugs.
>
> It seems that the networking code's use of RCU can cause 10ms+
> latencies:
>


Hi,
   I've noted for awhile that on my AMD64 machine that has xrun issues
that at least annecdotally it has always seemed that the network
interface was somehow involved. I wonder if this may turn out to be
true?

Q: Did the latency trace stuff ever get fixed for AMD64? I'm running
2.6.15-rc7-rt1 as of today. I've had xruns all afternoon while working
inside of MythTV. (Start, stop, rewind, pause all over the place...)

15:09:47.132 Statistics reset.
15:09:47.303 Client activated.
15:09:47.304 Audio connection change.
15:09:47.307 Audio connection graph change.
15:09:48.147 Audio connection graph change.
15:09:48.327 Audio connection change.
15:09:50.487 Audio connection graph change.
15:34:05.107 XRUN callback (1).
**** alsa_pcm: xrun of at least 0.148 msecs
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:36:15.580 XRUN callback (2).
**** alsa_pcm: xrun of at least 0.707 msecs
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:38:07.232 XRUN callback (3).
**** alsa_pcm: xrun of at least 0.967 msecs
**** alsa_pcm: xrun of at least 2.921 msecs
15:38:08.143 XRUN callback (1 skipped).
15:39:36.616 XRUN callback (5).
**** alsa_pcm: xrun of at least 0.079 msecs
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:43:04.318 XRUN callback (6).
**** alsa_pcm: xrun of at least 1.065 msecs
**** alsa_pcm: xrun of at least 0.955 msecs
15:43:05.642 XRUN callback (1 skipped).
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:44:16.964 XRUN callback (8).
**** alsa_pcm: xrun of at least 1.311 msecs
**** alsa_pcm: xrun of at least 1.956 msecs
15:44:18.028 XRUN callback (1 skipped).
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:45:11.371 XRUN callback (10).
**** alsa_pcm: xrun of at least 1.409 msecs
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:49:22.014 XRUN callback (11).
**** alsa_pcm: xrun of at least 1.332 msecs
16:10:30.306 XRUN callback (12).
**** alsa_pcm: xrun of at least 0.368 msecs
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
16:30:05.355 XRUN callback (13).
**** alsa_pcm: xrun of at least 0.873 msecs
subgraph starting at qjackctl-7906 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
16:33:21.938 XRUN callback (14).
**** alsa_pcm: xrun of at least 1.647 msecs

Bad stuff...

- Mark
