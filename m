Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWBGLsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWBGLsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWBGLsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:48:17 -0500
Received: from ns.suse.de ([195.135.220.2]:42198 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965035AbWBGLsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:48:16 -0500
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: [PATCH for 2.6.16] Fix bad apic fix on i386
Date: Tue, 7 Feb 2006 12:48:00 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jbeulich@novell.com,
       Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071248.01244.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix wrong ! in bad apic fix

I forget to remove the ! when moving the code from x86-64 to i386
x86-64 tested !disable_apic, but of course for cpu_has_apic
it shouldn't be negated.  

Credit goes to Jan Beulich for spotting it with eagle eyes.

Cc: jbeulich@novell
Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c
+++ linux/arch/i386/kernel/apic.c
@@ -77,7 +77,7 @@ void ack_bad_irq(unsigned int irq)
 	 * completely.
 	 * But only ack when the APIC is enabled -AK
 	 */
-	if (!cpu_has_apic)
+	if (cpu_has_apic)
 		ack_APIC_irq();
 }
 
