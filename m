Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUJDXzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUJDXzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268710AbUJDXzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:55:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24015 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S268707AbUJDXzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:55:09 -0400
Date: Mon, 4 Oct 2004 16:55:08 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix several warnings
Message-ID: <20041004165508.E13777@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes some annoying warnings due to unitialized variables.
Please apply.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/kernel/signal.c 1.37 vs edited =====
--- 1.37/arch/ppc/kernel/signal.c	2004-08-25 10:13:41 -07:00
+++ edited/arch/ppc/kernel/signal.c	2004-10-04 16:38:12 -07:00
@@ -270,7 +270,7 @@
 static int
 restore_user_regs(struct pt_regs *regs, struct mcontext __user *sr, int sig)
 {
-	unsigned long save_r2;
+	unsigned long save_r2 = 0;
 #if defined(CONFIG_ALTIVEC) || defined(CONFIG_SPE)
 	unsigned long msr;
 #endif
===== arch/ppc/mm/44x_mmu.c 1.4 vs edited =====
--- 1.4/arch/ppc/mm/44x_mmu.c	2004-08-07 11:05:38 -07:00
+++ edited/arch/ppc/mm/44x_mmu.c	2004-10-04 16:38:13 -07:00
@@ -72,7 +72,7 @@
 static void __init
 ppc44x_pin_tlb(int slot, unsigned int virt, unsigned int phys)
 {
-	unsigned long attrib;
+	unsigned long attrib = 0;
 
 	__asm__ __volatile__("\
 	clrrwi	%2,%2,10\n\
===== arch/ppc/syslib/ppc4xx_pic.c 1.11 vs edited =====
--- 1.11/arch/ppc/syslib/ppc4xx_pic.c	2004-07-01 22:23:47 -07:00
+++ edited/arch/ppc/syslib/ppc4xx_pic.c	2004-10-04 07:14:09 -07:00
@@ -256,7 +256,7 @@
 ppc4xx_uic_end(unsigned int irq)
 {
 	int bit, word;
-	unsigned int tr_bits;
+	unsigned int tr_bits = 0;
 
 	bit = irq & 0x1f;
 	word = irq >> 5;
===== arch/ppc/syslib/todc_time.c 1.9 vs edited =====
--- 1.9/arch/ppc/syslib/todc_time.c	2004-03-02 11:54:26 -07:00
+++ edited/arch/ppc/syslib/todc_time.c	2004-10-04 16:38:14 -07:00
@@ -277,9 +277,9 @@
 ulong
 todc_get_rtc_time(void)
 {
-	uint	year, mon, day, hour, min, sec;
+	uint	year = 0, mon = 0, day = 0, hour = 0, min = 0, sec = 0;
 	uint	limit, i;
-	u_char	save_control, uip;
+	u_char	save_control, uip = 0;
 
 	spin_lock(&rtc_lock);
 	save_control = todc_read_val(todc_info->control_a);
@@ -361,7 +361,7 @@
 todc_set_rtc_time(unsigned long nowtime)
 {
 	struct rtc_time	tm;
-	u_char		save_control, save_freq_select;
+	u_char		save_control, save_freq_select = 0;
 
 	spin_lock(&rtc_lock);
 	to_tm(nowtime, &tm);
@@ -416,7 +416,7 @@
  */
 static unsigned char __init todc_read_timereg(int addr)
 {
-	unsigned char save_control, val;
+	unsigned char save_control = 0, val;
 
 	switch (todc_info->rtc_type) {
 		case TODC_TYPE_DS1557:
