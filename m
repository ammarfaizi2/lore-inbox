Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUJRT0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUJRT0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUJRT0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:26:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2244 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267556AbUJRTXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:23:01 -0400
Date: Mon, 18 Oct 2004 21:24:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018192419.GA7076@elte.hu>
References: <OFF2CA4065.A5BB2E79-ON86256F31.005A287D-86256F31.005A2895@raytheon.com> <20041018165416.GA31259@elte.hu> <4173F879.40102@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4173F879.40102@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Well you just beat me with that one. :) And here is another for
> aha152x.

> -       DECLARE_MUTEX_LOCKED(sem);
> +       DECLARE_MUTEX(sem);

almost - the full patch is the one below. (DECLARE_MUTEX() initializes
the mutex as unlocked, so there's a difference.)

	Ingo

--- linux/drivers/scsi/aha152x.c.orig
+++ linux/drivers/scsi/aha152x.c
@@ -1160,11 +1160,12 @@ static void timer_expired(unsigned long 
 static int aha152x_device_reset(Scsi_Cmnd * SCpnt)
 {
 	struct Scsi_Host *shpnt = SCpnt->device->host;
-	DECLARE_MUTEX_LOCKED(sem);
+	DECLARE_MUTEX(sem);
 	struct timer_list timer;
 	int ret, issued, disconnected;
 	unsigned long flags;
 
+	init_MUTEX_LOCKED(&sem);
 #if defined(AHA152X_DEBUG)
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
 		printk(INFO_LEAD "aha152x_device_reset(%p)", CMDINFO(SCpnt), SCpnt);
