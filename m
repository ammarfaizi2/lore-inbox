Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbUJ2AHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUJ2AHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUJ2ABT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:01:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:50880 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263106AbUJ1Xv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:51:59 -0400
Date: Thu, 28 Oct 2004 16:51:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clustered apic patch missing APIC_DFR_CLUSTER def
Message-ID: <20041028165157.K2357@build.pdx.osdl.net>
References: <20041028112715.D14339@build.pdx.osdl.net> <200410281635.23848.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200410281635.23848.jamesclv@us.ibm.com>; from jamesclv@us.ibm.com on Thu, Oct 28, 2004 at 04:35:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Cleverdon (jamesclv@us.ibm.com) wrote:
> Hmmm...  The patch containing APIC_DFR_CLUSTER and friends went
> into the -mm tree in the June/July timeframe.  It must not have
> been pushed with the main cluster patch.

OK, looks like Andi just sent something similar (i dropped the l (ell), since
it looked meant to be only 32bit).

> You're right, we're using the generic version of
> cpu_present_to_apicid().  The cluster one can go.

This part resent (below).

thanks,
-chris

Remove cluster_cpu_present_to_apicid(), it's defined but not used anywhere.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== arch/x86_64/kernel/genapic_cluster.c 1.1 vs edited =====
--- 1.1/arch/x86_64/kernel/genapic_cluster.c	2004-10-28 00:39:50 -07:00
+++ edited/arch/x86_64/kernel/genapic_cluster.c	2004-10-28 11:18:10 -07:00
@@ -57,14 +57,6 @@
 	apic_write_around(APIC_LDR, val);
 }
 
-static int cluster_cpu_present_to_apicid(int mps_cpu)
-{
-	if ((unsigned)mps_cpu < NR_CPUS)
-		return (int)bios_cpu_apicid[mps_cpu];
-	else
-		return BAD_APICID;
-}
-
 /* Start with all IRQs pointing to boot CPU.  IRQ balancing will shift them. */
 
 static cpumask_t cluster_target_cpus(void)
