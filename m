Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVLEXeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVLEXeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVLEXeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:34:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41134 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964867AbVLEXet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:34:49 -0500
Date: Tue, 6 Dec 2005 00:34:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051205233430.GA1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <20051205172938.GC25114@atrey.karlin.mff.cuni.cz> <1133816579.3872.83.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133816579.3872.83.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > * compress the image. Needs to be done in userspace, so it needs
> > > > uswsusp to be merged, first. Patches for that are available. Should
> > > > speed it up about twice.
> > > 
> > > That's not true at all. You have cryptoapi in kernel space and can
> > > easily use it - it's very similar code to what you already have for
> > > encryption. You won't get double the speed with with the deflate
> > > compressor - more like 2 or 3MB/s :(. Suspend2 gets double the speed
> > > because we use lzf, which is a logically distinction addition
> > > (implemented now as another cryptoapi plugin).
> > 
> > Well, 3MB/sec improvement will save him  seconds on 20, or something
> > like that, so I guess LZF *is* a way to go, and I'd like to keep that
> > out of kernel. And I will not accept compression into mainline swsusp;
> > did that experiment with encryption once already, and I did not like
> > the result much.
> 
> No - I didn't mean a 3MB/s improvement. I meant that you'll get about
> 3MB/s throughput. It's _very_ slow. Of course having said that, I don't
> recall now what machine I saw that on. It may well be my 933 Celeron
> (Omnibook XE3).

Ah, okay -- that means that deflate compressor is pretty much useless.

> > If goal is "make it work with least effort", answer is of course
> > suspend2; but I need someone to help me doing it right.
> 
> How do you think suspend2 does it wrong? Is it just that you think that
> everything belongs in userspace, or is there more to it?

Everything belongs in userspace... that makes it "wrong
enough". Userland and kernel programming is quite different, so any
improvements to suspend2 will be wasted, long-term. You'll make users
happy for now, but it means u-swsusp gets less users and less
developers, making "doing it right" slightly harder...
								Pavel
-- 
Thanks, Sharp!
