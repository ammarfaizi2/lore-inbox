Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSGAIBp>; Mon, 1 Jul 2002 04:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSGAIBo>; Mon, 1 Jul 2002 04:01:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57246 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315455AbSGAIBn>;
	Mon, 1 Jul 2002 04:01:43 -0400
Date: Mon, 1 Jul 2002 10:00:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andreas Jaeger <aj@suse.de>
Cc: Nicholas Miell <nmiell@attbi.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] batch/idle priority scheduling, SCHED_BATCH
In-Reply-To: <ho1yaodju4.fsf@gee.suse.de>
Message-ID: <Pine.LNX.4.44.0207010954420.2321-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Jul 2002, Andreas Jaeger wrote:

> >> -#define SCHED_OTHER		0
> >> +#define SCHED_NORMAL		0
> >
> >>From IEEE 1003.1-2001 / Open Group Base Spec. Issue 6:
> > "Conforming implementations shall include one scheduling policy
> > identified as SCHED_OTHER (which may execute identically with either the
> > FIFO or round robin scheduling policy)."
> >
> > So, you probably want to add a "#define SCHED_OTHER SCHED_NORMAL" here
> > in order to prevent future confusion, especially because the user-space
> > headers have SCHED_OTHER, but no SCHED_NORMAL.
> 
> This can be done in glibc.  linux/sched.h should not be used by
> userspace applications, glibc has the define in <bits/sched.h> which is
> included from <sched.h> - and <sched.h> is the file defined by Posix.

yes, this was my thinking too.

the reason for the change: with the introduction of SCHED_BATCH the
regular scheduling policy cannot really be called 'other' anymore, from
the point of scheduler internals - it's in the middle of all scheduler
policies, its only speciality is that it's the default one.

(obviously for the user interface it has to be defined.)

	Ingo

