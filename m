Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbVIICg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbVIICg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVIICg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:36:57 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:63714 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965241AbVIICg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:36:56 -0400
Date: Thu, 8 Sep 2005 22:33:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13] x86: check host bridge when applying vendor
  quirks
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>
Message-ID: <200509082236_MC3-1-A99D-81DD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the i386 ACPI early quirk code and x86_64 equivalent
and it seems to me it should be checking the host bridge vendor, not
the one for various PCI bridges.  Nvidia might release some kind of
PCI card with an embedded bridge that would break this code, for
example.  I made this patch but I can't test it:

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/acpi/earlyquirk.c |    2 +-
 arch/x86_64/kernel/io_apic.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 2.6.13a.orig/arch/i386/kernel/acpi/earlyquirk.c
+++ 2.6.13a/arch/i386/kernel/acpi/earlyquirk.c
@@ -36,7 +36,7 @@ void __init check_acpi_pci(void) 
 				if (class == 0xffffffff)
 					break; 
 
-				if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
+				if ((class >> 16) != PCI_CLASS_BRIDGE_HOST)
 					continue; 
 				
 				vendor = read_pci_config(num, slot, func, 
--- 2.6.13a.orig/arch/x86_64/kernel/io_apic.c
+++ 2.6.13a/arch/x86_64/kernel/io_apic.c
@@ -242,7 +242,7 @@ void __init check_ioapic(void) 
 				if (class == 0xffffffff)
 					break; 
 
-		       		if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
+		       		if ((class >> 16) != PCI_CLASS_BRIDGE_HOST)
 					continue; 
 
 				vendor = read_pci_config(num, slot, func, 
__
Chuck
