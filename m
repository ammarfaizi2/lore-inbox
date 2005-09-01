Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVIARlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVIARlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVIARlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:41:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3262 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030260AbVIARls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:41:48 -0400
Date: Thu, 1 Sep 2005 23:06:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] : struct dentry : place d_hash close to d_parent and d_name to speedup lookups
Message-ID: <20050901173634.GA4767@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050901035542.1c621af6.akpm@osdl.org> <431721F0.6090402@cosmosbay.com> <431722CC.8040204@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431722CC.8040204@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 05:48:28PM +0200, Eric Dumazet wrote:
> dentry cache uses sophisticated RCU technology (and prefetching if 
> available) but touches 2 cache lines per dentry during hlist lookup.
> 
> This patch moves d_hash in the same cache line than d_parent and d_name 
> fields so that :
> 
> 1) One cache line is needed instead of two.
> 2) the hlist_for_each_rcu() prefetching has a chance to bring all the 
> needed data in advance, not only the part that includes d_hash.next.
> 
> I also changed one old comment that was wrong for 64bits.
> 
> A further optimisation would be to separate dentry in two parts, one that 
> is mostly read, and one writen (d_count/d_lock) to avoid false sharing on 
> SMP/NUMA but this would need different field placement depending on 32bits 
> or 64bits platform.

Do you have performance numbers that show the benefits ? In the
past, I did try some optimizations like this but found no demonstrable
benefits. If it ain't broken .....

Thanks
Dipankar
