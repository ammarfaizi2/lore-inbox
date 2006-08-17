Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWHQSQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWHQSQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 14:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWHQSQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 14:16:38 -0400
Received: from mga06.intel.com ([134.134.136.21]:45673 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932520AbWHQSQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 14:16:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,139,1154934000"; 
   d="scan'208"; a="110298817:sNHT2094870603"
Date: Thu, 17 Aug 2006 11:03:17 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-ID: <20060817110317.A14787@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com> <20060815212455.c9fe1e34.pj@sgi.com> <20060815214718.00814767.akpm@osdl.org> <20060816110357.B7305@unix-os.sc.intel.com> <20060817102030.f8c41330.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060817102030.f8c41330.pj@sgi.com>; from pj@sgi.com on Thu, Aug 17, 2006 at 10:20:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:20:30AM -0700, Paul Jackson wrote:
> > It refers to group's processing power. Perhaps "horsepower" is better term.
> 
> Well ... I don't think "horsepower" is a step in the right direction.
> 
> Andrew's point was over the word "power", not "cpu".  The term
> "cpu_power" suggested to him we were concerned with the power supply
> watts consumed by a group of CPUs.  Indeed, both those concerned with
> laptop battery lifetimes, and the air conditioning tonnage needed
> for big honkin NUMA iron might have reason to be concerned with the
> power consumed by CPUs.
> 
> Changing the word "cpu" to "horse", but keeping the word "power",
> does nothing to address Andrew's point.  Rather it just adds more
> confusion.  We are obviously dealing with CPUs here, not horses.

Let me resist the temptation and not go into the definition of horsepower
here. You can refer any dictionary.

> My understanding is that the "cpu_power" of the cpus in a sched group
> is rougly proportional to the BogoMIPS of the CPUs in that group.

This variable represents how many tasks(multiplied by scaling factor
SCHED_LOAD_SCALE)the group can handle before it starts distributing the load
to other idle or less lightly loaded groups. For example, group with
two HT threads will have it as < 2 * SCHED_LOAD_SCALE. group with
N physical cpus in a NUMA node will have it as N * SCHED_LOAD_SCALE.
When power savings policy is enabled, some of the domains group values will
increase making each group pickup more load and save some watt power.

"group_capacity" or "load_capacity" might be good term considering all this..

thanks,
suresh
