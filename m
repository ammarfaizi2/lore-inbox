Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWAZIZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWAZIZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAZIZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:25:30 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:977 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932131AbWAZIZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:25:29 -0500
Message-ID: <43D8889E.3020907@aitel.hist.no>
Date: Thu, 26 Jan 2006 09:30:22 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hancockr@shaw.ca
Subject: Re: sched_yield() makes OpenLDAP slow
References: <MDEHLPKNGKAHNMBLJOLKAEJBJKAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEJBJKAB.davids@webmaster.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

>>Robert Hancock wrote:
>>    
>>
>>But the thread the released the
>>mutex is not one of the waiting threads, and is not eligible for
>>consideration.
>>    
>>
>
>	Where are you getting this from? Nothing requires the scheduler to schedule
>any threads when the mutex is released.
>  
>
Correct.

>	All that must happen is that the mutex must be unlocked. The scheduler is
>permitted to allow any thread it wants to run at that point, or no thread.
>Nothing says the thread that released the mutex can't continue running and
>  
>
Correct. The releasing thread may keep running.

>nothing says that it can't call pthread_mutex_lock and re-acquire the mutex
>before any other thread gets around to getting it.
>  
>
Wrong.
The spec says that the mutex must be given to a waiter (if any) at the
moment of release.  The waiter don't have to be scheduled at that
point, it may keep sleeping with its freshly unlocked mutex.  So the
unlocking thread may continue - but if it tries to reaquire the mutex
it will find the mutex taken and go to sleep at that point. Then other
processes will schedule, and at some time the one now owning the mutex
will wake up and do its work.

>	In general, it is very bad karma for the scheduler to stop a thread before
>its timeslice is up if it doesn't have to. Consider one CPU and two threads,
>each needing to do 100 quick lock/unlock cycles. Why force 200 context
>switches?
>
Good point, except it is a strange program that do this.  Lock the mutex 
once,
do 100 operations, then unlock is the better way. :-)

Helge Hafting
