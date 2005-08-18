Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVHRHT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVHRHT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVHRHT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:19:26 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:34228
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1750905AbVHRHT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:19:26 -0400
Date: Thu, 18 Aug 2005 00:18:54 -0700 (PDT)
Message-Id: <20050818.001854.21765805.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: ak@suse.de, bcrl@linux.intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct file cleanup : the very large file_ra_state is
 now allocated only on demand.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43043567.3040204@cosmosbay.com>
References: <20050818010524.GW3996@wotan.suse.de>
	<20050817.194315.111196480.davem@davemloft.net>
	<43043567.3040204@cosmosbay.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Thu, 18 Aug 2005 09:14:47 +0200

> After reading your suggestions, I understand we still need two slabs.
> One (filp_cachep) without the readahead data, the other one
> (filp_ra_cachep) with it.

Correct.

> static inline struct file_ra_state *get_ra_state(struct file *f)
> {
> #ifdef CONFIG_DEBUG_READAHEAD
> 	BUG_ON(filp_ra_cachep != GET_PAGE_CACHE(virt_to_page(f)));
> #endif
> 	return (struct file_ra_state *)(f+1);
> }

Or, instead of mucking with SLAB internals, just put something like
a "filp_ra_present" debugging binary state into filp while it gets
debugged.

