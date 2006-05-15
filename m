Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWEORsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWEORsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWEORsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:48:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:45991 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965006AbWEORst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:48:49 -0400
Date: Mon, 15 May 2006 13:48:35 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Andi Kleen <ak@muc.de>, Don Zickus <dzickus@redhat.com>
Subject: [PATCH] Kdump i386 nmi event notification fix
Message-ID: <20060515174835.GA28981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o After a crash we should wait for NMI IPI event and not for external NMI
  or NMI watchdog tick.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-rc4-1M-vivek/arch/i386/kernel/crash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/crash.c~kdump-i386-nmi-event-notification-fix arch/i386/kernel/crash.c
--- linux-2.6.17-rc4-1M/arch/i386/kernel/crash.c~kdump-i386-nmi-event-notification-fix	2006-05-15 12:08:21.000000000 -0400
+++ linux-2.6.17-rc4-1M-vivek/arch/i386/kernel/crash.c	2006-05-15 13:25:09.000000000 -0400
@@ -102,7 +102,7 @@ static int crash_nmi_callback(struct not
 	struct pt_regs fixed_regs;
 	int cpu;
 
-	if (val != DIE_NMI)
+	if (val != DIE_NMI_IPI)
 		return NOTIFY_OK;
 
 	regs = ((struct die_args *)data)->regs;
@@ -113,7 +113,7 @@ static int crash_nmi_callback(struct not
 	 * an NMI if system was initially booted with nmi_watchdog parameter.
 	 */
 	if (cpu == crashing_cpu)
-		return 1;
+		return NOTIFY_STOP;
 	local_irq_disable();
 
 	if (!user_mode_vm(regs)) {
_
