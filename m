Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVCPV33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVCPV33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVCPV1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:27:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:4536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262815AbVCPV0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:26:40 -0500
Date: Wed, 16 Mar 2005 13:24:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] i386: add kstack=N option (from x86_64)
Message-Id: <20050316132438.76fc5039.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add "kstack=N" boot option for IA-32 (from x86_64).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 Documentation/kernel-parameters.txt |    3 +++
 arch/i386/kernel/traps.c            |    7 +++++++
 2 files changed, 10 insertions(+)

diff -Naurp ./arch/i386/kernel/traps.c~kstack_i386 ./arch/i386/kernel/traps.c
--- ./arch/i386/kernel/traps.c~kstack_i386	2005-03-01 23:37:49.000000000 -0800
+++ ./arch/i386/kernel/traps.c	2005-03-15 21:22:28.000000000 -0800
@@ -1038,3 +1038,10 @@ void __init trap_init(void)
 
 	trap_init_hook();
 }
+
+static int __init kstack_setup(char *s)
+{
+	kstack_depth_to_print = simple_strtoul(s, NULL, 0);
+	return 0;
+}
+__setup("kstack=", kstack_setup);
diff -Naurp ./Documentation/kernel-parameters.txt~kstack_i386 ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt~kstack_i386	2005-03-01 23:38:34.000000000 -0800
+++ ./Documentation/kernel-parameters.txt	2005-03-15 21:23:44.000000000 -0800
@@ -614,6 +617,9 @@ running once the system is up.
 
 	keepinitrd	[HW,ARM]
 
+	kstack=N	[IA-32, X86-64] Print N words from the kernel stack
+			in oops dumps.
+
 	l2cr=		[PPC]
 
 	lapic		[IA-32,APIC] Enable the local APIC even if BIOS disabled it.

---
