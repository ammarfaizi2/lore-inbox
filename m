Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752022AbWAEGWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbWAEGWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWAEGWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:22:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752022AbWAEGWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:22:09 -0500
Date: Thu, 5 Jan 2006 01:22:08 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: dual line backtraces for i386.
Message-ID: <20060105062208.GA12095@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another 'get better debug info from users' patch.
x86-64 has had this since day one, and I don't know why
no-one ever ported it to i386.

Instead of using one line per function call in the backtrace,
we can fit two per line.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15/arch/i386/kernel/traps.c~	2005-12-01 04:25:36.000000000 -0500
+++ linux-2.6.15/arch/i386/kernel/traps.c	2005-12-01 04:36:19.000000000 -0500
@@ -116,6 +116,7 @@ static inline unsigned long print_contex
 				unsigned long *stack, unsigned long ebp)
 {
 	unsigned long addr;
+	char space=0;
 
 #ifdef	CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
@@ -131,9 +132,17 @@ static inline unsigned long print_contex
 		if (__kernel_text_address(addr)) {
 			printk(" [<%08lx>]", addr);
 			print_symbol(" %s", addr);
-			printk("\n");
+			if (space == 0) {
+				printk("    ");
+				space = 1;
+			} else {
+				printk("\n");
+				space = 0;
+			}
 		}
 	}
+	if (space==1)
+		printk("\n");
 #endif
 	return ebp;
 }
