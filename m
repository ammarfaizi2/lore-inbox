Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWI1URG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWI1URG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWI1URG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:17:06 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:63248 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161161AbWI1URD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:17:03 -0400
Date: Thu, 28 Sep 2006 16:12:49 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: mj@atrey.karlin.mff.cuni.cz, davej@redhat.com, nhorman@tuxdriver.com
Subject: [PATCH] x86: update vmlinux.lds.S to place .data section on a page boundary
Message-ID: <20060928201249.GA10037@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to update vmlinux linker script so that .data section is on a page
boundary.  without this change the kernel's .data section is on a non-4k
boundary, and this prevents kexec from loading a new kernel.  Tested
successfully by me.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 vmlinux.lds.S |    1 +
 1 files changed, 1 insertion(+)


diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 1e7ac1c..43ed5be 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -50,6 +50,7 @@ SECTIONS
   }
   __tracedata_end = .;
 
+  . = ALIGN(4096);
   /* writeable */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
