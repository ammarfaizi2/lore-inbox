Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbRAaCZV>; Tue, 30 Jan 2001 21:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbRAaCZM>; Tue, 30 Jan 2001 21:25:12 -0500
Received: from palrel3.hp.com ([156.153.255.226]:43276 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129999AbRAaCZE>;
	Tue, 30 Jan 2001 21:25:04 -0500
Message-ID: <3A77777D.E1A998FC@cup.hp.com>
Date: Tue, 30 Jan 2001 18:25:01 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing 
 todowith ECN)
In-Reply-To: <Pine.GSO.4.30.0101302039580.3017-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How does ZC/SG change the nature of the packets presented to the NIC?
> 
> what do you mean? I am _sure_ you know how SG/ZC work. So i am suspecting
> more than socratic view on life here. Could be influence from Aristotle;->

Well, I don't know  the specifics of Linux, but I gather from what I've
read on the list thusfar, that prior to implementing SG support, Linux
NIC drivers would copy packets into single contiguous buffers that were
then sent to the NIC yes? 

If so, the implication is with SG going, that copy no longer takes
place, and so a chain of buffers is given to the NIC.

Also, if one is fully ZC :) pesky things like protocol headers can
naturally end-up in separate buffers.

So, now you have to ask how well any given NIC follows chains of
buffers. At what number of buffers is the overhead in the NIC of
following the chains enough to keep it from achieving link-rate?

One way to try and deduce that would be to meld some of the SG and preSG
behaviours and copy packets into varying numbers of buffers per packet
and measure the resulting impact on throughput through the NIC.

rick jones

As time marches on, the orders of magnitude of the constants may change,
but basic concepts still remain, and the "lessons" learned in the past
by one generation tend to get relearned in the next :) for example -
there is no such a thing as a free lunch... :)

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
