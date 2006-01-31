Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWAaUdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWAaUdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWAaUdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:33:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20330 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751464AbWAaUdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:33:33 -0500
Date: Tue, 31 Jan 2006 21:35:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Message-ID: <20060131203552.GG4215@suse.de>
References: <1138714918.6869.139.camel@localhost.localdomain> <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com> <1138724479.6869.201.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138724479.6869.201.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2006, Richard Purdie wrote:
> Hi,
> 
> On Tue, 2006-01-31 at 15:46 +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Why cannot existing block layer hook be used for this?
> 
> The trigger is supposed to be reflecting actual hardware activity, not
> block layer activity.
> 
> I'll experiment with the feasibility of the block later as I've always
> been uneasy about the hooks into the lower level layers. There are a
> number of issues to consider though.
> 
> 1. The block layer isn't always aware of device activity (eg. flash
> block erasing in mtd devices) (is this the case for IDE?).
> 
> 2. Default trigger naming becomes problematic for led devices. Currently
> an MMC card reader's LED could set its trigger to say "mmc-disk" and end
> up with some kind of sensible activity light. (ignoring the more than
> one card reader case where all the lights would be synced :).
> 
> A potential solution would be to add individual gendisk triggers by
> hooking add_disk/del_disk. The MMC read would presumably know its
> major/minor number before registering its LED. 
> 
> I'm not sure how to intercept disk activity for a given gendisk offhand.
> There is also a question of where the led_trigger pointers end up.
> struct gendisk may or may not be acceptable.
> 
> 3. Matching something like all IDE disks becomes hard (and is actually
> more desirable than individual devices at times - see below). 
> 
> At first glance a potential solution would be to hook
> register_blkdev/unregister_blkdev and create yet more triggers but where
> do you hook the activity? There is no data structure the led trigger
> pointer can be part of either.
> 
> These solutions are going to end up with a lot of unused led triggers on
> any given system. 

Perhaps a generic solution isn't feasible, because this isn't really a
generic problem. The LED stuff has very limited use - you mention
embedded platforms, perhaps they should just be doing this on their own?

Generally I'm finding a hard time justifying an LED api, honestly. It
just feels like one of those things where the actual abstraction ends up
being a lot bigger than code needed. Abstracting and creating an API
isn't always useful.

-- 
Jens Axboe

