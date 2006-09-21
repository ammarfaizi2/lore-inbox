Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWIUVcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWIUVcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWIUVcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:32:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16039 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750816AbWIUVcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:32:54 -0400
Date: Thu, 21 Sep 2006 23:32:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060921213253.GF2245@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609202154.39377.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202154.39377.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-09-20 21:54:38, Rafael J. Wysocki wrote:
> In order to use a swap file with swsusp we need to know the offset at which
> its swap header is located.  However, the swap header is always located in the
> first block of the swap file and it's quite easy to make sys_swapon() print
> the offset of the swap file's (or swap partition's) first block.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

(main point of this is that it changes user-visible printk, but that's
probably okay, and way better than changing /proc files...)
								Pavel
> @@ -1628,9 +1632,10 @@ asmlinkage long sys_swapon(const char __
>  	total_swap_pages += nr_good_pages;
>  
>  	printk(KERN_INFO "Adding %uk swap on %s.  "
> -			"Priority:%d extents:%d across:%lluk\n",
> +			"Priority:%d extents:%d across:%lluk offset:%llu\n",
>  		nr_good_pages<<(PAGE_SHIFT-10), name, p->prio,
> -		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10));
> +		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
> +		(unsigned long long)start);
>  
>  	/* insert swap space into swap_list: */
>  	prev = -1;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
