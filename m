Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSFQRTl>; Mon, 17 Jun 2002 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSFQRTk>; Mon, 17 Jun 2002 13:19:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64940 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316644AbSFQRTj>;
	Mon, 17 Jun 2002 13:19:39 -0400
Date: Mon, 17 Jun 2002 19:17:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sti() preemption fix, 2.5.22
In-Reply-To: <Pine.LNX.4.44.0206171003290.2580-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206171907430.20309-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jun 2002, Linus Torvalds wrote:

> > correct patch attached.
> 
> Ingo, please use "get_cpu()/put_cpu()" instead, which does exactly the
> preempt-disable etc, and is more readable.

done, attached. (and pushed to my BK tree.)

(the cli() fix is special, there we can take advantage of the 'free' cli.)

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
# - sti() preemption fix.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Jun 17 19:09:15 2002
+++ b/arch/i386/kernel/irq.c	Mon Jun 17 19:09:15 2002
@@ -366,11 +366,12 @@
 
 void __global_sti(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = get_cpu();
 
 	if (!local_irq_count(cpu))
 		release_irqlock(cpu);
 	__sti();
+	put_cpu();
 }
 
 /*

