Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFCWLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTFCWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:11:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:46243 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261568AbTFCWLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:11:48 -0400
Message-Id: <5.2.0.9.2.20030604001215.00ce2850@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 04 Jun 2003 00:29:44 +0200
To: "J.A. Magallon" <jamagallon@able.es>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: sched.c gives ICE [Was: Re: web page on O(1) scheduler]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030603205929.GC3661@werewolf.able.es>
References: <5.2.0.9.2.20030522114349.00cfd8f8@pop.gmx.net>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <16075.8557.309002.866895@napali.hpl.hp.com>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <5.2.0.9.2.20030522114349.00cfd8f8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:59 PM 6/3/2003 +0200, J.A. Magallon wrote:

>On 05.22, Mike Galbraith wrote:
> > At 10:56 AM 5/21/2003 -0700, David Mosberger wrote:
> > > >>>>> On Wed, 21 May 2003 11:26:31 +0200, Mike Galbraith <efault@gmx.de>
> > > said:
> > >
> > >   Mike> The page mentions persistent starvation.  My own explorations
> > >   Mike> of this issue indicate that the primary source is always
> > >   Mike> selecting the highest priority queue.
> > >
> > >My working assumption is that the problem is a bug with the dynamic
> > >prioritization.  The task receiving the signals calls sleep() after
> > >handling a signal and hence it's dynamic priority should end up higher
> > >than the priority of the task sending signals (since the sender never
> > >relinquishes the CPU voluntarily).
> > >
> > >However, I haven't actually had time to look at the relevant code, so
> > >I may be missing something.  If you understand the issue better,
> > >please explain to me why this isn't a dynamic priority issue.
> >
> > You're right, it looks like a corner case.  It works fine here with the
> > attached diff.
> >
>
>Have you tried to build with gcc-3.3 ? I applied it on top of 2.4.x-aa,
>and I just get an ICE:

No, I use 2.95.3.

>End of search list.
>sched.c: In function `do_schedule':
>sched.c:1003: internal compiler error: in merge_assigned_reloads, at 
>reload1.c:6134
>Please submit a full bug report,
>with preprocessed source if appropriate.
>See <URL:https://qa.mandrakesoft.com/> for instructions.
>
>sched.c::1003 is the closing brace for do_schedule().
>
>Any idea ?

Nope... gcc can have the blame if it wants it :)

         -Mike 

