Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276341AbRJYV3G>; Thu, 25 Oct 2001 17:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276380AbRJYV2z>; Thu, 25 Oct 2001 17:28:55 -0400
Received: from [194.213.32.137] ([194.213.32.137]:35076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276341AbRJYV2k>;
	Thu, 25 Oct 2001 17:28:40 -0400
Date: Thu, 25 Oct 2001 23:47:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011025234724.A10358@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com> <20011024173349.20613@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011024173349.20613@smtp.adsl.oleane.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >We should not have pending IO, but that's for a totally different reason:
> >the first thing the much much MUCH higher levels of suspend should be
> >doing is to make sure that user apps are "quiescent". And that isn't done
> >by getting involved with sg.c or anything similar, but by basically
> >stopping all user apps (think of the equivalent of a "kill -STOP -1", but
> >done internally in the kernel without actually using a signal).
> 
> Is this necessary ? That would definitely make things easier to implement
> to forget about incoming requests, but I'm not sure it's the right way.
> In fact, is it really working ? You could well have in-kernel threads
> triggering IOs or launching new userland stuffs (what happens if a not
> yet suspended driver for, let's say USB, see a new device coming in 
> and starts /sbin/hotplug). Some filesystems have garbage collector threads
> that can do IOs eventually. There are various kind of IOs that can in fact
> be triggered entirely within the kernel.

I need this for suspend to disk. I really need quiescent system if I
want to write to swap image, right?

I implemented a "refrigerator" mechanism, and manually marked threads
that should not be frozen. I'm doing my best to stop everyone who
might try to wake userland.

[I just mailed the patch as 2.4.13 - swsusp. Tell me if you want a
copy.]

								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


