Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVCPNPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVCPNPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVCPNPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:15:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37082 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262573AbVCPNPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:15:18 -0500
Subject: [PATCH] Reserve Bootmem fix for booting nondefault location kernel
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: multipart/mixed; boundary="=-d/XlY9CnMwuAb0WYNFjA"
Date: Wed, 16 Mar 2005 18:45:12 +0530
Message-Id: <1110978912.3575.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d/XlY9CnMwuAb0WYNFjA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-d/XlY9CnMwuAb0WYNFjA
Content-Disposition: attachment; filename=x86-nondefault-kernel-reserve-bootmem-fix.patch
Content-Type: text/x-patch; name=x86-nondefault-kernel-reserve-bootmem-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch fixes a problem with reserving memory during boot up of a kernel
built for non-default location. Currently boot memory allocator reserves the
memory required by kernel image, boot allocaotor bitmap etc. It assumes that
kernel is loaded at 1MB (HIGH_MEMORY hard coded to 1024*1024). But kernel can
be built for non-default locatoin, hence existing hardcoding will lead to
reserving unnecessary memory. This patch fixes it.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.11-mm3-vivek/arch/i386/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/setup.c~x86-nondefault-kernel-reserve-bootmem-fix arch/i386/kernel/setup.c
--- linux-2.6.11-mm3/arch/i386/kernel/setup.c~x86-nondefault-kernel-reserve-bootmem-fix	2005-03-15 14:15:25.391856008 +0530
+++ linux-2.6.11-mm3-vivek/arch/i386/kernel/setup.c	2005-03-15 14:16:12.780651816 +0530
@@ -1135,8 +1135,8 @@ void __init setup_bootmem_allocator(void
 	 * the (very unlikely) case of us accidentally initializing the
 	 * bootmem allocator with an invalid RAM area.
 	 */
-	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(min_low_pfn) +
-			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
+	reserve_bootmem(__PHYSICAL_START, (PFN_PHYS(min_low_pfn) +
+			 bootmap_size + PAGE_SIZE-1) - (__PHYSICAL_START));
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,
_

--=-d/XlY9CnMwuAb0WYNFjA--

