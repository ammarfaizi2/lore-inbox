Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVLEVOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVLEVOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVLEVOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:14:38 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:54165 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932497AbVLEVOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:14:37 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20051205172938.GC25114@atrey.karlin.mff.cuni.cz>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <20051205172938.GC25114@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133816579.3872.83.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 07:11:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-12-06 at 03:29, Pavel Machek wrote:
> > That's not apples with apples though. If you have a hopeless battery, as
> > many do, suspend to ram is only good if you're moving from one power
> > point to another.
> 
> Yes, it is not completely fair. But as I started to use X32 with good
> battery... well I'm not really using swsusp any more.

Ah. Personally, I quite like standby mode too - no need to vga post at
all. But my lappy's battery is one of those hopeless ones, so it won't
do for long. :(

> > > * compress the image. Needs to be done in userspace, so it needs
> > > uswsusp to be merged, first. Patches for that are available. Should
> > > speed it up about twice.
> > 
> > That's not true at all. You have cryptoapi in kernel space and can
> > easily use it - it's very similar code to what you already have for
> > encryption. You won't get double the speed with with the deflate
> > compressor - more like 2 or 3MB/s :(. Suspend2 gets double the speed
> > because we use lzf, which is a logically distinction addition
> > (implemented now as another cryptoapi plugin).
> 
> Well, 3MB/sec improvement will save him  seconds on 20, or something
> like that, so I guess LZF *is* a way to go, and I'd like to keep that
> out of kernel. And I will not accept compression into mainline swsusp;
> did that experiment with encryption once already, and I did not like
> the result much.

No - I didn't mean a 3MB/s improvement. I meant that you'll get about
3MB/s throughput. It's _very_ slow. Of course having said that, I don't
recall now what machine I saw that on. It may well be my 933 Celeron
(Omnibook XE3).

> If goal is "make it work with least effort", answer is of course
> suspend2; but I need someone to help me doing it right.

How do you think suspend2 does it wrong? Is it just that you think that
everything belongs in userspace, or is there more to it?

> > > * and of course you can apply one very big patch and do all of the
> > > above :-).
> > 
> > Could you stop being nasty, please?
> 
> Sorry, I was trying to be funny.

Ok. Sorry if I over-reacted.

Regards,

Nigel

