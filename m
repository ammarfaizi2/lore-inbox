Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271619AbRHUJHQ>; Tue, 21 Aug 2001 05:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271621AbRHUJG5>; Tue, 21 Aug 2001 05:06:57 -0400
Received: from [209.195.52.30] ([209.195.52.30]:804 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S271619AbRHUJGr>;
	Tue, 21 Aug 2001 05:06:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Date: Tue, 21 Aug 2001 00:49:14 -0700 (PDT)
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
In-Reply-To: <606175155.998387452@[169.254.45.213]>
Message-ID: <Pine.LNX.4.33.0108210042520.32719-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so as I see this discussion it goes something like this.

1. the entropy pool is not large enough on headless machines.
2. you don't want to use urandom as there are theoretical attacks against
it

so as a result you propose adding an option to weaken random (network
traffic is not that random which is a large part of why it's not included
now)

you are trading one theoretical attack for another known attack (a
difficult attack to pull off yes, but still known)

that doesn't sound like a reasonable tradeoff to me.

as for the arguments that applications all use random and would have to be
changed to use urandom.

don't forget that it's not the names that matter to the kernel it's the
major/minor numbers. you can rename random to really.random and urandom to
random and your software will not know the difference.

if you were arguing that the network traffic was truly random and that it
should be added in as well that would be a different story, but you're not
saying that you just don't want the incomvienience of blocking while
waiting for truely random data but want to fool yourself into thinking
that you are.

David Lang

 On Tue, 21 Aug 2001, Alex Bligh - linux-kernel wrote:

> Date: Tue, 21 Aug 2001 09:50:52 +0100
> From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
> To: David Schwartz <davids@webmaster.com>,
>      Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
> Cc: linux-kernel@vger.kernel.org,
>      Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
> Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was
>     Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
>
> David,
> > Alex Bligh wrote:
> >
> >> Many non-i386 platforms have more finely grained timers than 1 jiffie.
> >> The problem is the code doesn't use them. So my point is, it seems
> >> illogical to throw stones at (often) theoretical issues with Robert's
> >> patch, when people's energy would be better diverted to help fix up
> >> hole in the current implementation.
> >
> > 	I don't understand the connection. Either Robert's patch is good or it's
> > bad. If there are other problems, then we can address those too. But to
> > say that Robert's patch is bad because it doesn't fix the most important
> > problem that you can think of doesn't make any sense. Every problem
> > should be fixed, and if Robert has a patch to fix one of them, then
> > that's one less.
> >
> > 	You can certainly advise people to work on the most serious problems. But
> > you most certainly can't say that someone shouldn't work on X because Y is
> > more important.
>
> For clarity, I'm saying Robert's patch is GOOD, and those who are trying
> to point out what I consider to be extremely theoretical weakness it
> introduces into /dev/random (and then, only when config'd on), should
> instead spend their attention looking at miuch more serious issues
> in the algorithm elsewhere if they are that worried, rather than
> attacking something which is useful.
>
> To make an analogy, Robert is suggesting changing the 9 cylinder
> lock on the back door of a house to a 7 cylinder lock, which is much
> easier to operate, but perhaps slightly less secure. (well,
> to be precise, he's advocating giving the house own the
> OPTION to do this). However, the front door is wide open, swinging
> in the wind, with no lock on at all. And people are worried about
> Robert's patch. Doesn't make much sense...
>
> --
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
