Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRK1Lll>; Wed, 28 Nov 2001 06:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281890AbRK1Llb>; Wed, 28 Nov 2001 06:41:31 -0500
Received: from mail.galactica.it ([212.41.208.22]:16646 "EHLO galactica.it")
	by vger.kernel.org with ESMTP id <S281877AbRK1LlV>;
	Wed, 28 Nov 2001 06:41:21 -0500
From: "Matteo Sasso" <icemaze@tiscalinet.it>
To: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Subject: Tiny cosmetic patch
Date: Wed, 28 Nov 2001 12:42:35 +0100
Message-ID: <GAELJDOEMJGDLHEONDIOKECJCBAA.icemaze@tiscalinet.it>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0006_01C1780A.27E80E10"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2776.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C1780A.27E80E10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I noticed that lots of printk() have no loglevel tag on them, bringing them
down to loglevel 4. This results in many spurious messages when a loglevel
below 7 is selected.

Here's a tiny patch for a couple of "PCI: Enabling device" messages, which I
chose because there IS one of them with a KERN_INFO tag:
###
linux-2.5.16/arch/sh/kernel/pcibios.c:97:	printk(KERN_INFO "PCI: Enabling
device %s (%04x -> %04x)\n", dev->name, old_cmd, cmd);
###
so - I thought - why others shouldn't have it? They ARE informational
messages! So here's the patch against 2.4.16. If it will be included, I will
fix up some others...
--
icemaze@tiscalinet.it

------=_NextPart_000_0006_01C1780A.27E80E10
Content-Type: application/octet-stream;
	name="console-loglevel-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="console-loglevel-patch"

diff -Nru linux-2.4.16/arch/i386/kernel/pci-i386.c =
linux/arch/i386/kernel/pci-i386.c=0A=
--- linux-2.4.16/arch/i386/kernel/pci-i386.c	Wed Nov 28 10:24:33 2001=0A=
+++ linux/arch/i386/kernel/pci-i386.c	Wed Nov 28 10:31:40 2001=0A=
@@ -325,7 +325,7 @@=0A=
 	if (dev->resource[PCI_ROM_RESOURCE].start)=0A=
 		cmd |=3D PCI_COMMAND_MEMORY;=0A=
 	if (cmd !=3D old_cmd) {=0A=
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", dev->slot_name, =
old_cmd, cmd);=0A=
+		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n", =
dev->slot_name, old_cmd, cmd);=0A=
 		pci_write_config_word(dev, PCI_COMMAND, cmd);=0A=
 	}=0A=
 	return 0;=0A=
=0A=
diff -Nru linux-2.4.16/arch/mips/ddb5476/pci.c =
linux/arch/mips/ddb5476/pci.c=0A=
--- linux-2.4.16/arch/mips/ddb5476/pci.c	Sun Sep  9 19:43:01 2001=0A=
+++ linux/arch/mips/ddb5476/pci.c	Wed Nov 28 10:36:24 2001=0A=
@@ -426,7 +426,7 @@=0A=
 			cmd |=3D PCI_COMMAND_MEMORY;=0A=
 	}=0A=
 	if (cmd !=3D old_cmd) {=0A=
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",=0A=
+		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n",=0A=
 		       dev->slot_name, old_cmd, cmd);=0A=
 		pci_write_config_word(dev, PCI_COMMAND, cmd);=0A=
 	}=0A=
=0A=
diff -Nru linux-2.4.16/arch/mips/ddb5074/pci.c =
linux/arch/mips/ddb5074/pci.c=0A=
--- linux-2.4.16/arch/mips/ddb5074/pci.c	Sun Sep  9 19:43:01 2001=0A=
+++ linux/arch/mips/ddb5074/pci.c	Wed Nov 28 10:36:51 2001=0A=
@@ -352,7 +352,7 @@=0A=
 			cmd |=3D PCI_COMMAND_MEMORY;=0A=
 	}=0A=
 	if (cmd !=3D old_cmd) {=0A=
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",=0A=
+		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n",=0A=
 		       dev->slot_name, old_cmd, cmd);=0A=
 		pci_write_config_word(dev, PCI_COMMAND, cmd);=0A=
 	}=0A=
=0A=
diff -Nru linux-2.4.16/arch/ppc/kernel/pci.c linux/arch/ppc/kernel/pci.c=0A=
--- linux-2.4.16/arch/ppc/kernel/pci.c	Wed Nov 28 10:20:44 2001=0A=
+++ linux/arch/ppc/kernel/pci.c	Wed Nov 28 10:37:09 2001=0A=
@@ -410,7 +410,7 @@=0A=
 	if (dev->resource[PCI_ROM_RESOURCE].start)=0A=
 		cmd |=3D PCI_COMMAND_MEMORY;=0A=
 	if (cmd !=3D old_cmd) {=0A=
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", dev->slot_name, =
old_cmd, cmd);=0A=
+		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n", =
dev->slot_name, old_cmd, cmd);=0A=
 		pci_write_config_word(dev, PCI_COMMAND, cmd);=0A=
 	}=0A=
 	return 0;=0A=
@@ -873,7 +873,7 @@=0A=
 			cmd |=3D PCI_COMMAND_MEMORY;=0A=
 	}=0A=
 	if (cmd !=3D old_cmd) {=0A=
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",=0A=
+		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n",=0A=
 		       dev->slot_name, old_cmd, cmd);=0A=
 		pci_write_config_word(dev, PCI_COMMAND, cmd);=0A=
 	}=0A=

------=_NextPart_000_0006_01C1780A.27E80E10--

