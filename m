Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTBGQlR>; Fri, 7 Feb 2003 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBGQlR>; Fri, 7 Feb 2003 11:41:17 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:44042 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266010AbTBGQlO>;
	Fri, 7 Feb 2003 11:41:14 -0500
To: Linus Torvalds <torvalds@transmeta.com>
CC: andrew.grover@intel.com, trivial@rustcorp.com.au,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL, RESEND][ACPI, PCI] boot messages need line feeds
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
Date: Fri, 07 Feb 2003 17:44:54 +0100
Message-ID: <87of5o9h15.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


[This time sent to Linus, CC to Andrew Grover and the Trivial Patch
Monkey]


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
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:02.0
ACPI: No IRQ known for interrupt pin A of device 00:02.0 - using IRQ 255
pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:02.1
ACPI: No IRQ known for interrupt pin B of device 00:02.1 - using IRQ 255
pci_link-0484 [16] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:03.0
ACPI: No IRQ known for interrupt pin A of device 00:03.0pci_link-0484 [16] =
acpi_pci_link_get_irq : Link disabled

                                                        ^I think, here
should be a line feed.  Next messages:

 pci_irq-0256 [15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:07.2
ACPI: No IRQ known for interrupt pin D of device 00:07.2<6>PCI: Using ACPI =
for IRQ routing
                                                        ^and again.

The following patch fixes it.

--- linux-2.5.59/drivers/acpi/pci_irq.c.jh	2003-01-25 10:09:10.000000000 +0=
100
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
=20
 	dev->irq =3D irq;

Jochen

--=20
Wenn Du nicht wei=DFt was Du tust, tu's mit Eleganz.

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


--=20
Wenn Du nicht wei=DFt was Du tust, tu's mit Eleganz.

--=-=-=--
