Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268566AbRHHTQB>; Wed, 8 Aug 2001 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268567AbRHHTPv>; Wed, 8 Aug 2001 15:15:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51941 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268566AbRHHTPj>;
	Wed, 8 Aug 2001 15:15:39 -0400
Importance: Normal
Subject: Re: [RFC][PATCH] Scalable Scheduling
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF7B546FB4.1BE75E02-ON85256AA2.0069D89C@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 8 Aug 2001 15:16:45 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/08/2001 03:15:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought, Linus's suggestion is pretty straight forward and clear, like
you do it.
We fix it and resubmit ASAP.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Daniel Phillips <phillips@bonn-fries.net>@vger.kernel.org on 08/08/2001
03:06:01 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   Mike Kravetz <mkravetz@beaverton.ibm.com>, Linus Torvalds
      <torvalds@transmeta.com>
cc:   Hubertus Franke/Watson/IBM@IBMUS, linux-kernel@vger.kernel.org
Subject:  Re: [RFC][PATCH] Scalable Scheduling



On Wednesday 08 August 2001 20:28, Mike Kravetz wrote:
> Yes we have, we'll provide those numbers with the updated patch.
> One challenge will be maintaining the same level of performance
> for UP as in the current code.  The current code has #ifdefs to
> separate some of the UP/SMP code paths and we will try to eliminate
> these.

Does it help if I clarify what Linus was suggesting?  Instead of:

         #ifdef CONFIG_SMP
                 .. use nr_running() ..
         #else
                 .. use nr_running ..
         #endif

write:

     inline int nr_running(void)
     {
     #ifdef CONFIG_SMP
          int i = 0, tot=nt_running(REALTIME_RQ);
          while (i < smp_num_cpus) {
               tot += nt_running(cpu_logical_map(i++));
          }
          return(tot);
     #else
          return nr_running;
     #endif
     }

Then see if you can make the #ifdef's go away from that too.  (If that's
too hard, well, at least the #ifdef's are now reduced.)

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



