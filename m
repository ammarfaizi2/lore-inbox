Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWCQLrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWCQLrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWCQLrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:47:41 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:13755 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750774AbWCQLrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:47:41 -0500
Date: Fri, 17 Mar 2006 06:44:21 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
To: Daniel Jacobowitz <dan@debian.org>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200603170647_MC3-1-BAD9-ED70@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060316200201.GA20315@nevyn.them.org>

On Thu, 16 Mar 2006 15:02:01 -0500, Daniel Jacobowitz wrote:

> >               PTRACE_O_TRACEFORK
> >                      Stop the child at the next fork()  call  with  SIGTRAP  |
> >                      PTRACE_EVENT_FORK  <<  8  and automatically start tracing
> >                      the  newly  forked  process,  which  will  start  with  a
> >                      SIGSTOP.   The  pid  for the new process can be retrieved
> >                      with PTRACE_GETEVENTMSG.
> > 
> >               PTRACE_O_TRACEVFORK
> >                      Stop the child at the next vfork() call  with  SIGTRAP  |
> >                      PTRACE_EVENT_VFORK  <<  8 and automatically start tracing
> >                      the the newly vforked process, which will  start  with  a
> >                      SIGSTOP.   The  pid  for the new process can be retrieved
> >                      with PTRACE_GETEVENTMSG.
> > 
> >               PTRACE_O_TRACECLONE
> >                      Stop the child at the next clone() call  with  SIGTRAP  |
> >                      PTRACE_EVENT_CLONE  <<  8 and automatically start tracing
> >                      the  newly  cloned  process,  which  will  start  with  a
> >                      SIGSTOP.   The  pid  for the new process can be retrieved
> >                      with PTRACE_GETEVENTMSG.
> 
> Specifically, the three kinds of cloning are distinguished as:
> 
> if CLONE_VFORK -> PTRACE_EVENT_VFORK
> else if clone exit signal == SIGCHLD -> PTRACE_EVENT_FORK
> else PTRACE_EVENT_CLONE
> 
> You need to do some juggling to get the actual clone flags.

It might be best to leave these descriptions in terms of C library functions
rather than kernel-internal.  Looking at sys_clone() and sys_fork() I can see
what you mean but I'm not sure how to describe it to a programmer.

> BTW, I believe there are still some potential deadlocks between
> the vfork event and the vfork done event; I used to regularly generate
> unkillable processes working on this code.

I have a test program and didn't hit any problems yet.  Maybe this was fixed?


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

