Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbULJE3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbULJE3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbULJE3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:29:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21133 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261698AbULJE3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:29:00 -0500
Date: Fri, 10 Dec 2004 10:01:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: ganzinger@mvista.com
Cc: Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
Message-ID: <20041210043102.GC4161@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <41B8E6F1.4070007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B8E6F1.4070007@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 03:59:45PM -0800, George Anzinger wrote:
> I am working on VST code.  This code is called from the idle loop to check 
> for future timers.  It then sets up a timer to interrupt in time to handle 
> the nearest timer and turns off the time base interrupt source.  As part of 
> qualifying the entry to this state I want to make sure there is no pending 
> work so, from the idle task I have this:
> 
> 	if (local_softirq_pending())
> 		do_softirq();
> 
> 	BUG_ON(local_softirq_pending());
> 
> I did not really expect to find any pending softirqs, but, not only are 
> there some, they don't go away and the system BUGs.  The offender is the 
> RCU task. The question is: is this normal or is there something wrong?

Why do you think there would not be any softirq pending after do_softirq() ?
What if the cpu gets a network interrupt which raises a softirq ?
And yes, RCU processing in softirq context can re-raise the softirq.
AFAICS, it is perfectly normal.

Thanks
Dipankar
