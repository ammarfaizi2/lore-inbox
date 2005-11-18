Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbVKRMMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbVKRMMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVKRMMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:12:18 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:26807 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161066AbVKRMMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:12:18 -0500
Date: Fri, 18 Nov 2005 20:12:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 04/16] radix-tree: look-aside cache
Message-ID: <20051118121213.GA3807@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051109134938.757187000@localhost.localdomain> <20051109141448.974675000@localhost.localdomain> <437286BD.4000107@yahoo.com.au> <20051110052538.GA6585@mail.ustc.edu.cn> <4372EDA1.3000103@yahoo.com.au> <20051118112501.GB6401@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118112501.GB6401@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 07:25:01PM +0800, Wu Fengguang wrote:
> I run two rounds of oprofile on the context based method, which is the user of
> radix_tree_lookup_{head,tail}, which take advantage of the look-aside cache.
> This is the diffprofile grep output(disable vs. enable cache):
> 
> radixtree-lookaside-cache.diffprofile1:        -8   -53.3% radix_tree_lookup_head
> radixtree-lookaside-cache.diffprofile1:       -30    -7.8% radix_tree_lookup_node
> radixtree-lookaside-cache.diffprofile1:       -34   -18.9% radix_tree_insert
> 
> radixtree-lookaside-cache.diffprofile2:        16    10.9% radix_tree_insert
> radixtree-lookaside-cache.diffprofile2:        12    18.8% radix_tree_preload
> radixtree-lookaside-cache.diffprofile2:         6    42.9% radix_tree_lookup_tail
> radixtree-lookaside-cache.diffprofile2:        -7   -63.6% radix_tree_lookup_head
> radixtree-lookaside-cache.diffprofile2:       -23   -10.5% radix_tree_delete
> radixtree-lookaside-cache.diffprofile2:       -29    -6.9% radix_tree_lookup_node

The above profile data are gathered on comparing two big files:

# du /temp/kernel/bigfile*
626M    /temp/kernel/bigfile
626M    /temp/kernel/bigfile2

I run another real life test:

# grep -r 'asdfghjkl;' /backup/test/linux-2.6.14-rc4-git4-orig/

radixtree-lookaside-cache.diffprofile3:        16    43.2% radix_tree_tag_clear
radixtree-lookaside-cache.diffprofile3:         8    24.2% radix_tree_tag_set
radixtree-lookaside-cache.diffprofile3:        -9    -5.8% radix_tree_lookup_node

radixtree-lookaside-cache.diffprofile4:         7     4.5% radix_tree_lookup_node
radixtree-lookaside-cache.diffprofile4:        -8   -11.8% radix_tree_tag_clear

As expected, there's no noticable difference for small files.

Regards,
Wu
