Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUG0CBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUG0CBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 22:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUG0CBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 22:01:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37803 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266212AbUG0CBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 22:01:41 -0400
Date: Mon, 26 Jul 2004 21:01:34 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Locking optimization for cache_reap
Message-ID: <20040727020134.GA23967@sgi.com>
References: <20040723190555.GB16956@sgi.com> <20040726180104.62c480c6.akpm@osdl.org> <20040727014757.GA23937@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727014757.GA23937@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 08:47:57PM -0500, Dimitri Sivanich wrote:
> 
> While you've got irq's disabled, drain_array() (the function my patch removes)
> acquires the cache spin_lock, then releases it.  Cache_reap then acquires
> it again (with irq's having been off the entire time).  My testing has found
> that simply acquiring the lock once while irq's are off results in fewer
> excessively long latencies.
> 
> Results probably vary somewhat depending on the circumstance.

Of course, I should add that all of this is from the perspective of the
cpu doing the cache_reap.  If others feel that this may add too much
latency to other paths, other solutions may be in order.
