Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVEYUCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVEYUCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEYUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:02:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44022 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261534AbVEYUCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:02:50 -0400
Message-ID: <4294D9C6.3060501@mvista.com>
Date: Wed, 25 May 2005 13:02:14 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
CC: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com>
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

~
> On a more serious note: what is a real-time (read SCHED_FIFO/SCHED_RR) task to use to get millisecond accuracy wakeup timing services from the kernel? i.e. what are the alternatives to setitimer() that wake up the task exactly at the interval that is requested of it? You mention high-res timers as a possibility, but in the form of a patch. What's available in mainline unpatched?
> 
We ARE trying to get this into the main line, but save the patch, there is no 
way to get millisecond accuracy in the kernel OR in user land.  Never has been! 
  That is why the patch exists.  There was an effort by some university folks 
prior to the HRT stuff, but AFAIK it is not supported or uptodate.

Also, you should be aware that even with precise timers, there is still latency 
in the kernel AND it is in the millisecond range.  Again, folks are working on 
that in the form of a patch (see the the real time patch by Ingo and friends).

As for jiffies vs time, my understanding from senior time folks is that 1/HZ as 
a resolution is just an approximation.  We do the best we can but the x86 is 
really the PITs (pun intended) when it comes to time keeping resources.  If you 
really want millisecond accuracy, you may need to consider another platform....

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
