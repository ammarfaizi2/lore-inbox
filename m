Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277882AbRJISPO>; Tue, 9 Oct 2001 14:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277883AbRJISPE>; Tue, 9 Oct 2001 14:15:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20934 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277882AbRJISOv>; Tue, 9 Oct 2001 14:14:51 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE6E773ED.47F04939-ON88256AE0.00616553@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 10:46:46 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 12:15:14 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Oct 09, 2001 at 07:03:37PM +1000, Rusty Russell wrote:
> > I don't *like* making Alpha's wmb() stronger, but it is the
> > only solution which doesn't touch common code.
>
> It's not a "solution" at all.  It's so heavy weight you'd be
> much better off with locks.  Just use the damned rmb_me_harder.

There are a number of cases where updates are extremely rare.
FD management and module unloading are but two examples.  In
such cases, the overhead of the IPIs in the extremely rare updates
is overwhelmed by the reduction in overhead in the very common
accesses.

And getting rid of rmb() or rmb_me_harder() makes the read-side
code less complex.

                              Thanx, Paul

