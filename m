Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286743AbRLVJ2T>; Sat, 22 Dec 2001 04:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286745AbRLVJ2G>; Sat, 22 Dec 2001 04:28:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30377 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286743AbRLVJ2A>;
	Sat, 22 Dec 2001 04:28:00 -0500
Date: Sat, 22 Dec 2001 12:25:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ashok Raj <ashokr2@attbi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: affinity and tasklets...
In-Reply-To: <PPENJLMFIMGBGDDHEPBBMEAHCAAA.ashokr2@attbi.com>
Message-ID: <Pine.LNX.4.33.0112221222020.4780-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Ashok Raj wrote:

> In a MP case, we would like 2 separate processors taking the
> completion processing. But running tasklets dont seem to suit this
> since it basically queues on the same CPU that is currently running,
> and this means both get queued to the same tasklet_vec[cpu]. But i
> want each to run on a separate CPU. is using softirq the right method?
> or could i have cpu affinity for tasklets? (i know there is afficinity
> for interrupts, but iam not aware of this for tasklets.)

you'll get a natural affinity of tasklets: they will run on the processor
where the tasklet got activated. Tasklets are just a special form of
softirqs, they have no context in the classic task sense, the only
difference they have to softirqs is that the tasklet code guarantees
single-threadedness of the function executed.

if you are going to rely on tasklets for good SMP scalability then i'd
suggest using a separate tasklet for every device IRQ. Then bind hardirqs
to a particular CPU - thus both the hardirq, the softirq/tasklet will run
on the same processor.

	Ingo

