Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVLGMcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVLGMcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVLGMcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:32:51 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:4024 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750948AbVLGMcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:32:50 -0500
Date: Wed, 7 Dec 2005 20:59:33 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 06/16] mm: balance slab aging
Message-ID: <20051207125933.GA5355@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207105019.800865000@localhost.localdomain> <20051207110840.GC7570@mail.ustc.edu.cn> <4396C8B3.1020908@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396C8B3.1020908@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:34:11PM +1100, Nick Piggin wrote:
> Wu Fengguang wrote:
> >A question about the current one:
> >
> >For a NUMA system with N nodes, the way kswapd calculates lru_pages - only 
> >sum
> >up local zones - may cause N times more shrinking than a 1-CPU system.
> >
> 
> But it is equal pressure for all pools involved in being scaned the
> simplifying assumption is that slab is equally distributed among
> nodes. And yeah, scanning would load up when more than 1 kswapd is
> running.
> 
> I had patches to do per-zone inode and dentry slab shrinking ages
> ago, but nobody was interested... so I'm guessing it is a feature :)

I rechecked shrink_dcache_memory()/prune_dcache(), it seems to be operating in
a global manner, which means (conceptually) if 10 nodes each scans 10%, the
global dcache is scanned 100%. Isn't it crazy? ;)

Thanks,
Wu
