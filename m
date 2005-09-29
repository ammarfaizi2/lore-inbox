Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVI2Nnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVI2Nnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVI2Nni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:43:38 -0400
Received: from mail.suse.de ([195.135.220.2]:52660 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932157AbVI2Nni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:43:38 -0400
Date: Thu, 29 Sep 2005 15:43:37 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [NUMA , x86_64] Why memnode_shift is chosen with the lowest possible value ?
Message-ID: <20050929134337.GF2720@wotan.suse.de>
References: <1127939141.26401.32.camel@localhost.localdomain> <1127939593.26401.38.camel@localhost.localdomain> <20050928232027.28e1bb93.akpm@osdl.org> <p73k6h0jjh3.fsf@verdi.suse.de> <433BEED6.6000008@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433BEED6.6000008@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using memnode_shift=33 would access only 2 bytes from this memnodemap[], 
> touching fewer cache lines (well , one cache line). kfree() and friends 
> would be slightly faster, at least cache friendly.

Agreed. Please send a patch.

> 
> Another question is :
> 
> Could we add in pda (struct x8664_pda) the node of the cpu ?
> 
> We currently do :
> 
> #define numa_node_id()             (cpu_to_node(raw_smp_processor_id()))
> 
> Instead of reading the processor_id from pda, then access cpu_to_node[], we 
> could directly get this information from pda.
> 
> #if defined(CONFIG_NUMA)
> static inline __attribute_pure__ int numa_node_id() { return 
> read_pda(node);}
> #else
> #define numa_node_id()             0
> #endif

Should be fine too. Please send a patch for that too.

-Andi

