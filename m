Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbSJOGzK>; Tue, 15 Oct 2002 02:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbSJOGyl>; Tue, 15 Oct 2002 02:54:41 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5892 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263039AbSJOGx1>;
	Tue, 15 Oct 2002 02:53:27 -0400
Date: Tue, 15 Oct 2002 00:17:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ingo Adlung <Ingo.Adlung@t-online.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Message-ID: <20021015001747.A661@elf.ucw.cz>
References: <3DA4B1EC.781174A6@mvista.com> <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com> <3DA94F07.7070109@t-online.de> <20021014091855.A4197@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014091855.A4197@ucw.cz>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>This patch, in conjunction with the "core" high-res-timers
> > >>patch implements high resolution timers on the i386
> > >>platforms.
> > > 
> > > 
> > > I really don't get the notion of partial ticks, and quite frankly, this 
> > > isn't going into my tree until some major distribution kicks me in the 
> > > head and explains to me why the hell we have partial ticks instead of just 
> > > making the ticks shorter.
> 
> Not speaking for a major distro, just for me writing HPET (high
> performance event timer ...) support for x86-64 (and it happens to exist
> on ia64 as well, and possibly might be in new Intel P4 chipsets, too).
> 
> It's a very nice piece of hardware that allows very fine granularity
> aperiodic interrupts (in each interrupt you set when the next one will
> happen), without much overhead.

I believe the problem is like this: assume you have three timers,
10msec polling of mouse, 30msec keyboard autorepeat and 50msec cursor
blinking. With current approach, you get

10msec userland runs
<enter kernel>
<process mouse>
<process keyboard>
<process cursor>
<exit kernel>

With hires timers, you get:

3msec userland runs
<enter kernel>
<process mouse>
<exit kernel>
2msec userland runs
<enter kernel>
<process keyboard>
<exit kernel>
...

which is not so efficient. I guess rounding could be implemented to
preserve this "do-all-together" ability?
								Pavel
-- 
When do you have heart between your knees?
