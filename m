Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbULJUiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbULJUiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbULJUiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:38:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28388 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261826AbULJUhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:37:45 -0500
Date: Sat, 11 Dec 2004 02:10:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
Message-ID: <20041210204003.GC4073@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com> <41B9FC3F.50601@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B9FC3F.50601@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 11:42:55AM -0800, George Anzinger wrote:
> Dipankar Sarma wrote:
> >And yes, RCU processing in softirq context can re-raise the softirq.
> >AFAICS, it is perfectly normal.
> 
> My assumption was that, this being the idle task, RCU would be more than 
> happy to finish all its pending tasks.

We try to avoid really long running softirqs (RCU tasklet in this case)
for better scheduling latency. A long running rcu tasklet during
an idle cpu may delay running of an RT process that becomes runnable
during the rcu tasklet.

> 
> It may be necessary for me to rethink the conditions required to go into 
> the VST state.  I had assumed that it required NO softirq pending as a pre 
> condition. From this point on we would have the interrupt system off until 
> the hardware sleep instruction (hlt in the x86 case).

Unfortunately, we aren't there yet. But it is in my TODO list for a 
generic nohz system.

Thanks
Dipankar
