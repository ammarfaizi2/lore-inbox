Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVLBA5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVLBA5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVLBA5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:57:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46794 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932585AbVLBA5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:57:23 -0500
Date: Fri, 2 Dec 2005 01:55:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Message-ID: <20051202005514.GA1770@elf.ucw.cz>
References: <20051201173649.GA22168@hexapodia.org> <200512012242.44995.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512012242.44995.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> > 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> > successful suspend/resume cycles.  But now that I'm running
> > 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:
> 
> Thanks a lot for the report.
> 
> The problem is apparently caused by my recent patch intended to speed up
> suspend.  Could you please apply the appended debug patch, try to reproduce
> the problem and send full dmesg output back to me?
> 
> Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-01 22:13:17.000000000 +0100
> +++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-01 22:24:56.000000000 +0100
> @@ -635,12 +635,18 @@
>  	printk("Shrinking memory...  ");
>  	do {
>  #ifdef FAST_FREE
> -		tmp = count_data_pages() + count_highmem_pages();
> +		tmp = count_data_pages();
> +		printk("Data pages: %ld\n", tmp);
> +		tmp += count_highmem_pages();

You need at least count_data_pages() + 2*count_highmem_pages() free
pages (in lowmem).

								Pavel
-- 
Thanks, Sharp!
