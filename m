Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTEGSSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEGSSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:18:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1667 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264174AbTEGSSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:18:31 -0400
Date: Wed, 7 May 2003 14:33:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: petter wahlman <petter@bluezone.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052330844.3739.840.camel@badeip>
Message-ID: <Pine.LNX.4.53.0305071429390.13499@chaos>
References: <1052321673.3727.737.camel@badeip>  <Pine.LNX.4.53.0305071147510.12652@chaos>
  <1052323711.3739.750.camel@badeip>  <Pine.LNX.4.53.0305071247360.12878@chaos>
 <1052330844.3739.840.camel@badeip>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, petter wahlman wrote:

> On Wed, 2003-05-07 at 18:59, Richard B. Johnson wrote:
> > On Wed, 7 May 2003, petter wahlman wrote:
> >
> > > On Wed, 2003-05-07 at 18:00, Richard B. Johnson wrote:
> > > > On Wed, 7 May 2003, petter wahlman wrote:
> > > >
> > > > >
> > > > > It seems like nobody belives that there are any technically valid
> > > > > reasons for hooking system calls, but how should e.g anti virus
> > > > > on-access scanners intercept syscalls?
> > > > > Preloading libraries, ptracing init, patching g/libc, etc. are
> > > >   ^^^^^^^^^^^^^^^^^^^
> > > >                     |________  Is the way to go. That's how
> > > > you communicate every system-call to a user-mode daemon that
> > > > does whatever you want it to do, including phoning the National
> > > > Security Administrator if that's the policy.
> > > >
> > > > > obviously not the way to go.
> > > > >
> > > >
> > > > Oviously wrong.
> > >
> > >
> > > And how would you force the virus to preload this library?
> > >
> > > -p.
> > >
> >
> > The same way you would force a virus to not be statically linked.
> > You make sure that only programs that interface with the kernel
> > thorugh your hooks can run on that particular system.
> >
>
> Can you please elaborate.
> How would you implement the access control without modifying the
> respective syscalls or the system_call(), and would you'r
> solution be possible to implement run time?
>
> Regards,
>

The program loader for shared-library programs is ld.so or
ld-linux.so. It's the thing that mmaps the shared libraries
and, eventually calls _start: in the beginning of the program:

execve("/bin/ps", ["ps"], [/* 32 vars */]) = 0
brk(0)                                  = 0x804c748
open("/etc/ld.so.preload", O_RDONLY)    = 3 <<<<<<--- your hooks here!!
fstat(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
old_mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0
close(3)                                = 0



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

