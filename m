Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVAHRIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVAHRIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVAHRGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:06:40 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:61132 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261226AbVAHREe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:04:34 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170453.32690.22951.49104@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 6/7] ppc: remove cli()/sti() in arch/ppc/syslib/m8xx_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:04:33 -0600
Date: Sat, 8 Jan 2005 11:04:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cli() function call with local_irq_disable() in shutdown code.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/syslib/m8xx_setup.c linux-2.6.10-mm1/arch/ppc/syslib/m8xx_setup.c
--- linux-2.6.10-mm1-original/arch/ppc/syslib/m8xx_setup.c	2004-12-24 16:34:32.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/syslib/m8xx_setup.c	2005-01-03 19:26:53.224307353 -0500
@@ -238,7 +238,7 @@
 {
 	__volatile__ unsigned char dummy;
 
-	cli();
+	local_irq_disable();
 	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;
 
 	/* Clear the ME bit in MSR to cause checkstop on machine check
