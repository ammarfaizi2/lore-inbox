Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278885AbRJ1XUh>; Sun, 28 Oct 2001 18:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278880AbRJ1XU1>; Sun, 28 Oct 2001 18:20:27 -0500
Received: from [209.250.58.211] ([209.250.58.211]:23825 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S278885AbRJ1XUO>; Sun, 28 Oct 2001 18:20:14 -0500
Date: Sun, 28 Oct 2001 17:21:08 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: andrewm@uow.edu.au, rml@tech9.net
Subject: Processing hanging in 2.4.12
Message-ID: <20011028172108.A6509@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org, andrewm@uow.edu.au, rml@tech9.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 4:45pm  up 4 days,  4:48,  2 users,  load average: 6.42, 6.22, 6.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the unusual scenario of processes hanging and becoming unkilling
here.  Not only are they unkillable, but each of them absorb as much CPU
time as they can.  If not for the kernel-premption patch, I'd probably
be deadlocked.  Most of the processes are 'sh' and 'make' from a compile
job, but 1 is 'stonerview', an xscreensaver hack.

I got the output of Alt+SysRq+T, and examined a few of the tasks that
had hung.  Interestingly enough, all three of them have several lines in
common (the full traces for 3 processes are at the bottom, I can provide
more if they're needed).  The common lines are as follows:

Trace; c01233f1 <check_pgt_cache+11/20>
Trace; c01234ca <clear_page_tables+ca/d0>
Trace; c01261b6 <exit_mmap+126/130>
Trace; c0114876 <mmput+66/80>
Trace; c0119266 <do_exit+a6/240>

Any idea as to what may be causing this?  This is an AMD Athlon 900MHz,
memory known to be good, running Linus kernel 2.4.12 along with
preempt-patch and ext3-0.9.10.  Since it seems at least remotely
possible that one of these patches is causing the problem, I'm cc'ing
those maintainers as well.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin

Trace; c01088b7 <do_IRQ+97/100>
Trace; c010aac3 <call_do_IRQ+5/a>
Trace; c0111f09 <do_check_pgt_cache+19/80>
Trace; c01233f1 <check_pgt_cache+11/20>
Trace; c01234ca <clear_page_tables+ca/d0>
Trace; c01261b6 <exit_mmap+126/130>
Trace; c0114876 <mmput+66/80>
Trace; c0119266 <do_exit+a6/240>
Trace; c011942e <sys_exit+e/10>
Trace; c0106e7f <system_call+33/38>

Trace; c0113d50 <preempt_schedule+20/30>
Trace; c0106f55 <ret_from_exception+42/49>
Trace; c0111f60 <do_check_pgt_cache+70/80>
Trace; c01233f1 <check_pgt_cache+11/20>
Trace; c01234ca <clear_page_tables+ca/d0>
Trace; c01261b6 <exit_mmap+126/130>
Trace; c0114876 <mmput+66/80>
Trace; c0119266 <do_exit+a6/240>
Trace; c0106d0a <do_signal+23a/294>
Trace; c0142cea <select_bits_free+a/10>
Trace; c014315f <sys_select+46f/480>
Trace; c0106eb8 <signal_return+14/18>

Trace; c0113d50 <preempt_schedule+20/30>
Trace; c0106f55 <ret_from_exception+42/49>
Trace; c0111f09 <do_check_pgt_cache+19/80>
Trace; c01233f1 <check_pgt_cache+11/20>
Trace; c01234ca <clear_page_tables+ca/d0>
Trace; c01261b6 <exit_mmap+126/130>
Trace; c0114876 <mmput+66/80>
Trace; c0119266 <do_exit+a6/240>
Trace; c011942e <sys_exit+e/10>
Trace; c0106e7f <system_call+33/38>
