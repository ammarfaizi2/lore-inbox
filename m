Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268091AbUHKQSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268091AbUHKQSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUHKQSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:18:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20152 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268091AbUHKQSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:18:06 -0400
Date: Wed, 11 Aug 2004 09:17:32 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-Id: <20040811091732.411edb6d.pj@sgi.com>
In-Reply-To: <20040811131155.GA4239@in.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040811131155.GA4239@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> Considering that cpu_possible_map does not get fully initialized
> until smp_prepare_cpus gets called by init(), I thought it right
> to move cpuset_init() to after smp initialization.

Thank-you.  I suspect you're right.

Could you also provide some motivation for the other changes in your
patch, moving struct cpuset, enum cpuset_flagbits_t, and struct cpuset
top_cpuset definitions from kernel/cpuset.c to include/linux/cpuset.h?
I had found it rather pleasing that these structures did not need to
be known outside of kernel/cpuset.c.

Another approach that might work, in order to ensure that the top_cpuset
has its cpus_allowed set to the proper value of cpu_possible_map, would
be to add a routine, say cpuset_init_smp(), called from init/main.c
init() just after smp_init() returns, to update the cpus_allowed in
top_cpuset from the fully initialized value of cpu_possible_map.  This
seems to resemble the call sched_init_smp(), also made in init/main.c
init() just after smp_init() returns, to finish initializing some sched
stuff.

If you take your approach, should we remove the __init qualifier from
kernel/cpuset.c cpuset_init()?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
