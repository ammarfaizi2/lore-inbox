Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277883AbRJISPO>; Tue, 9 Oct 2001 14:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277884AbRJISPD>; Tue, 9 Oct 2001 14:15:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23750 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277883AbRJISOy>; Tue, 9 Oct 2001 14:14:54 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEC878319.4C453C4B-ON88256AE0.0063009C@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 11:01:40 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 12:15:14 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Oct 09, 2001 at 08:45:15AM -0700, Paul McKenney wrote:
> > Please see the example above.  I do believe that my algorithms are
> > reliably forcing proper read ordering using IPIs, just in an different
> > way.
>
> I wasn't suggesting that the IPI wouldn't work -- it will.
> But it will be _extremely_ slow.

Ah!  Please accept my apologies for belaboring the obvious
in my previous emails.

> I am suggesting that the lock-free algorithms should add the
> read barriers, and that failure to do so indicates that they
> are incomplete.  If nothing else, it documents where the real
> dependancies are.

Such read barriers are not needed on any architecture where
data dependencies imply an rmb().  Examples include i386, PPC,
and IA64.  On these architectures, read-side rmb()s add both
overhead and complexity.

On the completeness, it seems to me that in cases were updates
are rare, the IPIs fill in the gap, and with good performance
benefits.  What am I missing here?

                              Thanx, Paul

