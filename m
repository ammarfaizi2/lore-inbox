Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVCSEJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVCSEJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 23:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVCSEJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 23:09:20 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:6712 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262402AbVCSEJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 23:09:15 -0500
X-IronPort-AV: i="3.91,103,1110175200"; 
   d="scan'208"; a="237662091:sNHT21658404"
Date: Fri, 18 Mar 2005 22:09:14 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.30-pre3] x86_64: move init_tss declaration after tss_struct definition
Message-ID: <20050319040914.GA5755@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.4.30-pre3 for x86_64 with FC4-test1 gcc-4.0.0-0.32 fails
because include/asm-x86_64/processor.h declares init_tss[NR_CPUS] as a
sized array before struct tss_struct has been defined.  Simple fix
moves this declaration to after the definition of tss_struct.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== include/asm-x86_64/processor.h 1.9 vs edited =====
--- 1.9/include/asm-x86_64/processor.h	2004-03-21 18:35:56 -06:00
+++ edited/include/asm-x86_64/processor.h	2005-03-18 14:56:30 -06:00
@@ -68,7 +68,6 @@
 #define X86_VENDOR_UNKNOWN 0xff
 
 extern struct cpuinfo_x86 boot_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -298,6 +297,8 @@
 	u16 io_map_base;
 	u32 io_bitmap[IO_BITMAP_SIZE];
 } __attribute__((packed)) ____cacheline_aligned;
+
+extern struct tss_struct init_tss[NR_CPUS];
 
 struct thread_struct {
 	unsigned long	rsp0;
