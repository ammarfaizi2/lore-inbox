Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWFGReB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWFGReB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWFGReB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:34:01 -0400
Received: from mga07.intel.com ([143.182.124.22]:32952 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932363AbWFGReA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:34:00 -0400
X-IronPort-AV: i="4.05,217,1146466800"; 
   d="scan'208"; a="47493603:sNHT1053080980"
Date: Wed, 7 Jun 2006 10:29:17 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>, davem@caip.rutgers.edu
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       mingo@elte.hu, pwil3058@bigpond.net.au, linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: mc/smt power savings sched policy
Message-ID: <20060607102917.A25186@unix-os.sc.intel.com>
References: <20060606112521.A18026@unix-os.sc.intel.com> <20060607094943.0433a52c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060607094943.0433a52c.akpm@osdl.org>; from akpm@osdl.org on Wed, Jun 07, 2006 at 09:49:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 09:49:43AM -0700, Andrew Morton wrote:
> On Tue, 6 Jun 2006 11:25:21 -0700
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> 
> > Appended the patch. Can someone please test compile the powerpc change?
> 
> powerpc compiles and boots OK, but sparc64 is not so good.
> 
> kernel/built-in.o(.text+0x6ec0): In function `sched_create_sysfs_power_savings_entries':
> : undefined reference to `smt_capable'

Dave, I am not sure if the appended patch is the correct(perhaps temporary?)
mechanism(currently smp_prepare_cpus() also uses this mechanism) in identifying
a SMT capable sparc64 processor. Can you confirm?

thanks,
suresh
--

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.17-rc5/include/asm-sparc64/topology.h	2006-05-24 18:50:17.000000000 -0700
+++ linux/include/asm-sparc64/topology.h	2006-06-07 08:28:13.726071744 -0700
@@ -1,6 +1,9 @@
 #ifndef _ASM_SPARC64_TOPOLOGY_H
 #define _ASM_SPARC64_TOPOLOGY_H
 
+#include <asm/spitfire.h>
+#define smt_capable()	(tlb_type == hypervisor)
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_SPARC64_TOPOLOGY_H */
