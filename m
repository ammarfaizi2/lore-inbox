Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVAGVps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVAGVps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVAGVov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:44:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12739 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261625AbVAGVnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:43:49 -0500
Subject: [PATCH] ppc64: call idle_task_exit from cpu_die
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, paulus@au1.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1105134189.13391.6.camel@pants.austin.ibm.com>
References: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com>
	 <1104892877.8954.27.camel@localhost.localdomain>
	 <20050105110833.GA14956@elte.hu>
	 <1104939854.18695.29.camel@localhost.localdomain>
	 <20050107114353.GA29779@elte.hu>
	 <1105134189.13391.6.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1105134261.13391.9.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 Jan 2005 15:44:21 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call idle_task_exit from cpu_die to avoid mm_struct leak.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN arch/ppc64/kernel/setup.c~ppc64-call-idle_task_exit-from-cpu_die arch/ppc64/kernel/setup.c
--- linux-2.6.10-bk10/arch/ppc64/kernel/setup.c~ppc64-call-idle_task_exit-from-cpu_die	2005-01-07 15:33:02.000000000 -0600
+++ linux-2.6.10-bk10-nathanl/arch/ppc64/kernel/setup.c	2005-01-07 15:33:23.000000000 -0600
@@ -1345,6 +1345,7 @@ early_param("xmon", early_xmon);
 
 void cpu_die(void)
 {
+	idle_task_exit();
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
 	local_irq_disable();

_


