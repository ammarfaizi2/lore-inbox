Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSGXDBR>; Tue, 23 Jul 2002 23:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSGXDBR>; Tue, 23 Jul 2002 23:01:17 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:39438 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S316663AbSGXDBR>;
	Tue, 23 Jul 2002 23:01:17 -0400
Message-ID: <3D3E19F6.72806B9D@tv-sign.ru>
Date: Wed, 24 Jul 2002 07:07:34 +0400
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
> > __local_bh_enable() and do_softirq()->local_irq_save(flags).
> > It is only latency problem.
> 
> i dont think getting a preemption before softirqs are processed is a big
> problem. Such type of preemption comes in form of an interrupt, which
> handles softirqs in irq_exit() anyway, so there's no delay.

Well, no. Not all smp_xxx_interrupt() use irq_enter/exit().
Reschedule interrupt, for example, do not. But indeed, it is not
big problem.

Oleg.
