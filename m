Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269506AbRHLWcl>; Sun, 12 Aug 2001 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269515AbRHLWcb>; Sun, 12 Aug 2001 18:32:31 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:24076 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269491AbRHLWcS>; Sun, 12 Aug 2001 18:32:18 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Date: Sun, 12 Aug 2001 22:31:57 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9l704t$1rp$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108121509310.974-100000@penguin.transmeta.com> <E15W3ZC-0006IC-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 997655539 12041 127.0.0.1 (12 Aug 2001 22:32:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Aug 2001 22:32:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15W3ZC-0006IC-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> The problem with backing it out is that apparently nobody has tried to
>> really maintain it for a year, and if it gets backed out nobody will even
>> bother to try to fix it. So I'll let it be for a while, at least.
>
>I thought this was a stable kernel tree not 2.5 ?

Well, considering that the _old_ driver is also not stable and doesn't
work on all machines, we're really screwed whichever way we turn. 

If the old driver was a known working one, this would be a no-brainer. 
As it is, the old driver doesn't work for people _either_ - but they
probably aren't piping up, because the old driver has been broken
forever. 

So we have a situation that the new driver works better on some
machines, and the old driver works better on others. The old driver will
obviously neevr get fixed (we've given it several years now), so the old
driver is _known_ to be terminally broken. The new driver is a question
mark in that regard.

So I'd rather give the new driver a chance, and see if people can get it
fixed.  For example, the oops that people have reported _seems_ to be
due to initializing the tasklet before actually having initialized all
the data structures the tasklet depends on.  It may well be that moving
the two "tasklet_init()"s down two lines would fix it.

		Linus
