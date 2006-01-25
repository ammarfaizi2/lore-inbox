Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWAYOk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWAYOk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWAYOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:40:27 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6867 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751176AbWAYOk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:40:26 -0500
Date: Wed, 25 Jan 2006 08:38:19 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: sched_yield() makes OpenLDAP slow
In-reply-to: <43D78262.2050809@symas.com>
To: Howard Chu <hyc@symas.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <43D78D5B.3060008@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <20060124225919.GC12566@suse.de>
 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>
 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> No, because the thread that just released the mutex is obviously not one 
> of  the threads blocked on the mutex. When a mutex is unlocked, one of 
> the *waiting* threads at the time of the unlock must acquire it, and the 
> scheduling policy can determine that. But the thread the released the 
> mutex is not one of the waiting threads, and is not eligible for 
> consideration.

That statement does not imply that any reschedule needs to happen at the 
time of the mutex unlock at all, only that the other threads waiting on 
the mutex can attempt to reacquire it when the scheduler allows them to. 
  In all likelihood, what tends to happen is that either the thread that 
had the mutex previously still has time left in its timeslice and is 
allowed to keep running and reacquire the mutex, or another thread is 
woken up (perhaps on another CPU) but doesn't reacquire the mutex before 
the original thread carries on and acquires it, and therefore goes back 
to sleep.

Forcing the mutex to ping-pong between different threads would be quite 
inefficient (especially on SMP machines), and is not something that 
POSIX requires.

--
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
