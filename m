Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUBDGAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 01:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUBDGAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 01:00:24 -0500
Received: from ns.suse.de ([195.135.220.2]:6369 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266245AbUBDGAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 01:00:21 -0500
Date: Wed, 4 Feb 2004 06:56:59 +0100
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Please read for 2.6.2 on x86-64
Message-Id: <20040204065659.791414b2.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a small bug in 2.6.2 for x86-64 that breaks booting when CONFIG_DEBUG_INFO
is enabled. Either don't enable that option or apply the appended patch.

Thanks,
-Andi

--- linux-2.6.2rc2/arch/x86_64/kernel/entry.S	2004-01-26 05:52:30.000000000 +0100
+++ linux-2.6.2rc3-amd64/arch/x86_64/kernel/entry.S	2004-02-04 06:54:44.000000000 +0100
@@ -436,7 +436,7 @@
 	popq  %rdi
 	cli	
 	subl $1,%gs:pda_irqcount
-#ifdef CONFIG_KGDB
+#ifdef CONFIG_DEBUG_INFO
 	movq RBP(%rdi),%rbp
 #endif
 	leaq ARGOFFSET(%rdi),%rsp
