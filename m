Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVKFPzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVKFPzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVKFPzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:55:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15333 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932102AbVKFPzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:55:47 -0500
Date: Sun, 6 Nov 2005 16:55:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [patch] collie: enable frontlight
Message-ID: <20051106155524.GC28618@elf.ucw.cz>
References: <20051101232122.GA27107@elf.ucw.cz> <20051104151751.32c1abe7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104151751.32c1abe7.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > +static spinlock_t fl_lock = SPIN_LOCK_UNLOCKED;
> > +
> > +#define LCM_ALC_EN	0x8000
> > +
> > +void frontlight_set(struct locomo *lchip, int duty, int vr, int bpwf)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fl_lock, flags);
> > +	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> > +	udelay(100);
> > +	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
> > +	locomo_writel(bpwf | LCM_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> > +	spin_unlock_irqrestore(&fl_lock, flags);
> > +}
> 
> ick, a 100 microsecond glitch, quite unnecessary.  Why not use a semaphore
> here, if any locking is actually needed?  (It's called from device probe -
> there's higher-level serialisation, no?)

Oops, I see; I invented my own lock when I should have used
lchip->lock. Fixed locally, I'll push it up eventually.

							Pavel
-- 
Thanks, Sharp!
