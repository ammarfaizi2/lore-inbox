Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbUKRU34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbUKRU34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUKRTlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:41:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42390 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262941AbUKRTk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:40:58 -0500
Date: Thu, 18 Nov 2004 21:42:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
Message-ID: <20041118204239.GA5281@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <1100732223.3472.10.camel@localhost> <20041118155411.GB12483@elte.hu> <1100790475.3397.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100790475.3397.3.camel@localhost>
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


* Christian Meder <chris@onestepahead.de> wrote:

> Thanks, will try soon and report. There was another trace in my log of
> the vdr/router box which seemed unrelated to the bridging traces.

does the patch below fix that message?

	Ingo

--- linux/drivers/media/dvb/dvb-core/dvb_frontend.c.orig2	
+++ linux/drivers/media/dvb/dvb-core/dvb_frontend.c	
@@ -658,7 +658,7 @@ static void dvb_frontend_stop (struct dv
 		printk("dvb_frontend_stop: thread PID %d already died\n",
 				fe->thread_pid);
 		/* make sure the mutex was not held by the thread */
-		init_MUTEX (&fe->sem);
+		sema_init_nocheck (&fe->sem, 1);
 		return;
 	}
 
@@ -1127,10 +1127,10 @@ dvb_register_frontend (int (*ioctl) (str
 
 	memset (fe, 0, sizeof (struct dvb_frontend_data));
 
-	init_MUTEX (&fe->sem);
+	sema_init_nocheck (&fe->sem, 1);
 	init_waitqueue_head (&fe->wait_queue);
 	init_waitqueue_head (&fe->events.wait_queue);
-	init_MUTEX (&fe->events.sem);
+	sema_init_nocheck (&fe->events.sem, 1);
 	fe->events.eventw = fe->events.eventr = 0;
 	fe->events.overflow = 0;
 	fe->module = module;
