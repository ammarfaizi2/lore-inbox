Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSCIHOu>; Sat, 9 Mar 2002 02:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291377AbSCIHOk>; Sat, 9 Mar 2002 02:14:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292468AbSCIHO2>;
	Sat, 9 Mar 2002 02:14:28 -0500
Date: Sat, 9 Mar 2002 15:23:59 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Doug Siebert <dsiebert@divms.uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fast Userspace Mutexes (futex) vs. msem_*
Message-Id: <20020309152359.6a450af0.rusty@rustcorp.com.au>
In-Reply-To: <200203080615.g286Fqh24770@server.divms.uiowa.edu>
In-Reply-To: <200203080615.g286Fqh24770@server.divms.uiowa.edu>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002 00:15:52 -0600 (CST)
Doug Siebert <dsiebert@divms.uiowa.edu> wrote:
 
> The direction that the futex implementation is going is looking a lot like
> how they are implemented on HP-UX (as well as Tru64 and AIX)  I am curious
> though why the case of "what happens if the process holding the lock dies"
> is considered unimportant by some people.  It wouldn't be all that much
> more work to "do it right" (IMHO) and handle this case.  AFAIK, on HP-UX
> the implementation kept a "locker id" and a linked list of waiters' lock
> ids (to allow first come first served as well as handling the case of a
> lock holder dying)

Fundamentally, these locks are fast because they *don't* tell the kernel.
Also, if you die with a lock, "autocleaning" it is often far worse then
just locking up, since the data it was protecting may be inconcsistant.

At the end of the day, this is the place for an application-specific
answer.  And this is nothing that can't be done in userspace (ie. if
you can't get the lock for some length of time, notify the lock master
and it will do all the cleanups and release the lock).

Hope that clarifies,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
