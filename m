Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBDT4s>; Sun, 4 Feb 2001 14:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132232AbRBDT4j>; Sun, 4 Feb 2001 14:56:39 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:12474 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S129080AbRBDT4X>;
	Sun, 4 Feb 2001 14:56:23 -0500
Date: Sun, 4 Feb 2001 14:48:34 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Rick Jones <raj@cup.hp.com>
cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing 
 todowith ECN)
In-Reply-To: <3A77777D.E1A998FC@cup.hp.com>
Message-ID: <Pine.GSO.4.30.0102041426180.15417-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jan 2001, Rick Jones wrote:

> > > How does ZC/SG change the nature of the packets presented to the NIC?
> >
> > what do you mean? I am _sure_ you know how SG/ZC work. So i am suspecting
> > more than socratic view on life here. Could be influence from Aristotle;->
>
> Well, I don't know  the specifics of Linux, but I gather from what I've
> read on the list thusfar, that prior to implementing SG support, Linux
> NIC drivers would copy packets into single contiguous buffers that were
> then sent to the NIC yes?
>

yes.

> If so, the implication is with SG going, that copy no longer takes
> place, and so a chain of buffers is given to the NIC.
>

yes.

> Also, if one is fully ZC :) pesky things like protocol headers can
> naturally end-up in separate buffers.
>

yes.

> So, now you have to ask how well any given NIC follows chains of
> buffers. At what number of buffers is the overhead in the NIC of
> following the chains enough to keep it from achieving link-rate?
>

hmmm... not sure how you would enforce this today or why you would
want that. Alexey, Dave?
The kernel should be able to break it into two buffers(with netperf,
for example -- header + data).
Ok, probably with tux-http 3 (header, data, trailler).

> One way to try and deduce that would be to meld some of the SG and preSG
> behaviours and copy packets into varying numbers of buffers per packet
> and measure the resulting impact on throughput through the NIC.
>

If only time were on my hands i'd love to do this. Alas.
NOTE also, that effect would also be an effect of the specif NIC.

> rick jones
>
> As time marches on, the orders of magnitude of the constants may change,
> but basic concepts still remain, and the "lessons" learned in the past
> by one generation tend to get relearned in the next :) for example -
> there is no such a thing as a free lunch... :)

;->
BTW, i am reading one of your papers (circa 1993 ;->, "we go fast with a
little help from your apps")  in which you make an interesting
observation. That (figure 2) there is "a considerable increase in
efficiency but not a considerable increase in throughput" .... I "scanned"
to the end of the paper and dont see an explanation.
I've made a somehow similar observation with the current zc patches and
infact observed that throughput goes down with the linux zc patches.
[This is being contested but no-one else is testing at gigE, so my word is
the only truth].
Of course your paper doesnt talk about sendfile rather the page pinning +
COW tricks (which are considered taboo in Linux) but i do sense a
relationship.

cheers,
jamal

PS:- I dont have "my" machines yet and i have a feeling it will be a while
before i re-run the tests; however, i have created a patch for
linux-sendfile with netperf. Please take a look at it at:
http://www.cyberus.ca/~hadi/patch-nperf-sfile-linux.gz
tell me if is missing anything and if it is ok, could you please merge in
your tree?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
