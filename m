Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbQL3Evy>; Fri, 29 Dec 2000 23:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131582AbQL3Evn>; Fri, 29 Dec 2000 23:51:43 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:37640 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S131055AbQL3Evj>; Fri, 29 Dec 2000 23:51:39 -0500
Date: Fri, 29 Dec 2000 20:21:12 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petru Paler <ppetru@ppetru.net>,
        Jure Pecar <pegasus@telemach.net>, <linux-kernel@vger.kernel.org>,
        <thttpd@bomb.acme.com>
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
In-Reply-To: <20001229200657.B16261@athlon.random>
Message-ID: <Pine.LNX.4.30.0012291958250.7406-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Andrea Arcangeli wrote:

> On Fri, Dec 29, 2000 at 06:50:18PM +0000, Alan Cox wrote:
> > Your cgi will keep the other CPU occupied, or run two of them. thttpd has
> > superb scaling properties compared to say apache.
>
> I think with 8 CPUs and 8 NICs (usual benchmark setup) you want more than 1 cpu
> serving static data and it should be more efficient if it's threaded and
> sleeping in accept() instead of running eight of them (starting from sharing
> tlb entries and avoiding flushes probably without the need of CPU binding).

hey, nobody sane runs an 8 CPU box with 8 NICs for a production webserver.
8 single CPU boxes, or 4 dual boxes behind a load balancer.  now that's
more common, more scalable, more robust.  :)

oh yeah they all run perl, java, or php too :)  i've seen sites with more
than 100 dynamic front-ends and a pair of 350Mhz x86 boxes in the corner
handling all the static needs (running apache even!).  a pair only 'cause
of redundancy reasons, not because of load reasons.

100Mbits/s of *transit* internet bandwidth costs US$75000 per month in
typical datacenters btw.  obviously there's cheaper bandwidth if you push
out to the edges of the net, into the central offices.

this isn't to say that nobody will ever want phat bandwidth on a single
webserver... but i'd say linux and most everyone else is at least 3 years
ahead of the long-haul networks in terms of ability to pump data.  the
true value of zero-copy TCP will be more apparent in the upcoming age of 1
Mbit/s video thanks to MPEG4.  i'd expect to see the cable/dsl
conglomerates start doing this in their central offices soon.

the RAM and CPU hungry dynamic content languages tend to dictate the sheer
quantity of machines required to handle even small web volumes -- folks
quickly exceed the reasonably priced SMP systems available.  the cost per
CPU, and per Mb RAM are the limiting factors (these go up quickly when you
put all CPUs and RAM on the bus).  that plus the desire for reliability /
lack of a single failure point mean that web development tools have grown
up expecting to be on a distributed network of nodes rather than on a
large SMP system.

the 8 CPU monsters run stuff like NFS/filesystems and oracle.  some day
someone will build a horizontally scalable database which works, with a
reasonable licensing policy and then we'll see even more value in
commodity hardware/networking.  this is an area i'm currently quite
interested in, pointers to research / interesting projects appreciated.
i know about globalfilesystem.org, veritas clustered fs, oracle parallel
server, and IBM DB2 EEE already -- none are quite to the point where i'd
use them to scale something across 100 nodes yet though.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
