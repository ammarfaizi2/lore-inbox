Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUK0W0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUK0W0s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUK0W0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:26:48 -0500
Received: from gprs214-171.eurotel.cz ([160.218.214.171]:62593 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261352AbUK0WZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:25:49 -0500
Date: Sat, 27 Nov 2004 23:25:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge
Message-ID: <20041127222535.GA1445@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041127220752.16491.qmail@science.horizon.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My machine suspends in 7 seconds, and that's swsusp1. According to
> > your numbers, suspend2 should suspend it in 1 second and LZE
> > compressed should be .5 second.
> > 
> > I'd say "who cares". 7 seconds seems like fast enough for me.  And I'm
> > *not* going to add 2000 lines of code for 500msec speedup during
> > suspend.
> 
> Lucky you.  My machine takes minutes.
> (To be precise, it prints about a line and a half of dots in the
> count_data_pages() loop, and often takes 2 seconds per dot.)
> 
> AMD Athlon XP, 1066 MHz, 768K RAM, VIA KT133 chipset.
> Stock 2.6.10-rc1.
> 
> I could really use a speedup.

Yep, that's O(n^2) algorithm slowing it down. I have fix for it, but
2.6.10 is now too frozen for performance fix to go in. See "bigdiff" I
sent to hugang, or wait few minutes and you'll get really ugly diff in
private email, that should solve it, too.

[I'll be glad when you report results. It should make count_data_pages
< 1 second].

> if nothing else.  But complaining that it doesn't annoy *you* isn't the
> most valid argument.

Ok, it is the scale. Half a second speedup is not enough to justify
new compression algorithm in the kernel.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
