Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTAVOgI>; Wed, 22 Jan 2003 09:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTAVOgI>; Wed, 22 Jan 2003 09:36:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:65522 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261353AbTAVOgH>;
	Wed, 22 Jan 2003 09:36:07 -0500
Message-ID: <003301c2c235$2f3123c0$29060e09@andrewhcsltgw8>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Michael Hohnbaum" <hohnbaum@us.ibm.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Erich Focht" <efocht@ess.nec.de>,
       "Matthew Dobson" <colpatch@us.ibm.com>,
       "Christoph Hellwig" <hch@infradead.org>, "Robert Love" <rml@tech9.net>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>,
       "Anton Blanchard" <anton@samba.org>,
       "Andrea Arcangeli" <andrea@suse.de>
References: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain> <1043205347.5161.42.camel@kenai>
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
Date: Wed, 22 Jan 2003 08:41:55 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2003-01-20 at 13:18, Ingo Molnar wrote:
> >
> > the attached patch (against 2.5.59) is my current scheduler tree, it
> > includes two main areas of changes:
> >
> >  - interactivity improvements, mostly reworked bits from Andrea's tree
and
> >    various tunings.
> >
> >  - HT scheduler: 'shared runqueue' concept plus related logic: HT-aware
> >    passive load balancing, active-balancing, HT-aware task pickup,
> >    HT-aware affinity and HT-aware wakeup.
>
> I ran Erich's numatest on a system with this patch, plus the
> cputime_stats patch (so that we would get meaningful numbers),
> and found a problem.  It appears that on the lightly loaded system
> sched_best_cpu is now loading up one node before moving on to the
> next.  Once the system is loaded (i.e., a process per cpu) things
> even out.  Before applying the D7 patch, processes were distributed
> evenly across nodes, even in low load situations.

Michael,  my experience has been that 2.5.59 loaded up the first node before
distributing out tasks (at least on kernbench).  The first check in
sched_best_cpu would almost always place the new task on the same cpu, and
intra node balance on an idle cpu in the same node would almost always steal
it before a inter node balance could steal it.  Also, sched_best_cpu does
not appear to be changed in D7.  Actually, I expected D7 to have the
opposite effect you describe (although I have not tried it yet), since
load_balance will now steal a running task if called by an idle cpu.

I'll try to get some of these tests on x440 asap to compare.

-Andrew Theurer

