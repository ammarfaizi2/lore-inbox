Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317930AbSGWMvp>; Tue, 23 Jul 2002 08:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSGWMvp>; Tue, 23 Jul 2002 08:51:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14236 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317930AbSGWMvo>;
	Tue, 23 Jul 2002 08:51:44 -0400
Date: Tue, 23 Jul 2002 14:53:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] big IRQ lock removal, 2.5.27-F9
Message-ID: <Pine.LNX.4.44.0207231451190.9962-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -F9 irqlock patch can be found at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-F9

Changes in -F9:

 - replace all instances of:

	local_save_flags(flags);
	local_irq_disable();

   with the shorter form of:

	local_irq_save(flags);

  about 30 files are affected by this change.

Changes in -F8:

 - preempt/hardirq/softirq count separation, cleanups.

 - skbuff.c fix.

 - use irq_count() in scheduler_tick()

Changes in -F3:

 - the entry.S cleanups/speedups by Oleg Nesterov.

 - a rather critical synchronize_irq() bugfix: if a driver frees an 
   interrupt that is still being probed then synchronize_irq() locks up.
   This bug has caused a spurious boot-lockup on one of my testsystems,
   ifconfig would lock up trying to close eth0.

 - remove duplicate definitions from asm-i386/system.h, this fixes 
   compiler warnings.

	Ingo

