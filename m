Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUHRMxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUHRMxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUHRMwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:52:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:2498 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266175AbUHRMuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:50:54 -0400
X-Authenticated: #4399952
Date: Wed, 18 Aug 2004 15:01:48 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Charbonnel <thomas@undata.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P3
Message-Id: <20040818150148.4d2c56ec@mango.fruits.de>
In-Reply-To: <20040818122703.GA17301@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu>
	<1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu>
	<20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu>
	<20040818141231.4bd5ff9d@mango.fruits.de>
	<20040818122703.GA17301@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 14:27:03 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Hi, it applied against 2.6.8.1 with some offsets and some buzz [?].
> > Well anyways it compiled fine and the copy_page_range latency is
> > gone.. Now i also see the extracty entropy thing, too..
> 
> could you try the attached patch that changes SHA_CODE_SIZE to 3 -
> does this reduce the latency caused by extract_entropy?

will do..

> 
> > Btw: one question: at one point in time the IRQ handlers were in the
> > SCHED_FIFO scheduling class. Why has this changed?
> 
> so that they dont starve the audio threads by default - the audio IRQ
> has to get another priority anyway. Maybe we could try a default
> SCHED_FIFO prio lower than the typical rt_priority of jackd - e.g. 30?

Oh, upon rereading the chrt manpage i found out why i failed to set them
to SCHED_FIFO manually. So it was my error. I thought the
scheduling of the IRQ handlers was not changable at runtime. Thus my
question to make them SCHED_FIFO by default.

Well, i still think they should be SCHED_FIFO by default, so no user
process that is not itself SCHED_FIFO can starve them [X11 was able to
starve mouse irq's on my system with the defualt IRQ handlers
running SCHED_OTHER FWIW]. To make starving of user-SCHED_FIFO processes
unprobably maybe use a default static prio of 0.

Afaik jackd uses priorities > 0 for its audio threads when runing
SCHED_FIFO anyways..

But since the user will have to tweak his IRQ handlers manually anyways
[set soundcard irq higher prio than the rest, etc..], it doesn't really
make a difference.

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

