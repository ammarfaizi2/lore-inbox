Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWEORs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWEORs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWEORs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:48:59 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:19128 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965012AbWEORsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:48:55 -0400
Date: Mon, 15 May 2006 13:48:49 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Andi Kleen <ak@muc.de>, Don Zickus <dzickus@redhat.com>
Subject: [PATCH] kdump x86_64 nmi event notification fix
Message-ID: <20060515174849.GB28981@in.ibm.com>
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

 linux-2.6.17-rc4-1M-vivek/arch/x86_64/kernel/crash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86_64/kernel/crash.c~kdump-x86_64-nmi-event-notification-fix arch/x86_64/kernel/crash.c
--- linux-2.6.17-rc4-1M/arch/x86_64/kernel/crash.c~kdump-x86_64-nmi-event-notification-fix	2006-05-15 13:26:41.000000000 -0400
+++ linux-2.6.17-rc4-1M-vivek/arch/x86_64/kernel/crash.c	2006-05-15 13:27:02.000000000 -0400
@@ -102,7 +102,7 @@ static int crash_nmi_callback(struct not
 	struct pt_regs *regs;
 	int cpu;
 
-	if (val != DIE_NMI)
+	if (val != DIE_NMI_IPI)
 		return NOTIFY_OK;
 
 	regs = ((struct die_args *)data)->regs;
@@ -114,7 +114,7 @@ static int crash_nmi_callback(struct not
 	 * an NMI if system was initially booted with nmi_watchdog parameter.
 	 */
 	if (cpu == crashing_cpu)
-		return 1;
+		return NOTIFY_STOP;
 	local_irq_disable();
 
 	crash_save_this_cpu(regs, cpu);
_
