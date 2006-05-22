Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWEVNR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWEVNR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWEVNR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:17:27 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:10271
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750818AbWEVNR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:17:26 -0400
Message-Id: <4471D630.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Mon, 22 May 2006 15:18:08 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: [PATCH 4/6] reliable stack trace support (x86-64 syscall
	adjustment)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the CFA offset for 64- and 32-bit syscall entries so that the five
slots pre-subtracted from the stack pointer do not appear to reside outside
of the current frame.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: unwind-2.6.17-rc4/arch/x86_64/ia32/ia32entry.S
===================================================================
--- unwind-2.6.17-rc4.orig/arch/x86_64/ia32/ia32entry.S	2006-05-22 15:00:34.000000000 +0200
+++ unwind-2.6.17-rc4/arch/x86_64/ia32/ia32entry.S	2006-05-22 15:01:10.000000000 +0200
@@ -178,7 +178,7 @@ sysenter_tracesys:
  */ 	
 ENTRY(ia32_cstar_target)
 	CFI_STARTPROC32	simple
-	CFI_DEF_CFA	rsp,0
+	CFI_DEF_CFA	rsp,PDA_STACKOFFSET
 	CFI_REGISTER	rip,rcx
 	/*CFI_REGISTER	rflags,r11*/
 	swapgs
Index: unwind-2.6.17-rc4/arch/x86_64/kernel/entry.S
===================================================================
--- unwind-2.6.17-rc4.orig/arch/x86_64/kernel/entry.S	2006-05-22 15:01:07.000000000 +0200
+++ unwind-2.6.17-rc4/arch/x86_64/kernel/entry.S	2006-05-22 15:01:10.000000000 +0200
@@ -188,7 +188,7 @@ rff_trace:
 
 ENTRY(system_call)
 	CFI_STARTPROC	simple
-	CFI_DEF_CFA	rsp,0
+	CFI_DEF_CFA	rsp,PDA_STACKOFFSET
 	CFI_REGISTER	rip,rcx
 	/*CFI_REGISTER	rflags,r11*/
 	swapgs


