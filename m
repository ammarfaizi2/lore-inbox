Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUIYKPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUIYKPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 06:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269303AbUIYKPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 06:15:43 -0400
Received: from gprs214-249.eurotel.cz ([160.218.214.249]:50052 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269301AbUIYKPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 06:15:35 -0400
Date: Sat, 25 Sep 2004 12:15:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040925101522.GA4039@elf.ucw.cz>
References: <20040924021956.98FB5A315A@voldemort.scrye.com> <20040924143714.GA826@openzaurus.ucw.cz> <20040924210958.A3C5AA2073@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924210958.A3C5AA2073@voldemort.scrye.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Was trying to swsusp my 2.6.9-rc2-mm1 laptop tonight. It churned
> >> for a while, but didn't hibernate. Here are the messages.
> >> 
> >> ....................................................................................................
> >> .........................swsusp: Need to copy 34850 pages Sep 23
> >> 16:53:37 voldemort kernel: hibernate: page allocation
> >> failure. order:8, mode:0x120 Sep 23 16:53:37 voldemort kernel:
> Pavel> Out of memory... Try again with less loaded system. 
> 
> The system was no more loaded than usual. I have 1GB memory and 4GB of
> swap defined. I almost never touch swap. It might have been 100mb into
> the 4Gb of swap when this happened. 
> 
> What would cause it to be out of memory? 
> swsup needs to be reliable... rebooting when you are using your memory
> kinda defeats the purpose of swsusp. 

Read FAQ.

> Felipe W Damasio <felipewd@terra.com.br> sent me a patch, but I
> haven't had a chance to try it yet:
> 
> - --- linux-2.6.9-rc2-mm2/kernel/power/swsusp.c.orig	2004-09-23 23:46:49.292975768 -0300
> +++ linux-2.6.9-rc2-mm2/kernel/power/swsusp.c	2004-09-24 00:07:01.933626368 -0300
> @@ -657,6 +657,9 @@
>  	int diff = 0;
>  	int order = 0;
>  
> +	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
> +	nr_copy_pages += 1 << order;
> +
>  	do {
>  		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
>  		if (diff) {
> 
> 

That does not look like it could help. I do not see why this patch
should be good thing.
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
