Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSKCAuh>; Sat, 2 Nov 2002 19:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSKCAuh>; Sat, 2 Nov 2002 19:50:37 -0500
Received: from fmr05.intel.com ([134.134.136.6]:56059 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261530AbSKCAud>; Sat, 2 Nov 2002 19:50:33 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF71@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: pcihpd-discuss@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Date: Sat, 2 Nov 2002 16:56:58 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C282D3.E92BB020"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C282D3.E92BB020
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Greg,

The following patch changes function scopes only but fixes kernel dump on
Hot-Add of PCI bridge cards.

Thanks,
J.I. Lee
Enterprise Server Tech.
Intel Corp.

 arch/i386/pci/fixup.c |    4 ++--
 drivers/pci/quirks.c  |   50
+++++++++++++++++++++++++-------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)


------_=_NextPart_000_01C282D3.E92BB020
Content-Type: application/octet-stream;
	name="php_fix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="php_fix.diff"

diff -urN linux-2.5.45-ia64-021031.org/arch/i386/pci/fixup.c =
linux-2.5.45-ia64-021031-phpa/arch/i386/pci/fixup.c
--- linux-2.5.45-ia64-021031.org/arch/i386/pci/fixup.c	Wed Oct 30 =
16:41:56 2002
+++ linux-2.5.45-ia64-021031-phpa/arch/i386/pci/fixup.c	Sat Nov  2 =
16:22:15 2002
@@ -138,7 +138,7 @@
 #define VIA_8363_KL133_REVISION_ID 0x81
 #define VIA_8363_KM133_REVISION_ID 0x84
