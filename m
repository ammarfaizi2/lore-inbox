Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRCPCmq>; Thu, 15 Mar 2001 21:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRCPCmh>; Thu, 15 Mar 2001 21:42:37 -0500
Received: from netsonic.fi ([194.29.192.20]:15364 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S129569AbRCPCmU>;
	Thu, 15 Mar 2001 21:42:20 -0500
Date: Fri, 16 Mar 2001 04:41:30 +0200 (EET)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <Werner.Almesberger@epfl.ch>, <linux-net@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Performance is weird (fwd) -> results
In-Reply-To: <3AB11EDB.CCA47F45@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0103160421260.13953-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Manfred Spraul wrote:

> I've attached a patch.
> I tried to trigger the problem with my 10 MBit ne2k-pci connection, but
> without success.
>
> Could you try it?
> I've tested it with -ac17, and it applies to 2.4.2 cleanly.

On 2.4.2:

Before:
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 3.829257 real seconds = 4278.636822 KB/sec
(35.050593 Mb/sec)

After either of your patches, the result was the same, sorry.

I tried to apply the patch to 2.4.3 and still got the better result with
it, altought compiling kernel still improved the performance.

First:

[root@ropogw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 1.994121 real seconds = 8216.151377 KB/sec
(67.306712 Mb/sec)
[root@ropogw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 1.995773 real seconds = 8209.350462 KB/sec
(67.250999 Mb/sec)
[root@ropogw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 1.989680 real seconds = 8234.489968 KB/sec
(67.456942 Mb/sec)

(start to compile kernel on other console)

[root@ropogw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 1.072744 real seconds = 15272.982184 KB/sec
(125.116270 Mb/sec)
[root@ropogw test]# ./ttcp_atm -t -a -s 0.90
ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  atm  -> 0.90
ttcp-t: socket
ttcp-t: 16777216 bytes in 1.140261 real seconds = 14368.640162 KB/sec
(117.70790

I also applied it the test to the 3com card:

Before kernel compiling, patch applied or not:

ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  udp  ->
not.for.your.eyes
ttcp-t: socket
ttcp-t: 16777216 bytes in 2.218013 real seconds = 7386.791691 KB/sec
(60.512598 Mb/sec)

ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5013  udp  ->
not.for.your.eyes
ttcp-t: socket
ttcp-t: 16777216 bytes in 1.428264 real seconds = 11471.268617 KB/sec
(93.972633 Mb/sec)

Thanks,

  Sampsa Ranta
  sampsa@netsonic.fi

