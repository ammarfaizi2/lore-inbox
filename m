Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937710AbWLFWKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937710AbWLFWKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937711AbWLFWKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:10:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52953 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937710AbWLFWKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:10:32 -0500
Date: Wed, 6 Dec 2006 23:10:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: [PATCH] ARM: OMAP: omap1501->15xx conversions needed for sx1
Message-ID: <20061206221018.GA2012@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Ananiev <vovan888@gmail.com>

Convert 1501->15xx in generic omap code, so that sx1 can work.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index b84ba95..7e3b24f 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -691,7 +691,7 @@ #endif
 
 	info = omap_get_config(OMAP_TAG_CLOCK, struct omap_clock_config);
 	if (info != NULL) {
-		if (!cpu_is_omap1510())
+		if (!cpu_is_omap15xx())
 			crystal_type = info->system_clock_type;
 	}
 
diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
index 44fa86a..0a6059e 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ b/arch/arm/plat-omap/dsp/dsp_common.c
@@ -273,7 +273,7 @@ static int __init omap_dsp_init(void)
 
 	dspmem_size = 0;
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		dspmem_base = OMAP1510_DSP_BASE;
 		dspmem_size = OMAP1510_DSP_SIZE;
 		daram_base = OMAP1510_DARAM_BASE;
index 7e91779..4e5f9b7 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -127,7 +127,7 @@ #endif
 	}
 
 	/* Check for pull up or pull down selection on 1610 */
-	if (!cpu_is_omap1510()) {
+	if (!cpu_is_omap15xx()) {
 		if (cfg->pu_pd_reg && cfg->pull_val) {
 			spin_lock_irqsave(&mux_spin_lock, flags);
 			pu_pd_orig = omap_readl(cfg->pu_pd_reg);
@@ -183,7 +183,7 @@ #ifdef CONFIG_OMAP_MUX_DEBUG
 		printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
 		       cfg->mux_reg_name, cfg->mux_reg, reg_orig, reg);
 
-		if (!cpu_is_omap1510()) {
+		if (!cpu_is_omap15xx()) {
 			if (cfg->pu_pd_reg && cfg->pull_val) {
 				printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
 				       cfg->pu_pd_name, cfg->pu_pd_reg,
diff --git a/include/asm-arm/arch-omap/memory.h b/include/asm-arm/arch-omap/memory.h
index a350f5f..14cba97 100644
--- a/include/asm-arm/arch-omap/memory.h
+++ b/include/asm-arm/arch-omap/memory.h
@@ -70,7 +70,7 @@ #define OMAP1510_LB_OFFSET	UL(0x30000000
 
 #define virt_to_lbus(x)		((x) - PAGE_OFFSET + OMAP1510_LB_OFFSET)
 #define lbus_to_virt(x)		((x) - OMAP1510_LB_OFFSET + PAGE_OFFSET)
-#define is_lbus_device(dev)	(cpu_is_omap1510() && dev && (strncmp(dev->bus_id, "ohci", 4) == 0))
+#define is_lbus_device(dev)	(cpu_is_omap15xx() && dev && (strncmp(dev->bus_id, "ohci", 4) == 0))
 
 #define __arch_page_to_dma(dev, page)	({is_lbus_device(dev) ? \
 					(dma_addr_t)virt_to_lbus(page_address(page)) : \

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
