Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVCOXkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVCOXkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVCOXke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:40:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12966 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262126AbVCOXh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:37:56 -0500
Date: Wed, 16 Mar 2005 00:37:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add freezer call in
Message-ID: <20050315233740.GE21292@elf.ucw.cz>
References: <1110925280.6454.143.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110925280.6454.143.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds a freezer call to the slow path in __alloc_pages. It
> thus avoids freezing failures in low memory situations. Like the other
> patches, it has been in Suspend2 for longer than I can remember.

This one seems wrong.

What if someone does

	down(&some_lock_needed_during_suspend);
	kmalloc()

? If you freeze him during that allocation, you'll deadlock later...

								Pavel


> Signed-of-by: Nigel Cunningham <ncunningham@cyclades.com>
> 
> diff -ruNp 213-missing-refrigerator-calls-old/mm/page_alloc.c 213-missing-refrigerator-calls-new/mm/page_alloc.c
> --- 213-missing-refrigerator-calls-old/mm/page_alloc.c	2005-02-03 22:33:50.000000000 +1100
> +++ 213-missing-refrigerator-calls-new/mm/page_alloc.c	2005-03-16 09:01:28.000000000 +1100
> @@ -838,6 +838,7 @@ rebalance:
>  			do_retry = 1;
>  	}
>  	if (do_retry) {
> +		try_to_freeze(0);
>  		blk_congestion_wait(WRITE, HZ/50);
>  		goto rebalance;
>  	}


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
