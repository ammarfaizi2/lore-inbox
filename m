Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWJQKLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWJQKLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWJQKLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:11:25 -0400
Received: from mout2.freenet.de ([194.97.50.155]:44436 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932167AbWJQKLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:11:24 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove quirk_via_abnormal_poweroff
Date: Tue, 17 Oct 2006 12:13:17 +0200
User-Agent: KMail/1.9.4
Cc: Dave Jones <davej@redhat.com>, mjg59@srcf.ucam.org,
       Greg KH <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171213.18093.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My K8T800 mobo resumes fine from suspend to ram with and without
patch applied against 2.6.18.
quirk_via_abnormal_poweroff makes some boards not boot 2.6.18,
so IMO patch should go to head, 2.6.18.2 and everywhere
"ACPI: ACPICA 20060623" has been applied.

      Karsten

----------------------------------------------------------------
Remove quirk_via_abnormal_poweroff

Obsoleted by "ACPI: ACPICA 20060623":
<snip>
    Implemented support for "ignored" bits in the ACPI
    registers.  According to the ACPI specification, these
    bits should be preserved when writing the registers via
    a read/modify/write cycle. There are 3 bits preserved
    in this manner: PM1_CONTROL[0] (SCI_EN), PM1_CONTROL[9],
    and PM1_STATUS[11].
    http://bugzilla.kernel.org/show_bug.cgi?id=3691
</snip>

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 drivers/pci/quirks.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 23b599d..a53f713 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -683,33 +683,6 @@ static void __devinit quirk_vt82c598_id(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id );
 
-#ifdef CONFIG_ACPI_SLEEP
-
-/*
- * Some VIA systems boot with the abnormal status flag set. This can cause
- * the BIOS to re-POST the system on resume rather than passing control
- * back to the OS.  Clear the flag on boot
- */
-static void __devinit quirk_via_abnormal_poweroff(struct pci_dev *dev)
-{
-	u32 reg;
-
-	acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_STATUS,
-				&reg);
-
-	if (reg & 0x800) {
-		printk("Clearing abnormal poweroff flag\n");
-		acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-					ACPI_REGISTER_PM1_STATUS,
-					(u16)0x800);
-	}
-}
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235, quirk_via_abnormal_poweroff);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_abnormal_poweroff);
-
-#endif
-
 /*
  * CardBus controllers have a legacy base address that enables them
  * to respond as i82365 pcmcia controllers.  We don't want them to
-- 
1.4.2.3

