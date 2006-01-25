Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWAYUWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWAYUWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWAYUWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:22:53 -0500
Received: from mail.gmx.net ([213.165.64.21]:35014 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751206AbWAYUWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:22:52 -0500
X-Authenticated: #704063
Subject: [Patch] apha show_interrups() trashes argument
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net
Content-Type: text/plain
Date: Wed, 25 Jan 2006 21:22:50 +0100
Message-Id: <1138220570.5767.6.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this is a bug found by cpminer. The show_interrupts
function reuses i as a for loop counter, and therefore
trashes its contents, which are needed later.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-rc1-git4/arch/alpha/kernel/irq.c.orig	2006-01-25 21:19:14.000000000 +0100
+++ linux-2.6.16-rc1-git4/arch/alpha/kernel/irq.c	2006-01-25 21:20:12.000000000 +0100
@@ -75,9 +75,9 @@ show_interrupts(struct seq_file *p, void
 #ifdef CONFIG_SMP
 	if (i == 0) {
 		seq_puts(p, "           ");
-		for (i = 0; i < NR_CPUS; i++)
-			if (cpu_online(i))
-				seq_printf(p, "CPU%d       ", i);
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "CPU%d       ", j);
 		seq_putc(p, '\n');
 	}
 #endif


