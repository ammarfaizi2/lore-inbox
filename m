Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVCQLxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVCQLxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVCQLxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:53:12 -0500
Received: from ozlabs.org ([203.10.76.45]:38554 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263066AbVCQLMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 06:12:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.25809.285560.417056@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 22:06:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: johnrose@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 remove unnecessary ISA ioports
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During boot, pSeries_request_regions() should only request I/O ports for
legacy ISA in the case that ISA exists on the system.  Add a check for
this.  This patch was suggested by Anton.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/pSeries_pci.c~02_ppc64_request_regions arch/ppc64/kernel/pSeries_pci.c
--- 2_6_linus_4/arch/ppc64/kernel/pSeries_pci.c~02_ppc64_request_regions	2005-03-14 15:59:44.000000000 -0600
+++ 2_6_linus_4-johnrose/arch/ppc64/kernel/pSeries_pci.c	2005-03-14 15:59:44.000000000 -0600
@@ -540,6 +540,9 @@ EXPORT_SYMBOL(pcibios_remove_root_bus);
 
 static void __init pSeries_request_regions(void)
 {
+	if (!isa_io_base)
+		return;
+
 	request_region(0x20,0x20,"pic1");
 	request_region(0xa0,0x20,"pic2");
 	request_region(0x00,0x20,"dma1");
