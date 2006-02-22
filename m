Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWBVAr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWBVAr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWBVAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:47:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:62610 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030233AbWBVAr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:47:28 -0500
Subject: [BUG -rt] cpu rlimits not enforced w/ -rt
From: john stultz <johnstul@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 16:47:23 -0800
Message-Id: <1140569244.1271.36.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
	I've been hunting an issue in 2.6.14-rt16 (also present in
2.6.16-rt17), where the cpu rlimits were not being enforced. 

I tracked it down in update_process_times, where we have the following:

#ifndef CONFIG_PREEMPT_RT
 	run_posix_cpu_timers(p);
#endif

Yea, that would do it. :)


Hmm.. Looking through the archives, I came up w/ the discussion here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0509.3/1579.html

I was just curious what folks are thinking about for a fix here? Should
we just create a soft timer that calls run_posix_cpu_timers? 

thanks
-john




