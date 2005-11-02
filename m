Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVKBAjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVKBAjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKBAjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:39:33 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:47427 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932078AbVKBAjb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JFQGAY2BTPx2j+Sxj4t6Le+QeX+YrF9HD1Xj6fvJ+8cV4vICRr4OqtASahxvwh2Pks0nFsYiuaVRLGKo7PEKcpUy5iMwpLcsVf7Zct5JRK467uK2yQezKLxJFzi6y9C1k8pmVe5KzWrZZUKWmsPedTg6z3egCz2ef+2/llOmxcE=
Message-ID: <cb2ad8b50511011639w4d457013ibc740b544e8d6ecf@mail.gmail.com>
Date: Tue, 1 Nov 2005 19:39:27 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Esben Nielsen <simlo@phys.au.dk>
Subject: Re: BUG Realtime-preempt 2.6.16-rt2?
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Esben Nielsen <simlo@phys.au.dk> wrote:
>
>
> On Tue, 1 Nov 2005, Carlos Antunes wrote:
>
> > On 11/1/05, Carlos Antunes <cmantunes@gmail.com> wrote:
> > > On 11/1/05, Esben Nielsen <simlo@phys.au.dk> wrote:
> > > > On Tue, 1 Nov 2005, Carlos Antunes wrote:
> > > >
> > > > > Hi!
> > > > >
> > > > > I've been developing some code for the OpenPBX project
> > > > > (http://www.openpbx.org) and wrote a program to test how the system,
> > > > > responds when hundreds of threads are spawned. These threads run at
> > > > > high priority (SCHED_FIFO) and use clock_nanocleep with absolute
> > > > > timeouts on a 20ms loop cycle.
> > > > >
> > > > > With the stock 2.6.14 kernel, I get latencies in the order of several
> > > > > milliseconds (but less than 20ms) when running 1250 threads
> > > > > simultaneously. However, when I switch to a kernel patched with
> > > > > realtime-preempt latency increases to several hundred milliseconds in
> > > > > many cases.
> > > >
> > > > There is only one explanation:
> > > > Some of the operations (task switch, nanosleep etc.) are more expensive in
> > > > the RT kernel. Thus your 1250 threads spend 100% CPU doing what they do.
> > > > You therefore get very bad latencies.
> > > >
> > >
> > > Esben,
> > >
> > > Thanks for replying. Let me chalenge this assumption of yours, though.
> > >
> > > I just ran a test with those 1250 threads (all they do is sleep for
> > > 20ms, wake up, increment a number, and repeat the process). The CPU
> > > was 86% *IDLE* while running this. One thread took 1.3 seconds to wake
> > > up once. Do you think this is, well, normal, given how RT is supposed
> > > to operate?
> > >
> >
> > Esben,
> >
> > If, instead of SCHD_FIFO, I use SCHED_OTHER, I get max latency in the
> > order 13ms running those 1250 threads. With SCHED_FIFO (the only
> > change), I get 1.3 seconds. Makes sense to you?
> >
>
> No. I can't explain that one. You might have discovered a bug in
> SCHED_FIFO. What about SCHED_RR?
>

Same thing with SCHED_RR. It appears the realtime-preempt patch breaks
realtime scheduling! It doesn't matter if I use priority 1 or 50 or
99. I always get the same problems with SCHED_FIFO and SCHED_RR. With
SCHED_OTHER, the system is much more responsive.

How do we go about calling Ingo's attention to this?

Carlos

--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
