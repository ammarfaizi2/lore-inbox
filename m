Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUJLXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUJLXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUJLXi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:38:26 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:37879 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S268086AbUJLXfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:35:25 -0400
Message-ID: <416C6A33.6030202@mvista.com>
Date: Tue, 12 Oct 2004 16:35:15 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about linux time change
References: <4165AFBC.8010605@nortelnetworks.com>
In-Reply-To: <4165AFBC.8010605@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> I have been asked to add the ability to notify userspace when the time 
> of day changes.  The actual notification is the easy part.  I'm having 
> issues with where exactly the time is really changed.

Just what sort of time changes do you want to notify on?  The ntp code "drifts" 
time a lot.  Do you want to know about this?  If it is only cases where there is 
a jump in time, you might do well to look at "clock_was_set()".  It is in 
kernel/posix-timers.c and is called when ever do_settimeofday() is called AND on 
leap second calls.

You will even find code in there to push the ladder out of the softirq context.
> 
> do_settimeofday() is pretty straightforward.  No problems there.
> adjtimex() with ADJ_OFFSET_SINGLESHOT mode seems reasonable as well.
> 
> adjtimex() with ADJ_OFFSET is a bit harder to follow.  Can you give me 
> any pointers on what's going on with ADJ_OFFSET?

> 
> Thanks,
> 
> Chris
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

