Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTDDSBN (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTDDSBN (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:01:13 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:61968 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263800AbTDDSBL (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 13:01:11 -0500
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_ALPHA_PC164 compilation fix
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 04 Apr 2003 20:07:22 +0200
Message-ID: <wrpllyqdtlx.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

The included patch fixes 2.5.66 compilation with CONFIG_ALPHA_PC164
enabled.

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1002  -> 1.1003 
#	arch/alpha/kernel/sys_cabriolet.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/03	maz@hina.wild-wind.fr.eu.org	1.1003
# Fix warning (and thus error, because of -Werror) 
# when CONFIG_ALPHA_PC164 is defined.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
--- a/arch/alpha/kernel/sys_cabriolet.c	Fri Apr  4 20:06:49 2003
+++ b/arch/alpha/kernel/sys_cabriolet.c	Fri Apr  4 20:06:49 2003
@@ -132,11 +132,14 @@
 	setup_irq(16+4, &isa_cascade_irqaction);
 }
 
+#ifndef CONFIG_ALPHA_PC164
+/* PC164 is the only case we don't want this to be defined */
 static void __init
 cabriolet_init_irq(void)
 {
 	common_init_irq(srm_device_interrupt);
 }
+#endif
 
 #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_PC164)
 /* In theory, the PC164 has the same interrupt hardware as the other

-- 
Places change, faces change. Life is so very strange.
