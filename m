Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSFQQRR>; Mon, 17 Jun 2002 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFQQRQ>; Mon, 17 Jun 2002 12:17:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38055 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314707AbSFQQRP>;
	Mon, 17 Jun 2002 12:17:15 -0400
Date: Mon, 17 Jun 2002 18:15:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sti() preemption fix, 2.5.22
In-Reply-To: <Pine.LNX.4.44.0206171651480.15554-100000@e2>
Message-ID: <Pine.LNX.4.44.0206171811170.18282-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zoltan Szalontai noticed that my patch doesnt match the bugfix described
:-)

correct patch attached.

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.510   -> 1.511  
#	arch/i386/kernel/irq.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/17	mingo@elte.hu	1.511
# - sti() preemption fix. for real.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Jun 17 18:15:00 2002
+++ b/arch/i386/kernel/irq.c	Mon Jun 17 18:15:00 2002
@@ -366,11 +366,15 @@
 
 void __global_sti(void)
 {
-	int cpu = smp_processor_id();
+	int cpu;
+
+	preempt_disable();
+	cpu = smp_processor_id();
 
 	if (!local_irq_count(cpu))
 		release_irqlock(cpu);
 	__sti();
+	preempt_enable();
 }
 
 /*

