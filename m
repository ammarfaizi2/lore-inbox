Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVLER3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVLER3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVLER3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:29:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45764 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932472AbVLER3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:29:39 -0500
Date: Mon, 5 Dec 2005 18:29:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051205172938.GC25114@atrey.karlin.mff.cuni.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133791084.3872.53.camel@laptop.cunninghams>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[BTW right function to modify is swsusp_shrink_memory, it is quite
clear what it is doing, so finding formula that frees enough to make
it fast but not so much to make it unresponsive should be easy.]

> > Other possible ideas are:
> > 
> > * get suspend to RAM working if you want it *really* fast :-)
> 
> That's not apples with apples though. If you have a hopeless battery, as
> many do, suspend to ram is only good if you're moving from one power
> point to another.

Yes, it is not completely fair. But as I started to use X32 with good
battery... well I'm not really using swsusp any more.

> > * compress the image. Needs to be done in userspace, so it needs
> > uswsusp to be merged, first. Patches for that are available. Should
> > speed it up about twice.
> 
> That's not true at all. You have cryptoapi in kernel space and can
> easily use it - it's very similar code to what you already have for
> encryption. You won't get double the speed with with the deflate
> compressor - more like 2 or 3MB/s :(. Suspend2 gets double the speed
> because we use lzf, which is a logically distinction addition
> (implemented now as another cryptoapi plugin).

Well, 3MB/sec improvement will save him  seconds on 20, or something
like that, so I guess LZF *is* a way to go, and I'd like to keep that
out of kernel. And I will not accept compression into mainline swsusp;
did that experiment with encryption once already, and I did not like
the result much.

If goal is "make it work with least effort", answer is of course
suspend2; but I need someone to help me doing it right.

> > * and of course you can apply one very big patch and do all of the
> > above :-).
> 
> Could you stop being nasty, please?

Sorry, I was trying to be funny.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
