Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUG2F4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUG2F4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 01:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUG2F4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 01:56:50 -0400
Received: from ozlabs.org ([203.10.76.45]:33715 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264278AbUG2F4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 01:56:47 -0400
Date: Thu, 29 Jul 2004 15:52:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: paulus@samba.org, akpm@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64 SMT bugfix
Message-ID: <20040729055234.GF6456@krispykreme>
References: <4106A27C.3060306@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4106A27C.3060306@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Joel,

Yep, looks good to me. Longer term we should allow an aribtrary number
of siblings but we can fix that when the cpu_to_sibling stuff goes in.

Anton

--

From: Joel Schopp <jschopp@austin.ibm.com>

This patch is fairly straightforward.  maxcpus should be per SMT thread 
and not per physical processor.  

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>

diff -Nru a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Tue Jul 27 13:44:45 2004
+++ b/arch/ppc64/kernel/smp.c	Tue Jul 27 13:44:45 2004
@@ -422,7 +422,11 @@
 	}
 
 	maxcpus = ireg[num_addr_cell + num_size_cell];
-	/* DRENG need to account for threads here too */
+
+	/* Double maxcpus for processors which have SMT capability */
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		maxcpus *= 2;
+
 
 	if (maxcpus > NR_CPUS) {
 		printk(KERN_WARNING

