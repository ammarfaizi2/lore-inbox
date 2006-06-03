Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWFCUs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWFCUs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 16:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWFCUs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 16:48:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35089 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030339AbWFCUs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 16:48:57 -0400
Date: Sat, 3 Jun 2006 20:48:08 +0000
From: Pavel Machek <pavel@ucw.cz>
To: catalin.marinas@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc5 7/8] Remove some of the kmemleak false positives
Message-ID: <20060603204808.GB4629@ucw.cz>
References: <20060603081054.31915.4038.stgit@localhost.localdomain> <20060603081134.31915.37367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603081134.31915.37367.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> There are allocations for which the main pointer cannot be found but they
> are not memory leaks. This patch fixes some of them.

> @@ -1323,6 +1323,7 @@ legacy_init_iomem_resources(struct resou
>  		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
>  			continue;
>  		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
> +		memleak_debug_not_leak(res);

I'd suggest some shorter/more generic name.

	not_freed(res); ?

	alloc_forever(res); ?

-- 
Thanks for all the (sleeping) penguins.
