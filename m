Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263950AbUKZTx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbUKZTx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbUKZTx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:53:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262481AbUKZTbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:23 -0500
Date: Thu, 25 Nov 2004 22:54:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge:L 12/51: Disable OOM killer when suspending.
Message-ID: <20041125215426.GG2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294601.5805.237.camel@desktop.cunninghams> <20041125181208.GC1417@openzaurus.ucw.cz> <1101419241.27250.34.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101419241.27250.34.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > When preparing the image, suspend eats all the memory in sight, both to
> > > reduce the image size and to improve the reliability of our stats (We've
> > > worked hard to make it work reliably under heavy load - 100+). Of course
> > > this can result in the OOM killer being triggered, so this simple test
> > > stops that happening.
> > 
> > andrew's shrink_all_memory should enable you to free memory without
> > hacking OOM killer, no?
> 
> I do use shrink_all_memory, but I also then allocate those pages that
> were freed. We added that when seeking to get Suspend to work well and
> reliably under heavy load. IIRC, the issue was that pages that were
> freed were immediately getting allocated by other programs. Having said
> this, it is a while since I looked at the code for preparing the image.
> I can take a look and confirm my thinking.

How is it possible that other programs steal memory when they are
frozen? That just should not happen.

> > Hmm, yes, something like this migh be usefull for BUG_ONs etc...
> > For consistency, right name is probably in_suspend(void).
> 
> There is a difference; there is sections of time where we're in_suspend
> (test_suspend_state(SUSPEND_RUNNING)) but the freezer isn't on (initial
> set up and cleanup). As far as the OOM killer goes, it probably doesn't
> matter which is used, but I thought it important to point out that
> freezer being on !== in_suspend(). (Freezer could also be on for S3?..
> 'spose you don't care of OOM killer runs then, though). Would you like
> to see in_freezer()?

There was discussion on linux-pm that something like in_freezer()
would be nice for sanity-checks, but don't introduce it just because
of that.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
