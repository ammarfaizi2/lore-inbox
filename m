Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUK1RGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUK1RGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUK1REk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:04:40 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:54657 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261530AbUK1RDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:03:42 -0500
Date: Sun, 28 Nov 2004 18:03:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [2/6]
Message-ID: <20041128170324.GB1214@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com> <20041128162412.GB28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162412.GB28881@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -222,8 +221,105 @@ static void lock_swapdevices(void)
>  		}
>  	swap_list_unlock();
>  }
> +	
> +#define ONE_PAGE_PBE_NUM	(PAGE_SIZE/sizeof(struct pbe))
> +#define PBE_IS_PAGE_END(x)  \
> +	( PAGE_SIZE - sizeof(struct pbe) == ((x) - ((~(PAGE_SIZE - 1)) & (x))) )
> +
> +#define pgdir_for_each_safe(pos, n, head) \
> +	for(pos = head, n = pos ? (suspend_pagedir_t*)pos->dummy.val : NULL; \
> +		pos != NULL; \
> +		pos = n, n = pos ? (suspend_pagedir_t *)pos->dummy.val : NULL)
> +
> +#define pbe_for_each_safe(pos, n, index, max, head) \
> +	for(pos = head, index = 0, \
> +			n = pos ? (struct pbe *)pos->dummy.val : NULL; \
> +		(pos != NULL) && (index < max); \
> +		pos = (PBE_IS_PAGE_END((unsigned long)pos)) ? n : \
> +			((struct pbe *)((unsigned long)pos + sizeof(struct pbe))), \
> +			index ++, \
> +			n = pos ? (struct pbe*)pos->dummy.val : NULL)
> +

_safe suffix means it is safe to delete while traversing. I do not
think your macros can handle that, so you should not have _safe
suffix.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
