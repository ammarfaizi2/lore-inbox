Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264471AbSIVSwh>; Sun, 22 Sep 2002 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264472AbSIVSwh>; Sun, 22 Sep 2002 14:52:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59990 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264471AbSIVSwg>; Sun, 22 Sep 2002 14:52:36 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Bill Huey <billh@gnuppy.monkey.org>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Sep 2002 12:41:40 -0600
In-Reply-To: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com>
Message-ID: <m1u1khkgt7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> On Fri, 20 Sep 2002, Bill Huey wrote:
> 
> 
> > Don't remember off hand, but it's like to be several times a second which is
> > often enough to be a problem especially on large systems with high load.
> > 
> > The JVM with incremental GC is being targetted for media oriented tasks
> > using the new NIO, 3d library, etc... slowness in safepoints would cripple it
> > for these tasks. It's a critical item and not easily address by the current
> > 1:1 model.
> 
> Could you comment on how whell this works (or not) with linuxthreads,
> Solaris, and NGPT? I realize you probably haven't had time to look at NPTL
> yet. If an N:M model is really better for your application you might be
> able to just run NGPT.
> 
> Since preempt threads seem a problem, cound a dedicated machine run w/o
> preempt? I assume when you say "high load" that you would be talking a
> server, where performance is critical.

>From 10,000 feet out I have one comment.  If the VM has safe points. It sounds
like the problem is more that the safepoints don't provide the register
dumps more than anything else.

They are talking about an incremental GC routine so it does not need to stop
all threads simultaneously.  Threads only need to be stopped when the GC is gather
a root set.  This is what the safe points are for right?  And it does
not need to be 100% accurate in finding all of the garbage.  The
collector just needs to not make mistakes in the other direction.

I fail to see why:

/* This is a safe point ... */
if (needs to be suspended) {
        save_all_registers_on_the_stack()
        flag_gc_thread()
        wait_until_gc_thread_has_what_it_needs()
}

Needs kernel support.

Eric
