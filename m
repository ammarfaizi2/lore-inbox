Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbUK3A2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUK3A2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUK3A2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:28:53 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50888 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261886AbUK3A2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:28:42 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041129130336.GC3291@elf.ucw.cz>
References: <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams>
	 <20041126003944.GR2711@elf.ucw.cz>
	 <1101455756.4343.106.camel@desktop.cunninghams>
	 <20041126123847.GD1028@elf.ucw.cz>
	 <1101680972.4343.300.camel@desktop.cunninghams>
	 <20041128235530.GB2856@elf.ucw.cz>
	 <1101698428.4343.336.camel@desktop.cunninghams>
	 <20041129130336.GC3291@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101767970.4343.446.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 30 Nov 2004 11:24:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-11-30 at 00:03, Pavel Machek wrote:
> > If we want to compare apples with apples, we're going to have to make
> > the only difference which code is run. A normal load on my computer is
> > evolution, cyrus imapd, opera, win4lin running Libronix and a kernel
> > tree in the cache (last image sizes were 1000, 1002, 995, 949 and
> > 910MB). I'm happy to run your sped-up code for some tests, if you'd
> > like. You know where to find mine if you want to make sure I'm not
> > cheating :>
> 
> Okay, I started galeon (no opera here :-(), evolution, xpdf,
> oowriter. Well, it is not going to be too much "apples-to-apples"
> since swsusp1 cheats and discards caches (etc). Machine has 1GB memory
> total, before suspend attempt 800MB were in use. Suspend took 20
> seconds, after resume (and some swap-in) 250MB was in use.

Are you able to time up to when the swap in is finished? Without that,
we're not really comparing apples with apples, it seems.

> > > > These discussions are getting really unreasonable. "I don't want that
> > > > feature, therefore it shouldn't be merged" isn't a valid argument.
> > > > Neither is "Well, I can suspend in seven seconds with hardly any memory
> > > > in use." If you just don't want suspend2 in the kernel, come out and say
> > > > it. 
> > > 
> > > Ok, "I do not want suspend2 in kernel". Not what you'd call suspend2,
> > > anyway. I thought that stripping down suspend2 then merging it is
> > > reasonable way to go, but now it seems to me that enhancing swsusp1 is
> > > easier way to go. At least I'll be able to do it incrementally.
> > 
> > You'll be able to do that within limits, but once you do seriously given
> > up on the max-half-of-memory limit, you'll need some major redesigning.
> > If that's the way you want to go, okay. Assuming nothing else changes,
> 
> I'm not sure if I want to do full page-cache saving (and without that,
> half-of-memory limit does not bite too badly). "Everything is swapped
> out" problem is actually not limited to swsusp, updatedb overnight
> tends to have the same effect. Perhaps more generic solution is
> needed...

Would increases in the amount of memory machines have make this bite
more and more over time?

I guess the more generic solution would be to abandon using bio calls
and have your own device driver that could write the whole image to disk
without having to do the atomic copy. You'd have to write a lot of
support for drivers, though. I'd find it hard to imagine it being worth
the effort.

> cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null

What does this do?

> does solve part of the problem. (Another problem is how to actually
> measure improvements in this area).

Yes; that's always an 'interesting' issue :>

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

