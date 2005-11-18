Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVKRLX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVKRLX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVKRLXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:23:25 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:27601 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161031AbVKRLXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:23:25 -0500
Date: Fri, 18 Nov 2005 19:25:01 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 04/16] radix-tree: look-aside cache
Message-ID: <20051118112501.GB6401@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051109134938.757187000@localhost.localdomain> <20051109141448.974675000@localhost.localdomain> <437286BD.4000107@yahoo.com.au> <20051110052538.GA6585@mail.ustc.edu.cn> <4372EDA1.3000103@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4372EDA1.3000103@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Nov 10, 2005 at 05:50:09PM +1100, Nick Piggin wrote:
> Profile numbers would be great for the cached / non-cached cases.

Sorry for the delay!

I run two rounds of oprofile on the context based method, which is the user of
radix_tree_lookup_{head,tail}, which take advantage of the look-aside cache.
This is the diffprofile grep output(disable vs. enable cache):

radixtree-lookaside-cache.diffprofile1:        -8   -53.3% radix_tree_lookup_head
radixtree-lookaside-cache.diffprofile1:       -30    -7.8% radix_tree_lookup_node
radixtree-lookaside-cache.diffprofile1:       -34   -18.9% radix_tree_insert

radixtree-lookaside-cache.diffprofile2:        16    10.9% radix_tree_insert
radixtree-lookaside-cache.diffprofile2:        12    18.8% radix_tree_preload
radixtree-lookaside-cache.diffprofile2:         6    42.9% radix_tree_lookup_tail
radixtree-lookaside-cache.diffprofile2:        -7   -63.6% radix_tree_lookup_head
radixtree-lookaside-cache.diffprofile2:       -23   -10.5% radix_tree_delete
radixtree-lookaside-cache.diffprofile2:       -29    -6.9% radix_tree_lookup_node

Regards,
Wu
