Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266103AbUAGAb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 19:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266104AbUAGAb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 19:31:27 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:48607 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S266103AbUAGAbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 19:31:22 -0500
Message-Id: <5.1.1.5.2.20040106122045.033af688@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Tue, 06 Jan 2004 12:28:21 +1100
To: Robin Holt <holt@sgi.com>
From: auntvini <auntvini@sedal.usyd.edu.au>
Subject: Re: uids in task_struct-Further Explaining the Problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040106193517.GA15766@lnx-holt>
References: <3FF980C7.3060301@sedal.usyd.edu.au>
 <3FF980C7.3060301@sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks  for your reply.

Soon I will write explaining more about why I am not concerned about CPU 
usage which top gives.

Indeed you are correct and what I am after would be ps like correct uids. 
What I need is to connect(relate) them during the sampling time.

Then I will rename the variables in my code as advised by you.

Thanks

Sena Seneviratne
Computer Engineering Lab
Sydney University.

At 01:35 PM 1/6/2004 -0600, you wrote:
>On Tue, Jan 06, 2004 at 02:20:39AM +1100, sena wrote:
>Again, you have described what the problem is with your code and not
>the problem you are trying to solve.
>
>There are a couple solutions to the "Who has used what resource?"
>question.  The most prominent in my mind is a system accounting.
>This could be used to say which user consumed how much cpu/IO, etc.
>If that is the sort of information your are looking for (after the
>fact summary), then I would look to that direction.
>
>If, on the other hand, you are trying to see which users are consuming
>cpu resources, you might want to look at some of the top sorting
>information.
>
>I personally don't see the benefit to calculating a per-user load
>average, but maybe there is.
>
>As to euid and uid.  If ps -ef or ps -ale shows the correct uids, you
>should have no problem calculating on a per-user basis.  I would
>happily look at your source and try to give you pointers if that is
>what you ask for.  I won't be able to touch anything until tonight
>at the earliest.
>
>Thanks,
>Robin
>
> > Hi Robin,
> >
> > Thank you very much for the previous advice and for your valuable time.
> >
> > I thought of further explaining the problem to you.
> >
> >
> > At this stage linux kernel is calculating Load Averages. The major input
> > of the calculation is number of running exe and  Runnables in the
> > runnable Queue.
> >
> > This is happening In timer.c
> > static unsigned long count_active_tasks(void) and
> >
> > static inline void calc_load(unsigned long ticks)
> >
> > What I am Trying:
> >
> > What I am tryiing to do is to seperate the running exe and  Runnables
> > according to the owner of those processes (Say 5 people have login and
> > they run diffrent processes)
> >
> > And then seperately calculate the Load Averages for those respective
> > login users.
> >
> >
> > The Problems:
> >
> > The task_struct has a uid field. I have used that field to seperate
> > them. But the problem is when a child process is created by its parent
> > then the child inherits  the uid of the parents. As a result the correct
> > uid which is related to the username does not contain in that uid.
> >
> > Example:
> >
> > Say a computer has 5 user logins name1(500), name2(501),
> > name3(502).........name5(504) apart from root. If these 5 people
> > remotely login and runs there jobs, then the user name of those jobs are
> > name1,name2 and name3.
> >
> > Say if they use telnet to remotely login then those Tasks will be
> > started under telnet server as children.
> >
> > As the children inherits uid, euid etc of the parents. That means telnet
> > is run as root and it inherits uid<500.
> >
> > task_struct has uid and it is updated accordingly.
> >
> >
> > I have built the kernel 2.4.19sena1 successfully but this is my problem.
> > The problem because child process inherits uid etc if I start any
> > process through telnet
> >
> >
> > Thanks
> > Sena Seneviratne
> > Computer Engineering Lab
> > Sydney University
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

