Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVAHRNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVAHRNL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVAHRGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:06:12 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:26833 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261222AbVAHREW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:04:22 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170441.32690.65815.43213@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 4/7] ppc: remove cli()/sti() in arch/ppc/platforms/apus_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:04:21 -0600
Date: Sat, 8 Jan 2005 11:04:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cli() function call with local_irq_disable() in restart code.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/platforms/apus_setup.c linux-2.6.10-mm1/arch/ppc/platforms/apus_setup.c
--- linux-2.6.10-mm1-original/arch/ppc/platforms/apus_setup.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/platforms/apus_setup.c	2005-01-03 19:29:40.720694742 -0500
@@ -480,7 +480,7 @@
 void
 apus_restart(char *cmd)
 {
-	cli();
+	local_irq_disable();
 
 	APUS_WRITE(APUS_REG_LOCK,
 		   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK2);
