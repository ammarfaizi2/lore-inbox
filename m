Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292865AbSCEHJG>; Tue, 5 Mar 2002 02:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292929AbSCEHIp>; Tue, 5 Mar 2002 02:08:45 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:10252 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292865AbSCEHIm>; Tue, 5 Mar 2002 02:08:42 -0500
Date: Mon, 4 Mar 2002 17:13:46 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@engr.sgi.com>
Cc: frankeh@watson.ibm.com, martin.wirth@dlr.de, rusty@rustycorp.com.au,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] Lightweight userspace semaphores...
Message-Id: <20020304171346.04c9cac6.rusty@rustcorp.com.au>
In-Reply-To: <Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>
In-Reply-To: <20020302090856.A1332@elinux01.watson.ibm.com>
	<Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
