Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945989AbWANCft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWANCft (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945986AbWANCft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:35:49 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:28342 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945987AbWANCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:35:48 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1137203402.11300.41.camel@cog.beaverton.ibm.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137198221.11300.21.camel@cog.beaverton.ibm.com>
	 <1137201012.6727.1.camel@localhost.localdomain>
	 <1137201250.1408.39.camel@mindpipe>
	 <1137201821.11300.30.camel@cog.beaverton.ibm.com>
	 <1137202039.1408.42.camel@mindpipe>
	 <1137202773.11300.37.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0601132042050.7584@gandalf.stny.rr.com>
	 <1137203402.11300.41.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 21:34:52 -0500
Message-Id: <1137206092.7150.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 17:50 -0800, john stultz wrote:
> On Fri, 2006-01-13 at 20:43 -0500, Steven Rostedt wrote:
> > On Fri, 13 Jan 2006, john stultz wrote:
> > 
> > >
> > > This is as I understand it:
> > >
> > > With 2.6.15 on x86-64:
> > > 	If available, alternate timesources (HPET, ACPI PM) will be used if
> > > available on AMD SMP systems. (clock= is i386 only)
> > 
> > Hmm, should I boot without the clock= to prove this?
> 
> Feel free. That or grep the x86-64 time.c code.
> 
> Look for:
> 	time.c: Using PM based timekeeping.
> 
> To verify the timesource selection.

So much for not looking at code! 

I uploaded yet another version of 
http://www.kihontech.com/tests/rt/monotonic.c
that now also tests the tsc too, to see if it goes backwards.  If it
does, then it prints (only once) that fact and continues testing the
gettime function.

So this proves that the tsc does go back and the gettime still is
working.


$ ./monotonic
main program pid=7137
hello from thread 0!
hello from thread 4!
last tsc is 4389431102233  this tsc is 4389429636684
hello from thread 1!
hello from thread 2!
hello from thread 3!

-- Steve



