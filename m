Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVAXPKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVAXPKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVAXPKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:10:25 -0500
Received: from nevyn.them.org ([66.93.172.17]:63620 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261520AbVAXPKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:10:03 -0500
Date: Mon, 24 Jan 2005 10:10:00 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050124150959.GA21573@nevyn.them.org>
Mail-Followup-To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20050121100606.GB8042@dualathlon.random> <20050121093902.O469@build.pdx.osdl.net> <csrje8$bsn$1@abraham.cs.berkeley.edu> <20050121111700.Q469@build.pdx.osdl.net> <csvk20$6qa$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csvk20$6qa$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 07:34:24AM +0000, David Wagner wrote:
> Chris Wright  wrote:
> >* David Wagner (daw@taverner.cs.berkeley.edu) wrote:
> >> There is a simple tweak to ptrace which fixes that: one could add an
> >> API to specify a set of syscalls that ptrace should not trap on.  To get
> >> seccomp-like semantics, the user program could specify {read,write}, but
> >> if the user program ever wants to change its policy, it could change that
> >> set.  Solaris /proc (which is what is used for tracing) has this feature.
> >> I coded up such an extension to ptrace semantics a long time ago, and
> >> it seemed to work fine for me, though of course I am not a ptrace expert.
> >
> >Hmm, yeah, that'd be nice.  That only leaves the issue of tracer dying
> >(say from that crazy oom killer ;-).
> 
> Yes, I also implemented was a ptrace option which causes the child to be
> slaughtered if the parent dies for any reason.  I could dig up the code,
> but I don't recall it being very hard.  This was ages ago (a 2.0.x kernel)
> and I have no idea what might have changed.  Also, am definitely not a
> guru on kernel internals, so it is always possible I missed something.
> But, at least on the surface this doesn't seem hard to implement.

Maybe it's time to resubmit both of these.  OTOH, maybe it's time to do
something more drastic to ptrace to untangle it from signals...

> A third thing I implemented was a option which would cause ptrace() to be
> inherited across forks.  The way that strace does this (last I looked)
> is an unreliable abomination: when it sees a request to call fork(), it
> sets a breakpoint at the next instruction after the fork() by re-writing
> the code of the parent, then when that breakpoint triggers it attaches to
> the child, restores the parent's code, and lets them continue executing.
> This is icky, and I have little confidence in its security to prevent
> children from escaping a ptrace() jail, so I added a feature to ptrace()
> that remedies the situation.

This has since been done in 2.5.x; see PTRACE_EVENT_FORK.  GDB even
uses it nowadays.  I'm not sure if strace does.

-- 
Daniel Jacobowitz
