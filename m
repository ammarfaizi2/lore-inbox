Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264248AbRFSOwi>; Tue, 19 Jun 2001 10:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264250AbRFSOw2>; Tue, 19 Jun 2001 10:52:28 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:60849 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S264248AbRFSOwM>; Tue, 19 Jun 2001 10:52:12 -0400
Message-ID: <3B2F6759.6CF96382@kegel.com>
Date: Tue, 19 Jun 2001 07:53:13 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamagallon@able.es,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: accounting for threads
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> wrote:
> I want to know the CPU time used by a POSIX-threaded program. I have tried
> to use getrusage() with RUSAGE_SELF and RUSAGE_CHILDREN. Problem:
> main thread just do nothing, spawns children and waits. And I get always
> 0 ru_utime.
> 
> I guess it can be because of 2 things:
> 
> - RUSAGE_CHILDREN only works for fork()'ed children (although in linux threads
> and processes are the same). Perhaps fork() sets some kind of flag in
> clone() for accounting.
> 
> - AFAIK, linux puts an intermediate 'thread controller'. That controller
> uses no CPU time, and RUSAGE_CHILDREN gets only the first children level.
> 
> Any suggestion to mesaure threads CPU time ? I can't manage only with
> wall-time, because I'm not sure to have all the box just for me.
> And I would like also to mesaure system time to evaluate contention.

My post you replied to yesterday, subject "Re: getrusage vs /proc/pid/stat",
contains code that does what you want (it's also at http://www.kegel.com/lt.tar.gz).  
To use it, declare a variable
  LinuxTimes lt;
have each thread call lt.addSelf() once; then to measure the total CPU time
used by all those threads as a group, call lt.times() instead of times().
(On Solaris, you can continue to just call times(), you don't need lt at all.)
lt.times() is a simulation of the classical times() system call for LinuxThreads.

Let me know if this helps.  And anyone else, let me know if there's a simpler
way to do this.  Should LinuxThreads be doing this under the hood, so it can
be a little closer to posix threads compliance?
- Dan

-- 
"A computer is a state machine.
 Threads are for people who can't program state machines."
         - Alan Cox
