Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUCCUbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUCCUbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:31:04 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:57786 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261185AbUCCUa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:30:57 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove include/linux/acpi_serial.h
Date: Wed, 3 Mar 2004 13:30:56 -0700
User-Agent: KMail/1.5.4
Cc: khalid_aziz@hp.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031330.56338.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/acpi_serial.h has been obsolete for a long time,
and is never referenced.

This patch is against 2.6.4-rc1.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1630  -> 1.1631 
#	include/linux/acpi_serial.h	1.3     ->         (deleted)      
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/03	bjorn.helgaas@hp.com	1.1631
# Remove include/linux/acpi_serial.h (obsolete and unused).
# --------------------------------------------
#
diff -Nru a/include/linux/acpi_serial.h b/include/linux/acpi_serial.h
--- a/include/linux/acpi_serial.h	Wed Mar  3 13:27:49 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,107 +0,0 @@
-/*
- *  linux/include/linux/acpi_serial.h
- *
- *  Copyright (C) 2000  Hewlett-Packard Co.
- *  Copyright (C) 2000  Khalid Aziz <khalid_aziz@hp.com>
- *
- *  Definitions for ACPI defined serial ports (headless console and 
- *  debug ports)
- *
- */
-
-#include <linux/serial.h>
-
-extern void setup_serial_acpi(void *);
-
-#define ACPI_SIG_LEN		4
-
-/* ACPI table signatures */
-#define ACPI_SPCRT_SIGNATURE	"SPCR"
-#define ACPI_DBGPT_SIGNATURE	"DBGP"
-
-/* Interface type as defined in ACPI serial port tables */
-#define ACPI_SERIAL_INTFC_16550	0
-#define ACPI_SERIAL_INTFC_16450	1
-
-/* Interrupt types for ACPI serial port tables */
-#define ACPI_SERIAL_INT_PCAT	0x01
-#define ACPI_SERIAL_INT_APIC	0x02
-#define ACPI_SERIAL_INT_SAPIC	0x04
-
-/* Baud rates as defined in ACPI serial port tables */
-#define ACPI_SERIAL_BAUD_9600		3
-#define ACPI_SERIAL_BAUD_19200		4
-#define ACPI_SERIAL_BAUD_57600		6
-#define ACPI_SERIAL_BAUD_115200		7
-
-/* Parity as defined in ACPI serial port tables */
-#define ACPI_SERIAL_PARITY_NONE		0
-
-/* Flow control methods as defined in ACPI serial port tables */
-#define ACPI_SERIAL_FLOW_DCD	0x01
-#define ACPI_SERIAL_FLOW_RTS	0x02
-#define ACPI_SERIAL_FLOW_XON	0x04
-
-/* Terminal types as defined in ACPI serial port tables */
-#define ACPI_SERIAL_TERM_VT100		0
-#define ACPI_SERIAL_TERM_VT100X	1
-
-/* PCI Flags as defined by SPCR table */
-#define ACPI_SERIAL_PCIFLAG_PNP	0x00000001
-
-/* Space ID as defined in base address structure in ACPI serial port tables */
-#define ACPI_SERIAL_MEM_SPACE		0
-#define ACPI_SERIAL_IO_SPACE		1
-#define ACPI_SERIAL_PCICONF_SPACE	2
-
-/* 
- * Generic Register Address Structure - as defined by Microsoft 
- * in http://www.microsoft.com/hwdev/onnow/download/LFreeACPI.doc
- *
-*/
-typedef struct {
-	u8  space_id;
-	u8  bit_width;
-	u8  bit_offset;
-	u8  resv;
-	u32 addrl;
-	u32 addrh;
-} gen_regaddr;
-
-/* Space ID for generic register address structure */
-#define REGADDR_SPACE_SYSMEM	0
-#define REGADDR_SPACE_SYSIO	1
-#define REGADDR_SPACE_PCICONFIG	2
-
-/* Serial Port Console Redirection and Debug Port Table formats */
-typedef struct {
-	u8 signature[4];
-	u32 length;
-	u8  rev;
-	u8  chksum;
-	u8  oemid[6];
-	u8  oem_tabid[8];
-	u32 oem_rev;
-	u8  creator_id[4];
-	u32 creator_rev;
-	u8  intfc_type;
-	u8  resv1[3];
-	gen_regaddr base_addr;
-	u8  int_type;
-	u8  irq;
-	u8  global_int[4];
-	u8  baud;
-	u8  parity;
-	u8  stop_bits;
-	u8  flow_ctrl;
-	u8  termtype;
-	u8  language;
-	u16 pci_dev_id;
-	u16 pci_vendor_id;
-	u8  pci_bus;
-	u8  pci_dev;
-	u8  pci_func;
-	u8  pci_flags[4];
-	u8  pci_seg;
-	u32 resv2;
-} acpi_ser_t;

