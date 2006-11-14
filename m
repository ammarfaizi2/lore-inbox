Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933089AbWKNIWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbWKNIWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933211AbWKNIWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:22:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45263 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933089AbWKNIWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:22:50 -0500
Date: Tue, 14 Nov 2006 09:21:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: akpm@osdl.org
Cc: mm-commits@vger.kernel.org, ebiederm@xmission.com, tony.luck@intel.com,
       yanmin_zhang@linux.intel.com
Subject: Re: + ia64-irqs-use-name-not-typename.patch added to -mm tree
Message-ID: <20061114082103.GA25711@elte.hu>
References: <200611140744.kAE7iSdC024321@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611140744.kAE7iSdC024321@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* akpm@osdl.org <akpm@osdl.org> wrote:

> ------------------------------------------------------
> Subject: ia64 irqs: use `name' not `typename'
> From: Andrew Morton <akpm@osdl.org>
> 
> `typename' is going away and is usually uninitialised anwyay.

yeah.

  Acked-by: Ingo Molnar <mingo@elte.hu>

we also need the patch below, to update the remaining ia64 old-style 
hw_interrupt_type structures to use .name:

------------->
Subject: ia64: typename -> name conversion
From: Ingo Molnar <mingo@elte.hu>

convert irq chip typename -> name.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----
 arch/ia64/hp/sim/hpsim_irq.c  |    2 +-
 arch/ia64/kernel/iosapic.c    |    4 ++--
 arch/ia64/kernel/irq_lsapic.c |    2 +-
 arch/ia64/sn/kernel/irq.c     |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/arch/ia64/hp/sim/hpsim_irq.c
===================================================================
--- linux.orig/arch/ia64/hp/sim/hpsim_irq.c
+++ linux/arch/ia64/hp/sim/hpsim_irq.c
@@ -27,7 +27,7 @@ hpsim_set_affinity_noop (unsigned int a,
 }
 
 static struct hw_interrupt_type irq_type_hp_sim = {
-	.typename =	"hpsim",
+	.name =		"hpsim",
 	.startup =	hpsim_irq_startup,
 	.shutdown =	hpsim_irq_noop,
 	.enable =	hpsim_irq_noop,
Index: linux/arch/ia64/kernel/iosapic.c
===================================================================
--- linux.orig/arch/ia64/kernel/iosapic.c
+++ linux/arch/ia64/kernel/iosapic.c
@@ -456,7 +456,7 @@ iosapic_end_level_irq (unsigned int irq)
 #define iosapic_disable_level_irq	mask_irq
 
 struct hw_interrupt_type irq_type_iosapic_level = {
-	.typename =	"IO-SAPIC-level",
+	.name =		"IO-SAPIC-level",
 	.startup =	iosapic_startup_level_irq,
 	.shutdown =	iosapic_shutdown_level_irq,
 	.enable =	iosapic_enable_level_irq,
@@ -503,7 +503,7 @@ iosapic_ack_edge_irq (unsigned int irq)
 #define iosapic_end_edge_irq		nop
 
 struct hw_interrupt_type irq_type_iosapic_edge = {
-	.typename =	"IO-SAPIC-edge",
+	.name =		"IO-SAPIC-edge",
 	.startup =	iosapic_startup_edge_irq,
 	.shutdown =	iosapic_disable_edge_irq,
 	.enable =	iosapic_enable_edge_irq,
Index: linux/arch/ia64/kernel/irq_lsapic.c
===================================================================
--- linux.orig/arch/ia64/kernel/irq_lsapic.c
+++ linux/arch/ia64/kernel/irq_lsapic.c
@@ -34,7 +34,7 @@ static int lsapic_retrigger(unsigned int
 }
 
 struct hw_interrupt_type irq_type_ia64_lsapic = {
-	.typename =	"LSAPIC",
+	.name =		"LSAPIC",
 	.startup =	lsapic_noop_startup,
 	.shutdown =	lsapic_noop,
 	.enable =	lsapic_noop,
Index: linux/arch/ia64/sn/kernel/irq.c
===================================================================
--- linux.orig/arch/ia64/sn/kernel/irq.c
+++ linux/arch/ia64/sn/kernel/irq.c
@@ -201,7 +201,7 @@ static void sn_set_affinity_irq(unsigned
 }
 
 struct hw_interrupt_type irq_type_sn = {
-	.typename	= "SN hub",
+	.name		= "SN hub",
 	.startup	= sn_startup_irq,
 	.shutdown	= sn_shutdown_irq,
 	.enable		= sn_enable_irq,
