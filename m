Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131696AbRASRLm>; Fri, 19 Jan 2001 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135501AbRASRLc>; Fri, 19 Jan 2001 12:11:32 -0500
Received: from gateway.sequent.com ([192.148.1.10]:44624 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S131696AbRASRLU>; Fri, 19 Jan 2001 12:11:20 -0500
Date: Fri, 19 Jan 2001 09:11:04 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119091104.A26968@w-mikek.des.sequent.com>
In-Reply-To: <OF3A9EC7B6.EEDB9FBC-ON852569D9.0052DC7C@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <OF3A9EC7B6.EEDB9FBC-ON852569D9.0052DC7C@pok.ibm.com>; from frankeh@us.ibm.com on Fri, Jan 19, 2001 at 10:47:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 10:47:06AM -0500, Hubertus Franke wrote:
<stuff deleted>
> What you can see from these numbers is that MQ does an awesome job up to
> 1024 threads. When measuring in the future, we will take from now on the
> general concern about low number of threads into account. Your points are
> well taken. I m pretty confident our MQ scheduler will be in reasonable
> ballpark of the current scheduler.
<more stuff deleted>

Hubertus,

'Hopefully' the multi-queue scheduler will be in the ballpark for
low number of threads.  However, remember the extra overhead being
incurred in the current implementation.  To maintain existing
scheduler behavior, we look at all CPU specific runqueues to find
the highest priority (goodness) task in the system.  Therefore,
when running with a single thread on an 8 processor system, we
examine 8 runqueues instead of the single global runqueue.  In
a test where tasks are simply spinning doing sched_yield()s, I
suspect this difference may be significant.

I'll run the IIRC benchmark with low thread counts, and post the
results.  In adition, I have some ideas on how to make intelligent
decisions to avoid examining all runqueueus when the number of
running tasks is less than the number of processors.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
