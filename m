Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUDCFY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 00:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUDCFY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 00:24:57 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:61685 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261369AbUDCFYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 00:24:55 -0500
Date: Fri, 2 Apr 2004 21:23:50 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/23] mask v2 - Replace cpumask_t with one using mask
Message-Id: <20040402212350.547eb77d.pj@sgi.com>
In-Reply-To: <1080944675.9787.113.camel@arrakis>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131136.792495fa.pj@sgi.com>
	<1080944675.9787.113.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> a better way to do this for UP.
> +#define	cpu_online_map			\
> +({						\
> +	cpumask_t m = MASK_ALL1(NR_CPUS);	\
> +	m;					\
> +})

This only helps cpu_online_map and cpu_possible_map, and only on UP's.

My controversial patch 24/23 helps all MASK_ALL based initializations,
and all mask_of_bit based initializations, for all systems up to 32 CPUs
(or 64, depending on sizeof(long)).

In particular, grep for 'cpumask_of_cpu(0)' in the kernel. You will find
many hits.  This should be efficient for all 'normal' sized systems.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
