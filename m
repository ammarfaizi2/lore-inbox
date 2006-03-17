Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWCQUEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWCQUEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWCQUEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:04:35 -0500
Received: from nevyn.them.org ([66.93.172.17]:12941 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932501AbWCQUEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:04:35 -0500
Date: Fri, 17 Mar 2006 15:04:31 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
Message-ID: <20060317200431.GA20273@nevyn.them.org>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Michael Kerrisk <mtk-manpages@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200603170647_MC3-1-BAD9-ED70@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603170647_MC3-1-BAD9-ED70@compuserve.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 06:44:21AM -0500, Chuck Ebbert wrote:
> > Specifically, the three kinds of cloning are distinguished as:
> > 
> > if CLONE_VFORK -> PTRACE_EVENT_VFORK
> > else if clone exit signal == SIGCHLD -> PTRACE_EVENT_FORK
> > else PTRACE_EVENT_CLONE
> > 
> > You need to do some juggling to get the actual clone flags.
> 
> It might be best to leave these descriptions in terms of C library functions
> rather than kernel-internal.  Looking at sys_clone() and sys_fork() I can see
> what you mean but I'm not sure how to describe it to a programmer.

Those are user accessible flags.  Fork will give you a
PTRACE_EVENT_FORK, vfork will give you a PTRACE_EVENT_VFORK, but
clone may give you any of the above, depending on what arguments you
pass to it.  The SIGCHLD test matches the bit described in clone(2)
for __WALL or __WCLONE, for instance.

> > BTW, I believe there are still some potential deadlocks between
> > the vfork event and the vfork done event; I used to regularly generate
> > unkillable processes working on this code.
> 
> I have a test program and didn't hit any problems yet.  Maybe this was fixed?

One thing that IIRC was a problem was killing the parent before the
child (or maybe the other way round) when stopped at this point - such
as would happen if you typed "kill" at a GDB prompt after catch vfork.

-- 
Daniel Jacobowitz
CodeSourcery
