Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293252AbSCOVZD>; Fri, 15 Mar 2002 16:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCOVYx>; Fri, 15 Mar 2002 16:24:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51984 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293252AbSCOVYl>; Fri, 15 Mar 2002 16:24:41 -0500
Subject: Re: [PATCH] 2.4.18 scheduler bugs
To: joe.korty@ccur.com
Date: Fri, 15 Mar 2002 21:39:52 +0000 (GMT)
Cc: marcelo@conectiva.com.br, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200203152054.UAA27581@rudolph.ccur.com> from "Joe Korty" at Mar 15, 2002 03:54:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lzQW-0004j4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - ksoftirqd() - change daemon nice(2) value from 19 to -19.
> 
>     SoftIRQ servicing was less important than the most lowly of batch
>     tasks.  This patch makes it more important than all but the realtime
>     tasks.

Bad idea - the right fix to this is to stop using ksoftirqd so readily
under load. If it bales after 20 iterations life is good. As shipped life
is bad.

Once ksoftirq triggers its because we are seriously overloaded (or without
fixing its use slightly randomly). In that case we want other stuff to
do work before we potentially unleash the next flood.

> - reschedule_idle() - smp_send_reschedule when setting idle's need_resched
>     Idle tasks nowdays don't spin waiting for need->resched to change,
>     they sleep on a halt insn instead.  Therefore any setting of
>     need->resched on an idle task running on a remote CPU should be
>     accompanied by a cross-processor interrupt.

You can already tell the kernel to poll for idle tasks (and since newer intel
CPUS seem to gain nothing from hlt might as well on those)

