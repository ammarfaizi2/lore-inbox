Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbQJaWFy>; Tue, 31 Oct 2000 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbQJaWFo>; Tue, 31 Oct 2000 17:05:44 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:18776
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S130790AbQJaWFi>; Tue, 31 Oct 2000 17:05:38 -0500
Date: Tue, 31 Oct 2000 14:05:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031140534.A22819@work.bitmover.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
	Paul Menage <pmenage@ensim.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <39FF3D53.C46EB1A8@timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{lots of perf stuff deleted}

I'm posting this to point out that Linux networking is getting better at
a substantial pace.

I've already sent this to Davem and Linus a while back, but I have a
pretty nice lab here at BitMover, 4 100Mbit switched networks, servers
with 4 cards, and enough clients to generate load.   I actually have
two servers both of which have a NIC on each network; one server has
.2.15pre9 on it and the other has 2.4.0-test5 on it.

I don't have a lot of spare time, but if you are one of the kernel
developers and you have tests you want run, contact me privately.

I ran some tests to see how things have changed.  What follows are the
details, the short summary is that 2.4 looks to me to be about 2x better
in both latency and bandwidth, no mean feat.  I'm very impressed with
this, and I'm especially tickled to see the hand that Dave has had in
this, he's really come into his own as a senior kernel hacker.  I'm sure
he doesn't need me to stroke his ego, but I'm doing it anyways because
I'm proud of him (with no disrespect to the many other people who have
worked on this intended).

So here's what I did.  I fired up the lat_tcp and bw_tcp servers from
lmbench on the server and then generated load from all the clients.
I noodled around until I found the right mix which gave the best numbers
and that's roughly what is reported below.  I don't have the 2.2 numbers
handy but I can get them if you care, it was very close to 2x worse, 
like about 1.9x or so.

The server is running Linux 2.4 test9, I believe.  It has 3 Intel EEpro's
and one 3c905B.   It's a Ghz K7.

  Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
  Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (#2) (rev 8).
  Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (#3) (rev 8).
  Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 48).

All are going into Netgear Fs308 8 port switches.  There are 13 clients,
mostly Intel Linux boxes, but various others as well, let me know if
you care.  A couple of the clients were behind two levels of switches
(I have 6 here).

Run a single copy of lat_tcp on each client against the server, we see:
load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
4.68 443M  21M   0    0     0    0   0   0   0   42K  39K  55K  46K   4  96   0
4.68 443M  21M   0    0   2.0K   0   0   0   0   40K  38K  55K  44K   2  98   0
4.68 443M  21M   0    0     0    0   0   0   0   40K  38K  55K  44K   3  97   0
4.55 443M  21M   0    0     0    0   0   0   0   42K  40K  54K  48K   4  96   0
4.55 443M  21M   0    0     0    0   0   0   0   41K  39K  54K  45K   3  97   0
4.50 443M  21M   0    0     0    0   0   0   0   40K  38K  54K  44K   2  98   0
4.50 443M  21M   0    0     0    0   0   0   0   41K  38K  55K  44K   3  97   0
4.50 443M  21M   0    0     0    0   0   0   0   41K  41K  54K  45K   7  93   0
4.86 443M  21M   0    0     0    0   0   0   0   38K  38K  54K  44K   3  97   0


OK, now bandwidth.  Each client is capable of getting at least 11MB/sec from
the server when run one at a time.  I ran just 4 clients, one per network.

load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
0.28 444M  22M   0    0     0    0   0   0   0   14K  27K  15K 2.9K   2  55  43
0.28 444M  22M   0    0     0    0   0   0   0   14K  29K  16K 3.1K   2  66  32
0.26 444M  22M   0    0     0    0   0   0   0   14K  29K  16K 3.0K   1  67  32
0.26 444M  22M   0    0     0    0   0   0   0   15K  29K  16K 3.0K   1  65  34
0.24 444M  22M   0    0     0    0   0   0   0   15K  29K  16K 3.0K   0  70  30
0.24 444M  22M   0    0     0    0   0   0   0   15K  29K  16K 3.0K   0  63  37
0.24 444M  22M   0    0     0    0   0   0   0   14K  28K  16K 3.0K   1  62  37
0.22 444M  22M   0  2.0K    0    0   0   0   0   14K  28K  16K 2.9K   1  65  34

It works out to an average of 10.4MB/sec per client or 41.6MB/sec on the
server on a PCI/32 @ 33Mhz bus.  Same Ghz server.  Note the idle cycles,
bandwidth is a lot easier than latency.

Hope this is useful to someone.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
