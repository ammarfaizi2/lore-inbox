Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWCTTeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCTTeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWCTTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:34:09 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:59652 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751297AbWCTTeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:34:08 -0500
Date: Mon, 20 Mar 2006 14:33:56 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de
Subject: [RFC] pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)
Message-ID: <20060320193351.GC15746@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, gregkh@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The naming of the constant defined for PCI ID 1022:7450 does not seem
to match the information at http://pciids.sourceforge.net/:

	http://pci-ids.ucw.cz/iii/?i=1022

There 1022:7450 is listed as "AMD-8131 PCI-X Bridge" while 1022:7451
is listed as "AMD-8131 PCI-X IOAPIC".  Yet, the current definition for
0x7450 is PCI_DEVICE_ID_AMD_8131_APIC.	It seems to me like that name
should map to 0x7451, while a name like PCI_DEVICE_ID_AMD_8131_BRIDGE
should map to 0x7450.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
There is a PCI quirk that matches 1022:7450.  Even though that is
specifically related to the IOAPIC, I have to believe that it needs to
continue pointing at that ID.  Does anyone have any better information?

The reason I'm interested is because I have a tg3 patch that needs to
reference 1022:7450.  I could use the existing pci_ids.h definition,
but it just seems wrong.  So, it seems like it makes sense to fix
it now?

 drivers/pci/quirks.c    |    2 +-
 include/linux/pci_ids.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dda6099..eb4c95b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -589,7 +589,7 @@ static void __init quirk_amd_8131_ioapic
                 pci_write_config_byte( dev, AMD8131_MISC, tmp);
         }
 } 
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,         quirk_amd_8131_ioapic ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic); 
 
 static void __init quirk_svw_msi(struct pci_dev *dev)
 {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 751eea5..d2bdc25 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -496,7 +496,8 @@
 #define PCI_DEVICE_ID_AMD_8111_SMBUS	0x746b
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
-#define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
+#define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
+#define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
 #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
 #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
 #define PCI_DEVICE_ID_AMD_CS5536_AUDIO  0x2093
-- 
John W. Linville
linville@tuxdriver.com
