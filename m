Return-Path: <linux-kernel-owner+w=401wt.eu-S1030315AbXAEEfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbXAEEfp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbXAEEfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:35:37 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:51908 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030319AbXAEEfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:35:33 -0500
Date: Thu, 4 Jan 2007 20:35:30 -0800
Message-Id: <200701050435.l054ZUHx005535@zach-dev.vmware.com>
Subject: [PATCH 1/3] Vmi compile fix
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 05 Jan 2007 04:35:30.0344 (UTC) FILETIME=[EE315280:01C73082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The variable no_timer_check does not exist in UP builds; don't try to
set it in the vmi init code.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 21d7686ee318 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Jan 04 15:23:30 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Jan 04 15:55:39 2007 -0800
@@ -913,7 +913,9 @@ void __init vmi_init(void)
 
 	local_irq_save(flags);
 	activate_vmi();
+#ifdef CONFIG_SMP
 	no_timer_check = 1;
+#endif
 	local_irq_restore(flags & X86_EFLAGS_IF);
 }
 
