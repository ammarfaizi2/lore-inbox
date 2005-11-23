Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVKWGgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVKWGgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKWGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:36:47 -0500
Received: from graphe.net ([209.204.138.32]:35712 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S1030329AbVKWGgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:36:47 -0500
Date: Tue, 22 Nov 2005 22:36:41 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Rohit Seth <rohit.seth@intel.com>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <20051122213612.4adef5d0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511222231070.2084@graphe.net>
References: <20051122161000.A22430@unix-os.sc.intel.com>
 <20051122213612.4adef5d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Andrew Morton wrote:

> > [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> > local pcp lists when a higher order allocation request is not able to 
> > get serviced from global free_list.
> > 
> > This should help fix some of the earlier failures seen with order 1 allocations.
> > 
> > I will send separate patches for:
> > 
> > 1- Reducing the remote cpus pcp

That is already partially done by drain_remote_pages(). However, that 
draining is specific to this processors remote pagesets in remote 
zones.

> This significantly duplicates the existing drain_local_pages().

We need to extract __drain_pcp from all these functions and clearly 
document how they differ. Seth probably needs to call __drain_pages for 
each processor.
