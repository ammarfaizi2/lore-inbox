Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272858AbTHPMGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 08:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272867AbTHPMGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 08:06:06 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:56263 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S272858AbTHPMGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 08:06:04 -0400
Message-Id: <200308161205.h7GC5vlP005512@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BUG] slab debug vs. L1 alignement
To: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 16 Aug 2003 14:00:00 +0200
References: <kUMe.2pd.9@gated-at.bofh.it> <kWuz.41M.5@gated-at.bofh.it> <kYwo.5Xr.1@gated-at.bofh.it> <l5HD.4tl.21@gated-at.bofh.it> <l6kd.53T.1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Benjamin Herrenschmidt wrote:
> 
>>Same for ppc32. Anyway, I don't like MUST_HWCACHE_ALIGN because it
>>just disables redzoning, I'd rather allocate more and do both redzoning
>>and cache alignement.
>>  
>>
> I have a patch that creates helper functions that make that simple. The 
> patch is stuck right now, because it exposes a bug in the i386 debug 
> register handling. I'll add it redzoning with MUST_HWCACHE_ALIGN after 
> that one is in.

I have a related problem on s390: Some of my GFP_DMA data must be 8 byte
aligned, while my cache lines are 256 bytes wide. With slab debugging,
the whole structure is only 4 byte aligned and I get addressing exceptions.

When I go to MUST_HWCACHE_ALIGN, the data already grows from ~100 Bytes to
a full cache line, adding redzoning would make it far worse.

Is it possible to make kmem_cache_create accept a user specified alignment
parameter? I suppose there are other cases where you want to force
a specific alignment that is different from the L1 cache lines.

        Arnd <><
