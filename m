Return-Path: <linux-kernel-owner+w=401wt.eu-S1030333AbXAEEfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbXAEEfp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbXAEEfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:35:38 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:51918 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030323AbXAEEfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:35:33 -0500
Date: Thu, 4 Jan 2007 20:35:30 -0800
Message-Id: <200701050435.l054ZUO7005541@zach-dev.vmware.com>
Subject: [PATCH 2/3] Vmi initialize fs for smp
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 05 Jan 2007 04:35:30.0454 (UTC) FILETIME=[EE421B60:01C73082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Jeremy's change to move the kernel PDA to %fs has arrived,
convert the AP processor setup for SMP to use FS instead of GS.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 2ac108843573 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Jan 04 20:01:52 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Jan 04 20:02:42 2007 -0800
@@ -533,8 +533,8 @@ vmi_startup_ipi_hook(int phys_apicid, un
 
 	ap.ds = __USER_DS;
 	ap.es = __USER_DS;
-	ap.fs = 0;
-	ap.gs = __KERNEL_PDA;
+	ap.fs = __KERNEL_PDA;
+	ap.gs = 0;
 
 	ap.eflags = 0;
 
