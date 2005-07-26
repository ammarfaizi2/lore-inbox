Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVGZDbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVGZDbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 23:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVGZD3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 23:29:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261595AbVGZD2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 23:28:34 -0400
Date: Mon, 25 Jul 2005 20:27:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Fw: [PATCH] x86_64: fix SMP boot lockup on some machines
Message-Id: <20050725202737.4e6bd029.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


People who are experiencing early-boot lockups on x86_64
might find this useful..


Don't compare linux processor index with APICID

Fixes boot up lockups on some machines where CPU apic ids
don't start with 0

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -211,7 +211,7 @@ static __cpuinit void sync_master(void *
 {
 	unsigned long flags, i;
 
-	if (smp_processor_id() != boot_cpu_id)
+	if (smp_processor_id() != 0)
 		return;
 
 	go[MASTER] = 0;
