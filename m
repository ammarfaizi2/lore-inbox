Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbRE1T1g>; Mon, 28 May 2001 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbRE1T10>; Mon, 28 May 2001 15:27:26 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:2054 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S263126AbRE1T1L>;
	Mon, 28 May 2001 15:27:11 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105281926.XAA03405@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
To: mingo@elte.hu
Date: Mon, 28 May 2001 23:26:27 +0400 (MSK DST)
Cc: andrea@suse.de, davem@redhat.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.33.0105272255560.6868-100000@localhost.localdomain> from "Ingo Molnar" at May 27, 1 11:00:08 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> yep you are right.
> 
> i had this fixed too at a certain point, there is one subtle issue: under
> certain circumstances tasklets re-activate the tasklet softirq(s) from
> within the softirq handler, which leads to infinite loops if we just
> naively restart softirq handling.

Exactly. That's why it is not made in this way. 8)

Actually, Andrea's patch (probably improved) is the only visible
direction to solve this.

>From the other hand note one thing: the problem is old like pyramides.
It was always present and it is much _lighter_ in 2.4 comparing
f.e. with 2.2, because in 2.4 at least different softirqs are served
with low latency. So, if you guys consider Andrea's solution too cumbersome,
consider at least adding check for pending softirqs in idle task
(f.e. recent patch by Manfred Spraul) and the things still will
be quite satisfactory.

BTW Ingo, probably you missed one different moment in TUX: schedule() points.
If you do not schedule for long time, all the engine stops to work.
F.e. local_bh_disable() made in thread context are legal when and
only when some schedule() or return from syscall will follow really soon.

Alexey


PS Sorry, I am still offline, but returning to life.