=20
-static void __init pci_fixup_via_northbridge_bug(struct pci_dev *d)
+static void __devinit pci_fixup_via_northbridge_bug(struct pci_dev *d)
 {
 	u8 v;
 	u8 revision;
@@ -180,7 +180,7 @@
  * system to PCI bus no matter what are their window settings, so they =
are
  * "transparent" (or subtractive decoding) from programmers point of =
view.
  */
-static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+static void __devinit pci_fixup_transparent_bridge(struct pci_dev =
*dev)
 {
 	if ((dev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_PCI &&
 	    (dev->device & 0xff00) =3D=3D 0x2400)
diff -urN linux-2.5.45-ia64-021031.org/drivers/pci/quirks.c =
linux-2.5.45-ia64-021031-phpa/drivers/pci/quirks.c
--- linux-2.5.45-ia64-021031.org/drivers/pci/quirks.c	Wed Oct 30 =
16:41:36 2002
+++ linux-2.5.45-ia64-021031-phpa/drivers/pci/quirks.c	Sat Nov  2 =
16:27:32 2002
@@ -23,7 +23,7 @@
=20
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs =
*/
-static void __init quirk_passive_release(struct pci_dev *dev)
+static void __devinit quirk_passive_release(struct pci_dev *dev)
 {
 	struct pci_dev *d =3D NULL;
 	unsigned char dlc;
@@ -50,7 +50,7 @@
=20
 int isa_dma_bridge_buggy;		/* Exported */
    =20
-static void __init quirk_isa_dma_hangs(struct pci_dev *dev)
+static void __devinit quirk_isa_dma_hangs(struct pci_dev *dev)
 {
 	if (!isa_dma_bridge_buggy) {
 		isa_dma_bridge_buggy=3D1;
@@ -64,7 +64,7 @@
  *	Chipsets where PCI->PCI transfers vanish or hang
  */
=20
-static void __init quirk_nopcipci(struct pci_dev *dev)
+static void __devinit quirk_nopcipci(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_FAIL)=3D=3D0)
 	{
@@ -77,7 +77,7 @@
  *	Triton requires workarounds to be used by the drivers
  */
 =20
-static void __init quirk_triton(struct pci_dev *dev)
+static void __devinit quirk_triton(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_TRITON)=3D=3D0)
 	{
@@ -96,7 +96,7 @@
  *	Updated based on further information from the site and also on
  *	information provided by VIA=20
  */
-static void __init quirk_vialatency(struct pci_dev *dev)
+static void __devinit quirk_vialatency(struct pci_dev *dev)
 {
 	struct pci_dev *p;
 	u8 rev;
@@ -150,7 +150,7 @@
  *	VIA Apollo VP3 needs ETBF on BT848/878
  */
 =20
-static void __init quirk_viaetbf(struct pci_dev *dev)
+static void __devinit quirk_viaetbf(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_VIAETBF)=3D=3D0)
 	{
@@ -158,7 +158,7 @@
 		pci_pci_problems|=3DPCIPCI_VIAETBF;
 	}
 }
-static void __init quirk_vsfx(struct pci_dev *dev)
+static void __devinit quirk_vsfx(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_VSFX)=3D=3D0)
 	{
@@ -173,7 +173,7 @@
  *	at least
  */
 =20
-static void __init quirk_natoma(struct pci_dev *dev)
+static void __devinit quirk_natoma(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_NATOMA)=3D=3D0)
 	{
@@ -187,7 +187,7 @@
  *  If it's needed, re-allocate the region.
  */
=20
-static void __init quirk_s3_64M(struct pci_dev *dev)
+static void __devinit quirk_s3_64M(struct pci_dev *dev)
 {
 	struct resource *r =3D &dev->resource[0];
=20
@@ -197,7 +197,7 @@
 	}
 }
=20
-static void __init quirk_io_region(struct pci_dev *dev, unsigned =
region, unsigned size, int nr)
+static void __devinit quirk_io_region(struct pci_dev *dev, unsigned =
region, unsigned size, int nr)
 {
 	region &=3D ~(size-1);
 	if (region) {
@@ -222,7 +222,7 @@
  *	0xE0 (64 bytes of ACPI registers)
  *	0xE2 (32 bytes of SMB registers)
  */
-static void __init quirk_ali7101_acpi(struct pci_dev *dev)
+static void __devinit quirk_ali7101_acpi(struct pci_dev *dev)
 {
 	u16 region;
=20
@@ -237,7 +237,7 @@
  *	0x40 (64 bytes of ACPI registers)
  *	0x90 (32 bytes of SMB registers)
  */
-static void __init quirk_piix4_acpi(struct pci_dev *dev)
+static void __devinit quirk_piix4_acpi(struct pci_dev *dev)
 {
 	u32 region;
=20
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
 =09
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
 		d->irq =3D irq;
 }
=20
-static void __init quirk_via_irqpic(struct pci_dev *dev)
+static void __devinit quirk_via_irqpic(struct pci_dev *dev)
 {
 	u8 irq, new_irq =3D dev->irq & 0xf;
=20
@@ -377,7 +377,7 @@
  *
  * We mask out all r/wc bits, too.
  */
-static void __init quirk_piix3_usb(struct pci_dev *dev)
+static void __devinit quirk_piix3_usb(struct pci_dev *dev)
 {
 	u16 legsup;
=20
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
 =20
-static void __init quirk_amd_ioapic(struct pci_dev *dev)
+static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
 {
 	u8 rev;
=20
@@ -441,7 +441,7 @@
  * who turn it off!
  */
 =20
-static void __init quirk_amd_ordering(struct pci_dev *dev)
+static void __devinit quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
 	pci_read_config_dword(dev, 0x4C, &pcic);
@@ -464,14 +464,14 @@
  *	nothing gets put too close to it.
  */
=20
-static void __init quirk_dunord ( struct pci_dev * dev )
+static void __devinit quirk_dunord ( struct pci_dev * dev )
 {
 	struct resource * r =3D & dev -> resource [ 1 ];
 	r -> start =3D 0;
 	r -> end =3D 0xffffff;
 }
=20
-static void __init quirk_transparent_bridge(struct pci_dev *dev)
+static void __devinit quirk_transparent_bridge(struct pci_dev *dev)
 {
 	dev->transparent =3D 1;
 }
@@ -480,7 +480,7 @@
  *  The main table of quirks.
  */
=20
-static struct pci_fixup pci_fixups[] __initdata =3D {
+static struct pci_fixup pci_fixups[] __devinitdata =3D {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	=
quirk_dunord },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	=
quirk_passive_release },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	=
quirk_passive_release },

------_=_NextPart_000_01C282D3.E92BB020--
