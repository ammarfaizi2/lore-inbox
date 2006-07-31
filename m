Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWGaHTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWGaHTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWGaHTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:19:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65253 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932514AbWGaHTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:19:22 -0400
Date: Mon, 31 Jul 2006 09:12:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Suresh Siddha <suresh.b.siddha@intel.com>, Simon.Derr@bull.net,
       Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-ID: <20060731071242.GA31377@elte.hu>
References: <20060731070734.19126.40501.sendpatchset@v0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731070734.19126.40501.sendpatchset@v0>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> @@ -5675,12 +5675,13 @@ void build_sched_domains(const cpumask_t
>  		int group;
>  		struct sched_domain *sd = NULL, *p;
>  		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
> +		int cpus_per_node = cpus_weight(nodemask);
>  
>  		cpus_and(nodemask, nodemask, *cpu_map);
>  
>  #ifdef CONFIG_NUMA
> -		if (cpus_weight(*cpu_map)
> -				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
> +		if (cpus_weight(cpu_online_map)
> +				> SD_NODES_PER_DOMAIN*cpus_per_node) {
>  			if (!sched_group_allnodes) {
>  				sched_group_allnodes
>  					= kmalloc(sizeof(struct sched_group)

even if the bug is not fully understood in time, i think we should queue 
the patch above for v2.6.18. (with the small nit that you should put the 
new cpus_per_node variable under CONFIG_NUMA too, to avoid a compiler 
warning)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
