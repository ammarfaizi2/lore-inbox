Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUFCWCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUFCWCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 18:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUFCWCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 18:02:23 -0400
Received: from ozlabs.org ([203.10.76.45]:53938 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264419AbUFCWCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 18:02:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.41034.157316.71630@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jun 2004 08:03:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Fix locks.c properly this time
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I moved the exports into arch/ppc/lib/locks.c, I forgot to
include module.h, so it doesn't compile (with CONFIG_SMP +
CONFIG_SPINLOCK_DEBUG).  This patch fixes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/lib/locks.c pmac-2.5/arch/ppc/lib/locks.c
--- linux-2.5/arch/ppc/lib/locks.c	2004-06-04 07:19:00.606966040 +1000
+++ pmac-2.5/arch/ppc/lib/locks.c	2004-06-03 22:26:37.000000000 +1000
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <asm/ppc_asm.h>
 #include <asm/smp.h>
 
