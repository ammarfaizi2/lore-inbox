Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312339AbSCYIDk>; Mon, 25 Mar 2002 03:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312345AbSCYIDe>; Mon, 25 Mar 2002 03:03:34 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:26574 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S312339AbSCYIDR>; Mon, 25 Mar 2002 03:03:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7 Documentation/scsi
Date: Mon, 25 Mar 2002 09:03:31 +0100
X-Mailer: KMail [version 1.3.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203250903.31974@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This skript'n'patch creates Documentation/scsi and moves the scsi-related
documentation into. The docs are collected from Documentation/ and
drivers/scsi/*.

It also does:
-kill Changelog.serverraid. It's an older copy of Changelog.ids,
-fixes the references to the docs in drivers and Config.help,
-renames the files from README.* to *.txt to look the same way like the other
Documentation directories.
-makes some minor changes (all but one cosmetic) to the docs. The one not
cosmetic is the patch to cpqfc.txt, which kills 2 lines describing how to
include the driver into the kernel.

Depends on my patch to Documentation/00-INDEX!

Eike

Here comes the script:
---------------------
#!/bin/bash

mkdir Documentation/scsi
mv drivers/scsi/README.* Documentation/scsi/
rm drivers/scsi/ChangeLog.serverraid
mv drivers/scsi/ChangeLog.* Documentation/scsi/
mv drivers/scsi/LICENSE.FlashPoint Documentation/scsi/
mv drivers/scsi/aic7xxx_old/README.aic7xxx Documentation/scsi/README.aic7xxx_old
mv drivers/scsi/sym53c8xx_2/ChangeLog.txt Documentation/scsi/ChangeLog.sym53c8xx_2
mv drivers/scsi/sym53c8xx_2/Documentation.txt Documentation/scsi/README.sym53c8xx_2
mv drivers/scsi/cpqfc.Readme Documentation/scsi/cpqfc.txt
mv Documentation/scsi.txt Documentation/scsi/
mv Documentation/scsi-generic.txt Documentation/scsi/
mv Documentation/README.nsp_cs.eng Documentation/scsi/NinjaSCSI.txt
cd Documentation/scsi
for i in README.*; do
 mv $i `echo $i| sed 's/README\.//'`.txt
done
cd ../..

---------------------

diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/00-INDEX linux-2.5.7-scsi-doc/Documentation/00-INDEX
--- linux-2.5.7-scsi-doc-moved/Documentation/00-INDEX	Sun Mar 24 20:59:55 2002
+++ linux-2.5.7-scsi-doc/Documentation/00-INDEX	Sun Mar 24 20:59:12 2002
@@ -34,8 +34,6 @@
 	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux
 README.moxa
 	- release notes for Moxa mutiport serial card.
-README.nsp_cs.eng
-	- info on WorkBiT NinjaSCSI-3/32Bi driver.
 SAK.txt
 	- info on Secure Attention Keys.
 SubmittingDrivers
@@ -188,10 +186,8 @@
 	- directory with info on using Linux on the IBM S390.
 sh/
 	- directory with info on porting Linux to a new architecture.
-scsi-generic.txt
-	- info on the sg driver for generic (non-disk/CD/tape) SCSI devices.
-scsi.txt
-	- short blurb on using SCSI support as a module.
+scsi/
+	- directory with info on Linux scsi support.
 serial-console.txt
 	- how to set up Linux with a serial line console as the default.
 sgi-visws.txt
diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/scsi/00-INDEX linux-2.5.7-scsi-doc/Documentation/scsi/00-INDEX
--- linux-2.5.7-scsi-doc-moved/Documentation/scsi/00-INDEX	Thu Jan  1 01:00:00 1970
+++ linux-2.5.7-scsi-doc/Documentation/scsi/00-INDEX	Thu Mar 21 08:42:22 2002
@@ -0,0 +1,66 @@
+00-INDEX
+	- this file
+53c700.txt
+	- info on driver for 53c700 based adapters
+AM53C974.txt
+	- info on driver for AM53c974 based adapters
+BusLogic.txt
+	- info on driver for adapters with BusLogic chips
+ChangeLog
+	- Changes to scsi files, if not listed elsewhere
+ChangeLog.ips
+	- IBM ServeRAID driver Changelog
+ChangeLog.ncr53c8xx
+	- Changes to ncr53c8xx driver
+ChangeLog.sym53c8xx
+	- Changes to sym53c8xx driver
+ChangeLog.sym53c8xx_2
+	- Changes to second generation of sym53c8xx driver
+FlashPoint.txt
+	- info on driver for BusLogic FlashPoint adapters
+LICENSE.FlashPoint
+	- Licence of the Flashpoint driver
+Mylex.txt
+	- info on driver for Mylex adapters
+NinjaSCSI.txt
+	- info on WorkBiT NinjaSCSI-32/32Bi driver
+aha152x.txt
+	- info on driver for Adaptec AHA152x based adapters
+aic7xxx.txt
+	- info on driver for Adaptec controllers
+aic7xxx_old.txt
+	- info on driver for Adaptec controllers, old generation
+cpqfc.txt
+	- info on driver for Compaq Tachyon TS adapters
+dpti.txt
+	- info on driver for DPT SmartRAID and Adaptec I2O RAID based adapters
+dtc3x80.txt
+	- info on driver for DTC 2x80 based adapters
+g_NCR5380.txt
+	- info on driver for NCR5380 and NCR53c400 based adapters
+ibmmca.txt
+	- info on driver for IBM adapters with MCA bus
+in2000.txt
+	- info on in2000 driver
+ncr53c7xx.txt
+	- info on driver for NCR53c7xx based adapters
+ncr53c8xx.txt
+	- info on driver for NCR53c8xx based adapters
+osst.txt
+	- info on driver for OnStream SC-x0 SCSI tape
+ppa.txt
+	- info on driver for IOmega zip drive
+qlogicfas.txt
+	- info on driver for QLogic FASxxx based adapters
+qlogicisp.txt
+	- info on driver for QLogic ISP 1020 based adapters
+scsi-generic.txt
+	- info on the sg driver for generic (non-disk/CD/tape) SCSI devices.
+scsi.txt
+	- short blurb on using SCSI support as a module.
+st.txt
+	- info on scsi tape driver
+sym53c8xx_2.txt
+	- info on second generation driver for sym53c8xx based adapters
+tmscsim.txt
+	- info on driver for AM53c974 based adapters
diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/scsi/ChangeLog.ips linux-2.5.7-scsi-doc/Documentation/scsi/ChangeLog.ips
--- linux-2.5.7-scsi-doc-moved/Documentation/scsi/ChangeLog.ips	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/Documentation/scsi/ChangeLog.ips	Tue Mar 19 10:53:49 2002
@@ -86,4 +86,3 @@
                 - Fixed read/write errors when the adapter is using an
                   8K stripe size.
 
-
\ No newline at end of file
diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/scsi/ChangeLog.sym53c8xx_2 linux-2.5.7-scsi-doc/Documentation/scsi/ChangeLog.sym53c8xx_2
--- linux-2.5.7-scsi-doc-moved/Documentation/scsi/ChangeLog.sym53c8xx_2	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/Documentation/scsi/ChangeLog.sym53c8xx_2	Tue Mar 19 10:53:49 2002
@@ -142,7 +142,3 @@
 	  consistent with what archs are expecting.
 	- Use MMIO per default for Power PC instead of some fake normal IO,
 	  as Paul Mackerras stated that MMIO works fine now on this arch.
-
-
-
-
diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/scsi/FlashPoint.txt linux-2.5.7-scsi-doc/Documentation/scsi/FlashPoint.txt
--- linux-2.5.7-scsi-doc-moved/Documentation/scsi/FlashPoint.txt	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/Documentation/scsi/FlashPoint.txt	Tue Mar 19 10:53:49 2002
@@ -60,7 +60,7 @@
 Mylex Corp.
 510/796-6100
 peters@mylex.com
-
+
 			       ANNOUNCEMENT
 	       BusLogic FlashPoint LT/BT-948 Upgrade Program
 			      1 February 1996
diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/scsi/cpqfc.txt linux-2.5.7-scsi-doc/Documentation/scsi/cpqfc.txt
--- linux-2.5.7-scsi-doc-moved/Documentation/scsi/cpqfc.txt	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/Documentation/scsi/cpqfc.txt	Tue Mar 19 14:11:56 2002
@@ -91,8 +91,6 @@
 using "qa_test" (esp. io_test script) suite modified from Unix tests.
 	
 Installation:
-copy file cpqfcTS.patch to /usr/src/linux
-patch -p1 < cpqfcTS.patch
 make menuconfig
   (select SCSI low-level, Compaq FC HBA)
 make dep
diff -Naur linux-2.5.7-scsi-doc-moved/Documentation/scsi/dtc3x80.txt linux-2.5.7-scsi-doc/Documentation/scsi/dtc3x80.txt
--- linux-2.5.7-scsi-doc-moved/Documentation/scsi/dtc3x80.txt	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/Documentation/scsi/dtc3x80.txt	Tue Mar 19 10:53:49 2002
@@ -41,5 +41,3 @@
 nowhere, I give up.  So.....This driver does NOT use interrupts, even
 if you have the card jumpered to an IRQ.  Probably nobody will ever
 care.
-
-
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/Config.help linux-2.5.7-scsi-doc/drivers/scsi/Config.help
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/Config.help	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/Config.help	Tue Mar 19 15:12:43 2002
@@ -29,7 +29,7 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called sd_mod.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.  Do not compile this driver as a
+  <file:Documentation/scsi/scsi.txt>.  Do not compile this driver as a
   module if your root file system (the one containing the directory /)
   is located on a SCSI disk. In this case, do not compile the driver
   for your SCSI host adapter (below) as a module either.
@@ -51,14 +51,14 @@
   If you want to use a SCSI tape drive under Linux, say Y and read the
   SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and
-  <file:drivers/scsi/README.st> in the kernel source.  This is NOT for
-  SCSI CD-ROMs.
+  <file:Documentation/scsi/st.txt> in the kernel source.  This is
+  NOT for SCSI CD-ROMs.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called st.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.
+  <file:Documentation/scsi/scsi.txt>.
 
 CONFIG_CHR_DEV_OSST
   The OnStream SC-x0 SCSI tape drives can not be driven by the
@@ -70,7 +70,7 @@
   tapes (QIC-157) and can be driven by the standard driver st.
   For more information, you may have a look at the SCSI-HOWTO
   <http://www.linuxdoc.org/docs.html#howto>  and
-  <file:drivers/scsi/README.osst>  in the kernel source.
+  <file:Documentation/scsi/osst.txt>  in the kernel source.
   More info on the OnStream driver may be found on
   <http://linux1.onstream.nl/test/>
   Please also have a look at the standard st docu, as most of it
@@ -80,7 +80,7 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called osst.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.
+  <file:Documentation/scsi/scsi.txt>.
 
 CONFIG_BLK_DEV_SR
   If you want to use a SCSI CD-ROM under Linux, say Y and read the
@@ -92,7 +92,7 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called sr_mod.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.
+  <file:Documentation/scsi/scsi.txt>.
 
 CONFIG_SR_EXTRA_DEVS
   This controls the amount of additional space allocated in tables for
@@ -133,8 +133,8 @@
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>. The module will be called sg.o. If unsure,
-  say N.
+  <file:Documentation/scsi/scsi.txt>. The module will be called sg.o.
+  If unsure, say N.
 
 CONFIG_SCSI_MULTI_LUN
   If you have a SCSI device that supports more than one LUN (Logical
@@ -194,7 +194,7 @@
 
   It is explained in section 3.3 of the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>. You might also want to
-  read the file <file:drivers/scsi/README.aha152x>.
+  read the file <file:Documentation/scsi/aha152x.txt>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -229,7 +229,7 @@
 CONFIG_SCSI_DPT_I2O
   This driver supports all of Adaptec's I2O based RAID controllers as 
   well as the DPT SmartRaid V cards.  This is an Adaptec maintained
-  driver by Deanna Bonds.  See <file:drivers/scsi/README.dpti>.
+  driver by Deanna Bonds.  See <file:Documentation/scsi/dpti.txt>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -266,7 +266,7 @@
   Information on the configuration options for this controller can be
   found by checking the help file for each of the available
   configuration options. You should read
-  <file:drivers/scsi/aic7xxx_old/README.aic7xxx> at a minimum before
+  <file:Documentation/scsi/aic7xxx_old.txt> at a minimum before
   contacting the maintainer with any questions.  The SCSI-HOWTO,
   available from <http://www.linuxdoc.org/docs.html#howto>, can also
   be of great help.
@@ -289,19 +289,19 @@
 
   If you say Y here, you can still turn off TCQ on troublesome devices
   with the use of the tag_info boot parameter.  See the file
-  <file:drivers/scsi/README.aic7xxx> for more information on that and
-  other aic7xxx setup commands.  If this option is turned off, you may
-  still enable TCQ on known good devices by use of the tag_info boot
-  parameter.
+  <file:Documentation/scsi/aic7xxx_old.txt> for more information on
+  that and other aic7xxx setup commands.  If this option is turned off,
+  you may still enable TCQ on known good devices by use of the tag_info
+  boot parameter.
 
   If you are unsure about your devices then it is safest to say N
   here.
 
   However, TCQ can increase performance on some hard drives by as much
   as 50% or more, so it is recommended that if you say N here, you
-  should at least read the <file:drivers/scsi/README.aic7xxx> file so
-  you will know how to enable this option manually should your drives
-  prove to be safe in regards to TCQ.
+  should at least read the <file:Documentation/scsi/aic7xxx_old.txt>
+  file so you will know how to enable this option manually should your
+  drives prove to be safe in regards to TCQ.
 
   Conversely, certain drives are known to lock up or cause bus resets
   when TCQ is enabled on them.  If you have a Western Digital
@@ -358,10 +358,10 @@
   This is support for BusLogic MultiMaster and FlashPoint SCSI Host
   Adapters. Consult the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and the files
-  <file:drivers/scsi/README.BusLogic> and
-  <file:drivers/scsi/README.FlashPoint> for more information. If this
-  driver does not work correctly without modification, please contact
-  the author, Leonard N. Zubkoff, by email to lnz@dandelion.com.
+  <file:Documentation/scsi/BusLogic.txt> and
+  <file:Documentation/scsi/FlashPoint.txt> for more information. If
+  this driver does not work correctly without modification, please
+  contact the author, Leonard N. Zubkoff, by email to lnz@dandelion.com.
 
   You can also build this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -377,7 +377,8 @@
 
 CONFIG_SCSI_CPQFCTS
   Say Y here to compile in support for the Compaq StorageWorks Fibre
-  Channel 64-bit/66Mhz Host Bus Adapter.
+  Channel 64-bit/66Mhz Host Bus Adapter. Read
+  <file:Documentation/scsi/cpqfc.txt> for more information.
 
 CONFIG_SCSI_DMX3191D
   This is support for Domex DMX3191D SCSI Host Adapters.
@@ -391,7 +392,7 @@
   This is support for DTC 3180/3280 SCSI Host Adapters.  Please read
   the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and the file
-  <file:drivers/scsi/README.dtc3x80>.
+  <file:Documentation/scsi/dtc3x80.txt>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -507,7 +508,7 @@
   for the Trantor T130B in its default configuration; you might have
   to pass a command line option to the kernel at boot time if it does
   not detect your card.  See the file
-  <file:drivers/scsi/README.g_NCR5380> for details.
+  <file:Documentation/scsi/g_NCR5380.txt> for details.
 
 CONFIG_SCSI_G_NCR5380_PORT
   The NCR5380 and NCR53c400 SCSI controllers come in two varieties:
@@ -536,8 +537,8 @@
   <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/53c7,8xx.h>.  Please read
-  <file:drivers/scsi/README.ncr53c7xx> for the available boot time
-  command line options.
+  <file:Documentation/scsi/ncr53c7xx.txt> for the available boot
+  time command line options.
 
   Note: there is another driver for the 53c8xx family of controllers
   ("NCR53C8XX SCSI support" below).  If you want to use them both, you
@@ -581,7 +582,7 @@
   If your system has problems using this new major version of the
   SYM53C8XX driver, you may switch back to driver version 1.
 
-  Please read <file:drivers/scsi/sym53c8xx_2/Documentation.txt> for more
+  Please read <file:Documentation/scsi/sym53c8xx_2.txt> for more
   information.
 
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
@@ -638,7 +639,7 @@
   only one may be active at a time.  If you have a 53c8xx board, you
   probably do not want to use the "NCR53c7,8xx SCSI support".
 
-  Please read <file:drivers/scsi/README.ncr53c8xx> for more
+  Please read <file:Documentation/scsi/ncr53c8xx.txt> for more
   information.
 
 CONFIG_SCSI_SYM53C8XX
@@ -662,7 +663,7 @@
   SYM53C8XX driver, thus allowing the NCR53C8XX driver to attach them.
   The 'excl' option is also supported by the NCR53C8XX driver.
 
-  Please read <file:drivers/scsi/README.ncr53c8xx> for more
+  Please read <file:Documentation/scsi/ncr53c8xx.txt> for more
   information.
 
 CONFIG_SCSI_NCR53C8XX_SYNC
@@ -856,8 +857,8 @@
 
 CONFIG_SCSI_IN2000
   This is support for an ISA bus SCSI host adapter.  You'll find more
-  information in <file:drivers/scsi/README.in2000>. If it doesn't work
-  out of the box, you may have to change the jumpers for IRQ or
+  information in <file:Documentation/scsi/in2000.txt>. If it doesn't
+  work out of the box, you may have to change the jumpers for IRQ or
   address selection.
 
   If you want to compile this as a module ( = code which can be
@@ -937,7 +938,7 @@
   SCSI support"), below.
 
   Information about this driver is contained in
-  <file:drivers/scsi/README.qlogicfas>.  You should also read the
+  <file:Documentation/scsi/qlogicfas.txt>.  You should also read the
   SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>.
 
@@ -954,7 +955,7 @@
   If you say Y here, make sure to choose "BIOS" at the question "PCI
   access mode".
 
-  Please read the file <file:drivers/scsi/README.qlogicisp>.  You
+  Please read the file <file:Documentation/scsi/qlogicisp.txt>.  You
   should also read the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>.
 
@@ -1133,7 +1134,7 @@
   chip, e.g. Tekram DC390(T), DawiControl 2974 and some onboard
   PCscsi/PCnet (Am53/79C974) solutions.
 
-  Documentation can be found in <file:drivers/scsi/README.tmscsim>.
+  Documentation can be found in <file:Documentation/scsi/tmscsim.txt>.
 
   Note that this driver does NOT support Tekram DC390W/U/F, which are
   based on NCR/Symbios chips. Use "NCR53C8XX SCSI support" for those.
@@ -1150,7 +1151,7 @@
   EEPROM to get initial values for its settings, such as speed,
   termination, etc.  If it can't find this EEPROM, it will use
   defaults or the user supplied boot/module parameters.  For details
-  on driver configuration see <file:drivers/scsi/README.tmscsim>.
+  on driver configuration see <file:Documentation/scsi/tmscsim.txt>.
 
   If you say Y here and if no EEPROM is found, the driver gives up and
   thus only supports Tekram DC390(T) adapters.  This can be useful if
@@ -1161,7 +1162,7 @@
 
 CONFIG_SCSI_AM53C974
   This is support for the AM53/79C974 SCSI host adapters.  Please read
-  <file:drivers/scsi/README.AM53C974> for details.  Also, the
+  <file:Documentation/scsi/AM53C974.txt> for details.  Also, the
   SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, is for you.
 
@@ -1210,8 +1211,8 @@
   newer drives)", below.
 
   For more information about this driver and how to use it you should
-  read the file <file:drivers/scsi/README.ppa>.  You should also read
-  the SCSI-HOWTO, which is available from
+  read the file <file:Documentation/scsi/ppa.txt>.  You should also
+  read the SCSI-HOWTO, which is available from
   <http://www.linuxdoc.org/docs.html#howto>.  If you use this driver,
   you will still be able to use the parallel port for other tasks,
   such as a printer; it is safe to compile both drivers into the
@@ -1236,8 +1237,8 @@
   here and Y to "IOMEGA Parallel Port (ppa - older drives)", above.
 
   For more information about this driver and how to use it you should
-  read the file <file:drivers/scsi/README.ppa>.  You should also read
-  the SCSI-HOWTO, which is available from
+  read the file <file:Documentation/scsi/ppa.txt>.  You should also
+  read the SCSI-HOWTO, which is available from
   <http://www.linuxdoc.org/docs.html#howto>.  If you use this driver,
   you will still be able to use the parallel port for other tasks,
   such as a printer; it is safe to compile both drivers into the
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/FlashPoint.c linux-2.5.7-scsi-doc/drivers/scsi/FlashPoint.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/FlashPoint.c	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/FlashPoint.c	Tue Mar 19 10:53:49 2002
@@ -11,7 +11,8 @@
   Copyright 1995-1996 by Mylex Corporation.  All Rights Reserved
 
   This file is available under both the GNU General Public License
-  and a BSD-style copyright; see LICENSE.FlashPoint for details.
+  and a BSD-style copyright; see Documentation/scsi/LICENSE.FlashPoint for
+  details.
 
 */
 
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/aha152x.c linux-2.5.7-scsi-doc/drivers/scsi/aha152x.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/aha152x.c	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/aha152x.c	Tue Mar 19 14:34:26 2002
@@ -211,7 +211,7 @@
  *
  **************************************************************************
  
- see README.aha152x for configuration details
+ see Documentation/scsi/aha152x.txt for configuration details
 
  **************************************************************************/
 
@@ -1834,7 +1834,7 @@
 				       "aha152x: unable to verify geometry for disk with >1GB.\n"
 				       "         Using default translation. Please verify yourself.\n"
 				       "         Perhaps you need to enable extended translation in the driver.\n"
-				       "         See /usr/src/linux/drivers/scsi/README.aha152x for details.\n");
+				       "         See /usr/src/linux/Documentation/scsi/aha152x.txt for details.\n");
 			}
 		} else {
 			info_array[0] = info[0];
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/aic7xxx/aic7xxx_linux.c linux-2.5.7-scsi-doc/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/aic7xxx/aic7xxx_linux.c	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/aic7xxx/aic7xxx_linux.c	Tue Mar 19 14:37:19 2002
@@ -1076,7 +1076,7 @@
 		aic7xxx_setup(aic7xxx);
 	if (dummy_buffer[0] != 'P')
 		printk(KERN_WARNING
-"aic7xxx: Please read the file /usr/src/linux/drivers/scsi/README.aic7xxx\n"
+"aic7xxx: Please read the file /usr/src/linux/Documentation/scsi/aic7xxx.txt\n"
 "aic7xxx: to see the proper way to specify options to the aic7xxx module\n"
 "aic7xxx: Specifically, don't use any commas when passing arguments to\n"
 "aic7xxx: insmod or else it might trash certain memory areas.\n");
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/aic7xxx_old.c linux-2.5.7-scsi-doc/drivers/scsi/aic7xxx_old.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/aic7xxx_old.c	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/aic7xxx_old.c	Tue Mar 19 14:37:57 2002
@@ -9487,8 +9487,8 @@
   if(aic7xxx)
     aic7xxx_setup(aic7xxx);
   if(dummy_buffer[0] != 'P')
-    printk(KERN_WARNING "aic7xxx: Please read the file /usr/src/linux/drivers"
-      "/scsi/README.aic7xxx\n"
+    printk(KERN_WARNING "aic7xxx: Please read the file /usr/src/linux"
+      "Documentation/scsi/aic7xxx_old.txt\n"
       "aic7xxx: to see the proper way to specify options to the aic7xxx "
       "module\n"
       "aic7xxx: Specifically, don't use any commas when passing arguments to\n"
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/dpt/dpti_ioctl.h linux-2.5.7-scsi-doc/drivers/scsi/dpt/dpti_ioctl.h
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/dpt/dpti_ioctl.h	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/dpt/dpti_ioctl.h	Tue Mar 19 14:40:06 2002
@@ -5,7 +5,8 @@
     copyright            : (C) 2001 by Adaptec
     email                : deanna_bonds@adaptec.com
 
-    See README.dpti for history, notes, license info, and credits
+    See Documentation/scsi/dpti.txt for history, notes, license info and
+    credits
  ***************************************************************************/
 
 /***************************************************************************
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/dpt_i2o.c linux-2.5.7-scsi-doc/drivers/scsi/dpt_i2o.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/dpt_i2o.c	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/dpt_i2o.c	Tue Mar 19 14:39:27 2002
@@ -8,7 +8,8 @@
     			   July 30, 2001 First version being submitted
 			   for inclusion in the kernel.  V2.4
 
-    See README.dpti for history, notes, license info, and credits
+    See Documentation/scsi/dpti.txt for history, notes, license info and
+    credits
  ***************************************************************************/
 
 /***************************************************************************
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/dpti.h linux-2.5.7-scsi-doc/drivers/scsi/dpti.h
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/dpti.h	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/dpti.h	Tue Mar 19 14:39:11 2002
@@ -5,7 +5,8 @@
     copyright            : (C) 2001 by Adaptec
     email                : deanna_bonds@adaptec.com
 
-    See README.dpti for history, notes, license info, and credits
+    See Documentation/scsi/dpti.txt for history, notes, license info and
+    credits
  ***************************************************************************/
 
 /***************************************************************************
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/ibmmca.c linux-2.5.7-scsi-doc/drivers/scsi/ibmmca.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/ibmmca.c	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/ibmmca.c	Tue Mar 19 14:57:34 2002
@@ -4,8 +4,8 @@
  Copyright (c) 1995 Strom Systems, Inc. under the terms of the GNU
  General Public License. Written by Martin Kolinek, December 1995.
  Further development by: Chris Beauregard, Klaus Kudielka, Michael Lang
- See the file README.ibmmca for a detailed description of this driver,
- the commandline arguments and the history of its development.
+ See the file Documentation/scsi/ibmmca.txt for a detailed description of
+ this driver, the commandline arguments and the history of its development.
  See the WWW-page: http://www.uni-mainz.de/~langm000/linux.html for latest
  updates, info and ADF-files for adapters supported by this driver.
 */
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/ibmmca.h linux-2.5.7-scsi-doc/drivers/scsi/ibmmca.h
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/ibmmca.h	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/ibmmca.h	Tue Mar 19 15:15:26 2002
@@ -1,8 +1,9 @@
 /* 
  * Low Level Driver for the IBM Microchannel SCSI Subsystem
- * (Headerfile, see README.ibmmca for description of the IBM MCA SCSI-driver
- * For use under the GNU General Public License within the Linux-kernel project.
- * This include file works only correctly with kernel 2.4.0 or higher!!! */
+ * (Headerfile, see Documentation/scsi/ibmmca.txt for description of the
+ * IBM MCA SCSI-driver For use under the GNU General Public License within
+ * the Linux-kernel project. This include file works only correctly with
+ * kernel 2.4.0 or higher!!! */
 
 #ifndef _IBMMCA_H
 #define _IBMMCA_H
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/ncr53c8xx.c linux-2.5.7-scsi-doc/drivers/scsi/ncr53c8xx.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/ncr53c8xx.c	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/ncr53c8xx.c	Tue Mar 19 15:15:48 2002
@@ -1625,7 +1625,7 @@
 	**	Possible data corruption during Memory Write and Invalidate.
 	**	This work-around resets the addressing logic prior to the 
 	**	start of the first MOVE of a DATA IN phase.
-	**	(See README.ncr53c8xx for more information)
+	**	(See Documentation/scsi/ncr53c8xx.txt for more information)
 	*/
 	SCR_JUMPR ^ IFFALSE (IF (SCR_DATA_IN)),
 		20,
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/osst.c linux-2.5.7-scsi-doc/drivers/scsi/osst.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/osst.c	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/osst.c	Tue Mar 19 14:58:07 2002
@@ -1,6 +1,6 @@
 /*
   SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
-  file README.st for more information.
+  file Documentation/scsi/st.txt for more information.
 
   History:
 
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/qla1280.c linux-2.5.7-scsi-doc/drivers/scsi/qla1280.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/qla1280.c	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/qla1280.c	Tue Mar 19 14:59:28 2002
@@ -776,8 +776,8 @@
     if(options)
         qla1280_setup(options, NULL);
     if(dummy_buffer[0] != 'P')
-        printk(KERN_WARNING "qla1280: Please read the file /usr/src/linux/drivers"
-                "/scsi/README.qla1280\n"
+        printk(KERN_WARNING "qla1280: Please read the file /usr/src/linux"
+                "/Documentation/scsi/qla1280.txt\n"
                 "qla1280: to see the proper way to specify options to the qla1280 "
                 "module\n"
                 "qla1280: Specifically, don't use any commas when passing arguments to\n"
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/st.c linux-2.5.7-scsi-doc/drivers/scsi/st.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/st.c	Tue Mar 19 11:21:45 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/st.c	Tue Mar 19 14:59:57 2002
@@ -1,6 +1,6 @@
 /*
    SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
-   file README.st for more information.
+   file Documentation/scsi/st.txt for more information.
 
    History:
    Rewritten from Dwayne Forsyth's SCSI tape driver by Kai Makisara.
@@ -3638,7 +3638,7 @@
 }
 
 #ifndef MODULE
-/* Set the boot options. Syntax is defined in README.st.
+/* Set the boot options. Syntax is defined in Documentation/scsi/st.txt.
  */
 static int __init st_setup(char *str)
 {
diff -Naur linux-2.5.7-scsi-doc-moved/drivers/scsi/tmscsim.c linux-2.5.7-scsi-doc/drivers/scsi/tmscsim.c
--- linux-2.5.7-scsi-doc-moved/drivers/scsi/tmscsim.c	Tue Mar 19 11:21:46 2002
+++ linux-2.5.7-scsi-doc/drivers/scsi/tmscsim.c	Tue Mar 19 15:03:03 2002
@@ -5,7 +5,8 @@
  *		     Bus Master Host Adapter			       *
  * (C)Copyright 1995-1996 Tekram Technology Co., Ltd.		       *
  ***********************************************************************/
-/* (C) Copyright: put under GNU GPL in 10/96  (see README.tmscsim)	*
+/* (C) Copyright: put under GNU GPL in 10/96				*
+ *			(see Documentation/scsi/tmscsim.txt)		*
 *************************************************************************/
 /* $Id: tmscsim.c,v 2.60.2.30 2000/12/20 01:07:12 garloff Exp $		*/
 /*	Enhancements and bugfixes by					*
@@ -1523,7 +1524,7 @@
     DC390_write32 (DMA_ScsiBusCtrl, EN_INT_ON_PCI_ABORT);
     PDEVSET1; PCI_READ_CONFIG_WORD(PDEV, PCI_STATUS, &pstat);
     printk ("DC390: Register dump: PCI Status: %04x\n", pstat);
-    printk ("DC390: In case of driver trouble read linux/drivers/scsi/README.tmscsim\n");
+    printk ("DC390: In case of driver trouble read linux/Documentation/scsi/tmscsim.txt\n");
 };
 
 
