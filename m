Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbRBESvt>; Mon, 5 Feb 2001 13:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRBESvj>; Mon, 5 Feb 2001 13:51:39 -0500
Received: from palrel1.hp.com ([156.153.255.242]:9734 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S130020AbRBESvd>;
	Mon, 5 Feb 2001 13:51:33 -0500
Message-ID: <3A7EF631.174DB262@cup.hp.com>
Date: Mon, 05 Feb 2001 10:51:29 -0800
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
In-Reply-To: <Pine.GSO.4.30.0102041426180.15417-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As time marches on, the orders of magnitude of the constants may change,
> > but basic concepts still remain, and the "lessons" learned in the past
> > by one generation tend to get relearned in the next :) for example -
> > there is no such a thing as a free lunch... :)
> 
> ;->
> BTW, i am reading one of your papers (circa 1993 ;->, "we go fast with a
> little help from your apps")  in which you make an interesting
> observation. That (figure 2) there is "a considerable increase in
> efficiency but not a considerable increase in throughput" .... I "scanned"
> to the end of the paper and dont see an explanation.

That would be the copyavoidance paper using the very old G30 with the
HP-PB (sometimes called PeanutButter) bus :)
(http://ftp.cup.hp.com/dist/networking/briefs/)

No, back then we were not going to describe the dirty laundry of the G30
hardware :) The limiter appears to have been the bus converter from the
SGC (?) main bus of the Novas (8x7,F,G,H,I) to the HP-PB bus. The chip
was (apropriately enough) codenamed "BOA" and it was a constrictor :)

I never had a chance to carry-out the tests on an older 852 system -
those have slower CPU's, but HP-PB was _the_ bus in the system.
Prototypes leading to the HP-PB FDDI card achieved 10 MB/s on an 832
system using UDP - this was back in the 1988-1989 timeframe iirc.

> I've made a somehow similar observation with the current zc patches and
> infact observed that throughput goes down with the linux zc patches.
> [This is being contested but no-one else is testing at gigE, so my word is
> the only truth].
> Of course your paper doesnt talk about sendfile rather the page pinning +
> COW tricks (which are considered taboo in Linux) but i do sense a
> relationship.

Well, the HP-PB FDDI card did follow buffer chains rather well, and
there was no mapping overhead on a Nova - it was a non-coherent I/O
subsystem and DMA was done exclusively with physical addresses (and
requisite pre-DMA flushes on outbound, and purges on inbound - another
reason why copy-avoidance was such a win overheadwise).

Also, there was no throughput drop when going to copyavoidance in that
stuff. So, I'd say that while somethings might "feel" similar, it does
not go much deeper than that.


rick

> PS:- I dont have "my" machines yet and i have a feeling it will be a while
> before i re-run the tests; however, i have created a patch for
> linux-sendfile with netperf. Please take a look at it at:
> http://www.cyberus.ca/~hadi/patch-nperf-sfile-linux.gz
> tell me if is missing anything and if it is ok, could you please merge in
> your tree?

I will take a look.

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
