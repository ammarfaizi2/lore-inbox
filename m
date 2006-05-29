Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWE2Vkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWE2Vkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWE2Vjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:39:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61138 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751350AbWE2VZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:16 -0400
Date: Mon, 29 May 2006 23:25:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 30/61] lock validator: x86_64 early init
Message-ID: <20060529212537.GD3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

x86_64 uses spinlocks very early - earlier than start_kernel().
So call lockdep_init() from the arch setup code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/head64.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux/arch/x86_64/kernel/head64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/head64.c
+++ linux/arch/x86_64/kernel/head64.c
@@ -85,6 +85,11 @@ void __init x86_64_start_kernel(char * r
 	clear_bss();
 
 	/*
+	 * This must be called really, really early:
+	 */
+	lockdep_init();
+
+	/*
 	 * switch to init_level4_pgt from boot_level4_pgt
 	 */
 	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
