Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTBVGA5>; Sat, 22 Feb 2003 01:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267813AbTBVGA5>; Sat, 22 Feb 2003 01:00:57 -0500
Received: from crack.them.org ([65.125.64.184]:17543 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267812AbTBVGA4>;
	Sat, 22 Feb 2003 01:00:56 -0500
Date: Sat, 22 Feb 2003 01:10:57 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Dave Pifke <dave@pifke.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CLONE_THREAD with old (glibc 2.2.5) linuxthreads
Message-ID: <20030222061057.GA16475@nevyn.them.org>
Mail-Followup-To: Dave Pifke <dave@pifke.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0302211649300.19257-100000@burn.victim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302211649300.19257-100000@burn.victim.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 05:05:40PM -0800, Dave Pifke wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> 
> I'm attempting to add ps-like code to an application, and am running into
> a problem calculating the memory usage of multithreaded processes.  The
> memory usage numbers in /proc/PID/statm don't give any indication as to
> whether or not the process shares its VM with another, thus a
> multithreaded application appears to be using (actual usage * number of
> threads).
> 
> It looks like this could be easilly solved by looking at Tgid in
> /proc/PID/status and calculating memory usage per-thread-group instead of
> per-process.  The problem, however, is that glibc 2.2.5 does not set
> CLONE_THREAD and so Tgid == Pid in every case.
> 
> Would it break anything if I patch my glibc to set this flag?  Is
> task_struct->tgid just informational in 2.4, or does it modify the
> behavior of the task somehow?

Don't even try it.  CLONE_THREAD changs the semantics for signal
delivery.

> Or, is there perhaps another way to see if CLONE_VM was set when the
> process was cloned?  (Thus avoiding the need to change anything in glibc.)

There's no good way.  Once you have the process tree you can make
pretty good guesses though; the hierarchy of LinuxThreads is quite
distinctive (first -> manager -> all children).  It might be nice to
export the clone flags in proc.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
