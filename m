Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUJPGro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUJPGro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 02:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUJPGro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 02:47:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41106 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268667AbUJPGrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 02:47:41 -0400
Date: Sat, 16 Oct 2004 08:48:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016064852.GB30371@elte.hu>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041015231609.GA23505@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015231609.GA23505@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> On Fri, Oct 15, 2004 at 12:26:33PM +0200, Ingo Molnar wrote:
> > 
> > i have released the -U3 PREEMPT_REALTIME patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> 
> Atomic violations:

ok, the rtc clock needs to go back to raw for the time being - the patch
below should fix it.

	Ingo

--- linux.old/arch/i386/kernel/time.c	
+++ linux.new/arch/i386/kernel/time.c	
@@ -81,7 +81,7 @@ unsigned long cpu_khz;	/* Detected as we
 
 extern unsigned long wall_jiffies;
 
-DECLARE_SPINLOCK(rtc_lock);
+DECLARE_RAW_SPINLOCK(rtc_lock);
 
 #include <asm/i8253.h>
 
--- linux.old/include/linux/mc146818rtc.h	
+++ linux.new/include/linux/mc146818rtc.h	
@@ -16,7 +16,7 @@
 #include <linux/spinlock.h>		/* spinlock_t */
 #include <asm/mc146818rtc.h>		/* register access macros */
 
-extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
+extern raw_spinlock_t rtc_lock;		/* serialize CMOS RAM access */
 
 /**********************************************************************
  * register summary
