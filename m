Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267593AbUG2PkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267593AbUG2PkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267574AbUG2Ph4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:37:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38096 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268175AbUG2PfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:35:13 -0400
Date: Thu, 29 Jul 2004 10:35:10 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, haveblue@us.ibm.com,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
Message-ID: <20040729153510.GB1141@sgi.com>
References: <1089871489.10000.388.camel@nighthawk> <20040728234255.29ef4c13.pj@sgi.com> <4108B66D.1050000@yahoo.com.au> <20040729022912.04a0806d.pj@sgi.com> <4108D349.1030209@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4108D349.1030209@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 08:36:57PM +1000, Nick Piggin wrote:
> Hmm, nothing else seems to be oopsing. Maybe it is the ia64
> domain setup code that Jesse did? The domains/groups must
> not have been built properly somewhere.

Here's a patch to 2.6.8-rc2-mm1 that allows things to work:

--- sched.c.old 2004-07-29 10:11:00.000000000 -0500
+++ sched.c     2004-07-29 10:27:58.000000000 -0500
@@ -3770,8 +3770,6 @@ __init static void arch_init_sched_domai
                cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
 #ifdef CONFIG_NUMA
-               if (i != first_cpu(sd->groups->cpumask))
-                       continue;
                sd = &per_cpu(node_domains, i);
                group = cpu_to_node_group(i);
                *sd = SD_NODE_INIT;

