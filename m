Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSHWIIs>; Fri, 23 Aug 2002 04:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSHWIIs>; Fri, 23 Aug 2002 04:08:48 -0400
Received: from cibs9.sns.it ([192.167.206.29]:35089 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S318717AbSHWIIr>;
	Fri, 23 Aug 2002 04:08:47 -0400
Date: Fri, 23 Aug 2002 10:12:26 +0200 (CEST)
From: venom@sns.it
To: Gilad Ben-Yossef <gilad@benyossef.com>
cc: Hugh Dickins <hugh@veritas.com>, James Bourne <jbourne@mtroyal.ab.ca>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <1030087689.25063.7.camel@gby.benyossef.com>
Message-ID: <Pine.LNX.4.43.0208231006080.13418-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2002, Gilad Ben-Yossef wrote:

> Date: 23 Aug 2002 10:28:08 +0300
> From: Gilad Ben-Yossef <gilad@benyossef.com>
> To: Hugh Dickins <hugh@veritas.com>
> Cc: James Bourne <jbourne@mtroyal.ab.ca>,
>      "Reed, Timothy A" <timothy.a.reed@lmco.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Hyperthreading
>
> On Wed, 2002-08-21 at 20:33, Hugh Dickins wrote:
> > On Wed, 21 Aug 2002, James Bourne wrote:
> > > On Wed, 21 Aug 2002, Reed, Timothy A wrote:
> > > >
> > > > Can anyone lead me to a good source of information on what options should be
> > > > in the kernel for hyperthreading??  I am still fighting with a
> > > > sub-contractor over kernel options.
> > >
> > > As long as you have a P4 and use the P4 support you will get
> > > hyperthreading with 2.4.19 (CONFIG_MPENTIUM4=y).  2.4.18 you have to also
> > > turn it on with a lilo option of acpismp=force on the kernel command line.
> >
> > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > just appropriate to that processor in other ways.
>
>
> hmm... isn't there an option to tell the kernel you are using a
> HyperThreaded system, or is it detected on runtime?  I mean, think about
> a P4 Xeon 2 way SMP - unless told otherwise the kernel will 'see' it as
> a 4 way SMP box *but* the proccessors are not equel!
>
> If for example, you have a task running and another task just woke up
> and the scheduler needs to assign a CPU for it, choosing the other
> 'instance' of the same CPU as the already running task to run it on as
> opposed to choosing one of the 'instanaces' of the other seperate CPU
> seems a mistake IMHO, but the scheduler won't be able to make the
> judgment because it doesn't know it is running on a SMT box at all.
>
> Or am I missing something? :-)
>
with a dual processor with hyper threading where the kernel sees
CPU0-CPU1 (first CPU) and CPU2-CPU3 (second CPU), and you run a cpu
wasting job, it will be scheduled on CPU0, then the second CPU wastint job
will be scheduled on CPU2, and so on, with this alternation
CPU0-CPU2-CPU1-CPU3. So, as you see, the scheduler is smarter, and this
way it CPUs are used at best for what the system can. Then maybe there
could be some discussion about MPI jobs, (I should make some test, and I
am curious to listen someone else experience).

Luigi



