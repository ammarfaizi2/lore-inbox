Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVI1Vst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVI1Vst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVI1Vst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:48:49 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:33545 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750994AbVI1Vss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:48:48 -0400
Date: Wed, 28 Sep 2005 14:44:05 -0700
Message-Id: <200509282144.j8SLi53a032237@zach-dev.vmware.com>
Subject: [PATCH 3/3] Gdt hotplug
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 28 Sep 2005 21:44:06.0210 (UTC) FILETIME=[C00B2220:01C5C475]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Andi Kleen, don't allocate a GDT page if there is already one
present.  Needed for CPU hotplug.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-rc1/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/smpboot.c	2005-09-20 20:38:22.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/smpboot.c	2005-09-28 12:54:08.000000000 -0700
@@ -898,7 +898,8 @@ static int __devinit do_boot_cpu(int api
 	 * This grunge runs the startup process for
 	 * the targeted processor.
 	 */
-	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
+	if (!cpu_gdt_descr[cpu].address)
+		cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
 
 	atomic_set(&init_deasserted, 0);
 
