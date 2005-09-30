Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVI3CEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVI3CEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVI3CEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:04:30 -0400
Received: from fmr23.intel.com ([143.183.121.15]:9621 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932398AbVI3CEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:04:30 -0400
Date: Thu, 29 Sep 2005 19:04:20 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [Patch] x86, x86_64: fix cpu model for family 0x6
Message-ID: <20050929190419.C15943@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi, please pickup this patch and push to Andrew/Linus.

thanks,
suresh

--
According to cpuid instruction in IA32 SDM-Vol2, when computing cpu model,
we need to consider extended model ID for family 0x6 also.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.14-rc2-git7/arch/i386/kernel/cpu/common.c~	2005-09-29 17:44:12.030688920 -0700
+++ linux-2.6.14-rc2-git7/arch/i386/kernel/cpu/common.c	2005-09-29 17:44:30.967810040 -0700
@@ -233,10 +233,10 @@ static void __init early_cpu_detect(void
 		cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
 		c->x86 = (tfms >> 8) & 15;
 		c->x86_model = (tfms >> 4) & 15;
-		if (c->x86 == 0xf) {
+		if (c->x86 == 0xf)
 			c->x86 += (tfms >> 20) & 0xff;
+		if (c->x86 == 0x6 || c->x86 == 0xf)
 			c->x86_model += ((tfms >> 16) & 0xF) << 4;
-		}
 		c->x86_mask = tfms & 15;
 		if (cap0 & (1<<19))
 			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
--- linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c~	2005-09-29 18:05:26.503939536 -0700
+++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c	2005-09-29 18:06:42.318413984 -0700
@@ -1059,10 +1059,10 @@ void __cpuinit early_identify_cpu(struct
 		c->x86 = (tfms >> 8) & 0xf;
 		c->x86_model = (tfms >> 4) & 0xf;
 		c->x86_mask = tfms & 0xf;
-		if (c->x86 == 0xf) {
+		if (c->x86 == 0xf)
 			c->x86 += (tfms >> 20) & 0xff;
+		if (c->x86 == 0x6 || c->x86 == 0xf)
 			c->x86_model += ((tfms >> 16) & 0xF) << 4;
-		} 
 		if (c->x86_capability[0] & (1<<19)) 
 			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
 	} else {
