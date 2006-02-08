Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWBHHB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWBHHB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWBHHB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:01:58 -0500
Received: from cabal.ca ([134.117.69.58]:52907 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161023AbWBHHB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:01:57 -0500
Date: Wed, 8 Feb 2006 02:00:31 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unify pfn_to_page take 2 [1/25] generic funcs
Message-ID: <20060208070031.GA21184@quicksilver.road.mcmartin.ca>
References: <43E98482.2090305@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E98482.2090305@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 02:41:22PM +0900, KAMEZAWA Hiroyuki wrote:
> +#ifndef CONFIG_ARCH_HAS_PFN_TO_PAGE
> +/*

Since this file is entirely conditionalized on ARCH_HAS_PFN_TO_PAGE,
might it be better to put this in asm-generic/ and include it from
an asm- header instead of adding yet another ARCH_HAS_ define?

This way, m68k (iirc?) could just not include that header, and not
worry about this define.

Then again, adding the include to every arches headers likely offsets
some of the C code reduction. However, it's still a win on the unified
definition and long term maintainability angle. Perhaps someone more
authoritative than little old me, could cast judgement on this.

> [...]
> +#ifdef CONFIG_DONT_INLINE_PFN_TO_PAGE
> +
> +/* not-inlined version for some archs. funcs are defined in 
> mm/page_alloc.c */
> +extern unsigned long page_to_pfn(struct page *page);
> +extern struct page *pfn_to_page(unsigned long pfn);
> +
> +#else
> +

Commenting this #else might improve readability.

Cheers!
	Kyle
