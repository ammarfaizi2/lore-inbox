Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVDAMfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVDAMfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVDAMfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:35:38 -0500
Received: from ozlabs.org ([203.10.76.45]:36075 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262731AbVDAMfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:35:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16973.16407.480898.785184@cargo.ozlabs.ibm.com>
Date: Fri, 1 Apr 2005 22:35:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: David Woodhouse <dwmw2@infradead.org>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Export re{serv,leas}e_pmc_hardware() for oprofile
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_OPROFILE=m doesn't work on ppc64 if these aren't exported...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- linux-2.6.11/arch/ppc64/kernel/pmc.c.orig	2005-03-31 20:31:07.000000000 +0100
+++ linux-2.6.11/arch/ppc64/kernel/pmc.c	2005-03-31 20:30:15.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/pmc.h>
@@ -50,6 +51,7 @@ int reserve_pmc_hardware(perf_irq_t new_
 	spin_unlock(&pmc_owner_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(reserve_pmc_hardware);
 
 void release_pmc_hardware(void)
 {
@@ -62,3 +64,4 @@ void release_pmc_hardware(void)
 
 	spin_unlock(&pmc_owner_lock);
 }
+EXPORT_SYMBOL_GPL(release_pmc_hardware);
