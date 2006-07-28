Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWG1NTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWG1NTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWG1NTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:19:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49024 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030268AbWG1NTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:19:10 -0400
Date: Fri, 28 Jul 2006 15:13:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] bootmem: use MAX_DMA_ADDRESS instead of LOW32LIMIT
Message-ID: <20060728131306.GA32513@elte.hu>
References: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> __alloc_bootmem_low() and __alloc_bootmem_low_node() should use 
> MAX_DMA_ADDRESS as limit which is per architecture instead of a global 
> LOW32LIMIT. Otherwise the bootmem allocator may return addresses to 
> memory regions which cannot be used for DMA access.

> -#define LOW32LIMIT 0xffffffff

>  		if ((ptr = __alloc_bootmem_core(bdata, size,
> -						 align, goal, LOW32LIMIT)))
> +						 align, goal, MAX_DMA_ADDRESS)))

but this limits things to 16MB on i686. Are you sure this wont break 
anything?

	Ingo
