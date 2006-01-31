Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWAaWDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWAaWDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWAaWDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:03:45 -0500
Received: from tim.rpsys.net ([194.106.48.114]:15341 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751577AbWAaWDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:03:44 -0500
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060131203552.GG4215@suse.de>
References: <1138714918.6869.139.camel@localhost.localdomain>
	 <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
	 <1138724479.6869.201.camel@localhost.localdomain>
	 <20060131203552.GG4215@suse.de>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 22:03:35 +0000
Message-Id: <1138745015.6869.295.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 21:35 +0100, Jens Axboe wrote:
> Perhaps a generic solution isn't feasible, because this isn't really a
> generic problem. 

I agree. I think that email goes to show that totally generic led
triggers aren't achievable, desirable or useful.

> The LED stuff has very limited use - you mention
> embedded platforms, perhaps they should just be doing this on their own?

I am convinced the led class core and the led trigger *core* should be
in the mainline kernel. The alternative is for everyone to invent their
own versions and end up in a mess. The arm LED code is one example of
something done adhoc which no other arch can benefit from.

The core code doesn't touch anything outside of drivers/leds and can be
hidden behind any config options found to be appropriate.

> Generally I'm finding a hard time justifying an LED api, honestly. It
> just feels like one of those things where the actual abstraction ends up
> being a lot bigger than code needed. Abstracting and creating an API
> isn't always useful.

Nobody seems to have any issues with the led class or the led drivers
themselves. The triggers are the controversial aspect. The trigger API
is in a way too powerful as it can let you use anything as an LED
trigger. This leads to people asking for anything and everything as a
trigger.

Perhaps the best solution might be to allow the LED class core, the
triggers *core* and led drivers into the kernel but be extremely
selective about which triggers are allowed (if any). 

I think there is a case for including specific triggers like the sharpsl
charging trigger as if we're going to have sharpsl charging code in the
kernel (which we have), it might as well connect up to the charging led
it was built for.

If all other more generic triggers are rejected, I can live with that.
Maintaining a handful of trigger patches outside the kernel, most of
them a few lines long is much easier than maintaining a whole subsystem.

Would that be acceptable?

Richard

