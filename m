Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWIYWpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWIYWpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWIYWpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:45:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751581AbWIYWph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:45:37 -0400
Date: Tue, 26 Sep 2006 00:45:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060925224500.GB2540@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925144558.878c5374.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon 2006-09-25 14:45:58, Andrew Morton wrote:
> On Tue, 26 Sep 2006 07:34:03 +1000
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
> > </rant>
> 
> metoo!  I'd suggest that it'd be better to be expending the grey cells on
> making the present suspend stuff nice and solid, stable and fast.

[Un?]fortunately, Novell has some suggestions how I should expend my
grey cells in this area.

Anyway you want:

nice)
	not sure if me + Rafael can do much here. Perhaps someone else
	has to go through the code and rewrite it one more time? Or do
	you have specific areas where suspend is really ugly?

solid)
	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
	time before that... these are driver problems...

stable)
	I believe we are doing pretty well in this area. We did not
	have too many regressions, did we? (And notice that nice+fast
	are actually both conflicting goals with stable).

fast)
	frankly, that is not my priority for in-kernel
	suspend. uswsusp will always be few seconds faster, thanks to
	LZW. If we do 40MB/sec or 50MB/sec during write is not that
	important. Patches are always welcome.

> I mean, right now a suspend-to-disk spends more time futzing around doing
> mysterious-but-probably-pointless stuff than it does writing memory to
> disk.  I've no idea what it's doing with all that time, but I'll wager it's
> not very useful to anyone ;)

I liked the previous description more ;-).

Anyways this boils down to "find which drivers are delaying suspend
and fix them".

Okay, we could:

* avoid sending drivers down/up/down again during suspend... but that
will be ugly tree manipulating code, and all devices doing DMA must be
down, anyway... so it is probably easier to do it on per-driver basis
(as is done now) than in generic code

* tweak memory copying loops to make them slighty faster. But as
memory speeds are in GB/sec ranges, I'm not sure it is worth
optimizing.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
