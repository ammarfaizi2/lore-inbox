Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWGaQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWGaQPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWGaQPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:15:12 -0400
Received: from mga06.intel.com ([134.134.136.21]:40964 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030208AbWGaQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:15:09 -0400
X-IronPort-AV: i="4.07,199,1151910000"; 
   d="scan'208"; a="99238384:sNHT171688083"
Date: Mon, 31 Jul 2006 09:04:40 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Suresh Siddha <suresh.b.siddha@intel.com>, Simon.Derr@bull.net,
       Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-ID: <20060731090440.A2311@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0> <20060731071242.GA31377@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060731071242.GA31377@elte.hu>; from mingo@elte.hu on Mon, Jul 31, 2006 at 09:12:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:12:42AM +0200, Ingo Molnar wrote:
> 
> * Paul Jackson <pj@sgi.com> wrote:
> 
> > @@ -5675,12 +5675,13 @@ void build_sched_domains(const cpumask_t
> >  		int group;
> >  		struct sched_domain *sd = NULL, *p;
> >  		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
> > +		int cpus_per_node = cpus_weight(nodemask);
> >  
> >  		cpus_and(nodemask, nodemask, *cpu_map);
> >  
> >  #ifdef CONFIG_NUMA
> > -		if (cpus_weight(*cpu_map)
> > -				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
> > +		if (cpus_weight(cpu_online_map)
> > +				> SD_NODES_PER_DOMAIN*cpus_per_node) {
> >  			if (!sched_group_allnodes) {
> >  				sched_group_allnodes
> >  					= kmalloc(sizeof(struct sched_group)
> 
> even if the bug is not fully understood in time, i think we should queue 
> the patch above for v2.6.18. (with the small nit that you should put the 

I believe that this problem doesn't happen with the current mainline code.
Paul can you please test the mainline code and confirm? After going through
SLES10 code and current mainline code, my understanding is that SLES10 has
this bug but not mainline.

thanks,
suresh
