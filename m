Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271344AbTGQHtu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271345AbTGQHtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:49:49 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:42880 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S271344AbTGQHts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:49:48 -0400
Date: Thu, 17 Jul 2003 01:04:36 -0700
From: Danek Duvall <duvall@emufarm.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6.1int
Message-ID: <20030717080436.GA16509@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200307171213.02643.kernel@kolivas.org> <20030717045435.GA630@lorien.emufarm.org> <200307171712.20193.kernel@kolivas.org> <200307171213.02643.kernel@kolivas.org> <20030717045435.GA630@lorien.emufarm.org> <200307171635.25730.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307171712.20193.kernel@kolivas.org> <200307171635.25730.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003, Con Kolivas wrote:

> Thanks for testing. How does vanilla 2.6.0-test1 compare?

About the same, actually.  There are a few differences, but I can't call
one better or worse.

> Can you watch top while all this is running, and see what dynamic
> priority these applications are during this (the cc's, X, mozilla,
> xterm and xmms), and when their behavious is less than ideal what the
> priority is.

In 2.6.0-test1, the cc1 processes hover around 30 (early on they're
lower, but they ramp up quickly).  Xmms stays fixed at 20 pretty much
the entire time.  X stays fixed at 15, though sometimes with heavy
window moving it'll skyrocket to 16.  :)  Mozilla typically is at 20,
but after lots of scrolling, it edges up slowly (and, I think, pretty
linearly) to 30.  Scrolling's bad by the time you get to 23 (with the
compile going; if it's the only interesting thing happening, it's smooth
all the way up).

The jerkiness in mozilla scrolling repeatedly takes three to four
seconds before it shows up.  Let it sit for a few more seconds and it's
good to go again, at least for another three to four seconds.

The python process updating the portage database is in the 23-25 range.

In 2.6.0-test1-mm1 with O6.1int, mozilla takes longer to get jerky
(15-20 seconds), but once it does, it gets stuck there pretty bad.  Over
the 16 minutes it took to compile the kernel, I think I managed to get
it unstuck twice (maybe I didn't know how to do it right -- I kept
poking at it and maybe that was the wrong thing to do).  When left
alone, it would settle at 24, though it would drop to 20 or 21 when
either raised to the top of the window stack or lowered to the bottom
(I'm using fvwm, in case that matters here).  It would come back up to
24 within a second or two.  Any scrolling instantly brought it up to 27
and climbing.

X, cc1, and xmms all had the same behavior as in vanilla (roughly the
same amount of skippiness).

The python process had a lower priority, spending most of its time in
the 17-20 range.

One other thing -- xmms skips seem to cause it to spit out 

    ** WARNING **: snd_pcm_wait: Input/output error
    ** WARNING **: Buffer time reduced from 500 ms to 371 ms

Not consistently one or the other or both, but at least one of those
would show up each time.

Hope this helps,
Danek
