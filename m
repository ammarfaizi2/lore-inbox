Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbUKHHT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUKHHT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUKHHT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:19:26 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47322 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261759AbUKHHTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:19:23 -0500
Date: Mon, 8 Nov 2004 09:21:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
Message-ID: <20041108082124.GA7906@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <200411072322.55884.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411072322.55884.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> got this on a netconsole when I hit <TAB> in bash to complete "cat
> /proc/acpi":

does the patch below help?

	Ingo

--- linux/kernel/module.c.orig
+++ linux/kernel/module.c
@@ -53,7 +54,7 @@
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
 /* Protects module list */
-static spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_RAW_SPINLOCK(modlist_lock);
 
 /* List of modules, protected by module_mutex AND modlist_lock */
 static DECLARE_MUTEX(module_mutex);
