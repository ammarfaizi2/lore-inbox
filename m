Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031302AbWI1Al0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031302AbWI1Al0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031304AbWI1AlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:41:25 -0400
Received: from mga05.intel.com ([192.55.52.89]:51378 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1031088AbWI1AlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:41:24 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,226,1157353200"; 
   d="scan'208"; a="138568150:sNHT64668485"
Date: Wed, 27 Sep 2006 17:23:55 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: David Miller <davem@davemloft.net>
Cc: suresh.b.siddha@intel.com, akpm@osdl.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org, asit.k.mallick@intel.com
Subject: Re: [patch] mm: fix a race condition under SMC + COW
Message-ID: <20060927172355.B12423@unix-os.sc.intel.com>
References: <20060927151507.A12423@unix-os.sc.intel.com> <20060927.155442.71092068.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060927.155442.71092068.davem@davemloft.net>; from davem@davemloft.net on Wed, Sep 27, 2006 at 03:54:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 03:54:42PM -0700, David Miller wrote:
> You can't really do a set_pte_at() in this code path because
> there isn't a subsequent flush_tlb_*().
> 
> This is needed because some architectures queue up all set_pte_at()
> calls until the next flush_tlb_*() in order to batch TLB flushes.
> PowerPC and Sparc64 both do this.
> 
> The pte_establish() in the existing code works fine because it takes
> care of the set_pte_at() and flush_tlb_*() work internally when
> necessary on a given platform.

I am flushing the pte entry in ptep_clear_flush() and it is Ok not
to do another TLB flush after doing set_pte_at().

On Sparc64, this new set_pte_at() (after ptep_clear_flush) will not batch
any TLB flush as the previous pte contents were zero.

We are Ok with this patch, isn't it?

thanks,
suresh
