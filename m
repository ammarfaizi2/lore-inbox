Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSKFBpk>; Tue, 5 Nov 2002 20:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265474AbSKFBoo>; Tue, 5 Nov 2002 20:44:44 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21520 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265479AbSKFBnY>;
	Tue, 5 Nov 2002 20:43:24 -0500
Date: Tue, 5 Nov 2002 17:46:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106014603.GZ18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com> <20021106013835.GT18627@kroah.com> <20021106013915.GU18627@kroah.com> <20021106014304.GV18627@kroah.com> <20021106014358.GW18627@kroah.com> <20021106014444.GX18627@kroah.com> <20021106014528.GY18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106014528.GY18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.9, 2002/11/03 00:02:17-08:00, jung-ik.lee@intel.com

[PATCH] Patch: 2.5.45 PCI Fixups for PCI HotPlug

The following patch changes function scopes only but fixes kernel dump on
Hot-Add of PCI bridge cards.


diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	Tue Nov  5 17:25:54 2002
+++ b/arch/i386/pci/fixup.c	Tue Nov  5 17:25:54 2002
@@ -138,7 +138,7 @@
 #define VIA_8363_KL133_REVISION_ID 0x81
 #define VIA_8363_KM133_REVISION_ID 0x84
 
-static void __init pci_fixup_via_northbridge_bug(struct pci_dev *d)
+static void __devinit pci_fixup_via_northbridge_bug(struct pci_dev *d)
 {
 	u8 v;
 	u8 revision;
@@ -180,7 +180,7 @@
  * system to PCI bus no matter what are their window settings, so they are
  * "transparent" (or subtractive decoding) from programmers point of view.
  */
-static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
 {
 	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
 	    (dev->device & 0xff00) == 0x2400)
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Tue Nov  5 17:25:54 2002
+++ b/drivers/pci/quirks.c	Tue Nov  5 17:25:54 2002
@@ -23,7 +23,7 @@
 
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */
-static void __init quirk_passive_release(struct pci_dev *dev)
+static void __devinit quirk_passive_release(struct pci_dev *dev)
 {
 	struct pci_dev *d = NULL;
 	unsigned char dlc;
@@ -50,7 +50,7 @@
 
 int isa_dma_bridge_buggy;		/* Exported */
     
-static void __init quirk_isa_dma_hangs(struct pci_dev *dev)
+static void __devinit quirk_isa_dma_hangs(struct pci_dev *dev)
 {
 	if (!isa_dma_bridge_buggy) {
 		isa_dma_bridge_buggy=1;
@@ -64,7 +64,7 @@
  *	Chipsets where PCI->PCI transfers vanish or hang
  */
 
-static void __init quirk_nopcipci(struct pci_dev *dev)
+static void __devinit quirk_nopcipci(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_FAIL)==0)
 	{
@@ -77,7 +77,7 @@
  *	Triton requires workarounds to be used by the drivers
  */
  
-static void __init quirk_triton(struct pci_dev *dev)
+static void __devinit quirk_triton(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_TRITON)==0)
 	{
@@ -96,7 +96,7 @@
  *	Updated based on further information from the site and also on
  *	information provided by VIA 
  */
-static void __init quirk_vialatency(struct pci_dev *dev)
+static void __devinit quirk_vialatency(struct pci_dev *dev)
 {
 	struct pci_dev *p;
 	u8 rev;
@@ -150,7 +150,7 @@
  *	VIA Apollo VP3 needs ETBF on BT848/878
  */
  
-static void __init quirk_viaetbf(struct pci_dev *dev)
+static void __devinit quirk_viaetbf(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_VIAETBF)==0)
 	{
@@ -158,7 +158,7 @@
 		pci_pci_problems|=PCIPCI_VIAETBF;
 	}
 }
-static void __init quirk_vsfx(struct pci_dev *dev)
+static void __devinit quirk_vsfx(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_VSFX)==0)
 	{
@@ -173,7 +173,7 @@
  *	at least
  */
  
-static void __init quirk_natoma(struct pci_dev *dev)
+static void __devinit quirk_natoma(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_NATOMA)==0)
 	{
@@ -187,7 +187,7 @@
  *  If it's needed, re-allocate the region.
  */
 
-static void __init quirk_s3_64M(struct pci_dev *dev)
+static void __devinit quirk_s3_64M(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[0];
 
@@ -197,7 +197,7 @@
 	}
 }
 
-static void __init quirk_io_region(struct pci_dev *dev, unsigned region, unsigned size, int nr)
+static void __devinit quirk_io_region(struct pci_dev *dev, unsigned region, unsigned size, int nr)
 {
 	region &= ~(size-1);
 	if (region) {
@@ -222,7 +222,7 @@
  *	0xE0 (64 bytes of ACPI registers)
  *	0xE2 (32 bytes of SMB registers)
  */
-static void __init quirk_ali7101_acpi(struct pci_dev *dev)
+static void __devinit quirk_ali7101_acpi(struct pci_dev *dev)
 {
 	u16 region;
 
@@ -237,7 +237,7 @@
  *	0x40 (64 bytes of ACPI registers)
  *	0x90 (32 bytes of SMB registers)
  */
-static void __init quirk_piix4_acpi(struct pci_dev *dev)
+static void __devinit quirk_piix4_acpi(struct pci_dev *dev)
 {
 	u32 region;
 
@@ -251,7 +251,7 @@
  * VIA ACPI: One IO region pointed to by longword at
  *	0x48 or 0x20 (256 bytes of ACPI registers)
  */
-static void __init quirk_vt82c586_acpi(struct pci_dev *dev)
+static void __devinit quirk_vt82c586_acpi(struct pci_dev *dev)
 {
 	u8 rev;
 	u32 region;
@@ -270,7 +270,7 @@
  *	0x70 (128 bytes of hardware monitoring register)
  *	0x90 (16 bytes of SMB registers)
  */
-static void __init quirk_vt82c686_acpi(struct pci_dev *dev)
+static void __devinit quirk_vt82c686_acpi(struct pci_dev *dev)
 {
 	u16 hm;
 	u32 smb;
@@ -297,7 +297,7 @@
  * TODO: When we have device-specific interrupt routers,
  * this code will go away from quirks.
  */
-static void __init quirk_via_ioapic(struct pci_dev *dev)
+static void __devinit quirk_via_ioapic(struct pci_dev *dev)
 {
 	u8 tmp;
 	
@@ -338,7 +338,7 @@
  * value of the ACPI SCI interrupt is only done for convenience.
  *	-jgarzik
  */
-static void __init quirk_via_acpi(struct pci_dev *d)
+static void __devinit quirk_via_acpi(struct pci_dev *d)
 {
 	/*
 	 * VIA ACPI device: SCI IRQ line in PCI config byte 0x42
@@ -350,7 +350,7 @@
 		d->irq = irq;
 }
 
-static void __init quirk_via_irqpic(struct pci_dev *dev)
+static void __devinit quirk_via_irqpic(struct pci_dev *dev)
 {
 	u8 irq, new_irq = dev->irq & 0xf;
 
@@ -377,7 +377,7 @@
  *
  * We mask out all r/wc bits, too.
  */
-static void __init quirk_piix3_usb(struct pci_dev *dev)
+static void __devinit quirk_piix3_usb(struct pci_dev *dev)
 {
 	u16 legsup;
 
@@ -392,7 +392,7 @@
  * We need to switch it off to be able to recognize the real
  * type of the chip.
  */
-static void __init quirk_vt82c598_id(struct pci_dev *dev)
+static void __devinit quirk_vt82c598_id(struct pci_dev *dev)
 {
 	pci_write_config_byte(dev, 0xfc, 0);
 	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
@@ -404,7 +404,7 @@
  * do this even if the Linux CardBus driver is not loaded, because
  * the Linux i82365 driver does not (and should not) handle CardBus.
  */
-static void __init quirk_cardbus_legacy(struct pci_dev *dev)
+static void __devinit quirk_cardbus_legacy(struct pci_dev *dev)
 {
 	if ((PCI_CLASS_BRIDGE_CARDBUS << 8) ^ dev->class)
 		return;
@@ -421,7 +421,7 @@
  * of course. However the advice is demonstrably good even if so..
  */
  
-static void __init quirk_amd_ioapic(struct pci_dev *dev)
+static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
 {
 	u8 rev;
 
@@ -441,7 +441,7 @@
  * who turn it off!
  */
  
-static void __init quirk_amd_ordering(struct pci_dev *dev)
+static void __devinit quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
 	pci_read_config_dword(dev, 0x4C, &pcic);
@@ -464,14 +464,14 @@
  *	nothing gets put too close to it.
  */
 
-static void __init quirk_dunord ( struct pci_dev * dev )
+static void __devinit quirk_dunord ( struct pci_dev * dev )
 {
 	struct resource * r = & dev -> resource [ 1 ];
 	r -> start = 0;
 	r -> end = 0xffffff;
 }
 
-static void __init quirk_transparent_bridge(struct pci_dev *dev)
+static void __devinit quirk_transparent_bridge(struct pci_dev *dev)
 {
 	dev->transparent = 1;
 }
@@ -480,7 +480,7 @@
  *  The main table of quirks.
  */
 
-static struct pci_fixup pci_fixups[] __initdata = {
+static struct pci_fixup pci_fixups[] __devinitdata = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
