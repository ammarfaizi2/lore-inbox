Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032068AbWLGLeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032068AbWLGLeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032067AbWLGLeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:34:07 -0500
Received: from mail.charter.net ([209.225.8.178]:52890 "EHLO
	mtao04.charter.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1032066AbWLGLeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:34:03 -0500
Message-ID: <4577FC21.1080407@cybsft.com>
Date: Thu, 07 Dec 2006 05:33:53 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
References: <20061205171114.GA25926@elte.hu>
In-Reply-To: <20061205171114.GA25926@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------040804080503080406040706"
X-Chzlrs: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804080503080406040706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> usual place:
> 

Attached patch fixes rtc histogram. Looks like it got broken around
2.6.18-rt?, probably during the merge for 2.6.18?

-- 
	kr

--------------040804080503080406040706
Content-Type: text/x-patch;
 name="rtcfix1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtcfix1.patch"

--- linux-2.6.19/drivers/char/rtc.c.orig	2006-12-06 21:46:16.000000000 -0600
+++ linux-2.6.19/drivers/char/rtc.c	2006-12-06 21:46:48.000000000 -0600
@@ -427,9 +427,9 @@ irqreturn_t rtc_interrupt(int irq, void 
 	if (rtc_callback)
 		rtc_callback->func(rtc_callback->private_data);
 	spin_unlock(&rtc_task_lock);
-	wake_up_interruptible(&rtc_wait);
 
-	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	rtc_wake_event();
+	wake_up_interruptible(&rtc_wait);
 
 	return IRQ_HANDLED;
 }
@@ -1328,7 +1328,6 @@ static void rtc_dropped_irq(unsigned lon
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 
 	/* Now we have new data */
-	rtc_wake_event();
 	wake_up_interruptible(&rtc_wait);
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);

--------------040804080503080406040706--
