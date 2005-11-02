Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVKBJV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVKBJV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVKBJV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:21:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:41436 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932691AbVKBJV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:21:26 -0500
X-Authenticated: #4399952
Date: Wed, 2 Nov 2005 10:21:16 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, john stultz <johnstul@us.ibm.com>,
       Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt1
Message-ID: <20051102102116.3b0c75d1@mango.fruits.de>
In-Reply-To: <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
References: <20051017160536.GA2107@elte.hu>
	<20051020195432.GA21903@elte.hu>
	<20051030133316.GA11225@elte.hu>
	<1130876293.6178.6.camel@cmn3.stanford.edu>
	<1130899662.12101.2.camel@cmn3.stanford.edu>
	<cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	<1130900716.29788.22.camel@localhost.localdomain>
	<cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	<1130902342.29788.23.camel@localhost.localdomain>
	<cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005 23:05:09 -0500
Carlos Antunes <cmantunes@gmail.com> wrote:

> Here's the thing:
> http://www.nowthor.com/OpenPBX/timing.c
> 
> Let me know what kind of results you get.

Hi,

running the code i simply get:

~$ ./timing 
Failed to create thread # 382
Failed to create thread # 383
Failed to create thread # 384
Failed to create thread # 385
Failed to create thread # 386
Failed to create thread # 387
..
Failed to create thread # 498
Failed to create thread # 499

and then

Segmentation fault

Probably caused by not handling that some threads didn't get created. I
reduced the number down to 300:

~$ ./timing 
Histogram
Delay(ms)       Count
 0              300000
 1              0
 2              0
 3              0
 4              0
 5              0
 6              0
 7              0
 8              0
 9              0
10              0
11              0
12              0
13              0
14              0
15              0
16              0
17              0
18              0
19              0
20              0
Num threads = 300
Total sleeps = 300000
Min error = 0.014 ms
Max error = 0.133 ms

What would you expect to see? BTW: cpu load stayed moderately small with
this setting here.

As a sidenote: Of course the scheduling works completely different with
hundreds of threads running SCHED_FIFO at the same priority than with
hundreds of threads running SCHED_OTHER. SCHED_OTHER threads can preempt
each other when the dynamic priority changes. SCHED_FIFO threads OTOH
just sit and wait until they get to run, not preempting other SCHED_FIFO
threads of the same priority. So basically each SCHED_FIFO thread waits
until all others have run.

Dunno, if that would make a difference in this case though..

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
