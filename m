Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWANT3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWANT3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWANT3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:29:35 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:2564 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1750981AbWANT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:29:35 -0500
Message-ID: <43C9511D.70500@symas.com>
Date: Sat, 14 Jan 2006 11:29:33 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060111 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrecting a dead horse...
> *From: *Lee Revell
> *Date: * Sat Aug 20 2005 - 15:57:36 EST
>
> ------------------------------------------------------------------------
> On Sat, 2005-08-20 at 11:38 -0700, Howard Chu wrote:
> >/ But I also found that I needed to add a new /
> >/ yield(), to work around yet another unexpected issue on this system -/
> >/ we have a number of threads waiting on a condition variable, and the/
> >/ thread holding the mutex signals the var, unlocks the mutex, and then /
> >/ immediately relocks it. The expectation here is that upon unlocking/
> >/ the mutex, the calling thread would block while some waiting thread/
> >/ (that just got signaled) would get to run. In fact what happened is/
> >/ that the calling thread unlocked and relocked the mutex without/
> >/ allowing any of the waiting threads to run. In this case the only/
> >/ solution was to insert a yield() after the mutex_unlock(). /
>
> That's exactly the behavior I would expect. Why would you expect
> unlocking a mutex to cause a reschedule, if the calling thread still has
> timeslice left?
>
> Lee

POSIX requires a reschedule to occur, as noted here:
http://blog.firetree.net/2005/06/22/thread-yield-after-mutex-unlock/

The relevant SUSv3 text is here
http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_unlock.html

I suppose if pthread_mutex_unlock() actually behaved correctly we could 
remove the other sched_yield() hacks that didn't belong there in the 
first place and go on our merry way.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

