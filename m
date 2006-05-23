Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWEWBYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWEWBYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWEWBYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:24:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55178 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750831AbWEWBYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:24:06 -0400
Date: Mon, 22 May 2006 18:23:56 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>
Subject: Re: cpusets: only wakeup kswapd for zones in the current cpuset
Message-Id: <20060522182356.fbea4aec.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three months ago, Christoph wrote:
> If we get under some memory pressure in a cpuset (we only scan zones
> that are in the cpuset for memory) then kswapd is woken
> up for all zones. This patch only wakes up kswapd in zones that are
> part of the current cpuset.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.16-rc2/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
> +++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 00:05:09.000000000 -0800
> @@ -923,7 +923,8 @@ restart:
>  		goto got_pg;
>  
>  	do {
> -		wakeup_kswapd(*z, order);
> +		if (cpuset_zone_allowed(*z, gfp_mask))
> +			wakeup_kswapd(*z, order);
>  	} while (*(++z));
>  
>  	/*
> 

Christoph,

Does this patch serve any use?  Chris Wright just noticed (in private
email) that wakeup_kswapd() already contains a check for cpuset
confinement, so it would seem the above added check is superfluous.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
