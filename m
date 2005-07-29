Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVG2KOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVG2KOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVG2KLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:11:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:463 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262554AbVG2KJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:09:08 -0400
Date: Fri, 29 Jul 2005 12:08:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c : prefetchw the start of new allocated objects
Message-ID: <20050729100813.GA16129@elte.hu>
References: <42E6C8DB.4090608@earthlink.net> <s5hr7dklko4.wl%tiwai@suse.de> <42E7A8D8.1030809@earthlink.net> <20050729014150.6e97dfd2.akpm@osdl.org> <42E9F145.7040302@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E9F145.7040302@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

>  	local_irq_restore(save_flags);
>  	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
> +	prefetchw(objp);
>  	return objp;

the idea is good, but i'd suggest to do the prefetchw a bit earlier, 
right where we calculate objp. Furthermore, it might make sense to only 
trigger the prefetchw in the alloc-miss (non-per-CPU cache) case. There 
it's almost surely a win, in the per-CPU cache case it's not always.

	Ingo
