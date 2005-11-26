Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVKZOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVKZOvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVKZOvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:51:06 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:27604 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932205AbVKZOvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:51:05 -0500
Date: Sat, 26 Nov 2005 15:50:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B11)
Message-ID: <20051126145043.GA12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> All,
> 	The following patchset applies against 2.6.15-rc1-mm2 and 
> provides a generic timekeeping subsystem that is independent of the 
> timer interrupt. [...]

While we are at introducing and moving around code, i've done a big 
cleanup of all code touched/introduced by your patchset. The 
gtod-B11-cleanup.tar.gz file containing the cleanup patch-series can be 
found at:

   http://redhat.com/~mingo/gtod-patches/

(i'll send the patches individually as well, as replies to your mails).

one side-effect of the cleanups is that the core Linux NTP code has now 
become quite readable, for the first time in history ;-)

the cleanups are also included in the 2.6.14-rt18 tree, and i've tested 
them on a UP and on an SMP box. The cleanups are 99% coding style 
related, but while reviewing the code i've also inserted a few TODO 
entries:

+       /* TODO: bogus limit of 4 CPUs? --mingo */
+/* TODO: why a seqlock? It's only write-locked, so should be a spinlock. */
+                       /* TODO: is 2*time_constant correct? --mingo */
+        * TODO: shouldnt we write-lock xtime_lock below, and then
+        * TODO: shouldnt txc->time be filled in here, within ntp_lock and

	Ingo
