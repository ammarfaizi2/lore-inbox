Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293288AbSCEPJG>; Tue, 5 Mar 2002 10:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293291AbSCEPI5>; Tue, 5 Mar 2002 10:08:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47030 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293288AbSCEPIv>; Tue, 5 Mar 2002 10:08:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Date: Tue, 5 Mar 2002 10:09:47 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16i5tL-0006NV-00@wagner.rustcorp.com.au>
In-Reply-To: <E16i5tL-0006NV-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305150842.247963FE07@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 March 2002 10:45 pm, Rusty Russell wrote:
> In message <1015293007.882.87.camel@phantasy> you write:
> > On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
> > > That's great. What if the process holding the mutex dies while there're
> > > sleeping tasks waiting for it ?
> >
> > I can't find an answer in the code (meaning the lock is lost...) and no
> > one has yet answered.  Davide, have you noticed anything?
> >
> > I think this needs a proper solution..
>
>
> If you want this, use fcntl locks (see TDB).  If you don't tell the kernel
> what you are doing (which is the reason these locks are fast), it cannot
> clean up for you.
>
> One could conceive of a solution where a process told the kernel
> "here is where I keep my lock states: if I die, clean up".  Of course,
> there's a race there too.
>

Yes, the problem goes even deeper. A simple hook is not enough.
One must know who is actually holding the lock, so that the cleanup
routines do the right thing.
E.g. store the pid with the lock. As Rusty stated this has still race 
conditions.
Anyway, this should be orthogonal to the low level services
provided. 
Another issue is that of rwlocks. Here its perfectly OK to die if
you hold the lock in read mode and clean up before going away.

Again, this should not be part of the base service.

> IMHO, given that the lock is protecting something which is left in an
> unknown state, this is something which would require serious testing
> to be proven worthwhile.
>


> Hope that helps,
> Rusty.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
