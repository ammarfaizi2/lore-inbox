Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271861AbTGRRgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271862AbTGRRgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:36:15 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:15791 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271861AbTGRRgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:36:08 -0400
Date: Fri, 18 Jul 2003 19:50:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030718175045.GA195@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz> <20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com> <20030718032433.4b6b9281.akpm@osdl.org> <20030718152205.GA407@elf.ucw.cz> <m2el0nvnhm.fsf@telia.com> <20030718094542.07b2685a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718094542.07b2685a.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I tried the patch below, but it didn't work. Nothing (or very little)
> > was swapped out to disk. I also tried using GFP_KERNEL, but that
> > seemed to cause a deadlock. (Maybe it would have gone OOM if I had
> > waited long enough). I think the problem is that pdflush and friends
> > are already frozen when this code runs.
> 
> Oh, we shouldn't be doing this sort of thing when the kernel threads are
> refrigerated.  We do need kswapd services for the trick you tried.
> 
> And all flavours of ext3_writepage() can block on kjournald activity, so if
> kjournald is refrigerated during the memory shrink the machine can deadlock.
> 
> It would be much better to freeze kernel threads _after_ doing the big
> memory shrink.

I wanted to avoid that: we do want user threads refrigerated at that
point so that we know noone is allocating memory as we are trying to
do memory shrink. I'd like to avoid having refrigerator run in two
phases....

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
