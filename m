Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVIIORt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVIIORt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVIIORt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:17:49 -0400
Received: from mx1.suse.de ([195.135.220.2]:38357 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964908AbVIIORt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:17:49 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2.6.13] x86_64: Make trap_init() happen earlier - dropped
Date: Fri, 9 Sep 2005 16:17:40 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bob Picco <bob.picco@hp.com>
References: <20050908163757.GQ3966@smtp.west.cox.net>
In-Reply-To: <20050908163757.GQ3966@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091617.40770.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:37, Tom Rini wrote:
> It can be handy in some situations to have run trap_init() sooner than the
> generic code does.  In order to do this on x86_64 we need to add a custom
> early_setup_per_cpu_areas() call as well.

The patch is totally broken and causes crash even under light load
(just found it after a lengthy binary search) 

>
> +void __init early_setup_per_cpu_areas(void)
> +{
> +	static char cpu0[PERCPU_ENOUGH_ROOM] __cacheline_aligned
> +		__attribute__ ((aligned (SMP_CACHE_BYTES)));

The original code does

    /* Copy section for each CPU (we discard the original) */
        size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
#ifdef CONFIG_MODULES
        if (size < PERCPU_ENOUGH_ROOM)
                size = PERCPU_ENOUGH_ROOM;
#endif


perhaps end-start is larger than PERCPU_ENOUGH_ROOM ? (using defconfig) 

Dropped from my tree for now.

-Andi

