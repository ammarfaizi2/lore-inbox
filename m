Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTAYRkw>; Sat, 25 Jan 2003 12:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbTAYRkw>; Sat, 25 Jan 2003 12:40:52 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:49926 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S261640AbTAYRku> convert rfc822-to-8bit;
	Sat, 25 Jan 2003 12:40:50 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL][ACPI, PCI] boot messages need line feeds
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 25 Jan 2003 10:13:27 +0100
Message-ID: <87iswdsibs.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The messages are:

pci_link-0331 [15] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 0
pci_link-0331 [15] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
pci_link-0331 [15] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 0
pci_link-0331 [15] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 0
pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:02.0
ACPI: No IRQ known for interrupt pin A of device 00:02.0 - using IRQ 255
pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:02.1
ACPI: No IRQ known for interrupt pin B of device 00:02.1 - using IRQ 255
pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:03.0
ACPI: No IRQ known for interrupt pin A of device 00:03.0pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled

                                                        ^I think, here
should be a line feed.  Next messages:

 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:07.2
ACPI: No IRQ known for interrupt pin D of device 00:07.2<6>PCI: Using ACPI for IRQ routing
                                                        ^and again.

The following patch sould fix it, but is for now untested:

--- linux-2.5.59/drivers/acpi/pci_irq.c.jh	2003-01-25 10:09:10.000000000 +0100
+++ linux-2.5.59/drivers/acpi/pci_irq.c	2003-01-25 10:10:54.000000000 +0100
@@ -351,8 +351,10 @@
 			printk(" - using IRQ %d\n", dev->irq);
 			return_VALUE(dev->irq);
 		}
-		else
+		else {
+			printk("\n");
 			return_VALUE(0);
+		}
  	}
 
 	dev->irq = irq;

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
