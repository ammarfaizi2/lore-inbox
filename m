Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbUKHJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUKHJec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbUKHJdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:33:51 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15025 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261797AbUKHJWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:22:51 -0500
Date: Mon, 8 Nov 2004 11:24:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.19
Message-ID: <20041108102447.GA14980@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <200411081015.47750.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081015.47750.annabellesgarden@yahoo.de>
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

> RT-V0.7.19-dmesg_after_boot_rl3.log is a freshly booted dmesg output
> after logging on via ssh. RT-V0.7.19-proc_acpi_TAB.log is captured via
> netconsole. This log started after logging in locally, then typing in
> "cat /proc/acpi", then first <TAB> gives an additional "/", 2nd <TAB>
> gives no visual effect, 3rd <TAB> produces whats in the log.

there's at least one more netconsole buglet causing asserts, which
should be fixed by the patch below.

	Ingo

--- linux/net/core/netpoll.c.orig
+++ linux/net/core/netpoll.c
@@ -194,7 +194,7 @@ repeat:
 	}
 
 	spin_lock(&np->dev->xmit_lock);
-	np->dev->xmit_lock_owner = smp_processor_id();
+	np->dev->xmit_lock_owner = _smp_processor_id();
 
 	/*
 	 * network drivers do not expect to be called if the queue is
