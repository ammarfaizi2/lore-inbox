Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263660AbSJHUZo>; Tue, 8 Oct 2002 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263638AbSJHUZQ>; Tue, 8 Oct 2002 16:25:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:18692 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263660AbSJHUX6>;
	Tue, 8 Oct 2002 16:23:58 -0400
Date: Tue, 8 Oct 2002 22:28:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.41
Message-ID: <20021008222845.C296@elf.ucw.cz>
References: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com> <Pine.NEB.4.44.0210081359280.8340-100000@mimas.fachschaften.tu-muenchen.de> <20021008134107.GH12432@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008134107.GH12432@holomorphy.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This change causes the following compile error with CONFIG_DISCONTIGMEM
> > enabled:
> > kernel/suspend.c: In function `count_and_copy_data_pages':
> > kernel/suspend.c:479: `max_mapnr' undeclared (first use in this function)
> > kernel/suspend.c:479: (Each undeclared identifier is reported only once
> > kernel/suspend.c:479: for each function it appears in.)
> > make[1]: *** [kernel/suspend.o] Error 1
> > make: *** [kernel] Error 2
> 
> max_mapnr must die. It's mostly buggy largely because it's not what
> people think it is. Most of the time people want max_pfn, and the rest
> they don't want it at all.

It seems more logical now.

> Pavel, you might also want to make config options conflict instead of
> panicking.

Actually, I think I prefer panic(). That way it will be less broken
when someone will try to fix discontigmem.

> diff -urN linux-2.5.41/kernel/suspend.c swsusp-2.5.41/kernel/suspend.c
> --- linux-2.5.41/kernel/suspend.c	2002-10-07 11:23:37.000000000 -0700
> +++ swsusp-2.5.41/kernel/suspend.c	2002-10-08 06:16:54.000000000 -0700
> @@ -474,9 +474,9 @@
>  #ifdef CONFIG_DISCONTIGMEM
>  	panic("Discontingmem not supported");
>  #else
> -	BUG_ON (max_mapnr != num_physpages);
> +	BUG_ON (max_pfn != num_physpages);
>  #endif
> -	for (pfn = 0; pfn < max_mapnr; pfn++) {
> +	for (pfn = 0; pfn < max_pfn; pfn++) {
>  		page = pfn_to_page(pfn);
>  		if (PageHighMem(page))
>  			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");

Applied.

								Pavel
-- 
When do you have heart between your knees?
