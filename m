Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277057AbRJDBHJ>; Wed, 3 Oct 2001 21:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277058AbRJDBG7>; Wed, 3 Oct 2001 21:06:59 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:58808 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277057AbRJDBGs>;
	Wed, 3 Oct 2001 21:06:48 -0400
Date: Wed, 3 Oct 2001 21:04:22 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Simon Kirby <sim@netnation.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Ben Greear <greearb@candelatech.com>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011003130203.A2315@netnation.com>
Message-ID: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Simon Kirby wrote:

> On Wed, Oct 03, 2001 at 09:33:12AM -0700, Linus Torvalds wrote:
>
> Actually, the way I first started looking at this problem is the result
> of a few attacks that have happened on our network.  It's not just a
> while(1) sendto(); UDP spamming program that triggers it -- TCP SYN
> floods show the problem as well, and _there is no way_ to protect against
> this without using syncookies or some similar method that can only be
> done on the receiving TCP stack only.
>
> At one point, one of our webservers received 30-40Mbit/sec of SYN packets
> sustained for almost 24 hours.  Needless to say, the machine was not
> happy.
>

I think you can save yourself a lot of pain today by going to a "better
driver"/hardware. Switch to a tulip based board; in particular one which
is based on the 21143 chipset. Compile in hardware traffic control and
save yourself some pain.
The interface was published but so far only the tulip conforms to it.
It can sustain upto about 90% of the wire rate before it starts
dropping. And at those rates you still have plenty of CPU available.
The ingress policer in the traffic control code might also be able to
help, however CPU cycles are already wasted by the time that code is hit;
with NAPI you should be able to push the filtering much lower in the
stack.

cheers,
jamal

