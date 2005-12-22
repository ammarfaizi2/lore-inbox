Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVLVU6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVLVU6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbVLVU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:58:36 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50148 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030313AbVLVU6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:58:35 -0500
Date: Thu, 22 Dec 2005 14:35:28 -0600
From: Suresh Kodati <kodatisu@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] fix smp_processor_id() use in include/asm-generic/percpu.h
Message-ID: <20051222203528.GA4407@dyn9041041086.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch suppresses the following BUG() seen during bootup of 2.6.15-rc5-mm3 on i386 machines by replacing smp_processor_id with raw_smp_processor_id().

<snip>
[   11.258828] Freeing unused kernel memory: 260k freed
[   11.258864] BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1 
[   11.258878] caller is mod_page_state_offset+0x12/0x28
</snip>

Signed-off-by: Suresh Kodati <kodatisu@in.ibm.com>
-- 

include/asm-generic/percpu.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-rc5/include/asm-generic/percpu.h.orig	2005-12-21 15:13:27.000000000 -0600
+++ linux-2.6.15-rc5/include/asm-generic/percpu.h	2005-12-21 15:13:43.000000000 -0600
@@ -13,7 +13,7 @@ extern unsigned long __per_cpu_offset[NR
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
-#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+#define __get_cpu_var(var) per_cpu(var, raw_smp_processor_id())
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
