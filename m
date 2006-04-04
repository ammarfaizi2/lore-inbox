Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWDDGav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWDDGav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWDDGav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:30:51 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:7371 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751820AbWDDGav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:30:51 -0400
Message-ID: <44321298.4000409@bigpond.net.au>
Date: Tue, 04 Apr 2006 16:30:48 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.2 for  2.6.17-rc1
References: <4431FB72.9030907@bigpond.net.au>
In-Reply-To: <4431FB72.9030907@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------000102090202070008050109"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 06:30:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000102090202070008050109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> This version updates staircase scheduler to version 15 (thanks Con)
> and includes the latest smpnice patches
> 
> A patch for 2.6.17-rc1 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.2-for-2.6.17-rc1.patch?download> 
> 
> 
> Very Brief Documentation:
> 
> You can select a default scheduler at kernel build time.  If you wish to
> boot with a scheduler other than the default it can be selected at boot
> time by adding:
> 
> cpusched=<scheduler>
> 
> to the boot command line where <scheduler> is one of: ingosched,
> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
> or zaphod.  If you don't change the default when you build the kernel
> the default scheduler will be ingosched (which is the normal scheduler).
> 
> The scheduler in force on a running system can be determined by the
> contents of:
> 
> /proc/scheduler
> 
> Control parameters for the scheduler can be read/set via files in:
> 
> /sys/cpusched/<scheduler>/
> 
> Peter

This fails to build when SCHEDSTATS is not configured in.  The attached 
patch fixes that problem.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------000102090202070008050109
Content-Type: text/plain;
 name="build-without-schedstats"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build-without-schedstats"

Index: Linux-2.6.17-rc1/include/linux/sched_pvt.h
===================================================================
--- Linux-2.6.17-rc1.orig/include/linux/sched_pvt.h	2006-04-04 12:20:47.000000000 +1000
+++ Linux-2.6.17-rc1/include/linux/sched_pvt.h	2006-04-04 16:27:33.000000000 +1000
@@ -209,6 +209,7 @@ static inline void sched_info_switch(tas
 		sched_info_arrive(next);
 }
 #else
+#define schedstat_inc(rq, field)	do { } while (0)
 #define sched_info_queued(t)		do { } while (0)
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */

--------------000102090202070008050109--
