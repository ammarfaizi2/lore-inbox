Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbRGPS0v>; Mon, 16 Jul 2001 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267591AbRGPS0l>; Mon, 16 Jul 2001 14:26:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30135 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267571AbRGPS0X>;
	Mon, 16 Jul 2001 14:26:23 -0400
Importance: Normal
Subject: Re: CPU affinity & IPI latency
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF26B65F46.BFC0D9EB-ON85256A8B.0064A8BC@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 16 Jul 2001 14:26:23 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/16/2001 02:26:10 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, actually the sole purpose of <has_cpu> is
to lock a task out of a scheduling decision. Remember
during transient states, there are two tasks that have
the <has_cpu> flag set for a particular cpu.
So I think using <has_cpu> is kosher and preferred in
this situation, IMHO.

As you saw from David Levines reply, he thinks that
a list is more appropriate for more generic decision
support.
But I don't like the fact that you lock down several
tasks at that point. In my solution, you return the
task back to general schedulability.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com



Mike Kravetz <mkravetz@sequent.com> on 07/16/2001 12:14:46 PM

To:   Hubertus Franke/Watson/IBM@IBMUS
cc:   Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
      linux-kernel@vger.kernel.org
Subject:  Re: CPU affinity & IPI latency



On Fri, Jul 13, 2001 at 11:25:21PM -0400, Hubertus Franke wrote:
>
> Mike, could we utilize the existing mechanism such as has_cpu.
>

I like it.  Especially the way you eliminated the situation where
we would have multiple tasks waiting for schedule.  Hope this is
not a frequent situation!!!  The only thing I don't like is the
use of has_cpu to prevent the task from being scheduled.  Right
now, I can't think of any problems with it.  However, in the past
I have been bit by using fields for purposes other than what they
were designed for.

--
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center



