Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRAaL0A>; Wed, 31 Jan 2001 06:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRAaLZv>; Wed, 31 Jan 2001 06:25:51 -0500
Received: from chiara.elte.hu ([157.181.150.200]:4870 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129798AbRAaLZl>;
	Wed, 31 Jan 2001 06:25:41 -0500
Date: Wed, 31 Jan 2001 12:24:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Cc: jamal <hadi@cyberus.ca>, Ion Badulescu <ionut@cs.columbia.edu>,
        Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to
 do with ECN)
In-Reply-To: <20010131112145.A13345@sable.ox.ac.uk>
Message-ID: <Pine.LNX.4.30.0101311222220.2140-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jan 2001, Malcolm Beattie wrote:

> Without the raised tcp_wmem setting I was getting 81 MByte/s. With
> tcp_wmem set as above I got 86 MByte/s. Nice increase. Any other
> setting I can tweak apart from {r,w}mem_max and tcp_{w,r}mem? The CPU
> on the client (350 MHz PII) is the bottleneck: gensink4 maxes out at
> 69 Mbyte/s pulling TCP from the server and 94 Mbyte/s pushing. (The
> other system, 733 MHz PIII pushes >100MByte/s UDP with ttcp but the
> client drops most of it).

you can speed up the client significantly by using the MSG_TRUNC option
('truncate message'). It will zap incoming data without copying it into
user-space. (you can use this for the 'bulk transfer' part - the initial
protocol handling code needs to see the actual data.) This way you should
be able to saturate the server even more.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
