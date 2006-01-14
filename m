Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWANWrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWANWrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWANWrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:47:21 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:178 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751340AbWANWrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:47:20 -0500
Date: Sat, 14 Jan 2006 16:47:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: sched_yield() makes OpenLDAP slow
In-reply-to: <5uZqb-4fo-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C97F6B.7020600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5uZqb-4fo-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> POSIX requires a reschedule to occur, as noted here:
> http://blog.firetree.net/2005/06/22/thread-yield-after-mutex-unlock/

No, it doesn't:

> 
> The relevant SUSv3 text is here
> http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_unlock.html 

"If there are threads blocked on the mutex object referenced by mutex 
when pthread_mutex_unlock() is called, resulting in the mutex becoming 
available, the scheduling policy shall determine which thread shall 
acquire the mutex."

This says nothing about requiring a reschedule. The "scheduling policy" 
can well decide that the thread which just released the mutex can 
re-acquire it.

> I suppose if pthread_mutex_unlock() actually behaved correctly we could 
> remove the other sched_yield() hacks that didn't belong there in the 
> first place and go on our merry way.

Generally, needing to implement hacks like this is a sign that there are 
problems with the synchronization design of the code (like a mutex which 
has excessive contention). Programs should not rely on the scheduling 
behavior of the kernel for proper operation when that behavior is not 
defined.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

