Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312497AbSCUVPZ>; Thu, 21 Mar 2002 16:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312499AbSCUVPG>; Thu, 21 Mar 2002 16:15:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:35797 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312497AbSCUVO5>; Thu, 21 Mar 2002 16:14:57 -0500
Date: Thu, 21 Mar 2002 22:14:38 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: [patch] fix the last .text.exit error in 2.4.19-pre4
Message-ID: <Pine.NEB.4.44.0203212211200.2125-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

there's still one .text.exit error in 2.4.19-pre4:

drivers/char/char.o(.data+0xad74): undefined reference to `local symbols
in discarded section .text.exit'

It seems the following part of the latest version of Andrew Morton's
.text.exit fixes didn't make it into 2.4.19-pre4 (with this patch it's
fixed):

--- linux-2.4.18-rc1/drivers/char/wdt_pci.c	Wed Feb 13 12:59:10 2002
+++ linux-akpm/drivers/char/wdt_pci.c	Thu Feb 14 19:23:21 2002
@@ -577,7 +577,7 @@ out_reg:
 }


-static void __exit wdtpci_remove_one (struct pci_dev *pdev)
+static void __devexit wdtpci_remove_one (struct pci_dev *pdev)
 {
 	/* here we assume only one device will ever have
 	 * been picked up and registered by probe function */
@@ -602,7 +602,7 @@ static struct pci_driver wdtpci_driver =
 	name:		"wdt-pci",
 	id_table:	wdtpci_pci_tbl,
 	probe:		wdtpci_init_one,
-	remove:		wdtpci_remove_one,
+	remove:		__devexit_p(wdtpci_remove_one),
 };




cu
Adrian


