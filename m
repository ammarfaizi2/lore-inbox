Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTEHRwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTEHRwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:52:33 -0400
Received: from holomorphy.com ([66.224.33.161]:48537 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261944AbTEHRwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:52:24 -0400
Date: Thu, 8 May 2003 11:04:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Torsten Landschoff <torsten@debian.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030508180445.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Torsten Landschoff <torsten@debian.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507150429.GA7248@stargate.galaxy> <20030507160144.GS8931@holomorphy.com> <20030508173647.W626@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508173647.W626@nightmaster.csn.tu-chemnitz.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 09:01:44AM -0700, William Lee Irwin III wrote:
>> Pure per-cpu stacks would require the interrupt model of programming to
>> be used, which is a design decision deep enough it's debatable whether
>> it's feasible to do conversions to or from at all, never mind desirable.
>> Basically every entry point into the kernel is treated as an interrupt,
>> and nothing can ever sleep or be scheduled in the kernel, but rather
>> only register callbacks to be run when the event waited for occurs.
>> Scheduling only happens as a decision of which userspace task to resume
>> when returning from the kernel to userspace, though one could envision
>> a priority queue discipline for processing the registered callbacks.

On Thu, May 08, 2003 at 05:36:47PM +0200, Ingo Oeser wrote:
> To illustrate that: It's basically a difference like between
> fork() and spawn(). Threads (of control) are completely decoupled
> und re-coupled only by the event/callback mechanism. 
> This is introducing exactly the mechanisms Linus didn't like when
> he decided, that he doesn't want a micro kernel architecture.
> So it is not going to happen RSN.

Your analogy is poor and I vaguely doubt the mechanism has been
suggested by anyone for use in Linux ever. It has nothing whatsoever to
do with a microkernel and in most incarnations precludes microkernel
designs. I'm not suggesting it, I just thought that was what "per-cpu
stacks" was supposed to mean.

Not that elaboration is needed, but the threads of control are not
decoupled as you suggest, but rather connected with continuations at
what would in the UNIX model be scheduling points. spawn() is just
POSIX' API for optimizing out some of the overhead of a fork()/exec()
cycle, and has nothing to do with interrupt model programming, esp.
since it is the exact opposite of thread creation. i.e. the interrupt
model is the extreme incarnation of "state machines, not threads".


-- wli
