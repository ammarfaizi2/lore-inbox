Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314443AbSDVSsA>; Mon, 22 Apr 2002 14:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSDVSsA>; Mon, 22 Apr 2002 14:48:00 -0400
Received: from zero.tech9.net ([209.61.188.187]:53769 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314443AbSDVSr6>;
	Mon, 22 Apr 2002 14:47:58 -0400
Subject: [PATCH] updated 2.4 O(1) scheduler patches
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 14:48:02 -0400
Message-Id: <1019501283.939.42.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of Ingo Molnar's multiqueue O(1) scheduler is
available at:

	http://www.kernel.org/pub/linux/kernel/people/rml/sched

for kernels 2.4.18 and 2.4.19-pre7.

This patch has the following changes over Ingo's -K3 release and what is
in Alan's -ac tree:

        - remove wake_up_sync and friends, we don't need them now
        - abstract away access to need_resched
        - load_balance optimizations and cleanup
        - fix scheduler deadlock on some platforms
        - sched_yield optimizations and cleanup
        - better use of MAX_RT_PRIO define instead of magic numbers
        - misc. code cleanups
        - misc. fixes and optimizations

and most importantly:

       - backport the migration_thread and associated code to 2.4

and also the following changes since my initial patch:

	- include linux/interrupt.h in sched.c
	- use yield() where needed

The migration_thread code allows arch-independent `pushing' of tasks
from one CPU to another.  This allows the implementation of a reliable
set_cpus_allowed method for use in the kernel as well as things like
task cpu affinity interfaces.

The migration_thread code used in this patch is actually newer than what
is in 2.5.8 - it contains the interrupt-off fix pointed out by Erich
Focht and William Lee Irwin's new migration_init code.

This is not suggested for inclusion in mainline 2.4.  2.4 != 2.5.

Enjoy,

	Robert Love

