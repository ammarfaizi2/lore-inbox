Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293581AbSCEDmq>; Mon, 4 Mar 2002 22:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293563AbSCEDm3>; Mon, 4 Mar 2002 22:42:29 -0500
Received: from [202.135.142.196] ([202.135.142.196]:49931 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293583AbSCEDmN>; Mon, 4 Mar 2002 22:42:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
In-Reply-To: Your message of "04 Mar 2002 20:50:06 CDT."
             <1015293007.882.87.camel@phantasy> 
Date: Tue, 05 Mar 2002 14:45:31 +1100
Message-Id: <E16i5tL-0006NV-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1015293007.882.87.camel@phantasy> you write:
> On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
> 
> > That's great. What if the process holding the mutex dies while there're
> > sleeping tasks waiting for it ?
> 
> I can't find an answer in the code (meaning the lock is lost...) and no
> one has yet answered.  Davide, have you noticed anything?
> 
> I think this needs a proper solution..

No.  From my previous post:

Date: Mon, 4 Mar 2002 17:13:46 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@engr.sgi.com>
Cc: frankeh@watson.ibm.com, martin.wirth@dlr.de, rusty@rustycorp.com.au, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] Lightweight userspace semaphores...
Message-Id: <20020304171346.04c9cac6.rusty@rustcorp.com.au>
In-Reply-To: <Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>
In-Reply-To: <20020302090856.A1332@elinux01.watson.ibm.com>
	<Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>

On Sun, 3 Mar 2002 14:13:45 -0800
Paul Jackson <pj@engr.sgi.com> wrote:

> On Sat, 2 Mar 2002, Hubertus Franke wrote:
> > But more conceptually, if you process dies while holding a lock ... 
> > your app is toast at that point.
> 
> Without application specific knowledge, certainly.
> 
> Is there someway one could support a hook, to enable
> an application to register a handler that could clean
> up, for those apps that found that worthwhile?

If you want this, use fcntl locks (see TDB).  If you don't tell the kernel
what you are doing (which is the reason these locks are fast), it cannot
clean up for you.

One could conceive of a solution where a process told the kernel
"here is where I keep my lock states: if I die, clean up".  Of course,
there's a race there too.

IMHO, given that the lock is protecting something which is left in an
unknown state, this is something which would require serious testing
to be proven worthwhile.

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
