Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264541AbRF3BpR>; Fri, 29 Jun 2001 21:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264586AbRF3BpH>; Fri, 29 Jun 2001 21:45:07 -0400
Received: from erouter0.it-datacntr.louisville.edu ([136.165.1.36]:10482 "HELO
	erouter0.it-datacntr.louisville.edu") by vger.kernel.org with SMTP
	id <S264541AbRF3Box>; Fri, 29 Jun 2001 21:44:53 -0400
From: "Jeff S Wheeler" <jsw@five-elements.com>
To: <linux-kernel@vger.kernel.org>
Cc: <cpbotha@ieee.org>
Subject: VIA 82C686B SouthBridge fixup in linux/drivers/pci/quirks.c
Date: Fri, 29 Jun 2001 21:44:51 -0400
Message-ID: <NEBBJNLLGLPLEJAFGEPEEEFLCBAA.jsw@five-elements.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am not subscribed to the list.  Please CC me on replies.

The VIA686B SouthBridge bug workaround is not activated on motherboards
which have a VIA 82C686B that needs fixing, but not a VIA NorthBridge.  For
example, my Asus A7M266 has an AMD 761 NorthBridge, and the table at the end
of linux/drivers/pci/quirks.c thus does not attempt to apply the fix.
Someone suggested a fix against 2.4.4 in this thread, however it has not all
been fixed on 2.4.5 nor 2.4.5-ac22 (current, I believe).

Below is a patch to the __initdata table which causes the fix to be applied
based on detection of the buggy SouthBridge, and *not* the NorthBridge which
is commonly used with it.  This is the correct behavior, and was suggested
by someone during the thread I reference, however this aspect of the fix was
overlooked.

http://mailman.real-time.com/pipermail/linux-kernel/Week-of-Mon-20010430/032
013.html

---
Jeff S Wheeler           jsw@five-elements.com
Software Development        Five Elements, Inc


--- linux-2.4.5/drivers/pci/quirks.c.orig       Fri Jun 29 20:24:09 2001
+++ linux-2.4.5/drivers/pci/quirks.c    Fri Jun 29 20:58:14 2001
@@ -358,7 +358,7 @@
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82443BX_2,  quirk_natoma },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,
PCI_DEVICE_ID_SI_5597,          quirk_nopcipci },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,
PCI_DEVICE_ID_SI_496,           quirk_nopcipci },
-       { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_8363_0,       quirk_vialatency },
+       { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C686,       quirk_vialatency },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C597_0,     quirk_viaetbf },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C597_0,     quirk_vt82c598_id },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C586_3,     quirk_vt82c586_acpi },

