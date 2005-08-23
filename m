Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVHWKVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVHWKVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 06:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVHWKVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 06:21:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16814 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751309AbVHWKVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 06:21:13 -0400
Date: Tue, 23 Aug 2005 10:10:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, hawkes@sgi.com, dino@in.ibm.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains on partial nodes temp fix
Message-ID: <20050823081035.GA1346@elte.hu>
References: <20050823080427.14740.20177.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823080427.14740.20177.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

>  	/*
> +	 * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
> +	 * Require the 'cpu_exclusive' cpuset to include all (or none)
> +	 * of the CPUs on each node, or return w/o changing sched domains.
> +	 * Remove this hack when dynamic sched domains fixed.
> +	 */
> +	{
> +		int i, j;
> +
> +		for_each_cpu_mask(i, cur->cpus_allowed) {
> +			for_each_cpu_mask(j, node_to_cpumask(cpu_to_node(i))) {
> +				if (!cpu_isset(j, cur->cpus_allowed))
> +					return;
> +			}
> +		}
> +	}
> +

certainly looks acceptable from a scheduler POV.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
