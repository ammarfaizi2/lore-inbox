Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289850AbSBEXMX>; Tue, 5 Feb 2002 18:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289853AbSBEXMN>; Tue, 5 Feb 2002 18:12:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41220 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289850AbSBEXMA>; Tue, 5 Feb 2002 18:12:00 -0500
Date: Tue, 5 Feb 2002 18:11:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Re: 2.4.17 Oops when trying to mount ATAPI CDROM
In-Reply-To: <Pine.LNX.4.44.0202050759060.2739-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.3.96.1020205180314.3562B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Zwane Mwaikambo wrote:

> Patch to fix the oops as encountered by Manuel McLure
> 
> Quick browse of the trace...
> 
> <snip>
    [big snip]

> [1] In this case we get to 2 because we failed the if (id) check, but then we don't check again...
> 
> Patch diffed against 2.4.18-pre7 and applies to 2.5.3-pre6 with offsets.

I have two comments on that code, first that it is some of the ugliest
code I've seen in a while in terms of goto's, unintuitive tests, etc. And
the patch adds a goto to avoid duplicating the test for the missing id,
which really could be made more readable. If I thought a patch just to
make the code readable and maintainable would be accepted I'd write it
(while I have a flow diagram in front of me), but given the recent
discussion of path acceptable lately I won't bother. The code really is
uglier than a hedgehog's asshole, though.

MORE IMPORTANT: doesn't this imply that the device id has either been lost
or not initialized? I haven't finished grepping for calls to this code
yet, but intuitively I would guess that if we don't have the id all the
other stuff might be suspect as well.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

