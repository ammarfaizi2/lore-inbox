Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132866AbRDDRfH>; Wed, 4 Apr 2001 13:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132865AbRDDRe6>; Wed, 4 Apr 2001 13:34:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10133 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132867AbRDDRen>;
	Wed, 4 Apr 2001 13:34:43 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF8ACA39F0.083AA905-ON85256A24.005FCAC2@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 13:34:37 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 01:33:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct, that's true.

Our patch does various things.
(a) limit search for a task to a admin specified set of cpu's
    during schedule()..
(b) limits search for a preemptable task to another set of cpu's
    during reschedule_idle()
     <need to reactivate this functionality 10 lines of code>
(c) loadbalancing, i.e. moving from queue to queue.
    Currently we balance within a set and across sets.

Obviously in NUMA one could specify
     (a) such that multiple sets fall into the same node
         no node crossings.
     (b) specify this set to at least span a node
     (c) do some intelligent moving based on memory maps
          etc.

I guess (c) would be first instance on where to plug architecture
dependent information, e.g. how much memory footprint does a task
have on a particular node and how much would the moving cost.
The loadbalance we provide is a simple sceleton to tickle you mind,
not a solution. Nevertheless, one can see it can have some impact.

See for results for various combinations of poolsizes and balancings:
http://lse.sourceforge.net/scheduling/results012501/status.html#Load%20Balancing


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Kanoj Sarcar <kanoj@google.engr.sgi.com> on 04/04/2001 01:14:28 PM

To:   Hubertus Franke/Watson/IBM@IBMUS
cc:   linux-kernel@vger.kernel.org (Linux Kernel List),
      lse-tech@lists.sourceforge.net
Subject:  Re: [Lse-tech] Re: a quest for a better scheduler



>
>
>
> Kanoj, our cpu-pooling + loadbalancing allows you to do that.
> The system adminstrator can specify at runtime through a
> /proc filesystem interface the cpu-pool-size, whether loadbalacing
> should take place.

Yes, I think this approach can support the various requirements
put on the scheduler.

I think there are two degrees of freedom that are needed in the
scheduler. One, as you say, for the sysadmin to be able to specify
what overall scheduler behavior he wants.

Secondly, from the kernel standpoint, there needs to be perarch
hooks, to be able to utilize nodelevel/multilevel caches, NUMA
aspects etc.

Kanoj



