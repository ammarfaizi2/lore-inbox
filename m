Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWCVRPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWCVRPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCVRPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:15:11 -0500
Received: from ns1.suse.de ([195.135.220.2]:22962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWCVRPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:15:10 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Cpuset: alloc_pages_node overrides cpuset constraints
Date: Wed, 22 Mar 2006 17:33:51 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <clameter@sgi.com>
References: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
In-Reply-To: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221733.51726.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 21:40, Paul Jackson wrote:

> --- 2.6.16-rc6.orig/kernel/cpuset.c	2006-03-13 20:19:36.000000000 -0800
> +++ 2.6.16-rc6/kernel/cpuset.c	2006-03-17 21:52:18.000000000 -0800
> @@ -2164,6 +2164,8 @@ int __cpuset_zone_allowed(struct zone *z
>  	node = z->zone_pgdat->node_id;
>  	if (node_isset(node, current->mems_allowed))
>  		return 1;
> +	if (gfp_mask & __GFP_NOCPUSET)
> +		return 1;
>  	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
>  		return 0;

Faster would be if (gfp_mask & (__GFP_NOCPUSET|__GFP_HARDWALL)) { /* sort them out */ } 
That would only give a single test for the common case of no such flag set.

-Andi

