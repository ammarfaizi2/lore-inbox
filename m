Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWAYNwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWAYNwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWAYNwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:52:03 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:19472 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751164AbWAYNwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:52:02 -0500
Message-ID: <43D78262.2050809@symas.com>
Date: Wed, 25 Jan 2006 05:51:30 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: hancockr@shaw.ca
Subject: Re: sched_yield() makes OpenLDAP slow
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de>
In-Reply-To: <20060125121125.GH5465@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert Hancock wrote:
 > Howard Chu wrote:
 > > POSIX requires a reschedule to occur, as noted here:
 > > http://blog.firetree.net/2005/06/22/thread-yield-after-mutex-unlock/
 >
 > No, it doesn't:
 >
 > >
 > > The relevant SUSv3 text is here
 > > 
http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_unlock.html 

 >
 > "If there are threads blocked on the mutex object referenced by mutex
 > when pthread_mutex_unlock() is called, resulting in the mutex becoming
 > available, the scheduling policy shall determine which thread shall
 > acquire the mutex."
 >
 > This says nothing about requiring a reschedule. The "scheduling policy"
 > can well decide that the thread which just released the mutex can
 > re-acquire it.

No, because the thread that just released the mutex is obviously not one 
of  the threads blocked on the mutex. When a mutex is unlocked, one of 
the *waiting* threads at the time of the unlock must acquire it, and the 
scheduling policy can determine that. But the thread the released the 
mutex is not one of the waiting threads, and is not eligible for 
consideration.

 > > I suppose if pthread_mutex_unlock() actually behaved correctly we 
could
 > > remove the other sched_yield() hacks that didn't belong there in the
 > > first place and go on our merry way.
 >
 > Generally, needing to implement hacks like this is a sign that there are
 > problems with the synchronization design of the code (like a mutex which
 > has excessive contention). Programs should not rely on the scheduling
 > behavior of the kernel for proper operation when that behavior is not
 > defined.
 >
 > --
 > Robert Hancock      Saskatoon, SK, Canada
 > To email, remove "nospam" from hancockr@nospamshaw.ca
 > Home Page: http://www.roberthancock.com/

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

