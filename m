Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUAZLKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUAZLKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:10:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40600 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265083AbUAZLKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:10:46 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.62900.619526.550375@laputa.namesys.com>
Date: Mon, 26 Jan 2004 14:10:44 +0300
To: timothy parkinson <t@timothyparkinson.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Better "Losing Ticks" Error Message
In-Reply-To: <20040124032147.GA177@h00a0cca1a6cf.ne.client2.attbi.com>
References: <20040124032147.GA177@h00a0cca1a6cf.ne.client2.attbi.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timothy parkinson writes:
 > 
 > Andrew,
 > 
 > Seems like a lot of people see the below error message, but aren't quite sure
 > why it happens or how to fix it.  I sure didn't.
 > 
 > Here's my attempt at remedying that - Should apply cleanly against 2.6.1.
 > 
 > Thanks,
 > Timothy
 > 
 > diff -urN linux-2.6.1-orig/arch/i386/kernel/timers/timer_tsc.c linux-2.6.1/arch/i386/kernel/timers/timer_tsc.c
 > --- linux-2.6.1-orig/arch/i386/kernel/timers/timer_tsc.c	2004-01-09 01:59:46.000000000 -0500
 > +++ linux-2.6.1/arch/i386/kernel/timers/timer_tsc.c	2004-01-23 21:16:24.000000000 -0500
 > @@ -232,9 +232,13 @@
 >  		/* sanity check to ensure we're not always losing ticks */
 >  		if (lost_count++ > 100) {
 >  			printk(KERN_WARNING "Losing too many ticks!\n");
 > -			printk(KERN_WARNING "TSC cannot be used as a timesource."
 > -					" (Are you running with SpeedStep?)\n");
 > -			printk(KERN_WARNING "Falling back to a sane timesource.\n");
 > +			printk(KERN_WARNING "TSC cannot be used as a timesource.  ");
 > +			printk(KERN_WARNING "Possible reasons for this are:\n");
 > +			printk(KERN_WARNING "  You're running with Speedstep,\n");
 > +			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
 > +			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");

+#ifdef CONFIG_KGDB
+			printk(KERN_WARNING "  You're single-stepping under kgdb (see what you are doing).\n");
+#endif

Modulo that person debugging kernel with kgdb probably understands this
anyway.

 > +			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
 > +

Nikita.
