Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbRAVUHn>; Mon, 22 Jan 2001 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135179AbRAVUHd>; Mon, 22 Jan 2001 15:07:33 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:42404 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S130309AbRAVUHZ>; Mon, 22 Jan 2001 15:07:25 -0500
Importance: Normal
Subject: Re: [Lse-tech] more on scheduler benchmarks
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
From: "Bill Hartner" <bhartner@us.ibm.com>
Date: Mon, 22 Jan 2001 15:07:21 -0500
Message-ID: <OFBD35263C.BED6AC47-ON852569DC.006C12E2@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.3 (Intl)|21 March 2000) at
 01/22/2001 03:07:23 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hubertus wrote :

> The only problem I have with sched_yield like benchmarks is that it
creates
> artificial lock contention as we basically spent most of the time other
> then context switching + syscall under the scheduler lock. This we won't
> see in real apps, that's why I think the chatroom numbers are probably
> better indicators.

Agreed. 100% artificial. The intention of the benchmark is to put a lot
of pressure on the scheduler so that the benchmark results will be very
"sensitive" to changes in schedule().  For example, if you were to split
the scheduling fields used by goodness() into several cache lines, the
benchmark results should reveal the degradation.  chatroom would probably
show it too though.  At some point, we could run your patch on our
SPECweb99 setup using Zeus - we don't have any lock analysis data on the
workload yet so I don't know what the contention on the run_queue lock is.
Zeus does not use many threads.  Apache does.

Bill

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
