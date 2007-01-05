Return-Path: <linux-kernel-owner+w=401wt.eu-S1030334AbXAEEfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbXAEEfn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbXAEEfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:35:36 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:51911 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030317AbXAEEfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:35:33 -0500
Date: Thu, 4 Jan 2007 20:35:30 -0800
Message-Id: <200701050435.l054ZUWn005547@zach-dev.vmware.com>
Subject: [PATCH 3/3] Vmi native fix
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 05 Jan 2007 04:35:30.0547 (UTC) FILETIME=[EE504C30:01C73082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In paravirt builds with VMI compiled in, vmi_bringup is called
unconditionally, not via a paravirt-ops table (as no other hypervisor
uses the APIC startup technique).  Make the calls to setup VMI state
conditional on the presence of the VMI ROM.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 1915e2685a3c arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Jan 04 15:56:40 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Jan 04 15:57:38 2007 -0800
@@ -645,7 +645,8 @@ void vmi_bringup(void)
 void vmi_bringup(void)
 {
  	/* We must establish the lowmem mapping for MMU ops to work */
-	vmi_ops.set_linear_mapping(0, __PAGE_OFFSET, max_low_pfn, 0);
+	if (vmi_rom) 
+		vmi_ops.set_linear_mapping(0, __PAGE_OFFSET, max_low_pfn, 0);
 }
 
 /*
