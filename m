Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269623AbUJSTRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbUJSTRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbUJSTQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:16:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13218
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269623AbUJSTM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 15:12:57 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019180059.GA23113@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>
Content-Type: multipart/mixed; boundary="=-D5IYtBC93BDE9CMe4W2n"
Organization: linutronix
Message-Id: <1098212697.12223.1006.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 21:04:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D5IYtBC93BDE9CMe4W2n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-10-19 at 20:00, Ingo Molnar wrote:
> i have released the -U7 Real-Time Preemption patch:

Another simple fix.

tglx


--=-D5IYtBC93BDE9CMe4W2n
Content-Disposition: attachment; filename=rawmidi.c.diff
Content-Type: text/x-patch; name=rawmidi.c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U6a/sound/core/rawmidi.c 2.6.9-rc4-mm1-VP-U4-LRT1/sound/core/rawmidi.c
--- 2.6.9-rc4-mm1-RT-U6a/sound/core/rawmidi.c	2004-10-12 09:32:23.000000000 +0200
+++ 2.6.9-rc4-mm1-VP-U4-LRT1/sound/core/rawmidi.c	2004-10-19 20:44:18.000000000 +0200
@@ -134,7 +134,8 @@
 	err = 0;
 	runtime->drain = 1;
 	while (runtime->avail < runtime->buffer_size) {
-		timeout = interruptible_sleep_on_timeout(&runtime->sleep, 10 * HZ);
+		timeout = wait_event_interruptible_timeout(runtime->sleep, 
+				runtime->avail < runtime->buffer_size, 10 * HZ);
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
 			break;

--=-D5IYtBC93BDE9CMe4W2n--

