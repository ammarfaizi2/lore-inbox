Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbTBFW3u>; Thu, 6 Feb 2003 17:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTBFW3t>; Thu, 6 Feb 2003 17:29:49 -0500
Received: from crack.them.org ([65.125.64.184]:9194 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267651AbTBFW3s>;
	Thu, 6 Feb 2003 17:29:48 -0500
Date: Thu, 6 Feb 2003 17:39:24 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Ptrace updates [0/5]
Message-ID: <20030206223924.GA22688@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while since the last set of ptrace patches; here's what I've
queued up.  They'll follow in individual messages, or they're available by
BitKeeper (details below).

These are all small changes; there may be some more interesting ones in a
couple of weeks, after GDB support for NPTL is more mature.  Overview:
  - Two new traceable events, end-of-vfork and process exit.
  - Ptrace calls to get and set the siginfo struct associated with a signal.
  - Two separate signal handling fixes for the fork-tracing and CLONE_PTRACE
    support.
  - A bugfix to prevent zombie processes when debugging LinuxThreads.



Linus, please do a

	bk pull http://ptrace.bkbits.net/for-linus-2.5

This will update the following files:

 include/linux/ptrace.h |    6 ++++++
 include/linux/sched.h  |    3 +++
 kernel/exit.c          |   30 ++++++++++++++++++++++++++----
 kernel/fork.c          |    8 +++++---
 kernel/ptrace.c        |   36 +++++++++++++++++++++++++++++++++++-
 kernel/signal.c        |    8 +++++++-
 6 files changed, 82 insertions(+), 9 deletions(-)

through these ChangeSets:

<drow@nevyn.them.org> (03/02/06 1.961)
   Signal handling bugs for thread exit + ptrace

<drow@nevyn.them.org> (03/02/06 1.960)
   Add PTRACE_O_TRACEVFORKDONE and PTRACE_O_TRACEEXIT facilities.

<drow@nevyn.them.org> (03/02/04 1.959)
   Use force_sig_specific to send SIGSTOP to newly-created CLONE_PTRACE processes.

<drow@nevyn.them.org> (03/01/18 1.958)
   Add PTRACE_GETSIGINFO and PTRACE_SETSIGINFO
   
   These new ptrace commands allow a debugger to control signals more precisely;
   for instance, store a signal and deliver it later, as if it had come from the
   original outside process or in response to the same faulting memory access.

<drow@nevyn.them.org> (03/01/18 1.957)
   Tweak has_stopped_jobs for use with debugging


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
