Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293084AbSBWCsL>; Fri, 22 Feb 2002 21:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293085AbSBWCsB>; Fri, 22 Feb 2002 21:48:01 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:1287 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293084AbSBWCru>; Fri, 22 Feb 2002 21:47:50 -0500
Date: Sat, 23 Feb 2002 13:47:43 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
Cc: pj@engr.sgi.com, focht@ess.nec.de, rml@tech9.net,
        linux-kernel@vger.kernel.org, mingo@elte.hu, colpatch@us.ibm.com,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Message-Id: <20020223134743.19cb675f.rusty@rustcorp.com.au>
In-Reply-To: <20020220173242.2BDF.K-SUGANUMA@mvj.biglobe.ne.jp>
In-Reply-To: <Pine.LNX.4.21.0202202337320.10032-100000@sx6.ess.nec.de>
	<Pine.SGI.4.21.0202201619560.565754-100000@sam.engr.sgi.com>
	<20020220173242.2BDF.K-SUGANUMA@mvj.biglobe.ne.jp>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002 17:40:56 -0800
Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp> wrote:

> Hi all,
> 
> On Wed, 20 Feb 2002 17:12:21 -0800
> Paul Jackson <pj@engr.sgi.com> wrote:
> 
> > > Another problem is the right moment to change the cpu field of the
> > > task. ... The IPI to the target CPU is the same as in the
> > > initial design of Ingo. It has to wait for the task to unschedule and
> > > knows it will find it dequeued.
> > 
> > How about not changing anything of the target task synchronously,
> > except for some new "proposed_cpus_allowed" field.  Set that
> > field and get out of there.  Let the target process run the
> > set_cpus_allowed() routine on itself, next time it passes through
> > the schedule() code.  Leave it the case that the set_cpus_allowed()
> > routine can only be run on the current process.
> > 
> > Perhaps others need this cpus_allowed change (and the migration
> > of a task to a different allowed cpu) to happen "right away".
> > But I don't, and I don't (yet) know that anyone else does.
> 
> CPU hotplug needs to change cpus_allowed in definite time.
> When a process is sleeping for 100000 seconds, how can we offline
> a CPU the process belongs?

Hi All,

	I've been working on hotplug with the new scheduler and preempt.
It still crashes, so no public code yet 8).  It follows Linus's suggestion
that cpu_up() be called during the boot process, which is nicer.

	But this particular problem did not hurt me, since I now run a 
"suicide" thread on the dying CPU, making it safe and trivial to manually
re-queue processes.  The question of what to do with processes which cannot
be scheduled on any remaining CPUs is another interesting question.

(Note: downing a CPU with a suicide thread introduces cleanup issues: I may
yet return to the original implementations where suicide thread == idle thread).

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
