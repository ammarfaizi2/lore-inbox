Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUGZCWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUGZCWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 22:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUGZCWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 22:22:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4806 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264815AbUGZCWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 22:22:33 -0400
Date: Sun, 25 Jul 2004 21:22:02 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] consolidate sched domains
Message-ID: <20040726022202.GA21602@sgi.com>
References: <41008386.9060009@yahoo.com.au> <20040723153022.GA16563@sgi.com> <200407231450.47070.suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407231450.47070.suresh.b.siddha@intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 02:50:46PM -0700, Siddha, Suresh B wrote:
> On Friday 23 July 2004 08:30, Dimitri Sivanich wrote:
> > Do other architectures need to define their own cpu_sibling_maps, or am I
> > missing something that would define that for IA64 and others?
> 
> Nick means, all the architectures which use CONFIG_SCHED_SMT needs to define 
> cpu_sibling_map.
> 
> Nick, aren't you missing the attached fix in your patch?
> 
> thanks,
> suresh

Ok, but cpu_to_phys_group() does a lookup in cpu_sibling map:
__init static int cpu_to_phys_group(int cpu)
{
        return first_cpu(cpu_sibling_map[cpu]);
}

and is called from outside of a CONFIG_SCHED_SMT ifdef here:
                sd = &per_cpu(phys_domains, i);
==>             group = cpu_to_phys_group(i);
                *sd = SD_CPU_INIT;
                sd->span = nodemask;
                sd->parent = p;
                sd->groups = &sched_group_phys[group];

#ifdef CONFIG_SCHED_SMT
                p = sd;
                sd = &per_cpu(cpu_domains, i);
..

