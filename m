Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSKBUTg>; Sat, 2 Nov 2002 15:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSKBUTf>; Sat, 2 Nov 2002 15:19:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26128 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261400AbSKBUSf>; Sat, 2 Nov 2002 15:18:35 -0500
Date: Sat, 2 Nov 2002 21:25:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021102202504.GD18576@atrey.karlin.mff.cuni.cz>
References: <20021102184735.GA179@elf.ucw.cz> <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's patch to prevent random scribling over disks during
> > suspend... In the meantime alan killed (unreferenced at that time)
> > idedisk_suspend() and idedisk_release(), so I have to reintroduce
> > them.
> 
> Please fix this at a different level. idedisk is not the place to be
> doing this. If the device layer is doing the right thing then the
> request queue will be idle. 

How can I wait for all requests to be finished? Should it be at
ll_rw_blk level?

Anyway if I want disk to be spinned down (so their caches are
flushed), some kind of idedisk_suspend is required, right?

> > +	.gen_driver		= {
> > +		.suspend	= idedisk_suspend,
> > +		.resume		= idedisk_resume,
> > +	}
> 
> Some disks are going to be settint their own power methods too.

Fine with me as long as they call idedisk_suspend() first ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
