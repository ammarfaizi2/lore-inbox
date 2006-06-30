Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWF3WS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWF3WS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWF3WS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:18:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750771AbWF3WS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:18:58 -0400
Date: Fri, 30 Jun 2006 15:18:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Alessio Sangalli <alesan@manoweb.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org>
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jul 2006, Daniel Ritz wrote:
> 
> nope. but from the docs available i would _guess_ this thing is really
> similar to the 82443BX/82371AB combination. at least the SMBus base address
> register is hidden at the very same place (32bit at 0x90 in function 3 of the
> "south" brigde)...so the attached little patch might be enough to fix things...

Alessio has PCI ID 8086:7194, which is not the 82443MX_3, so you'd need 
something like this instead (but yes, it might indeed be the standard 
PIIX4 quirks).

		Linus

---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4364d79..0c073b4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -401,6 +401,7 @@ static void __devinit quirk_piix4_acpi(s
 	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82440MX_0,	quirk_piix4_acpi );
 
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9ae6b1a..889d4da 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2205,6 +2205,7 @@ #define PCI_DEVICE_ID_INTEL_82443LX_1	0x
 #define PCI_DEVICE_ID_INTEL_82443BX_0	0x7190
 #define PCI_DEVICE_ID_INTEL_82443BX_1	0x7191
 #define PCI_DEVICE_ID_INTEL_82443BX_2	0x7192
+#define PCI_DEVICE_ID_INTEL_82440MX_0	0x7194
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #define PCI_DEVICE_ID_INTEL_440MX_6	0x7196
 #define PCI_DEVICE_ID_INTEL_82443MX_0	0x7198
