Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319611AbSIMLvL>; Fri, 13 Sep 2002 07:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319614AbSIMLvL>; Fri, 13 Sep 2002 07:51:11 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:7660 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319611AbSIMLvK>; Fri, 13 Sep 2002 07:51:10 -0400
Date: Fri, 13 Sep 2002 05:56:05 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: Ingo Molnar <mingo@elte.hu>, Steven Cole <elenstev@mesatop.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Steven Cole <scole@lanl.gov>
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
In-Reply-To: <1031902825.4429.130.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209130554350.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13 Sep 2002, Robert Love wrote:
> On Fri, 2002-09-13 at 03:36, Robert Love wrote:
> Actually, looking at this again, we probably want to still BUG() if
> in_interrupt() but _not_ if in_atomic().

-	if (unlikely(in_atomic()))
-		BUG();
+	if (unlikely((in_interrupt() || (!in_atomic())) && preempt_count() != PREEMPT_ACTIVE)) {
+		printk(KERN_ERROR "schedule() called while non-atomic, or in interrupt!\n");
+		show_stack(NULL);
+	}

?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

