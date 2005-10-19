Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVJSOyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVJSOyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVJSOyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:54:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65218 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751026AbVJSOyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:54:14 -0400
Date: Wed, 19 Oct 2005 16:54:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: -rt10 build problem [WAS]Re: scsi_eh / 1394 bug - -rt7
Message-ID: <20051019145435.GA6455@elte.hu>
References: <5bdc1c8b0510190750s377a2696kf9c323789b392664@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510190750s377a2696kf9c323789b392664@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> Problem building 2.6.14-rc4-rt10. The only change to my config file 
> was to turn on a few options for Mac disks. I doubt that's involved 
> with this. I will send the .config file if requested.

does the patch below fix it?

	Ingo

Index: linux/kernel/ktimers.c
===================================================================
--- linux.orig/kernel/ktimers.c
+++ linux/kernel/ktimers.c
@@ -1097,17 +1097,19 @@ static void check_ktimer_signal(struct k
 
 		printk("\n");
 		printk("expires:   %u/%u\n",
-			timer->expires.tv.sec, timer->expires.tv.nsec);
+			ktime_get_high(timer->expires),
+			ktime_get_low(timer->expires));
 		printk("expired:   %u/%u\n",
-			timer->expired.tv.sec, timer->expired.tv.nsec);
-		printk("      at:  %d\n",
-			timer->expiry_mode);
+			ktime_get_high(timer->expired),
+			ktime_get_low(timer->expired));
+		printk("      at:  %d\n", timer->expiry_mode);
 		printk("interval:  %u/%u\n",
-			timer->interval.tv.sec, timer->interval.tv.nsec);
+			ktime_get_high(timer->interval),
+			ktime_get_low(timer->interval));
 		printk("now:       %u/%u\n",
-			now.tv.sec, now.tv.nsec);
+			ktime_get_high(now), ktime_get_low(now));
 		printk("rem:       %u/%u\n",
-			rem.tv.sec, rem.tv.nsec);
+			ktime_get_high(rem), ktime_get_low(rem));
 		printk("overrun:   %d\n", timer->overrun);
 #ifdef CONFIG_HIGH_RES_TIMERS
 		printk("getoffset: %p\n", base->getoffset);
