Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282052AbRK0Gmj>; Tue, 27 Nov 2001 01:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282825AbRK0Gma>; Tue, 27 Nov 2001 01:42:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2788 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282052AbRK0GmV>;
	Tue, 27 Nov 2001 01:42:21 -0500
Date: Tue, 27 Nov 2001 09:40:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <1006832357.1385.3.camel@icbm>
Message-ID: <Pine.LNX.4.33.0111270930470.3061-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


your comments about syscall vs. procfs:

> This patch comes about as an alternative to Ingo Molnar's
> syscall-implemented version.  Ingo's code is nice; however I and
> others expressed discontent as yet another syscall. [...]

i do express discontent over yet another procfs bloat. What if procfs is
not mounted in a high security installation? Are affinities suddenly
unavailable? Such kind of dependencies are unacceptable IMO - if we want
to export the setting of affinities to user-space, then it should be a
system call.

(Also procfs is visibly slower than a system-call - i can well imagine
this to be an issue in some sort of threaded environment that creates and
destroys threads at a high rate, and wants to have a different affinity
for every new thread.)

> [...] Other benefits include the ease with which to set the affinity
> of tasks that are unaware of the new interface [...]

this was a red herring - see chaff.c.

> [...] and that with this approach applications don't need to hackishly
> check for the existence of a syscall.

uhm, what check? A nonexistent system call does not have to be checked
for.

(so far no legitimate technical point has been made against the
syscall-based setting of affinities.)

	Ingo

