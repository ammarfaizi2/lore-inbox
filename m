Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVAZGcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVAZGcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 01:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVAZGcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 01:32:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:10731 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262359AbVAZGcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 01:32:11 -0500
Message-ID: <41F73773.2020905@osdl.org>
Date: Tue, 25 Jan 2005 22:23:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@redhat.com, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] irq_affinity: fix build when CONFIG_PROC_FS=n
Content-Type: multipart/mixed;
 boundary="------------020700050907010905030008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020700050907010905030008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Need 'irq_affinity' array when CONFIG_PROC_FS=n.

With CONFIG_PROC_FS=n, the irq_affinity[NR_IRQS] array
is not available in arch/i386/kernel code:

arch/i386/kernel/built-in.o(.text+0x10037): In function `do_irq_balance':
: undefined reference to `irq_affinity'
arch/i386/kernel/built-in.o(.text+0x101a9): In function `do_irq_balance':
: undefined reference to `irq_affinity'

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  kernel/irq/manage.c |    2 ++
  kernel/irq/proc.c   |    2 --
  2 files changed, 2 insertions(+), 2 deletions(-)

--------------020700050907010905030008
Content-Type: text/x-patch;
 name="irq_affinity_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq_affinity_data.patch"


diff -Naurp ./kernel/irq/proc.c~irq_affinity ./kernel/irq/proc.c
--- ./kernel/irq/proc.c~irq_affinity	2004-12-24 13:34:29.000000000 -0800
+++ ./kernel/irq/proc.c	2005-01-25 20:53:45.581952208 -0800
@@ -19,8 +19,6 @@ static struct proc_dir_entry *root_irq_d
  */
 static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
 
-cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
-
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 				  int count, int *eof, void *data)
 {
diff -Naurp ./kernel/irq/manage.c~irq_affinity ./kernel/irq/manage.c
--- ./kernel/irq/manage.c~irq_affinity	2004-12-24 13:35:50.000000000 -0800
+++ ./kernel/irq/manage.c	2005-01-25 20:54:09.753277608 -0800
@@ -15,6 +15,8 @@
 
 #ifdef CONFIG_SMP
 
+cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
+
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *

--------------020700050907010905030008--
