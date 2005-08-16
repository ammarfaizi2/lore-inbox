Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVHPSHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVHPSHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVHPSHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:07:45 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:19671 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030274AbVHPSHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:07:44 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124214647.5764.40.camel@localhost.localdomain>
References: <20050816121843.GA24308@elte.hu>
	 <1124206316.5764.14.camel@localhost.localdomain>
	 <1124207046.5764.17.camel@localhost.localdomain>
	 <1124208507.5764.20.camel@localhost.localdomain>
	 <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu>
	 <20050816165247.GA10386@elte.hu>  <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 14:07:11 -0400
Message-Id: <1124215631.5764.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 13:50 -0400, Steven Rostedt wrote:

> I changed it for now to the following, but it still desn't make sense to
> me.  With a local_save_flags, which doesn't disable or restore the
> interrupts, why bother with the trace at all?

Or should the following patch really be applied? (it boots and compiles
nicely).

-- Steve

Index: linux_realtime_ernie/include/linux/rt_irq.h
===================================================================
--- linux_realtime_ernie/include/linux/rt_irq.h	(revision 294)
+++ linux_realtime_ernie/include/linux/rt_irq.h	(working copy)
@@ -26,7 +26,7 @@
 # endif
 
 /* soft state does not follow the hard state */
-# define raw_local_save_flags(flags)	do { typecheck(unsigned long,flags); if (raw_irqs_disabled_flags(flags)) trace_irqs_off(); else trace_irqs_on(); __raw_local_save_flags(flags); } while (0)
+# define raw_local_save_flags(flags)	do { typecheck(unsigned long,flags);  __raw_local_save_flags(flags); } while (0)
 # define raw_local_irq_enable()		do { trace_irqs_on(); __raw_local_irq_enable(); } while (0)
 # define raw_local_irq_disable()	do { __raw_local_irq_disable(); trace_irqs_off(); } while (0)
 # define raw_local_irq_save(flags)	do { __raw_local_irq_save(flags); trace_irqs_off(); } while (0)


