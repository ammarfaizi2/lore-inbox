Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262470AbREXWv1>; Thu, 24 May 2001 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262475AbREXWvR>; Thu, 24 May 2001 18:51:17 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:65294 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S262470AbREXWvC>;
	Thu, 24 May 2001 18:51:02 -0400
Message-ID: <25369470B6F0D41194820002B328BDD20717A0@ATLOPS>
From: Bharath Madhavan <bharath_madhavan@ivivity.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Accelerated TCP/IP support from kernel
Date: Thu, 24 May 2001 18:50:53 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot. That was useful info especially your last point
where you are saying that most of the area we can save is in
data processing and not in protocol processing.
So, if we use the ZERO_COPY feature, we should gain quite a bit.
I guess 3c905c NIC supports HW checksumming. Is this true?
In this case, do we have any benchmarking for this card 
with and without ZERO_COPY (and HW checksumming). I am eager to
know by how many times did the system throughput increase?
Thanks a lot
Bharath




-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Thursday, May 24, 2001 6:29 PM
To: Bharath Madhavan
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accelerated TCP/IP support from kernel



Bharath Madhavan writes:
 > 	I am looking into a scenario where we have a NIC which performs 
 > all the TCP/IP processing and basically the core CPU offloads all data
from
 > the socket level interface onwards to this NIC. 

Why would you ever want to do this?

Point 1: Support for new TCP techniques and bug fixes are hard enough
to propagate to user's systems as it is with the implementation being
done in software.

Point 2: If I find a bug in the cards TCP implementation, will I be
able to get at the source for the firmware and fix it?  Likely the
answer to this is no.

Every couple years a few vendors make cards like this, yet ignore
these core issues.  It is currently impractical to use these kinds of
cards today except in a few very special case situations.

Furthermore, the actual protocol processing overhead is quite small
and almost neglible especially on today's gigahertz beasts.  The data
copy is where the time is spent, and checksum offload takes care of
that.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
