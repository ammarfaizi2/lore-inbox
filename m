Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUK2NGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUK2NGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 08:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUK2NFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 08:05:16 -0500
Received: from gprs214-59.eurotel.cz ([160.218.214.59]:23432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261717AbUK2NDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 08:03:55 -0500
Date: Mon, 29 Nov 2004 14:03:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041129130336.GC3291@elf.ucw.cz>
References: <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <1101455756.4343.106.camel@desktop.cunninghams> <20041126123847.GD1028@elf.ucw.cz> <1101680972.4343.300.camel@desktop.cunninghams> <20041128235530.GB2856@elf.ucw.cz> <1101698428.4343.336.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101698428.4343.336.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > My machine suspends in 7 seconds, and that's swsusp1. According to
> > > > your numbers, suspend2 should suspend it in 1 second and LZE
> > > > compressed should be .5 second.
> > > 
> > > Seven seconds? How much memory is in use when you start, and how much is
> > > actually written to disk? If you're starting with 1GB of RAM in use,
> > > I'll sit up and listen, but I suspect you're talking about something
> > > closer to 20MB and init S :>
> > 
> > It was on .5GB machine, with X running, IIRC. Specify how should I
> > load the system and I'll try it here. swsusp1 got some speedups with
> > O(n^2) killing (not yet merged).
> 
> So it wrote .5GB of memory in seven seconds, or started with .5GB of RAM
> in use?

Machine had .5GB total, not surehow much was really used.

> If we want to compare apples with apples, we're going to have to make
> the only difference which code is run. A normal load on my computer is
> evolution, cyrus imapd, opera, win4lin running Libronix and a kernel
> tree in the cache (last image sizes were 1000, 1002, 995, 949 and
> 910MB). I'm happy to run your sped-up code for some tests, if you'd
> like. You know where to find mine if you want to make sure I'm not
> cheating :>

Okay, I started galeon (no opera here :-(), evolution, xpdf,
oowriter. Well, it is not going to be too much "apples-to-apples"
since swsusp1 cheats and discards caches (etc). Machine has 1GB memory
total, before suspend attempt 800MB were in use. Suspend took 20
seconds, after resume (and some swap-in) 250MB was in use.

> > > These discussions are getting really unreasonable. "I don't want that
> > > feature, therefore it shouldn't be merged" isn't a valid argument.
> > > Neither is "Well, I can suspend in seven seconds with hardly any memory
> > > in use." If you just don't want suspend2 in the kernel, come out and say
> > > it. 
> > 
> > Ok, "I do not want suspend2 in kernel". Not what you'd call suspend2,
> > anyway. I thought that stripping down suspend2 then merging it is
> > reasonable way to go, but now it seems to me that enhancing swsusp1 is
> > easier way to go. At least I'll be able to do it incrementally.
> 
> You'll be able to do that within limits, but once you do seriously given
> up on the max-half-of-memory limit, you'll need some major redesigning.
> If that's the way you want to go, okay. Assuming nothing else changes,

I'm not sure if I want to do full page-cache saving (and without that,
half-of-memory limit does not bite too badly). "Everything is swapped
out" problem is actually not limited to swsusp, updatedb overnight
tends to have the same effect. Perhaps more generic solution is
needed...

cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null

does solve part of the problem. (Another problem is how to actually
measure improvements in this area).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
