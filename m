Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUHWTIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUHWTIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbUHWTEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:04:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:8900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267293AbUHWSg7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:59 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860853649@kroah.com>
Date: Mon, 23 Aug 2004 11:34:46 -0700
Message-Id: <10932860862730@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.16, 2004/08/04 18:26:31-07:00, greg@kroah.com

PCI: clean up code formatting of quirks.c

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |   90 +++++++++++++++------------------------------------
 1 files changed, 27 insertions(+), 63 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-08-23 11:05:49 -07:00
+++ b/drivers/pci/quirks.c	2004-08-23 11:05:49 -07:00
@@ -47,8 +47,6 @@
     
     This appears to be BIOS not version dependent. So presumably there is a 
     chipset level fix */
-    
-
 int isa_dma_bridge_buggy;		/* Exported */
     
 static void __devinit quirk_isa_dma_hangs(struct pci_dev *dev)
@@ -75,13 +73,11 @@
 /*
  *	Chipsets where PCI->PCI transfers vanish or hang
  */
-
 static void __devinit quirk_nopcipci(struct pci_dev *dev)
 {
-	if((pci_pci_problems&PCIPCI_FAIL)==0)
-	{
+	if ((pci_pci_problems & PCIPCI_FAIL)==0) {
 		printk(KERN_INFO "Disabling direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_FAIL;
+		pci_pci_problems |= PCIPCI_FAIL;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
@@ -90,13 +86,11 @@
 /*
  *	Triton requires workarounds to be used by the drivers
  */
- 
 static void __devinit quirk_triton(struct pci_dev *dev)
 {
-	if((pci_pci_problems&PCIPCI_TRITON)==0)
-	{
+	if ((pci_pci_problems&PCIPCI_TRITON)==0) {
 		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_TRITON;
+		pci_pci_problems |= PCIPCI_TRITON;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton ); 
@@ -122,19 +116,16 @@
 	/* Ok we have a potential problem chipset here. Now see if we have
 	   a buggy southbridge */
 	   
-	p=pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
-	if(p!=NULL)
-	{
+	p = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
+	if (p!=NULL) {
 		pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
 		/* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis */
 		/* Check for buggy part revisions */
 		if (rev < 0x40 || rev > 0x42) 
 			return;
-	}
-	else
-	{
+	} else {
 		p = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
-		if(p==NULL)	/* No problem parts */
+		if (p==NULL)	/* No problem parts */
 			return;
 		pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
 		/* Check for buggy part revisions */
@@ -170,23 +161,20 @@
 /*
  *	VIA Apollo VP3 needs ETBF on BT848/878
  */
- 
 static void __devinit quirk_viaetbf(struct pci_dev *dev)
 {
-	if((pci_pci_problems&PCIPCI_VIAETBF)==0)
-	{
+	if ((pci_pci_problems&PCIPCI_VIAETBF)==0) {
 		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_VIAETBF;
+		pci_pci_problems |= PCIPCI_VIAETBF;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf );
 
 static void __devinit quirk_vsfx(struct pci_dev *dev)
 {
-	if((pci_pci_problems&PCIPCI_VSFX)==0)
-	{
+	if ((pci_pci_problems&PCIPCI_VSFX)==0) {
 		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_VSFX;
+		pci_pci_problems |= PCIPCI_VSFX;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx );
@@ -197,30 +185,25 @@
  *	workaround applied too
  *	[Info kindly provided by ALi]
  */	
- 
 static void __init quirk_alimagik(struct pci_dev *dev)
 {
-	if((pci_pci_problems&PCIPCI_ALIMAGIK)==0)
-	{
+	if ((pci_pci_problems&PCIPCI_ALIMAGIK)==0) {
 		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_ALIMAGIK|PCIPCI_TRITON;
+		pci_pci_problems |= PCIPCI_ALIMAGIK|PCIPCI_TRITON;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1647, 	quirk_alimagik );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1651, 	quirk_alimagik );
 
-
 /*
  *	Natoma has some interesting boundary conditions with Zoran stuff
  *	at least
  */
- 
 static void __devinit quirk_natoma(struct pci_dev *dev)
 {
-	if((pci_pci_problems&PCIPCI_NATOMA)==0)
-	{
+	if ((pci_pci_problems&PCIPCI_NATOMA)==0) {
 		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_NATOMA;
+		pci_pci_problems |= PCIPCI_NATOMA;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82441, 	quirk_natoma ); 
@@ -234,7 +217,6 @@
  *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
  *  If it's needed, re-allocate the region.
  */
-
 static void __devinit quirk_s3_64M(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[0];
@@ -265,7 +247,6 @@
  *	ATI Northbridge setups MCE the processor if you even
  *	read somewhere between 0x3b0->0x3bb or read 0x3d3
  */
- 
 static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
 {
 	printk(KERN_INFO "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.\n");
@@ -417,14 +398,12 @@
  * noapic specified. For the moment we assume its the errata. We may be wrong
  * of course. However the advice is demonstrably good even if so..
  */
- 
 static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
 {
 	u8 rev;
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
-	if(rev >= 0x02)
-	{
+	if (rev >= 0x02) {
 		printk(KERN_WARNING "I/O APIC: AMD Errata #22 may be present. In the event of instability try\n");
 		printk(KERN_WARNING "        : booting with the \"noapic\" option.\n");
 	}
@@ -442,7 +421,6 @@
 #define AMD8131_revB0        0x11
 #define AMD8131_MISC         0x40
 #define AMD8131_NIOAMODE_BIT 0
-
 static void __init quirk_amd_8131_ioapic(struct pci_dev *dev) 
 { 
         unsigned char revid, tmp;
@@ -574,13 +552,11 @@
  * To be fair to AMD, it follows the spec by default, its BIOS people
  * who turn it off!
  */
- 
 static void __devinit quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
 	pci_read_config_dword(dev, 0x4C, &pcic);
-	if((pcic&6)!=6)
-	{
+	if ((pcic&6)!=6) {
 		pcic |= 6;
 		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
 		pci_write_config_dword(dev, 0x4C, pcic);
@@ -598,12 +574,11 @@
  *	assigned to it. We force a larger allocation to ensure that
  *	nothing gets put too close to it.
  */
-
 static void __devinit quirk_dunord ( struct pci_dev * dev )
 {
-	struct resource * r = & dev -> resource [ 1 ];
-	r -> start = 0;
-	r -> end = 0xffffff;
+	struct resource *r = &dev->resource [1];
+	r->start = 0;
+	r->end = 0xffffff;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord );
 
@@ -620,14 +595,12 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge );
 
-
 /*
  * Common misconfiguration of the MediaGX/Geode PCI master that will
  * reduce PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1
  * datasheets found at http://www.national.com/ds/GX for info on what
  * these bits do.  <christer@weinigel.se>
  */
- 
 static void __init quirk_mediagx_master(struct pci_dev *dev)
 {
 	u8 reg;
@@ -640,7 +613,6 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
 
-
 /*
  * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
  * running in Compatible mode (bits 0 and 2 in the ProgIf for primary and
@@ -658,7 +630,6 @@
  * we do now ? We don't want is pci_enable_device to come along
  * and assign new resources. Both approaches work for that.
  */ 
-
 static void __devinit quirk_ide_bases(struct pci_dev *dev)
 {
        struct resource *res;
@@ -697,18 +668,16 @@
  *	the BIOS but in the odd case it is not the results are corruption
  *	hence the presence of a Linux check
  */
- 
 static void __init quirk_disable_pxb(struct pci_dev *pdev)
 {
 	u16 config;
 	u8 rev;
 	
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
-	if(rev != 0x04)		/* Only C0 requires this */
+	if (rev != 0x04)		/* Only C0 requires this */
 		return;
 	pci_read_config_word(pdev, 0x40, &config);
-	if(config & (1<<6))
-	{
+	if (config & (1<<6)) {
 		config &= ~(1<<6);
 		pci_write_config_word(pdev, 0x40, config);
 		printk(KERN_INFO "PCI: C0 revision 450NX. Disabling PCI restreaming.\n");
@@ -719,7 +688,6 @@
 /*
  *	VIA northbridges care about PCI_INTERRUPT_LINE
  */
- 
 int interrupt_line_quirk;
 
 static void __devinit quirk_via_bridge(struct pci_dev *pdev)
@@ -749,7 +717,6 @@
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */
-
 static void __init quirk_eisa_bridge(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
@@ -768,7 +735,6 @@
  * becomes necessary to do this tweak in two steps -- I've chosen the Host
  * bridge as trigger.
  */
-
 static int __initdata asus_hides_smbus = 0;
 
 static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
@@ -829,7 +795,7 @@
 	if (val & 0x8) {
 		pci_write_config_word(dev, 0xF2, val & (~0x8));
 		pci_read_config_word(dev, 0xF2, &val);
-		if(val & 0x8)
+		if (val & 0x8)
 			printk(KERN_INFO "PCI: i801 SMBus device continues to play 'hide and seek'! 0x%x\n", val);
 		else
 			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
@@ -916,12 +882,12 @@
 	/* the first BAR is the location of the IO APIC...we must
 	 * not touch this (and it's already covered by the fixmap), so
 	 * forcibly insert it into the resource tree */
-	if(pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
+	if (pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
 		insert_resource(&iomem_resource, &pdev->resource[0]);
 
 	/* The next five BARs all seem to be rubbish, so just clean
 	 * them out */
-	for(i=1; i < 6; i++) {
+	for (i=1; i < 6; i++) {
 		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
 	}
 
@@ -1017,9 +983,7 @@
 	while (f < end) {
 		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
  		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
-#ifdef DEBUG
-			printk(KERN_INFO "PCI: Calling quirk %p for %s\n", f->hook, pci_name(dev));
-#endif
+			pr_debug(KERN_INFO "PCI: Calling quirk %p for %s\n", f->hook, pci_name(dev));
 			f->hook(dev);
 		}
 		f++;

