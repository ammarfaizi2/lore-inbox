Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWIYXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWIYXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWIYXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:22:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30660 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751226AbWIYXWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:22:05 -0400
Date: Tue, 26 Sep 2006 01:21:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060925232151.GA1896@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz> <20060925160648.de96b6fa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925160648.de96b6fa.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon 2006-09-25 16:06:48, Andrew Morton wrote:
> On Tue, 26 Sep 2006 00:45:00 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Anyways this boils down to "find which drivers are delaying suspend
> > and fix them".
> 
> The first step would be "find some way of identifying where all the time is
> being spent".
> 
> Right now, netconsole gets disabled (or makes the machine hang) and most of
> these machines don't have serial ports and the printk buffer gets lost
> during resume.
> 
> The net result is that the machine takes a long time to suspend and resume,
> and you don't have a clue *why*.
> 
> And this is a significant issue, IMO.  In terms of
> niceness-of-user-interface, being able to suspend in twelve seconds instead
> of twenty seven rates fairly highly...

Your machines spend 15 seconds in drivers? Ouch, I did not realize
_that_. 

(My machine suspends in 7 seconds, perhaps 2-3 of that are playing
with drivers, so I just failed to see where the problem is).

Are these your big SMP servers? Any SCSI involved?

Rafael has "fakesuspend" patches somewhere, but you can probably just
swapoff -a, then echo disk > /sys/power/state. If you are lucky, that
should be slow, too... fortunately you'll have useful dmesg buffer
when you are done. CONFIG_PRINTK_TIMING or something, and you should
have enough clues...?

15 seconds spend within drivers is definitely _not_ okay.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
