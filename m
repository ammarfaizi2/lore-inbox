Return-Path: <linux-kernel-owner+w=401wt.eu-S1755348AbXABQ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbXABQ1Y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbXABQ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:27:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46230 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754885AbXABQ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:27:23 -0500
Date: Tue, 2 Jan 2007 08:25:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
In-Reply-To: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0701020822230.15611@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Pekka J Enberg wrote:

> +
> +	if (nodeid == -1 || nodeid == numa_node_id()) {
> +		if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
> +			obj = alternate_node_alloc(cache, flags);
> +			if (obj)
> +				goto out;
> +		}

This reintroduces a bug that was fixed a while ago.

kmalloc_node() must never obey memory policies. 
Alternate_node_alloc implements memory policies.

With this patch kmalloc_node(...., numa_node_id()) would get redirected 
again to other nodes if a memory policy is in effect.

