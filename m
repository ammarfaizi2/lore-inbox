Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUBVG5W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUBVG5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:57:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:37255 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbUBVG5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:57:21 -0500
Date: Sat, 21 Feb 2004 22:57:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: mfedyk@matchmail.com, cw@f00f.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040221225746.31907f86.akpm@osdl.org>
In-Reply-To: <40384D9D.6040604@cyberone.com.au>
References: <4037FCDA.4060501@matchmail.com>
	<20040222023638.GA13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
	<20040222031113.GB13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
	<20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
	<40383300.5010203@matchmail.com>
	<4038402A.4030708@cyberone.com.au>
	<40384325.1010802@matchmail.com>
	<403845CB.8040805@cyberone.com.au>
	<20040221221721.42e734d6.akpm@osdl.org>
	<40384D9D.6040604@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> Can you maybe use this patch then, please?

OK.

> +static unsigned int nr_lowmem_lru_pages(void)

heh, that's what I called it.

> + * Total number of items in each slab should be used, not just freeable ones.
> + * Unfreeable slab items should not count toward the scanning total.

That's up to the individual shrinkers.  What we have for dcache and icache
is close enough.  Most entries on inode_unused and dentry_unused should be
reclaimable, but checking that with some instrumentation wouldn't hurt.

> +		if (i < ZONE_HIGHMEM)
> +			*lowmem_scanned += nr_scanned;

yup.


