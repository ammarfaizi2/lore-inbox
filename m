Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281494AbRKMFyS>; Tue, 13 Nov 2001 00:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRKMFyI>; Tue, 13 Nov 2001 00:54:08 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:19594 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281494AbRKMFyA>; Tue, 13 Nov 2001 00:54:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 13 Nov 2001 16:54:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15344.46456.814742.182373@notabene.cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
In-Reply-To: message from Linus Torvalds on Monday November 12
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 12, torvalds@transmeta.com wrote:
> 
> Which means that I'd also like people to double-check that there are no
> embarrassing missing pieces due to the merge (or other patches).

I'm still lamenting the loss of the "-Werror" compile switch....

I compiled a fairly vanilla config, filtered the wheat from the chaff
and got:

agpgart_be.c:1533: warning: `intel_820_cleanup' defined but not used
lvm-snap.c: In function `lvm_snapshot_release':
lvm-snap.c:545: warning: unused variable `nbhs'
uhci.c:2986: warning: initialization discards qualifiers from pointer target type
dmi_scan.c:195: warning: `disable_ide_dma' defined but not used

The following patch removes these warnings.  I suspect all parts are
correct, but *please* don't apply unless you (or someone else)
corroborate.

NeilBrown



--- ./drivers/char/agp/agpgart_be.c	2001/11/13 05:38:20	1.1
+++ ./drivers/char/agp/agpgart_be.c	2001/11/13 05:38:31
@@ -1529,6 +1529,7 @@
   return;
 }
 
+#if 0
 static void intel_820_cleanup(void)
 {
 	u8 temp;
@@ -1541,7 +1542,7 @@
 	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
 			      previous_size->size_value);
 }
-
+#endif
 
 static int intel_820_configure(void)
 {
--- ./drivers/usb/uhci.c	2001/11/13 05:41:32	1.1
+++ ./drivers/usb/uhci.c	2001/11/13 05:41:36
@@ -2968,7 +2968,7 @@
 }
 #endif
 
-static const struct pci_device_id __devinitdata uhci_pci_ids[] = { {
+static const struct pci_device_id uhci_pci_ids[] = { {
 
 	/* handle any USB UHCI controller */
 	class: 		((PCI_CLASS_SERIAL_USB << 8) | 0x00),
--- ./drivers/md/lvm-snap.c	2001/11/13 05:35:39	1.1
+++ ./drivers/md/lvm-snap.c	2001/11/13 05:35:41
@@ -542,7 +542,6 @@
 
 void lvm_snapshot_release(lv_t * lv)
 {
-	int 	nbhs = KIO_MAX_SECTORS;
 
 	if (lv->lv_block_exception)
 	{
--- ./arch/i386/kernel/dmi_scan.c	2001/11/13 05:42:55	1.1
+++ ./arch/i386/kernel/dmi_scan.c	2001/11/13 05:43:01
@@ -184,6 +184,7 @@
 #define NO_MATCH	{ NONE, NULL}
 #define MATCH(a,b)	{ a, b }
 
+#if 0
 /*
  *	We have problems with IDE DMA on some platforms. In paticular the
  *	KT7 series. On these it seems the newer BIOS has fixed them. The
@@ -203,6 +204,7 @@
 #endif	
 	return 0;
 }
+#endif
 
 /* 
  * Reboot options and system auto-detection code provided by
