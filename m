Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312409AbSCUSHD>; Thu, 21 Mar 2002 13:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312420AbSCUSGy>; Thu, 21 Mar 2002 13:06:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312409AbSCUSGp>; Thu, 21 Mar 2002 13:06:45 -0500
Date: Thu, 21 Mar 2002 13:07:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Brown <dave@codewhore.org>
cc: Amol Kumar Lad <amolk@ishoni.com>, linux-kernel@vger.kernel.org
Subject: Re: Porting from vxworks to linux
In-Reply-To: <20020321114011.A27340@codewhore.org>
Message-ID: <Pine.LNX.3.95.1020321130441.962A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, David Brown wrote:

> Hi:
> 
> I haven't actually played with it, but the 'MM Shared Memory Library' at
> http://www.engelschall.com/sw/mm/ looks like a starting point.
> 
> According to the manual:
>  "The MM library is a 2-layer abstraction library which simplifies the
>   usage of shared memory between forked (and this way strongly related)
>   processes under Unix platforms. On the first layer it hides all platform
>   dependent implementation details (allocation and locking) when dealing
>   with shared memory segments and on the second layer it provides a
>   high-level malloc(3)-style API for a convenient and well known way to
>   work with data-structures inside those shared memory segments."
> 
> BSD-style license and all that good stuff.
> 
> Regards,
> - Dave
>   dave@codewhore.org
> 
> 
> On Thu, Mar 21, 2002 at 04:09:51PM +0530, Amol Kumar Lad wrote:
> > Hi ,
> >   Sorry for posting this to wrong list. But you can help me out.
> > 
> > I am porting some code from Vxworks to Linux (application level, not
> > kernel). 
> > THe problem is , in Vxworks as there is a single address space so a 'malloc'
> > done by one process is visible to other process also, i.e. all the global
> > data is shared in Vxworks across processes.
> > 
> > This is not true in linux, as every process has its own address space. 
> > What could be done so that I can use same 'malloc' like interface and have
> > all my 'global data'
> > shared across process. 
> > 
> > I can understand that i have to use shared memory for this. Is there any
> > library available
> > that provides me a 'malloc' type interface for shared memory.
> > 
> > All processes are unrelated processes ( fork -> exec)
> > 
> > Thanks
> > Amol
> > 
> > -- please CC me..
> > -


You don't need any special shared-memory library. All you need is
already present in the 'C' runtime libraries.

Basically, a task tries to attach some shared memory using a
key-word ID that you define. If it works, you get a pointer to
the existing shared memory. If it fails, your task is the
first to attempt it, so you create a shared memory area and
return a pointer. Easy. You don't use malloc() and friends
for shared memory. You use it for private memory.

If you want to contact me off-line, I can mail you a procedure
you can use as a template.

You may want to re-think a lot of stuff that was written for
VXWorks. Unix/Linux has many ways for tasks to communicate
including pipes and sockets. In many cases, shared memory is
not the way to go. Also, I note that a lot of stuff written
for linear-global address space, like VXWorks, ends up using
very poor design techniques like a big global trash-heap for
every variable. This is not the way to design something if
it needs to be tested and maintained.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

