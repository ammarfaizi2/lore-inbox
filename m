Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132169AbRASQ2w>; Fri, 19 Jan 2001 11:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135347AbRASQ2n>; Fri, 19 Jan 2001 11:28:43 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37565 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132169AbRASQ2b>;
	Fri, 19 Jan 2001 11:28:31 -0500
Importance: Normal
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
To: David Lang <dlang@diginsite.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, Andrea Arcangeli <andrea@suse.de>,
        <lse-tech@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFCCD29238.A3FCD613-ON852569D9.0059F149@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 19 Jan 2001 11:30:04 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/19/2001 11:28:21 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sure, we are measuring that as well.
We are running all these benchmarks and configurations that I mentioned in
my previous message on
1-2-4-6- and 8 way configurations.
We have posted some preliminary results on older kernels on the website:

http://lse.sourceforge.net/scheduling/prelim.html

MQ scheduler is meaningless for a UP kernel that is only build under the
SMP flag.
The priority==tablebased scheduler does make sense to run on a UP (i.e. not
SMP compiled) kernel.
Some more fine-tuning of the current code base might improve that case,
because affinity is not a concern
I can simply go to my top table hash, retrieve the first P entry with
!P->has_cpu and I am ready to go.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



David Lang <dlang@diginsite.com>@lists.sourceforge.net on 01/19/2001
11:06:37 AM

Sent by:  lse-tech-admin@lists.sourceforge.net


To:   Mike Kravetz <mkravetz@sequent.com>
cc:   Andrea Arcangeli <andrea@suse.de>, <lse-tech@lists.sourceforge.net>,
      <linux-kernel@vger.kernel.org>
Subject:  Re: [Lse-tech] Re: multi-queue scheduler update



another thing that would be interesting is what is the overhead on UP or
small (2-4 way) SMP machines

David Lang

On Thu, 18 Jan 2001, Mike Kravetz wrote:

> Date: Thu, 18 Jan 2001 16:52:25 -0800
> From: Mike Kravetz <mkravetz@sequent.com>
> To: Andrea Arcangeli <andrea@suse.de>
> Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Subject: Re: [Lse-tech] Re: multi-queue scheduler update
>
> On Fri, Jan 19, 2001 at 01:26:16AM +0100, Andrea Arcangeli wrote:
> > On Thu, Jan 18, 2001 at 03:53:11PM -0800, Mike Kravetz wrote:
> > > Here are some very preliminary numbers from sched_test_yield
> > > (which was previously posted to this (lse-tech) list by Bill
> > > Hartner).  Tests were run on a system with 8 700 MHz Pentium
> > > III processors.
> > >
> > >                            microseconds/yield
> > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > ------------   ---------         --------     ---------------
> > > 16               18.740            4.603         1.455
> >
> > I remeber the O(1) scheduler from Davide Libenzi was beating the
mainline O(N)
> > scheduler with over 7 tasks in the runqueue (actually I'm not sure if
the
> > number was 7 but certainly it was under 10). So if you also use a O(1)
> > scheduler too as I guess (since you have a chance to run fast on the
lots of
> > tasks running case) the most interesting thing is how you score with
2/4/8
> > tasks in the runqueue (I think the tests on the O(1) scheduler patch
was done
> > at max on a 2-way SMP btw). (the argument for which Davide's patch
wasn't
> > included is that most machines have less than 4/5 tasks in the runqueue
at the
> > same time)
> >
> > Andrea
>
> Thanks for the suggestion.  The only reason I hesitated to test with
> a small number of threads is because I was under the assumption that
> this particular benchmark may have problems if the number of threads
> was less than the number of processors.  I'll give the tests a try
> with a smaller number of threads.  I'm also open to suggestions for
> what benchmarks/test methods I could use for scheduler testing.  If
> you remember what people have used in the past, please let me know.
>
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/lse-tech



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
