Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263747AbREYNwN>; Fri, 25 May 2001 09:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbREYNwD>; Fri, 25 May 2001 09:52:03 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:23315 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S263747AbREYNvt>;
	Fri, 25 May 2001 09:51:49 -0400
Message-ID: <25369470B6F0D41194820002B328BDD20717A2@ATLOPS>
From: Bharath Madhavan <bharath_madhavan@ivivity.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Accelerated TCP/IP support from kernel
Date: Fri, 25 May 2001 09:51:39 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	We will most probably be looking into supporting Gig MACs and that
is
the reason why I was wondering if HW assist will help.
We are talking of Gigs of network data (dont ask me the application!)
I dont know about IPv6 support, we havent thought of that.
But the point is, We can visualize a scenario where the processor
is overworked and we want to relieve it off some of its load.
To summarize the info I got from the mailing list, there are two
conflicting views about this topic.
1. Protocol processing does not take much time compared to data processing 
and so the ZERO_COPY/HW_CHECKSUM feature in Linux currently is good enough.
2. The application maybe unique and heavy load that it may save the
processor
some bandwidth especially when several TCP connections needs to be
maintained.

I am mainly looking into case 2, and just trying to see the amount of work
that needs to go into this area. I am asking your expert opinions and find
out if this is an easy job, if so can it be done to maintain compatability 
with older NICs too and able to move along easily with standard linux
distributions. If the kernel can provide some hooks to "branch off" to
a different set of drivers at the socket level, that will do the trick I
think.
Is this easy?
Thanks a lot
Bharath






-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Thursday, May 24, 2001 7:08 PM
To: Bharath Madhavan
Cc: 'linux-kernel@vger.kernel.org'
Subject: RE: Accelerated TCP/IP support from kernel



Bharath Madhavan writes:
 > I guess 3c905c NIC supports HW checksumming. Is this true?

Yes.

 > In this case, do we have any benchmarking for this card 
 > with and without ZERO_COPY (and HW checksumming). I am eager to
 > know by how many times did the system throughput increase?

It doesn't matter with 100baseT cards, they are slow enough that even
with the cpu doing the data copies the link may be easily saturated.
What you will get is decreased CPU utilization.

You need to go to gigabit or faster link speeds to see any real
throughput improvement.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
