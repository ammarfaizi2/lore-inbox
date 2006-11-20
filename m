Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934251AbWKTQ3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934251AbWKTQ3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934252AbWKTQ3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:29:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43734 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S934251AbWKTQ3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:29:31 -0500
Date: Mon, 20 Nov 2006 11:29:09 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: [PATCH] x86_64: Align data segment to PAGE_SIZE boundary
Message-ID: <20061120162909.GJ11450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

This patch was previously part of relocatable kernel series but now I have
forked it out as it is required for 2.6.19 kernels and relocatable kernel
patches have to wait.

Please apply.

Thanks
Vivek


o Explicitly align data segment to PAGE_SIZE boundary otherwise depending on
  config options and tool chain it might be placed on a non PAGE_SIZE aligned
  boundary and vmlinux loaders like kexec fail when they encounter a 
  PT_LOAD type segment which is not aligned to PAGE_SIZE boundary.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-align-data-segment-to-4K-boundary arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/vmlinux.lds.S~x86_64-align-data-segment-to-4K-boundary	2006-11-17 00:05:06.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/vmlinux.lds.S	2006-11-17 00:05:06.000000000 -0500
@@ -60,6 +60,7 @@ SECTIONS
   }
 #endif
 
+  . = ALIGN(PAGE_SIZE);        /* Align data segment to page size boundary */
 				/* Data */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
_
