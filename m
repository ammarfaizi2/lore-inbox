Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131761AbRCOP0y>; Thu, 15 Mar 2001 10:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131760AbRCOP0o>; Thu, 15 Mar 2001 10:26:44 -0500
Received: from netsonic.fi ([194.29.192.20]:31753 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S131759AbRCOP0f>;
	Thu, 15 Mar 2001 10:26:35 -0500
Date: Thu, 15 Mar 2001 17:25:44 +0200 (EET)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Performance is weird (fwd)
Message-ID: <Pine.LNX.4.33.0103151717020.2681-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Subject: Performance is weird
The following message was first posted to linux-atm mailing list, it
is followed with one of the replies I got, thanks Werner Almesberger
<Werner.Almesberger@epfl.ch>.

Actually, with 2.4.3pre4 kernel I got something like 66Mbit/s which were
better than the 2.4.2 results.
--

 Hello,

I am running a set of ForeRunner LE 155 cards on two Athlon 900
machines. The cards are currently back to back connected. I am having
problems with performance and this problem seems a bit curious to me.

The boxes are running kernel versions 2.4.2 with the builtin ATM
functionality.

First when the machine is idle and i run ttcp_atm, the record is:

[root@akvagw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 3.805066 real seconds = 4305.838585 KB/sec
(35.273430
Mb/sec)

I can get the same result when I run it as many times as I want when the
machine is idle, however, the performance of the increases a lot when I
give the processor something to do, for example compile the kernel, when
gcc is compiling the kernel, I get better results:

[root@akvagw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 0.997561 real seconds = 16424.058278 KB/sec (134.545885 Mb/sec)

For the record, the remote machine does not affect the tests, because the
machine just sends data even when none listens.

Can someone explain, and maybe do something, please? Or am I supposed to
compile kernel all the time on my production ATM routers.

Same seems to apply when I stream UDP via my 3C905C card to one of my
routers, first I get 60Mbytes / s, then 94Mbytes/s when I start to compile
the kernel.

 Thanks,
   Sampsa Ranta
   sampsa@netsonic.fi


"
Don't know where those "negative CPU cycles" come from. It's probably
a driver problem. Could be that either you're triggering scheduling of a
softirq or such, where there normally wouldn't be one (but should be),
or that there's a race condition leading to the loss of an event
(softirq, tasklet, wait queue, etc.), and background activity makes this
happen in the correct order.
"





