Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVDMBaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVDMBaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVDMB2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:28:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbVDLT5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:57:20 -0400
Date: Tue, 12 Apr 2005 12:57:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 3/9] no PF_MEMALLOC tinkering
Message-Id: <20050412125701.40fe5c70.akpm@osdl.org>
In-Reply-To: <425BC3D2.3020909@yahoo.com.au>
References: <425BC262.1070500@yahoo.com.au>
	<425BC3D2.3020909@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> PF_MEMALLOC is really not a tool for tinkering. It is pretty specifically
>  used to prevent recursion into page reclaim, and to prevent low memory
>  deadlocks.
> 
>  The mm/swap_state.c code was the only legitimate tinkerer. Its concern
>  was addressed by the previous patch.

What previous patch?  radix tree allocation doesn't use mempools, so this
patch will cause add_to_swap() to oom the machine with radix tree node
allocations.

Now if we were to add __GFP_NOMEMALLOC in add_to_swap() then things would
work as we want them to.


The dm_crypt change looks OK.


The code in mpage.c is saying "if we failed to allocate a correctly-sized
bvec and if we're doing pageout then try to allocate a smaller-sized bvec
instead".

It's probably fairly useless, but afaict there's nothing in any of the
other patches here which makes it redundant.


