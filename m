Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbTIWTDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTIWTDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:03:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5382 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263419AbTIWTDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:03:36 -0400
Date: Tue, 23 Sep 2003 21:02:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923190219.GA5997@alpha.home.local>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923160600.GA4161@alpha.home.local> <20030923162319.GA1269@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923162319.GA1269@velociraptor.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list stripped down]

On Tue, Sep 23, 2003 at 06:23:19PM +0200, Andrea Arcangeli wrote:
 
> You simply want *two* different APIs, where one is worhtless and
> obsoleted by the more powerful one.

I never said I wanted *two* of them. I proposed first a fairly non-intrusive
one which doesn't add any line of code, just defines, and managed to reunify
architectures which used different values by default.

*You* proposed a second one. I have no objections against it, as I said, since
I certainly understand that some people would prefer to use it. But *you*
decided that mine was totally unusable and obsoleted by yours, reason for it to
be removed. And this is *that* I objected to. Since the can both coexist and
fit different people's needs without adding a byte of code (at least for mine),
I don't see the goal in eliminating it, deciding unilaterally that nobody will
use it.

I repeat, at the end, I don't mind. I have the patch and can live with one
more patch, as I did before. It's just the fact that you decide for everyone
that always adding a command line option is more convenient than a once-for-all
fixed config option.

> My API is good for everyone, yours is not

I'm impressed that you know so many people. I know that mine at least
satisfies a few collegues, customers, and I. So I deduced that it might be
useful to others too. Even Marcelo thought the same a time ago.

> I don't see why we've to keep both when nobody depends on yours yet.

Nobody depends on mine, since it doesn't change defaults nor semantics. Perhaps
some people depend on yours *not* being in. You changed LOG_BUF_LEN from a
define to a static, and THAT could break other external patches. BTW, I've
just checked 2.4.22aa1, I noticed that you removed kmsgdump, is it because it
doesn't apply, compile or work anymore since your API change ?

Honnestly, I simply took a conservative approach. My proposal not being what
will save the world, I'm 100% with you on that. Mine being useless to everyone,
I'm only 20% with you on that. Yours being "good for everyone", I'm only 20%
with you on that too, and perhaps less since it might break some compatibility.
Yours *is* interesting to some aspects, but is not an equivalent.

> I just don't buy the fact that you don't like to pass params to the
> kernel because you already do, you have to or it won't boot on a system
> different than the one that you compiled the kernel.

Believe it or not, there are people who don't like to pass params to the
kernel. I just told a friend while I was typing this mail, and he replied me
"he must be joking !". So at least, we're two on earth.

> Yeah, I'm forcing you to waste a dozen bytes of disk space in
> /etc/lilo.conf, you can definitely claim that, but I don't that as an
> argument either (delete the spaces/tabs and you may save more). And
> maybe thanks to this you won't run into the number of kernel images
> limitation anymore.

OK Andrea, you're in a bad mood today. You're trying to prove me crazy. I
won't fight. You're the kernel hacker. Not me. I have never been proud of
putting a patch in the kernel and never will be. I'm more ashamed when I send
an obvious "fix" which breaks someone's setup. Your attitude today seems to be
the opposite. Your patch is useful, I won't contest that. It won't annoy anyone,
I'll let others report it to you themselves, I've done my part of it. But they
will waste their time since you don't want to listen and will try to sell your
patch anyway because "it's good for everyone" as you stated it.

> I'm deinitely against worthless APIs in the kernel, when more powerful
> one exists, and they give you zero disavantage

There are people out there who are against worthless lines in config files,
and against APIs which break other patches.

> As for decreasing the buf size, my option will allow you to decrease it
> too after I fix it! While the shift only let you increase the buf size,
> not decrease. So you should prefer the dynamic API too.

I don't see why you say that ! Set LOG_BUF_SHIFT to 10 and you'll have 1kB !

Have a good night anyway,
Willy

