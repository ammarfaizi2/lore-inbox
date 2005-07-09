Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVGILud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVGILud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVGILua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:50:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15791 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261211AbVGILu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:50:27 -0400
Date: Sat, 9 Jul 2005 13:49:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [9/48] Suspend2 2.1.9.8 for 2.6.12: 354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch
Message-ID: <20050709114936.GA1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164401343@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164401343@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ruNp 360-reset-kswapd-max-order-after-resume.patch-old/mm/vmscan.c 360-reset-kswapd-max-order-after-resume.patch-new/mm/vmscan.c
> --- 360-reset-kswapd-max-order-after-resume.patch-old/mm/vmscan.c	2005-07-06 11:18:05.000000000 +1000
> +++ 360-reset-kswapd-max-order-after-resume.patch-new/mm/vmscan.c	2005-07-04 23:14:20.000000000 +1000
> @@ -1228,8 +1228,10 @@ static int kswapd(void *p)
>  	order = 0;
>  	for ( ; ; ) {
>  		unsigned long new_order;
> -
> -		try_to_freeze();
> +		if (freezing(current)) {
> +			try_to_freeze();
> +			pgdat->kswapd_max_order = 0;
> +		}

Why not
	if (try_to_freeze())
		pgdat->... = 0;

?
							Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
