Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312574AbSCYU5D>; Mon, 25 Mar 2002 15:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312573AbSCYU4y>; Mon, 25 Mar 2002 15:56:54 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:7598 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S312570AbSCYU4m>;
	Mon, 25 Mar 2002 15:56:42 -0500
Message-ID: <001101c1d43f$9e0b3f90$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: "Paul Clements" <kernel@steeleye.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <001001c1d436$90abdf70$010411ac@local> <3C9F870A.E1280D33@zip.com.au>
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt
Date: Mon, 25 Mar 2002 21:57:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew Morton" <akpm@zip.com.au>
> > OTHO, if a function doesn't work correctly if it's called with
disabled
> > interrupts, then it should not use spin_lock_irqsave() - it's
> > misleading.
> > e.g. if it calls kmalloc(GFP_KERNEL), down(), schedule(), etc.
>
> mm?  Those are legal (albeit unpleasant) inside local_irq_save(),
> but illegal inside global_cli() in 2.5.  Aren't they?  If not,
> then release_kernel_lock() needs talking to.
>
If a function is called with disabled interrupts, then the caller
probably expects that the interrupts remain disabled - otherwise he
would have reenabled them before calling. schedule reenables interrupts.
The calls might be legal, but usually they indicate a bug.

--
    Manfred

