Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTAFPkT>; Mon, 6 Jan 2003 10:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbTAFPkT>; Mon, 6 Jan 2003 10:40:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:55708 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266996AbTAFPkQ>; Mon, 6 Jan 2003 10:40:16 -0500
Date: Mon, 6 Jan 2003 10:50:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Doug McNaught <doug@mcnaught.org>
cc: Dirk Bull <dirkbull102@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: shmat problem
In-Reply-To: <m31y3qi999.fsf@varsoon.wireboard.com>
Message-ID: <Pine.LNX.3.95.1030106104344.1785A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Doug McNaught wrote:

> "Dirk Bull" <dirkbull102@hotmail.com> writes:
> 
> > Doug, thanks for the reply. I've set SHM_RND in the call and used
> > "__attribute__ ((aligned(4096)))" during the the declaration of
> > variable global01_
> > (as shown below) such that it is aligned on a page boundary. I'm
> > porting code that was
> > written for a Unix system to Linux and the example shown below is how
> > the code is
> > implemented on Unix.
> 
> Hmmm, I may be ignorant, but I don't see how the below could work.
> You're asking for the kernel to map your shared memory in the middle
> of an already-mapped area (the bss segment).  I'm actually surprised
> it works on any Unix.
> 
> If you can point out a clear violation of the POSIX spec, someone may
> be willing to change it, but it's not clear to me that you're
> guaranteed to be able to map a shared memory area inside your existing
> data segment.
> 
> > union {
> > 	long IN[2048];
> > } global01_ __attribute__ ((aligned(4096)));
> 
> [...]
> 
> > 	if ( (shmptr = shmat(shmid, &global01_, SHM_RND)) == (void *) -1)
> > 		printf("shmat error: %d %s\n",errno, strerror(errno));
> > 	else
> > 		printf("shared memory attached from %x to %x\n",
> > 				shmptr, shmptr+sizeof(global01_));
> 
> -Doug

You beat me to the answer. I was re-writing this to use a pointer,
not an already allocated data object that exists in the .bss section.
This was to show how it's usually done. Basically, SHM_RND may round
down so, with odd-sized mapping, you have to be careful.

Since I did not think it should work, I tried first to initialize
global01_, which would put it into the .data section. This didn't
work either so I don't think the demo code is supposed to work.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


