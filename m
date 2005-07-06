Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVGGAXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVGGAXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVGFUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:02:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63167 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262425AbVGFR1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:27:34 -0400
Date: Wed, 6 Jul 2005 19:27:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706172716.GA28755@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061756.20861.s0348365@sms.ed.ac.uk> <20050706170158.GA27797@elte.hu> <200507061814.23656.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061814.23656.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > great! Do the softlockup warnings still occur?
> 
> Yes, but in no greater a number.

could you apply the patch below, so that we can see what kind of time 
gap the softlockup detector encountered?

	Ingo

Index: linux/kernel/softlockup.c
===================================================================
--- linux.orig/kernel/softlockup.c
+++ linux/kernel/softlockup.c
@@ -65,8 +65,8 @@ void softlockup_tick(void)
 		per_cpu(print_timestamp, this_cpu) = timestamp;
 
 		spin_lock(&print_lock);
-		printk(KERN_ERR "BUG: soft lockup detected on CPU#%d!\n",
-			this_cpu);
+		printk(KERN_ERR "BUG: soft lockup detected on CPU#%d! %ld-%ld\n",
+			this_cpu, jiffies, timestamp);
 		dump_stack();
 #if defined(__i386__) && defined(CONFIG_SMP)
 		nmi_show_all_regs();
