Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUHJXi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUHJXi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUHJXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:38:27 -0400
Received: from gprs214-124.eurotel.cz ([160.218.214.124]:3456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267823AbUHJXg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:36:29 -0400
Date: Wed, 11 Aug 2004 01:36:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
Subject: suspend2 merge [was Re: [RFC] Fix Device Power Management States]
Message-ID: <20040810233607.GC2287@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net> <20040809212949.GA1120@elf.ucw.cz> <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net> <1092130981.2676.1.camel@laptop.cunninghams> <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net> <1092176983.2709.3.camel@laptop.cunninghams> <Pine.LNX.4.50.0408101544470.28789-100000@monsoon.he.net> <1092179384.2711.29.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092179384.2711.29.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm not intending to patch the current implementation into the new
> > > version; there are so many changes that it would make the process
> > > extremely painful (as evolution would have been if it were really true).
> > > Instead, I proposed, as Andrew requested to post a number of patches
> > > simply adding the new version along side the old. When you're satisfied
> > > that the new does everything the old does, I'm hoping we'll simply drop
> > > the old version.
> > 
> > Then there is something seriously wrong with your development process.
> 
> No. It's just that the changes are so fundamental (how data is stored,
> how we prepare the image etc) that to talk about evolution is simply a
> misnomer. It's a redesign. The steps did occur one at a time, and there
> are basic similarities, but some of the steps were fundamental
> rewrites.

At one point I was pretty unhappy with swsusp state (that was just
before I wrote trivial highmem support), and was willing to merge
suspend2 pretty much at all costs. (Okay, I was never willing to let
LZO-suspend2 sneak into 2.6). I'm now way happier with merged
pmdisk+swsusp works.

I feared big problems with highmem support, but surprisingly, trivial
support thats in current code does not cause problems for
people. People seem to like pmdisk+swsusp, too...

Now, people like suspend2 even more, and for good reasons: it is
extremely fast, it provides nice feedback and its refrigerator is
superior.

I also realized that suspend2 is fundamentally more complex than
swsusp: it introduces additional time period where page cache must not
be touched. I did not realize this sooner.

I do longer think that "merge at all costs" is good idea now: in
kernel code is small, simple and nice by now, and I'd like to keep it
that way.

Now, there are some parts of swsusp that are not quite okay. One of
them is refrigerator -- it fails (in non-critical way but still) in
some cases where it should not fail. suspend2 seems to have this
solved, and I'd like to merge its refrigerator.

Other parts... I'm not so sure. Incremental patches would certainly
help a lot here.

Best regards,
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
