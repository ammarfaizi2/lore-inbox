Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVFXDRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVFXDRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVFXDR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:17:27 -0400
Received: from fmr18.intel.com ([134.134.136.17]:24458 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S263033AbVFXDPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:15:39 -0400
Subject: Trival patch: CPU hotplug some HPET routines
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 11:25:02 +0800
Message-Id: <1119583502.4277.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is a trival patch. With hpet enabled, cpu hotplug uses some
routines marked with __init.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>

---

 linux-2.6.12-mm1-root/arch/i386/kernel/time_hpet.c     |    2 +-
 linux-2.6.12-mm1-root/arch/i386/kernel/timers/common.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/time_hpet.c~timer_initcall_cleanup arch/i386/kernel/time_hpet.c
--- linux-2.6.12-mm1/arch/i386/kernel/time_hpet.c~timer_initcall_cleanup	2005-06-23 10:58:20.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/time_hpet.c	2005-06-23 10:58:20.000000000 +0800
@@ -50,7 +50,7 @@ static void hpet_writel(unsigned long d,
  * comparator value and continue. Next tick can be caught by checking
  * for a change in the comparator value. Used in apic.c.
  */
-static void __init wait_hpet_tick(void)
+static void __devinit wait_hpet_tick(void)
 {
 	unsigned int start_cmp_val, end_cmp_val;
 
diff -puN arch/i386/kernel/timers/common.c~timer_initcall_cleanup arch/i386/kernel/timers/common.c
--- linux-2.6.12-mm1/arch/i386/kernel/timers/common.c~timer_initcall_cleanup	2005-06-23 10:58:20.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/timers/common.c	2005-06-23 10:58:20.000000000 +0800
@@ -86,7 +86,7 @@ bad_ctc:
 #define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
 #define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
 
-unsigned long __init calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr)
+unsigned long __devinit calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr)
 {
 	unsigned long tsc_startlow, tsc_starthigh;
 	unsigned long tsc_endlow, tsc_endhigh;
_


