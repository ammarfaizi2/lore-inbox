Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUHUX0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUHUX0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268015AbUHUX0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:26:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:47495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268008AbUHUXZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:25:58 -0400
Date: Sat, 21 Aug 2004 16:24:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/14] kexec: i8259-sysfs.x86_64
Message-Id: <20040821162417.7bad0b08.akpm@osdl.org>
In-Reply-To: <m1zn4p66c2.fsf@ebiederm.dsl.xmission.com>
References: <m1zn4p66c2.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> The i8259 does not yet have sysfs support on x86_64

umm, yes it does.  It went into Linus's tree post 2.6.8.1.

I added the below make-it-compile patch.  Please check it.

--- 25/arch/x86_64/kernel/i8259.c~kexec-x86_64-i8259-fixes	2004-08-21 16:22:54.833282048 -0700
+++ 25-akpm/arch/x86_64/kernel/i8259.c	2004-08-21 16:23:42.330061440 -0700
@@ -343,44 +343,6 @@ spurious_8259A_irq:
 	}
 }
 
-static int i8259A_resume(struct sys_device *dev)
-{
-	init_8259A(0);
-	return 0;
-}
-
-static int i8259A_shutdown(struct sys_device *dev)
-{
-	/* Put the i8259A into a quiescent state that
-	 * the kernel initialization code can get it
-	 * out of.
-	 */
-	outb(0xff, 0x21);	/* mask all of 8259A-1 */
-	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
-	return 0;
-}
-
-static struct sysdev_class i8259_sysdev_class = {
-	set_kset_name("i8259"),
-	.resume = i8259A_resume,
-	.shutdown = i8259A_shutdown,
-};
-
-static struct sys_device device_i8259A = {
-	.id	= 0,
-	.cls	= &i8259_sysdev_class,
-};
-
-static int __init i8259A_init_sysfs(void)
-{
-	int error = sysdev_class_register(&i8259_sysdev_class);
-	if (!error)
-		error = sysdev_register(&device_i8259A);
-	return error;
-}
-
-device_initcall(i8259A_init_sysfs);
-
 void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
_

