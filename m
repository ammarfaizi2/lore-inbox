Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310334AbSCGOBi>; Thu, 7 Mar 2002 09:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310335AbSCGOB3>; Thu, 7 Mar 2002 09:01:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48257 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310334AbSCGOBQ>; Thu, 7 Mar 2002 09:01:16 -0500
Date: Thu, 7 Mar 2002 09:00:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Steven A. DuChene" <linux-clusters@mindspring.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_YIELD undeclared with Trond's NFS patch w/2.4.19-pre2-ac2
In-Reply-To: <20020307084514.C16224@lapsony.mydomain.here>
Message-ID: <Pine.LNX.3.95.1020307085809.19727A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Steven A. DuChene wrote:

> I am attempting to apply Trond's linux-2.4.18-NFS_ALL.dif patch to 2.4.19-pre2-ac2
> I get the patch to apply once I massage fs/nfs/inode.c a little bit but when I try
> to compile it I get:
> 
> svcsock.c: In function `svc_recv':
> svcsock.c:987: `SCHED_YIELD' undeclared (first use in this function)
> svcsock.c:987: (Each undeclared identifier is reported only once
> svcsock.c:987: for each function it appears in.)
> make[3]: *** [svcsock.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.X/net/sunrpc'
> make[2]: *** [first_rule] Error 2
> 

> Now I know there were some changes because of the O(1) stuff in the ac2 patch but
> what is the process for eliminating references to SCHED_YIELD?
> -- 
> Steven A. DuChene      linux-clusters@mindspring.com
>                       sduchene@mindspring.com

You need to change loops that do something like:

    while(something)
    {
        current->policy |= SCHED_YIELD;
        schedule();
    }
    
    to:

    while(something)
        sys_sched_yield();


Reference:

On Tue, 26 Feb 2002, Richard B. Johnson wrote:

> On Tue, 26 Feb 2002, Davide Libenzi wrote:
> >
> > In 2.5 yield() maps to sys_sched_yield(). You can handle it in the same
> > way in your includes if version <= 2.4.
>
> It's not exported as well as not defined in a header! It results in
> an undefined symbol in the module.

You can try to ask Marcelo to add a line in include/linux/sched.h and one
in kernel/ksym.c
In this way a compatibility interface can be achieved for code that needs it.


- Davide






Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

