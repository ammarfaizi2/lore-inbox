Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWEVWMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWEVWMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWEVWMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:12:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18922 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751227AbWEVWMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:12:43 -0400
Date: Mon, 22 May 2006 15:12:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       ak@suse.de, linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov,
       dsp@llnl.gov
Subject: Re: [PATCH (try #2)] mm: avoid unnecessary OOM kills
Message-Id: <20060522151227.37fd9e51.pj@sgi.com>
In-Reply-To: <200605222143.k4MLhs2w021071@calaveras.llnl.gov>
References: <200605222143.k4MLhs2w021071@calaveras.llnl.gov>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> -	if (printk_ratelimit()) {
> -		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
> -			gfp_mask, order);
> -		dump_stack();
> -		show_mem();
> -	}
> -
> +	printk("oom-killer: gfp_mask=0x%x, order=%d\n", gfp_mask, order);
> +	dump_stack();
> +	show_mem();

Why disable this printk_ratelimit?  Does this expose us to a Denial of
Service attack from someone forcing multiple oom-kills in a small
cpuset, generating much kernel printk output?

> +/* Try to allocate one more time before invoking the OOM killer. */
> +static struct page * oom_alloc(gfp_t gfp_mask, unsigned int order,

This comment is slightly stale.  Not only does oom_alloc() try one
more allocation, it also actually does invoke the OOM killer.

How about the comment:

   /* Serialize oom killing, while trying to allocate a page */

Or some such ..

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
