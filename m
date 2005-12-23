Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVLWCGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVLWCGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVLWCGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:06:31 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58095 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030346AbVLWCGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:06:30 -0500
Subject: Re: 2.6.15-rc5-rt4 fails to compile - question
From: Steven Rostedt <rostedt@goodmis.org>
To: John Rigg <lk@sound-man.co.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20051222231153.GA4316@localhost.localdomain>
References: <20051222231153.GA4316@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 21:06:22 -0500
Message-Id: <1135303582.12761.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 23:11 +0000, John Rigg wrote:
> On Wednesday Dec 21 2005 John Rigg wrote:
> > 2.6.14-rc5-rt4
> > failed to compile
> > on x86_64 SMP
> >
> > kernel/hrtimer.c: In function 'hrtimer_cancel':
> > kernel/hrtimer.c:673: error: 'HRTIMER_SOFTIRQ' undeclared (first use in this function)
> > kernel/hrtimer.c:673: error: (Each undeclared identifier is reported only once
> > kernel/hrtimer.c:673: error: for each function it appears in.)
> > make[1]: *** [kernel/hrtimer.o] Error 1
> > make: *** [kernel] Error 2
> 
> The obvious way to get it to compile would be to use CONFIG_HIGH_RES_TIMERS=y .
> Stupid question: how do I enable this on x86_64 SMP?
> I can't find it in menuconfig and if I edit .config manually my edits just
> get deleted (obviously I'm doing something wrong). I've tried grepping the
> source and googling, but haven't been able to find the answer.

Oops, sorry that was my fault. Here's the fix.

I've successfully compiled this on a x86_64.  Since that's the box I'm
writing this email on, I'll try booting it later.

-- Steve 

Index: linux-2.6.15-rc5-rt4/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5-rt4.orig/kernel/hrtimer.c	2005-12-22 20:55:30.000000000 -0500
+++ linux-2.6.15-rc5-rt4/kernel/hrtimer.c	2005-12-22 20:56:47.000000000 -0500
@@ -670,7 +670,9 @@
 
 		if (ret >= 0)
 			return ret;
+#ifdef CONFIG_HIGH_RES_TIMERS
 		wait_for_softirq(HRTIMER_SOFTIRQ);
+#endif
 	}
 }
 


