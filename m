Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVKBOfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVKBOfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVKBOfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:35:17 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:48362 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965036AbVKBOfP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:35:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lz8821bOFs/mDYsQfCiSMRAtP8xYBdGD4fLlNBEPIJ3w7n/8ovkAjvQZFs2VW3KzSqDQNt5HMG1RtVV4SC+NnRAVbAMGF+GWOFKc5oksR7wGBDaBCV54W3wR1dEVEBwI35aZjAsh5FJOXs8FDrpYnjZOW1xGDfJLeFtENydOCn4=
Message-ID: <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
Date: Wed, 2 Nov 2005 09:35:12 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: 2.6.14-rt1
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, john stultz <johnstul@us.ibm.com>,
       Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051102102116.3b0c75d1@mango.fruits.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
	 <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
	 <20051102102116.3b0c75d1@mango.fruits.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Florian Schmidt <mista.tapas@gmx.net> wrote:
> On Tue, 1 Nov 2005 23:05:09 -0500
> Carlos Antunes <cmantunes@gmail.com> wrote:
>
> > Here's the thing:
> > http://www.nowthor.com/OpenPBX/timing.c
> >
> > Let me know what kind of results you get.
>
> Hi,
>
> running the code i simply get:
>
> ~$ ./timing
> Failed to create thread # 382
> Failed to create thread # 383
> Failed to create thread # 384
> Failed to create thread # 385
> Failed to create thread # 386
> Failed to create thread # 387
> ..
> Failed to create thread # 498
> Failed to create thread # 499
>
> and then
>
> Segmentation fault
>

That's interesting. Are you running a fairly recent pthread lib?

>
> Probably caused by not handling that some threads didn't get created. I
> reduced the number down to 300:
>
> ~$ ./timing
> Histogram
> Delay(ms)       Count
>  0              300000
>  1              0
>  2              0
>  3              0
>  4              0
>  5              0
>  6              0
>  7              0
>  8              0
>  9              0
> 10              0
> 11              0
> 12              0
> 13              0
> 14              0
> 15              0
> 16              0
> 17              0
> 18              0
> 19              0
> 20              0
> Num threads = 300
> Total sleeps = 300000
> Min error = 0.014 ms
> Max error = 0.133 ms
>
> What would you expect to see? BTW: cpu load stayed moderately small with
> this setting here.
>

Did you run that with SCHED_FIFO or SCHED_OTHER? If it was with
SCHED_FIFO, it was a pretty good result. But maybe your machine is
just very fast. What CPU is that? DId you use 2.6.14-rt2 or some other
version?

>
> As a sidenote: Of course the scheduling works completely different with
> hundreds of threads running SCHED_FIFO at the same priority than with
> hundreds of threads running SCHED_OTHER. SCHED_OTHER threads can preempt
> each other when the dynamic priority changes. SCHED_FIFO threads OTOH
> just sit and wait until they get to run, not preempting other SCHED_FIFO
> threads of the same priority. So basically each SCHED_FIFO thread waits
> until all others have run.
>

Yes, they are supposed to act differently. In particular, my
understanding of realtime scheduling suggests SCHED_FIFO is supposed
to provide better (meaning lower) wakeup latency.

Thanks for tryting this out. Although I'm still puzzled at the low
number of threads you were able to create.

Carlos

--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
