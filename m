Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWGKU4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWGKU4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWGKU4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:56:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2211
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751316AbWGKU4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:56:42 -0400
Date: Tue, 11 Jul 2006 13:57:29 -0700 (PDT)
Message-Id: <20060711.135729.104381402.davem@davemloft.net>
To: bos@serpentine.com
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
 keep cache pressure down
From: David Miller <davem@davemloft.net>
In-Reply-To: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@serpentine.com>
Date: Tue, 11 Jul 2006 13:50:55 -0700

> This copy routine is memcpy-compatible, but on some architectures will use
> cache-bypassing loads to avoid bringing the source data into the cache.
> 
> One case where this is useful is when a device issues a DMA to a memory
> region, and the CPU must copy the DMAed data elsewhere before doing any
> work with it.  Since the source data is read-once, write-never from the
> CPU's perspective, caching those addresses can only evict potentially
> useful data.
> 
> We provide an x86_64 implementation that uses SSE non-temporal loads,
> and a generic version that falls back to plain memcpy.
> 
> Implementors for other arches should not use cache-bypassing stores to
> the destination, as in most cases, the destination is accessed almost
> immediately after a copy finishes.
> 
> Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
> Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

Please don't use a weak attribute, and instead use the same
"__HAVE_ARCH_FOO" cpp test scheme used for the other string
operations to allow a platform to override the default
implementation in lib/string.x
