Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129905AbRA0Mor>; Sat, 27 Jan 2001 07:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbRA0Moh>; Sat, 27 Jan 2001 07:44:37 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:35253 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S129905AbRA0Mo2>;
	Sat, 27 Jan 2001 07:44:28 -0500
Date: Sat, 27 Jan 2001 07:43:31 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au>
Message-ID: <Pine.GSO.4.30.0101270729270.24088-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Jan 2001, Andrew Morton wrote:

> (Please keep netdev copied, else Jamal will grump at you, and
>  you don't want that).
>

Thanks, Andrew ;-> Isnt netdev where networking stuff should be
discussed? I think i give up and will join lk, RSN ;->

> The kernels which were tested were 2.4.1-pre10 with and without the
> zerocopy patch.  We only look at client load (the TCP sender).
>
> The link throughput was 11.5 mbytes/sec at all times (saturated 100baseT)
>
> 2.4.1-pre10-vanilla, using sendfile():          29.6% CPU
> 2.4.1-pre10-vanilla, using read()/write():      34.5% CPU
>
> 2.4.1-pre10+zercopy, using sendfile():          18.2% CPU
> 2.4.1-pre10+zercopy, using read()/write():      38.1% CPU
>
> 2.4.1-pre10+zercopy, using sendfile():          22.9% CPU    * hardware tx checksums disabled
> 2.4.1-pre10+zercopy, using read()/write():      39.2% CPU    * hardware tx checksums disabled
>
>
> What can we conclude?
>
> - sendfile is 10% cheaper than read()-then-write() on 2.4.1-pre10.
>
> - sendfile() with the zerocopy patch is 40% cheaper than
>   sendfile() without the zerocopy patch.
>

It is also useful to have both client and server stats.
BTW, since the laptop (with the 3C card) is the client, the SG
shouldnt kick in at all.

> - hardware Tx checksums don't make much difference.  hmm...
>
> Bear in mind that the 3c59x driver uses a one-interrupt-per-packet
> algorithm.  Mitigation reduces this to 0.3 ints/packet.
> So we're absorbing 4,500 interrupts/sec while processing
> 12,000 packets/sec.  gigE NICs do much better mitigation than
> this and the relative benefits of zerocopy will be much higher
> for these.  Hopefully Jamal can do some testing.
>

I dont have my babies right now, but as soon as i can get access to
them

> BTW: I could not reproduce Jamal's oops when sending large
> files (2 gigs with sendfile()).

Alexey was concerned about this. Good. But maybe it will still
happen with my setupo. We'll see.

>
> The test tool is, of course, documented [ :-)/2 ].  It's at
>
> 	http://www.uow.edu.au/~andrewm/linux/#zc
>

I'll give this a shot later. Can you try with the sendfiled-ttcp?
http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz
Anyways, you are NIC-challenged ;-> Get GigE. 100Mbps doesnt give
much information.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
