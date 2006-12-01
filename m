Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758847AbWLADtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847AbWLADtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758842AbWLADtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:49:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:21309 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1758823AbWLADtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:49:24 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,482,1157353200"; 
   d="scan'208"; a="171443883:sNHT17592785"
Subject: [patch]VMSPLIT_2G conflicts with PAE
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 11:48:45 +0800
Message-Id: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_OFFSET is 0x78000000 with VMSPLIT_2G, this address is in the middle
of the second pgd entry with pae enabled. This breaks assumptions
(address is aligned to pgd entry's address) in a lot of places like
pagetable_init. Fixing the assumptions is hard (eg, low mapping). SO I
just changed the address to 0x80000000.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8ff1c6f..fddfb26 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -532,7 +532,7 @@ endchoice
 config PAGE_OFFSET
 	hex
 	default 0xB0000000 if VMSPLIT_3G_OPT
-	default 0x78000000 if VMSPLIT_2G
+	default 0x80000000 if VMSPLIT_2G
 	default 0x40000000 if VMSPLIT_1G
 	default 0xC0000000
 
