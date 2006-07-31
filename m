Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWGaR0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWGaR0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWGaR0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:26:20 -0400
Received: from mga07.intel.com ([143.182.124.22]:57257 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030275AbWGaR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:26:19 -0400
X-IronPort-AV: i="4.07,199,1151910000"; 
   d="scan'208"; a="73059077:sNHT54645339"
Date: Mon, 31 Jul 2006 10:15:43 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, vatsa@in.ibm.com, Simon.Derr@bull.net,
       steiner@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-ID: <20060731101542.A2817@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0> <20060731071242.GA31377@elte.hu> <20060731090440.A2311@unix-os.sc.intel.com> <20060731095429.d2b8801d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060731095429.d2b8801d.pj@sgi.com>; from pj@sgi.com on Mon, Jul 31, 2006 at 09:54:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:54:29AM -0700, Paul Jackson wrote:
> > Paul can you please test the mainline code and confirm?
> 
> Sure - which version of Linus and/or Andrew's tree is the minimum
> worth testing?
> 
> Could you explain why you don't think the mainline has this
> problem?  I still see the critical code piece there:
> 
>   #ifdef CONFIG_NUMA
>                 if (cpus_weight(*cpu_map)
>                                 > SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {

This code piece is not the culprit. In 2.6.16, the mechanism of setting
up group power for allnodes_domains is wrong(which is actually causing
this issue in the presence of dynamic sched groups patch) and the mainline
has fixes for all these issues.

> What other critical bugs are fixed between the SLES10 variant
> and the mainline?

Basically SLES10 has to backport all these patches:

sched: fix group power for allnodes_domains
sched_domai: Allocate sched_group structures dynamically
sched: build_sched_domains() fix

thanks,
suresh
