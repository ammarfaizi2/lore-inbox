Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbTAGU2G>; Tue, 7 Jan 2003 15:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267460AbTAGU2G>; Tue, 7 Jan 2003 15:28:06 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:64456 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S267452AbTAGU2C>;
	Tue, 7 Jan 2003 15:28:02 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 2/7: fix old pci_find_capability merge botch
Date: Tue, 7 Jan 2003 13:36:40 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071336.40221.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.972   -> 1.973  
#	drivers/char/agp/sworks-agp.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.973
# Fix serverworks_agp_enable() merge botch.  (Old code not removed
# when pci_find_capability() introduced.)
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:04 2003
+++ b/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:04 2003
@@ -430,16 +430,6 @@
 	pci_for_each_dev(device) {
 		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (cap_ptr != 0x00) {
-			do {
-				pci_read_config_dword(device,
-						      cap_ptr, &cap_id);
-
-				if ((cap_id & 0xff) != 0x02)
-					cap_ptr = (cap_id >> 8) & 0xff;
-			}
-			while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-		}
-		if (cap_ptr != 0x00) {
 			/*
 			 * Ok, here we have a AGP device. Disable impossible 
 			 * settings, and adjust the readqueue to the minimum.

