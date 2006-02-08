Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWBHMjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWBHMjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWBHMju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:39:50 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21268 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030405AbWBHMjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:39:49 -0500
Date: Wed, 8 Feb 2006 13:39:40 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 07/10] s390: fix non smp build of kexec
Message-ID: <20060208123940.GH1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add missing smp_cpu_not_running define to avoid build warnings
in the non smp case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/machine_kexec.c |    5 +++--
 include/asm-s390/smp.h           |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index f0ed5c6..bad81b5 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -12,15 +12,16 @@
  * on the S390 architecture.
  */
 
-#include <asm/cio.h>
-#include <asm/setup.h>
 #include <linux/device.h>
 #include <linux/mm.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <asm/cio.h>
+#include <asm/setup.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/system.h>
+#include <asm/smp.h>
 
 static void kexec_halt_all_cpus(void *);
 
diff --git a/include/asm-s390/smp.h b/include/asm-s390/smp.h
index a2ae762..9c6e9c3 100644
--- a/include/asm-s390/smp.h
+++ b/include/asm-s390/smp.h
@@ -101,6 +101,7 @@ smp_call_function_on(void (*func) (void 
 	func(info);
 	return 0;
 }
+#define smp_cpu_not_running(cpu)	1
 #define smp_get_cpu(cpu) ({ 0; })
 #define smp_put_cpu(cpu) ({ 0; })
 #endif
