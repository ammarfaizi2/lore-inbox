Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSGWJoK>; Tue, 23 Jul 2002 05:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSGWJoK>; Tue, 23 Jul 2002 05:44:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60621 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318007AbSGWJoJ>;
	Tue, 23 Jul 2002 05:44:09 -0400
Date: Tue, 23 Jul 2002 11:46:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] big IRQ lock removal, 2.5.27-F3
Message-ID: <Pine.LNX.4.44.0207231142160.5844-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the latest irqremove patch, against 2.5.27-BK-current:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-F3

Changes:

 - the entry.S cleanups/speedups by Oleg Nesterov.

 - a rather critical synchronize_irq() bugfix: if a driver frees an 
   interrupt that is still being probed then synchronize_irq() locks up.
   This bug has caused a spurious boot-lockup on one of my testsystems,
   ifconfig would lock up trying to close eth0.

 - remove duplicate definitions from asm-i386/system.h, this fixes 
   compiler warnings.

compiles, boots, works just fine.

	Ingo


