Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbTCIT2C>; Sun, 9 Mar 2003 14:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbTCIT1Y>; Sun, 9 Mar 2003 14:27:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36114 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262584AbTCIT0C>; Sun, 9 Mar 2003 14:26:02 -0500
Date: Sun, 9 Mar 2003 19:36:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (5/7): add support for ICH4-M chipset in speedstep driver
Message-ID: <20030309193639.F26266@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Dominik Brodowski <linux@brodo.de> -----

From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq (5/7): add support for ICH4-M chipset in speedstep driver
Date: Fri, 7 Mar 2003 11:09:16 +0100

Intel ICH4-M soutbridges use exactly the same register interface for SpeedStep 
as ICH2-M and ICH3-M southbridges -- which makes adding support for this 
bridge (almost) trivial.

Please apply,

	Dominik

 speedstep.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-03-06 21:56:18.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-03-06 21:57:07.000000000 +0100
@@ -29,6 +29,9 @@
 
 #include <asm/msr.h>
 
+#ifndef PCI_DEVICE_ID_INTEL_82801DB_12
+#define PCI_DEVICE_ID_INTEL_82801DB_12  0x24cc
+#endif
 
 /* speedstep_chipset:
  *   It is necessary to know which chipset is used. As accesses to 
@@ -40,7 +43,7 @@
 
 #define SPEEDSTEP_CHIPSET_ICH2M         0x00000002
 #define SPEEDSTEP_CHIPSET_ICH3M         0x00000003
-
+#define SPEEDSTEP_CHIPSET_ICH4M         0x00000004
 
 /* speedstep_processor
  */
@@ -106,6 +109,7 @@
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
 	case SPEEDSTEP_CHIPSET_ICH3M:
+	case SPEEDSTEP_CHIPSET_ICH4M:
 		/* get PMBASE */
 		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
 		if (!(pmbase & 0x01))
@@ -166,6 +170,7 @@
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
 	case SPEEDSTEP_CHIPSET_ICH3M:
+	case SPEEDSTEP_CHIPSET_ICH4M:
 		/* get PMBASE */
 		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
 		if (!(pmbase & 0x01))
@@ -245,6 +250,7 @@
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
 	case SPEEDSTEP_CHIPSET_ICH3M:
+	case SPEEDSTEP_CHIPSET_ICH4M:
 	{
 		u16             value = 0;
 
@@ -277,6 +283,14 @@
 static unsigned int speedstep_detect_chipset (void)
 {
 	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+			      PCI_DEVICE_ID_INTEL_82801DB_12, 
+			      PCI_ANY_ID,
+			      PCI_ANY_ID,
+			      NULL);
+	if (speedstep_chipset_dev)
+		return SPEEDSTEP_CHIPSET_ICH4M;
+
+	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
 			      PCI_DEVICE_ID_INTEL_82801CA_12, 
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

