Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSGUSsh>; Sun, 21 Jul 2002 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSGUSsh>; Sun, 21 Jul 2002 14:48:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29875 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S293680AbSGUSsh>;
	Sun, 21 Jul 2002 14:48:37 -0400
Date: Sun, 21 Jul 2002 20:50:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] "big IRQ lock" removal, 2.5.27-A1
Message-ID: <Pine.LNX.4.44.0207212038350.23450-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the next iteration of the big-IRQ-lock removal patch, against
2.5.27 + sched-fixes + ldt-fixes:

  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A1

one clarification wrt. disable_irq(): while it does not synchronize with
all IRQ sources globally anymore, it does synchronize with that particular
irq source (globally) - so drivers can use it safely to ensure that no
pending IRQ handler is running on another CPU after disable_irq() has
returned.

Changes:

 - Oleg Nesterov noticed a do_IRQ() bug which can cause a reschedule in
   do_IRQ().

 - George Anzinger noticed that local_bh_enable() did not re-run softirqs.

 - Linus suggested to still define cli(), sti(), save_flags(),
   restore_flags() on UP kernels, to ease the transition.

the patch compiles, boots & works just fine on UP - on SMP it boots just
fine using the following limited .config:

  http://redhat.com/~mingo/remove-irqlock-patches/config

(the serial subsystem is disabled for example.)

	Ingo

