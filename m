Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTDMOaU (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTDMOaU (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:30:20 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:58088 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263517AbTDMOaT (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 10:30:19 -0400
Date: Sun, 13 Apr 2003 15:12:32 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-ID: <20030413151232.D672@nightmaster.csn.tu-chemnitz.de>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030412180852.77b6c5e8.akpm@digeo.com>; from akpm@digeo.com on Sat, Apr 12, 2003 at 06:08:52PM -0700
X-Spam-Score: -29.3 (-----------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *194igH-0001b4-00*OBpRn66DKU.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
hi lists readers,

On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
> +gfp_repeat.patch
> 
>  Implement __GFP_REPEAT: so we can consolidate lots of alloc-with-retry code.

What about reworking the semantics of kmalloc()?

Many users of kmalloc get the flags and size reversed (major
source of hard to find bugs), so wouldn't it be simpler to have:

__kmalloc() /* The old kmalloc()*/

kmalloc()               /* kmalloc(, GFP_KERNEL) */
kmalloc_user()          /* kmalloc(, GFP_USER) */
kmalloc_dma()           /* kmalloc(, GFP_KERNEL | GFP_DMA) */
kmalloc_dma_repeat()    /* kmalloc(, GFP_KERNEL | GFP_DMA | __GFP_REPEAT) */
kmalloc_repeat()        /* kmalloc(, GFP_KERNEL | __GFP_REPEAT) */
kmalloc_atomic()        /* kmalloc(, GFP_ATOMIC) */
kmalloc_atomic_dma()    /* kmalloc(, GFP_ATOMIC | GFP_DMA) */

an so on? These functions will of course just be static inline
wrappers for __kmalloc().

These functions above would just take a size and not confuse
programmers anymore (as prototypes with compatible arguments
usally do).

If it's just a matter of "nobody had the time do do it, yet",
than this is doable, if only slowly.

If this is considered nonsense, then I will shut-up.

What do you think?

Regards

Ingo Oeser
