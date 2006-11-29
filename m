Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933667AbWK2FMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933667AbWK2FMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933429AbWK2FME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:12:04 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:26984 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933667AbWK2FMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:12:02 -0500
Date: Tue, 28 Nov 2006 21:12:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jirislaby@gmail.com
Subject: [PATCH -mm] char: drivers use/need PCI
Message-Id: <20061128211203.fa197b15.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

With CONFIG_PCI=n:
drivers/char/mxser_new.c: In function 'mxser_release_res':
drivers/char/mxser_new.c:2383: warning: implicit declaration of function 'pci_release_region'
drivers/char/mxser_new.c: In function 'mxser_probe':
drivers/char/mxser_new.c:2578: warning: implicit declaration of function 'pci_request_region'
drivers/built-in.o: In function `sx_remove_card':
sx.c:(.text.sx_remove_card+0x65): undefined reference to `pci_release_region'
drivers/char/isicom.c: In function 'isicom_probe':
drivers/char/isicom.c:1793: warning: implicit declaration of function 'pci_request_region'
drivers/char/isicom.c:1827: warning: implicit declaration of function 'pci_release_region'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc6-mm2.orig/drivers/char/Kconfig
+++ linux-2.6.19-rc6-mm2/drivers/char/Kconfig
@@ -203,7 +203,7 @@ config MOXA_SMARTIO
 
 config MOXA_SMARTIO_NEW
 	tristate "Moxa SmartIO support v. 2.0 (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
@@ -218,7 +218,7 @@ config MOXA_SMARTIO_NEW
 
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	select FW_LOADER
 	help
 	  This is a driver for the Multi-Tech cards which provide several
@@ -312,7 +312,7 @@ config SPECIALIX_RTSCTS
 
 config SX
 	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	help
 	  This is a driver for the SX and SI multiport serial cards.
 	  Please read the file <file:Documentation/sx.txt> for details.


---
