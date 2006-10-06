Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWJFS72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWJFS72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWJFS64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:58:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:54401 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422853AbWJFS6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=EtB9GEyUW4h61FjdrPzbTmlWG4d3nF6mOcMRkMqu3z9DawEaUMJgMWTJsO/dfPF/zziU+LN13Q8yUboKqlUfNkFdKY0TDhxvEHEfPxUVXW7efNyUEJQj2bnfKUTmiPeOeItZ8+0sLqlpON3diToKOpcq66u8nQScIaIvqBz3+sw=
Date: Fri, 6 Oct 2006 18:58:24 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-git] ixp4xxdefconfig arm fixes
Message-ID: <20061006185824.GN352@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the following patch, the ixp4xxdefconfig builds correctly.
I'll test some more configs if I get some time.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index b094e3e..c03cab5 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -27,6 +27,7 @@ #include <linux/errno.h>
 #include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
+#include <linux/irq.h>
 
 #include <asm/leds.h>
 #include <asm/thread_info.h>
@@ -327,7 +328,7 @@ EXPORT_SYMBOL(restore_time_delta);
 void timer_tick(void)
 {
 	struct pt_regs *regs = get_irq_regs();
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 	do_leds();
 	do_set_rtc();
 	do_timer(1);
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 35f10f7..5bfeaed 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -38,7 +38,7 @@ static void resend_irqs(unsigned long ar
 		clear_bit(irq, irqs_resend);
 		desc = irq_desc + irq;
 		local_irq_disable();
-		desc->handle_irq(irq, desc, NULL);
+		desc->handle_irq(irq, desc);
 		local_irq_enable();
 	}
 }
