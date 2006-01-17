Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWAQUNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWAQUNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWAQUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:13:37 -0500
Received: from fmr20.intel.com ([134.134.136.19]:5312 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964807AbWAQUNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:13:35 -0500
Date: Tue, 17 Jan 2006 12:14:06 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Mathieu =?ISO-8859-1?B?QulyYXJk?= <Mathieu.Berard@crans.org>
Cc: lkml <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>,
       jgarzik <jgarzik@pobox.com>, akpm <akpm@osdl.org>
Subject: [PATCH 3/3] libata-acpi: update Makefile & Kconfig
Message-Id: <20060117121406.3053913a.randy_d_dunlap@linux.intel.com>
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

Changelog addition:

This option adds support for SATA-related ACPI objects.
These ACPI objects add the ability to retrieve taskfiles
from the ACPI BIOS and write them to the disk controller.
These objects may be related to performance, security,
power management, or other areas.
You can disable this at kernel boot time by using the
option 'libata.noacpi'.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/Kconfig  |    8 ++++++++
 drivers/scsi/Makefile |    6 ++----
 2 files changed, 10 insertions(+), 4 deletions(-)

--- linux-2615-mm4.orig/drivers/scsi/Makefile
+++ linux-2615-mm4/drivers/scsi/Makefile
@@ -166,10 +166,8 @@ ncr53c8xx-flags-$(CONFIG_SCSI_ZALON) \
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
--- linux-2615-mm4.orig/drivers/scsi/Kconfig
+++ linux-2615-mm4/drivers/scsi/Kconfig
@@ -620,6 +620,14 @@ config SCSI_SATA_ACPI
 	bool
 	depends on SCSI_SATA && ACPI
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


---
~Randy [MPG MPAD MSAE SSA]
