Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031331AbWI1Bzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031331AbWI1Bzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031332AbWI1Bzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:55:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62136
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031331AbWI1Bzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:55:42 -0400
Date: Wed, 27 Sep 2006 18:55:41 -0700 (PDT)
Message-Id: <20060927.185541.02300409.davem@davemloft.net>
To: suresh.b.siddha@intel.com
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       asit.k.mallick@intel.com
Subject: Re: [patch] mm: fix a race condition under SMC + COW
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060927172355.B12423@unix-os.sc.intel.com>
References: <20060927151507.A12423@unix-os.sc.intel.com>
	<20060927.155442.71092068.davem@davemloft.net>
	<20060927172355.B12423@unix-os.sc.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Date: Wed, 27 Sep 2006 17:23:55 -0700

> I am flushing the pte entry in ptep_clear_flush() and it is Ok not
> to do another TLB flush after doing set_pte_at().
> 
> On Sparc64, this new set_pte_at() (after ptep_clear_flush) will not batch
> any TLB flush as the previous pte contents were zero.
> 
> We are Ok with this patch, isn't it?

Ok, it seems PowerPC also has the "don't do anything if previous PTE
was zero" logic.  So yes, it should be ok.

