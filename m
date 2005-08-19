Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVHSB7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVHSB7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 21:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVHSB7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 21:59:19 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37764 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750924AbVHSB7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 21:59:18 -0400
Subject: Re:[PATCH] Mobil Pentium 4 HT and the NMI
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 21:59:08 -0400
Message-Id: <1124416748.5186.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm resending this since I don't see it in git yet, and I'm wondering if
there is a problem with this patch.  I have a IBM ThinkPad G41 with a
Mobile Pentium 4 HT.  Without this patch, the NMI won't be setup.  Is
there a reason that if the x86_model is greater than 0x3 it will return.
Since my processor has a 0x4 x86_model, I upped it to that. Otherwise my
laptop won't be able to use the NMI.

Thanks,

-- Steve

Description:
  This patch is to allow the Mobile Penitum 4 HT to use the NMI.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc6-git10/arch/i386/kernel/nmi.c.orig	2005-08-18 21:51:11.000000000 -0400
+++ linux-2.6.13-rc6-git10/arch/i386/kernel/nmi.c	2005-08-18 21:52:03.000000000 -0400
@@ -195,7 +195,7 @@ static void disable_lapic_nmi_watchdog(v
 			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
 			break;
 		case 15:
-			if (boot_cpu_data.x86_model > 0x3)
+			if (boot_cpu_data.x86_model > 0x4)
 				break;
 
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
@@ -432,7 +432,7 @@ void setup_apic_nmi_watchdog (void)
 			setup_p6_watchdog();
 			break;
 		case 15:
-			if (boot_cpu_data.x86_model > 0x3)
+			if (boot_cpu_data.x86_model > 0x4)
 				return;
 
 			if (!setup_p4_watchdog())


