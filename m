Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291129AbSBGOp5>; Thu, 7 Feb 2002 09:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291143AbSBGOpr>; Thu, 7 Feb 2002 09:45:47 -0500
Received: from [151.17.201.167] ([151.17.201.167]:56847 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S291129AbSBGOpe>;
	Thu, 7 Feb 2002 09:45:34 -0500
Message-ID: <3C6291E8.AFF26AD1@teamfab.it>
Date: Thu, 07 Feb 2002 15:40:40 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ian Abbott <abbotti@mev.co.uk>, Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Support for the Decision PCCOM 4 ports in Serial 5.0.5
Content-Type: multipart/mixed;
 boundary="------------9FE6EF772A2C38E3AA764E0D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9FE6EF772A2C38E3AA764E0D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

This patch add support for the Decision PCCOM 4 (1) ports pci cards.
The patch was made and tested on a 2.2.19 kernel with the 5.0.5
serial driver.

bye,
luca

(1) 
Serial controller: Decision Computer International Co. PCCOM4 (rev 02) (prog-if 02 [16550])
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 5
Region 0: Memory at e9002000 (32-bit, non-prefetchable)
Region 1: I/O ports at e400
Region 3: I/O ports at e800
--------------9FE6EF772A2C38E3AA764E0D
Content-Type: text/plain; charset=us-ascii;
 name="pccom4_diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pccom4_diff.txt"

diff -ur linux-2.2.19-ori/drivers/char/serial.c linux-2.2.19/drivers/char/serial.c
--- linux-2.2.19-ori/drivers/char/serial.c	Mon Aug  6 12:06:13 2001
+++ linux-2.2.19/drivers/char/serial.c	Thu Feb  7 12:07:13 2002
@@ -54,6 +54,9 @@
  *  7/00: fix some returns on failure not using MOD_DEC_USE_COUNT.
  *	  Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *
+ *  2/02: Support for the Decision PCCOM 4 ports added.
+ *	  Luca Montecchiani <l.montecchiani@teamsystem.com>
+ *
  * This module exports the following rs232 io functions:
  *
  *	int rs_init(void);
@@ -4569,10 +4572,15 @@
 		SPCI_FL_BASE0, 1, 520833,
 		64, 3, NULL, 0x300 },
 #endif
+	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM4,
+		PCI_ANY_ID, PCI_ANY_ID,
+		SPCI_FL_BASE3, 4, 115200,
+		8 },
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
 		PCI_ANY_ID, PCI_ANY_ID,
 		SPCI_FL_BASE3, 8, 115200,
-		8 },		
+		8 },
 	/* Generic serial board */
 	{	0, 0,
 		0, 0,
diff -ur linux-2.2.19-ori/drivers/char/serial_compat.h linux-2.2.19/drivers/char/serial_compat.h
--- linux-2.2.19-ori/drivers/char/serial_compat.h	Mon Aug  6 12:06:13 2001
+++ linux-2.2.19/drivers/char/serial_compat.h	Thu Feb  7 11:39:41 2002
@@ -476,6 +476,10 @@
 #define PCI_DEVICE_ID_RASTEL_2PORT	0x2000
 #endif
 
+#ifndef PCI_DEVICE_ID_DCI_PCCOM4
+#define PCI_DEVICE_ID_DCI_PCCOM4 0x0001
+#endif
+
 #ifndef PCI_DEVICE_ID_DCI_PCCOM8
 #define PCI_DEVICE_ID_DCI_PCCOM8 0x0002
 #endif

--------------9FE6EF772A2C38E3AA764E0D--

