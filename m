Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWFZSYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWFZSYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWFZSYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:24:55 -0400
Received: from fmr17.intel.com ([134.134.136.16]:38324 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932619AbWFZSYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:24:54 -0400
Message-ID: <44A02642.2030308@ichips.intel.com>
Date: Mon, 26 Jun 2006 11:24:02 -0700
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>, Roland Dreier <rdreier@cisco.com>,
       torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Array overrun in drivers/infiniband/core/cma.c
References: <1150916186.23613.1.camel@alice>
In-Reply-To: <1150916186.23613.1.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn wrote:
> this was spotted by coverity #id 1300. Since
> the array has only four elements, we should 
> just use those four.
> 
> Patch is against todays git tree.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Acked-by: Sean Hefty <sean.hefty@intel.com>

please apply Eric's patch below

> --- linux-2.6/drivers/infiniband/core/cma.c.orig	2006-06-21 20:54:10.000000000 +0200
> +++ linux-2.6/drivers/infiniband/core/cma.c	2006-06-21 20:54:22.000000000 +0200
> @@ -476,7 +476,7 @@ static inline int cma_zero_addr(struct s
>  	else {
>  		ip6 = &((struct sockaddr_in6 *) addr)->sin6_addr;
>  		return (ip6->s6_addr32[0] | ip6->s6_addr32[1] |
> -			ip6->s6_addr32[3] | ip6->s6_addr32[4]) == 0;
> +			ip6->s6_addr32[2] | ip6->s6_addr32[3]) == 0;
>  	}
>  }
>  
> 

