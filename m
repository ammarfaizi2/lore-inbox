Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132681AbRDQO11>; Tue, 17 Apr 2001 10:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132674AbRDQO1A>; Tue, 17 Apr 2001 10:27:00 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:54898 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132664AbRDQO0b>; Tue, 17 Apr 2001 10:26:31 -0400
Date: Tue, 17 Apr 2001 09:26:26 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104171426.JAA76050@tomcat.admin.navo.hpc.mil>
To: ebrunet@quatramaran.ens.fr, linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <200104170915.LAA00596@quatramaran.ens.fr>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brunet <ebrunet@quatramaran.ens.fr>:
> >"Adam J. Richter" <adam@yggdrasil.com> said:
> >
> >> 	I suppose that running the child first also has a minor
> >> advantage for clone() in that it should make programs that spawn lots
> >> of threads to do little bits of work behave better on machines with a
> 
> There is another issue with this proposition. I have begun to write (free
> time, slow pace) an userland sandbox which allows me to prevent a process
> and its childs to perform some given actions, like removing files or
> writing in some directories. This works by ptrace-ing the process,
> modifying system calls and faking return values. It also needs,
> obviously, to ptrace-attach childs of the sandboxed process. When the
> parent in a fork runs first, the sandbox program has time to
> ptrace-attach the child before it does any system call. Obviously, if the
> child runs first, this is no longer the case.
> 
> If it is decided that the child should run first in a fork, there should
> be a way to reliably ptrace-attach it before it can do anything.
> 
> By the way, I tried to solve this problem in my sandbox program by
> masqerading any fork call into a clone system call with the flag
> CLONE_PTRACE. I had hoped that the child would in this way start already
> ptraced. However, this didn't work as expected. The child did start in a
> ptraced state, but the owner of the trace was its parent (which issued
> the fork), and not my sandbox process which was ptracing this parent. I
> find that this behaviour is really weird and useless. I could simulate
> the current behaviour simply by calling ptrace(TRACE_ME,..) in the child.
> What is the real use of the CLONE_PTRACE flag ?

I believe it allows the debugger to start the process to be debugged.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
