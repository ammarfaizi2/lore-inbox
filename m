Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSGXAyY>; Tue, 23 Jul 2002 20:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSGXAyY>; Tue, 23 Jul 2002 20:54:24 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:33806 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S315709AbSGXAyX>;
	Tue, 23 Jul 2002 20:54:23 -0400
Message-ID: <3D3DFC3B.677AFDD7@tv-sign.ru>
Date: Wed, 24 Jul 2002 05:00:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-G0
References: <Pine.LNX.4.44.0207240137190.3812-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> > Then local_bh_enable() has a small preemptible window between
>
> i dont think getting a preemption before softirqs are processed is a big
> problem. Such type of preemption comes in form of an interrupt, which

Ah, yes...

> > But in irq_exit() case interrupt context may be preempted
>
> okay - i've fixed irq_exit() once more in -G4

found G5, your forgot to add preempt_disable() in irq_exit()

 #define irq_exit()
 do {
+               preempt_disable();
                preempt_count() -= IRQ_EXIT_OFFSET;
                if (!in_interrupt() && softirq_pending(smp_processor_id()))

Oleg.
