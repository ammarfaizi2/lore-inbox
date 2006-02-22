Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWBVWMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWBVWMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWBVWLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:11:41 -0500
Received: from fmr19.intel.com ([134.134.136.18]:51080 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751489AbWBVWLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:11 -0500
Date: Wed, 22 Feb 2006 13:58:02 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 7/13] ATA ACPI: more Makefile/Kconfig
Message-Id: <20060222135802.60ab42ab.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Simplify Makefile.
Add Kconfig help.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/Kconfig  |   10 +++++++++-
 drivers/scsi/Makefile |    6 ++----
 2 files changed, 11 insertions(+), 5 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/Makefile
+++ linux-2616-rc4-ata/drivers/scsi/Makefile
@@ -163,10 +163,8 @@ ncr53c8xx-flags-$(CONFIG_SCSI_ZALON) \
 CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-y) $(ncr53c8xx-flags-m)
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
-libata-objs	:= libata-core.o libata-scsi.o
-ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
-  libata-objs	+= libata-acpi.o
-endif
+libata-y	:= libata-core.o libata-scsi.o
+libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
--- linux-2616-rc4-ata.orig/drivers/scsi/Kconfig
+++ linux-2616-rc4-ata/drivers/scsi/Kconfig
@@ -601,8 +601,16 @@ config SCSI_SATA_INTEL_COMBINED
 
 config SCSI_SATA_ACPI
 	bool
-	depends on SCSI_SATA && ACPI
+	depends on SCSI_SATA && ACPI && PCI
 	default y
+	help
+	  This option adds support for SATA-related ACPI objects.
+	  These ACPI objects add the ability to retrieve taskfiles
+	  from the ACPI BIOS and write them to the disk controller.
+	  These objects may be related to performance, security,
+	  power management, or other areas.
+	  You can disable this at kernel boot time by using the
+	  option 'libata.noacpi'.
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
