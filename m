Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSHHNyA>; Thu, 8 Aug 2002 09:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSHHNyA>; Thu, 8 Aug 2002 09:54:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46547 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317499AbSHHNx7>;
	Thu, 8 Aug 2002 09:53:59 -0400
Date: Thu, 8 Aug 2002 15:56:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: bad: schedule() with irqs disabled! (+ ksymoops)
In-Reply-To: <20020808094026.GA11264@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0208081555500.25416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill,

please try the attached patch against 2.5.30, does it help?

	Ingo

--- linux/kernel/softirq.c.orig	Thu Aug  8 15:57:42 2002
+++ linux/kernel/softirq.c	Thu Aug  8 15:58:02 2002
@@ -98,10 +98,9 @@
 			mask &= ~pending;
 			goto restart;
 		}
-		__local_bh_enable();
-
 		if (pending)
 			wakeup_softirqd(cpu);
+		__local_bh_enable();
 	}
 
 	local_irq_restore(flags);

