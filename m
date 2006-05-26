Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWEZUKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWEZUKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWEZUKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:10:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48773
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751411AbWEZUKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:10:51 -0400
Date: Fri, 26 May 2006 13:10:59 -0700 (PDT)
Message-Id: <20060526.131059.27783433.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] fix update_mmu_cache in fremap.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0605261926350.24818@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605261926350.24818@blonde.wat.veritas.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Fri, 26 May 2006 19:28:14 +0100 (BST)

> There are two calls to update_mmu_cache in fremap.c, both defective.
> The one in install_page needs to be accompanied by lazy_mmu_prot_update
> (some other cleanup time, move that into ia64 update_mmu_cache itself); and
> the one in install_file_pte should be removed since the pte is not present.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Where did that rule come from?  We should call update_mmu_cache() even
if the PTE was not present before, look at the fault path in
mm/memory.c, it does this too.

This is where we install hash table entries for newly installed
mappings on sparc64 and powerpc, so this update_mmu_cache() call
is important even for not-previously-present mappings.
