Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270157AbUJTEtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270157AbUJTEtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269885AbUJTEpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 00:45:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21922
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270146AbUJSXdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:33:13 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1098212697.12223.1006.camel@thomas>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>  <1098212697.12223.1006.camel@thomas>
Content-Type: multipart/mixed; boundary="=-q0AMdl76pbp5ZPJ+NLg+"
Organization: linutronix
Message-Id: <1098228314.12223.1136.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 01:25:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q0AMdl76pbp5ZPJ+NLg+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-10-19 at 21:04, Thomas Gleixner wrote:
> On Tue, 2004-10-19 at 20:00, Ingo Molnar wrote:
> > i have released the -U7 Real-Time Preemption patch:
> 
Nobrainer typo removal. I'm feeling stupid.

tglx



--=-q0AMdl76pbp5ZPJ+NLg+
Content-Disposition: attachment; filename=svc.nobrain.diff
Content-Type: text/x-patch; name=svc.nobrain.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urN 2.6.9-rc4-mm1-RT-U7/fs/lockd/svc.c 2.6.9-rc4-mm1-RT-U7-work/fs/lockd/svc.c
--- 2.6.9-rc4-mm1-RT-U7/fs/lockd/svc.c	2004-10-19 20:29:43.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/fs/lockd/svc.c	2004-10-20 00:42:20.000000000 +0200
@@ -306,7 +306,7 @@
 	 * Wait for the lockd process to exit, but since we're holding
 	 * the lockd semaphore, we can't wait around forever ...
 	 */
-	if (!wait_event_interruptible_timeout(lockd_exit, 
+	if (wait_event_interruptible_timeout(lockd_exit, 
 					     nlmsvc_pid == 0, HZ) <= 0) {
 		printk(KERN_WARNING 
 			"lockd_down: lockd failed to exit, clearing pid\n");

--=-q0AMdl76pbp5ZPJ+NLg+--

