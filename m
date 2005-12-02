Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVLBCSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVLBCSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVLBCSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:18:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14445
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964789AbVLBCSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:18:14 -0500
Date: Fri, 2 Dec 2005 03:18:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202021811.GB28539@opteron.random>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201173015.675f4d80.akpm@osdl.org> <20051202020407.GA4445@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202020407.GA4445@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 10:04:07AM +0800, Wu Fengguang wrote:
> btw, maybe it's time to lower the low_mem_reserve.
> There should be no need to keep ~50M free memory with the balancing patch.

low_mem_reserve is indipendent from shrink_cache, because shrink_cache can't
free unfreeable pinned memory.

If you want to remove low_mem_reserve you'd better start by adding
migration of memory across the zones with pte updates etc... That would
at least mitigate the effect of anonymous memory w/o swap. But
low_mem_reserve is still needed for all other kind of allocations like
kmalloc or pci_alloc_consistent (i.e. not relocatable) etc...
