Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUIPLhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUIPLhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUIPLhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:37:40 -0400
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:24706 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267961AbUIPLcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:32:25 -0400
Date: Thu, 16 Sep 2004 13:32:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 0/2
Message-ID: <20040916113205.GF5467@elf.ucw.cz>
References: <1095332314.3855.157.camel@laptop.cunninghams> <20040916111852.GC5467@elf.ucw.cz> <1095334173.3324.200.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095334173.3324.200.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Here are two patches for the driver model, which have been in use in
> > > suspend2 for around a month.
> > > 
> > > The first provides support for keeping part of the device tree alive
> > > while suspending the remainder. This is accomplished by abstracting the
> > > dpm_active, dpm_off and dpm_irq lists into a new struct partial device
> > 
> > I believe this is wrong approach.
> > 
> > For atomic snapshot to work, all devices need to be stopped. If your
> > video card does DMA, it needs to be stopped. So all drivers need to
> > know, you can not just exclude part of tree.
> 
> Sorry. Perhaps I wasn't clear enough. I do suspend these devices. But I
> do it later:
> 
> Suspend all other drivers.
> Write pageset 2 (page cache).
> Suspend used drivers.
> Make atomic copy.
> Resume used drivers.
> Write pageset 1 (atomic copy)
> Suspend used drivers.
> Power down all.

What is problem with:

Write pageset 2
Suspend all drivers (avoiding slow operations)
Make atomic copy
Resume all drivers (avoiding slow operations)
Write pageset 1
Suspend all drivers
Power down all.

?

> > Now, you probably do not want disks to spin down and you want your
> > screen unblanked (as an optimalization/speedup). Patch for keeping
> > disk up is allready in -mm. Patch for keeping radeonfb up looks like
> > this, and is pending, too.
> 
> Mm. Don't forget i8xx and the gazillion other drivers there :>. I see
> this is using the SYSTEM_SNAPSHOT value. Do those changes look like
> being merged to Linus soon?

I still hope so. Patrick is back, so it could be merged by the end of
week... if we are lucky.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
