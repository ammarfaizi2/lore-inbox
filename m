Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSEUVOP>; Tue, 21 May 2002 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSEUVOO>; Tue, 21 May 2002 17:14:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46322 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316603AbSEUVON>;
	Tue, 21 May 2002 17:14:13 -0400
Message-ID: <3CEAB85D.1532F5A2@mvista.com>
Date: Tue, 21 May 2002 14:13:01 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] POSIX personality
In-Reply-To: <64270000.1022012868@baldur.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> 
> As part of improving support for POSIX multithreading I've been putting
> together some patches to allow more things to be shared between tasks.
> Right now this is accomplished via flags to clone() with one flag per
> resource to be shared.  This usually translates to a data structure pointed
> to out of task_struct, complete with reference count and lock.
> 
> In a discussion today an alternate idea was proposed by Ben LaHaise.  He
> suggested creating a POSIX personality, or execution domain.  This would
> take some pressure off the clone flag space as well as allowing some
> optimizations in the code. It could also be used in situations where
> POSIX-compatible behavior entails more than just sharing extra resources
> between tasks.
> 
> This would assume that the resources I'm sharing would only be useful for
> POSIX compatibility, but at this point it seems unlikely that anyone would
> want to share a subset of them.  The resources I'm currently working on
> include credentials, signals,  and timers, and there's a patch available
> for semaphore undo that could also be part of this mechanism.
> 
> Since you've made it this far my question to you all is this:  assuming
> that we do want improved POSIX compatibility does this sound like a
> reasonable way to add it?
> 
What you are proposing seem a bit vague.  I think that
CLONE_THREAD should group all the thread related stuff under
the one flag.  IMHO POSIX compatibility should not be off in
the corner as a step child, but rather should be the norm. 
The CLONE_THREAD flag would indicate to fork that it should
create a POSIX thread and set up the needed shared stuff.  I
rather image this to be a structure that each task_struct
points to, possibly with a usage count (but that is a
detail).  Each thread_struct would point to such a
structure, but processes that are not threaded would not be
sharing this area with other threads.

Is this close to what you had in mind?

-g
> 
> ======================================================================
> Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
> dmccr@us.ibm.com                                        T/L   678-3059
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
