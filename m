Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVAOVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVAOVrs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAOVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:45:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25873 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262337AbVAOVkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:40:22 -0500
Date: Sat, 15 Jan 2005 22:40:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64 msr.c: make two functions static (fwd)
Message-ID: <20050115214017.GA4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (already ACK'ed by H. Peter Anvin) still 
applies and compiles against 2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 6 Dec 2004 01:41:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64 msr.c: make two functions static

The patch below makes two needlessly global functions static.


diffstat output:
 arch/i386/kernel/msr.c   |    4 ++--
 arch/x86_64/kernel/msr.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/msr.c.old	2004-12-06 01:23:13.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/msr.c	2004-12-06 01:23:26.000000000 +0100
@@ -291,7 +291,7 @@
 	.notifier_call = msr_class_cpu_callback,
 };
 
-int __init msr_init(void)
+static int __init msr_init(void)
 {
 	int i, err = 0;
 	i = 0;
@@ -328,7 +328,7 @@
 	return err;
 }
 
-void __exit msr_exit(void)
+static void __exit msr_exit(void)
 {
 	int cpu = 0;
 	for_each_online_cpu(cpu)
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/msr.c.old	2004-12-06 01:23:35.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/msr.c	2004-12-06 01:23:48.000000000 +0100
@@ -255,7 +255,7 @@
 	.open = msr_open,
 };
 
-int __init msr_init(void)
+static int __init msr_init(void)
 {
 	if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
 		printk(KERN_ERR "msr: unable to get major %d for msr\n",
@@ -266,7 +266,7 @@
 	return 0;
 }
 
-void __exit msr_exit(void)
+static void __exit msr_exit(void)
 {
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

