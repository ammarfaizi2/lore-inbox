Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263042AbVCDUwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbVCDUwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVCDUtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:49:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38551 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263106AbVCDUnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:43:10 -0500
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <42283857.9050007@mvista.com>
References: <1109869828.2908.18.camel@mindpipe>
	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>
	 <42283857.9050007@mvista.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 15:43:05 -0500
Message-Id: <1109968985.6710.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 02:28 -0800, George Anzinger wrote:
> Lee Revell wrote:
> > On Thu, 2005-03-03 at 16:45 -0800, Andrew Morton wrote:
> > 
> >>If efi_enabled is true and efi_set_rtc_mmss(xtime.tv_sec) returns zero, the
> >>new code will run set_rtc_mmss(xtime.tv_sec) whereas the old code won't.
> > 
> > 
> > Argh, I should know better then to send patches before having coffee.
> > 
> > Here's a new patch.  Still ugly, but might be a worthwhile cleanup.
> 
> Lets ask the obvious question: Why isn't this update hung on a timer?  It seems 
> silly to check this 6000 times per update.  I am sure we can sync a timer to the 
> same degree we do timer interrupts, so there _must_ be some other reason.  Right?
> 

Thanks George, I knew there was an obvious question here, I just didn't
know what it was ;-).

The thin that brought this code to my attention is that with PREEMPT_RT
this happens to be the longest non-preemptible code path in the kernel.
On my 1.3 Ghz machine set_rtc_mmss takes about 50 usecs, combined with
the rest of timer irq we end up disabling preemption for about 90 usecs.
Unfortunately I don't have the trace anymore.

Anyway the upshot is if we hung this off a timer it looks like we would
improve the worst case latency with PREEMPT_RT by almost 50%.  Unless
there is some reason it has to be done synchronously of course.

Lee





