Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVCaXua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVCaXua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVCaXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:48:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:39648 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262117AbVCaXYM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:12 -0500
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] I2C: busses documentation update 2 of 2
In-Reply-To: <1112311393548@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:13 -0800
Message-Id: <11123113933537@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2341, 2005/03/31 14:30:05-08:00, R.Marek@sh.cvut.cz

[PATCH] I2C: busses documentation update 2 of 2

Patch contains promised documentation update for i2c bus drivers.
I would like to thank Jean Delvare and Aurelien Jarno for their
comments.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/i2c/busses/i2c-ali1535       |   42 ++++++++++
 Documentation/i2c/busses/i2c-ali1563       |   27 ++++++
 Documentation/i2c/busses/i2c-ali15x3       |  112 +++++++++++++++++++++++++++++
 Documentation/i2c/busses/i2c-amd756        |   25 ++++++
 Documentation/i2c/busses/i2c-amd8111       |   41 ++++++++++
 Documentation/i2c/busses/i2c-i801          |   80 ++++++++++++++++++++
 Documentation/i2c/busses/i2c-i810          |   46 +++++++++++
 Documentation/i2c/busses/i2c-nforce2       |   41 ++++++++++
 Documentation/i2c/busses/i2c-parport       |   18 ++--
 Documentation/i2c/busses/i2c-parport-light |   11 ++
 Documentation/i2c/busses/i2c-pca-isa       |   23 +++++
 Documentation/i2c/busses/i2c-piix4         |   72 ++++++++++++++++++
 Documentation/i2c/busses/i2c-prosavage     |   23 +++++
 Documentation/i2c/busses/i2c-savage4       |   26 ++++++
 Documentation/i2c/busses/i2c-sis5595       |   59 +++++++++++++++
 Documentation/i2c/busses/i2c-sis630        |   49 ++++++++++++
 Documentation/i2c/busses/i2c-sis69x        |   73 ++++++++++++++++++
 Documentation/i2c/busses/i2c-via           |   34 ++++++++
 Documentation/i2c/busses/i2c-viapro        |   47 ++++++++++++
 Documentation/i2c/busses/i2c-voodoo3       |   62 ++++++++++++++++
 Documentation/i2c/busses/scx200_acb        |   14 +++
 21 files changed, 915 insertions(+), 10 deletions(-)


diff -Nru a/Documentation/i2c/busses/i2c-ali1535 b/Documentation/i2c/busses/i2c-ali1535
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-ali1535	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,42 @@
+Kernel driver i2c-ali1535
+
+Supported adapters:
+  * Acer Labs, Inc. ALI 1535 (south bridge)
+    Datasheet: Now under NDA
+	http://www.ali.com.tw/eng/support/datasheet_request.php
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>,
+	Dan Eaton <dan.eaton@rocketlogix.com>,
+	Stephen Rousset<stephen.rousset@rocketlogix.com>
+												
+Description
+-----------
+
+This is the driver for the SMB Host controller on Acer Labs Inc. (ALI)
+M1535 South Bridge.
+
+The M1535 is a South bridge for portable systems. It is very similar to the
+M15x3 South bridges also produced by Acer Labs Inc.  Some of the registers
+within the part have moved and some have been redefined slightly.
+Additionally, the sequencing of the SMBus transactions has been modified to
+be more consistent with the sequencing recommended by the manufacturer and
+observed through testing.  These changes are reflected in this driver and
+can be identified by comparing this driver to the i2c-ali15x3 driver. For
+an overview of these chips see http://www.acerlabs.com
+
+The SMB controller is part of the M7101 device, which is an ACPI-compliant
+Power Management Unit (PMU).
+
+The whole M7101 device has to be enabled for the SMB to work. You can't
+just enable the SMB alone. The SMB and the ACPI have separate I/O spaces.
+We make sure that the SMB is enabled. We leave the ACPI alone.
+
+
+Features
+--------
+
+This driver controls the SMB Host only. This driver does not use
+interrupts.
diff -Nru a/Documentation/i2c/busses/i2c-ali1563 b/Documentation/i2c/busses/i2c-ali1563
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-ali1563	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,27 @@
+Kernel driver i2c-ali1563
+
+Supported adapters:
+  * Acer Labs, Inc. ALI 1563 (south bridge)
+    Datasheet: Now under NDA
+	http://www.ali.com.tw/eng/support/datasheet_request.php
+
+Author: Patrick Mochel <mochel@digitalimplant.org>
+
+Description
+-----------
+
+This is the driver for the SMB Host controller on Acer Labs Inc. (ALI)
+M1563 South Bridge.
+
+For an overview of these chips see http://www.acerlabs.com
+
+The M1563 southbridge is deceptively similar to the M1533, with a few
+notable exceptions. One of those happens to be the fact they upgraded the
+i2c core to be SMBus 2.0 compliant, and happens to be almost identical to
+the i2c controller found in the Intel 801 south bridges. 
+
+Features
+--------
+
+This driver controls the SMB Host only. This driver does not use
+interrupts.
diff -Nru a/Documentation/i2c/busses/i2c-ali15x3 b/Documentation/i2c/busses/i2c-ali15x3
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-ali15x3	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,112 @@
+Kernel driver i2c-ali15x3
+
+Supported adapters:
+  * Acer Labs, Inc. ALI 1533 and 1543C (south bridge)
+    Datasheet: Now under NDA
+	http://www.ali.com.tw/eng/support/datasheet_request.php
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>, 
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Initialize the base address of the i2c controller
+
+
+Notes
+-----
+
+The force_addr parameter is useful for boards that don't set the address in
+the BIOS. Does not do a PCI force; the device must still be present in
+lspci. Don't use this unless the driver complains that the base address is
+not set.
+
+Example: 'modprobe i2c-ali15x3 force_addr=0xe800'
+
+SMBus periodically hangs on ASUS P5A motherboards and can only be cleared
+by a power cycle. Cause unknown (see Issues below).
+
+
+Description
+-----------
+
+This is the driver for the SMB Host controller on Acer Labs Inc. (ALI)
+M1541 and M1543C South Bridges.
+
+The M1543C is a South bridge for desktop systems.
+The M1541 is a South bridge for portable systems.
+They are part of the following ALI chipsets:
+   
+ * "Aladdin Pro 2" includes the M1621 Slot 1 North bridge with AGP and 
+ 		100MHz CPU Front Side bus
+ * "Aladdin V" includes the M1541 Socket 7 North bridge with AGP and 100MHz 
+ 		CPU Front Side bus
+   Some Aladdin V motherboards:
+	Asus P5A
+	Atrend ATC-5220
+	BCM/GVC VP1541
+	Biostar M5ALA
+	Gigabyte GA-5AX (** Generally doesn't work because the BIOS doesn't
+                            enable the 7101 device! **)
+	Iwill XA100 Plus
+	Micronics C200
+	Microstar (MSI) MS-5169
+
+  * "Aladdin IV" includes the M1541 Socket 7 North bridge
+   		with host bus up to 83.3 MHz.
+
+For an overview of these chips see http://www.acerlabs.com. At this time the
+full data sheets on the web site are password protected, however if you
+contact the ALI office in San Jose they may give you the password.
+
+The M1533/M1543C devices appear as FOUR separate devices on the PCI bus. An
+output of lspci will show something similar to the following:
+
+  00:02.0 USB Controller: Acer Laboratories Inc. M5237 (rev 03)
+  00:03.0 Bridge: Acer Laboratories Inc. M7101      <= THIS IS THE ONE WE NEED
+  00:07.0 ISA bridge: Acer Laboratories Inc. M1533 (rev c3)
+  00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1)
+
+** IMPORTANT **
+** If you have a M1533 or M1543C on the board and you get
+** "ali15x3: Error: Can't detect ali15x3!"
+** then run lspci.
+** If you see the 1533 and 5229 devices but NOT the 7101 device,
+** then you must enable ACPI, the PMU, SMB, or something similar
+** in the BIOS. 
+** The driver won't work if it can't find the M7101 device.
+
+The SMB controller is part of the M7101 device, which is an ACPI-compliant
+Power Management Unit (PMU).
+
+The whole M7101 device has to be enabled for the SMB to work. You can't
+just enable the SMB alone. The SMB and the ACPI have separate I/O spaces.
+We make sure that the SMB is enabled. We leave the ACPI alone.
+
+Features 
+-------- 
+
+This driver controls the SMB Host only. The SMB Slave
+controller on the M15X3 is not enabled. This driver does not use
+interrupts.
+
+
+Issues
+------
+
+This driver requests the I/O space for only the SMB
+registers. It doesn't use the ACPI region.
+
+On the ASUS P5A motherboard, there are several reports that
+the SMBus will hang and this can only be resolved by
+powering off the computer. It appears to be worse when the board
+gets hot, for example under heavy CPU load, or in the summer.
+There may be electrical problems on this board.
+On the P5A, the W83781D sensor chip is on both the ISA and
+SMBus. Therefore the SMBus hangs can generally be avoided
+by accessing the W83781D on the ISA bus only.
+
diff -Nru a/Documentation/i2c/busses/i2c-amd756 b/Documentation/i2c/busses/i2c-amd756
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-amd756	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,25 @@
+Kernel driver i2c-amd756
+
+Supported adapters:
+  * AMD 756
+  * AMD 766
+  * AMD 768
+  * AMD 8111
+    Datasheets: Publicly available on AMD website
+
+  * nVidia nForce
+    Datasheet: Unavailable
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com> 
+
+Description
+-----------
+
+This driver supports the AMD 756, 766, 768 and 8111 Peripheral Bus
+Controllers, and the nVidia nForce.
+
+Note that for the 8111, there are two SMBus adapters. The SMBus 1.0 adapter
+is supported by this driver, and the SMBus 2.0 adapter is supported by the
+i2c-amd8111 driver.
diff -Nru a/Documentation/i2c/busses/i2c-amd8111 b/Documentation/i2c/busses/i2c-amd8111
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-amd8111	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,41 @@
+Kernel driver i2c-adm8111
+
+Supported adapters:
+    * AMD-8111 SMBus 2.0 PCI interface
+
+Datasheets:
+	AMD datasheet not yet available, but almost everything can be found
+	in publically available ACPI 2.0 specification, which the adapter 
+	follows.
+
+Author: Vojtech Pavlik <vojtech@suse.cz>
+
+Description
+-----------
+
+If you see something like this:
+
+00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
+        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
+        Flags: medium devsel, IRQ 19
+        I/O ports at d400 [size=32]
+
+in your 'lspci -v', then this driver is for your chipset.
+
+Process Call Support
+--------------------
+
+Supported.
+
+SMBus 2.0 Support
+-----------------
+
+Supported. Both PEC and block process call support is implemented. Slave
+mode or host notification are not yet implemented.
+
+Notes
+-----
+
+Note that for the 8111, there are two SMBus adapters. The SMBus 2.0 adapter
+is supported by this driver, and the SMBus 1.0 adapter is supported by the
+i2c-amd756 driver.
diff -Nru a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-i801	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,80 @@
+Kernel driver i2c-i801
+
+Supported adapters:
+  * Intel 82801AA and 82801AB (ICH and ICH0 - part of the
+    '810' and '810E' chipsets)
+  * Intel 82801BA (ICH2 - part of the '815E' chipset)
+  * Intel 82801CA/CAM (ICH3)
+  * Intel 82801DB (ICH4) (HW PEC supported, 32 byte buffer not supported)
+  * Intel 82801EB/ER (ICH5) (HW PEC supported, 32 byte buffer not supported)
+  * Intel 6300ESB
+  * Intel 82801FB/FR/FW/FRW (ICH6)
+  * Intel ICH7
+    Datasheets: Publicly available at the Intel website
+
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>, 
+	Mark Studebaker <mdsxyz123@yahoo.com>
+
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Forcibly enable the ICH at the given address. EXTREMELY DANGEROUS!
+
+
+Description
+-----------
+
+The ICH (properly known as the 82801AA), ICH0 (82801AB), ICH2 (82801BA),
+ICH3 (82801CA/CAM) and later devices are Intel chips that are a part of
+Intel's '810' chipset for Celeron-based PCs, '810E' chipset for
+Pentium-based PCs, '815E' chipset, and others.
+
+The ICH chips contain at least SEVEN separate PCI functions in TWO logical
+PCI devices. An output of lspci will show something similar to the
+following:
+
+  00:1e.0 PCI bridge: Intel Corporation: Unknown device 2418 (rev 01)
+  00:1f.0 ISA bridge: Intel Corporation: Unknown device 2410 (rev 01)
+  00:1f.1 IDE interface: Intel Corporation: Unknown device 2411 (rev 01)
+  00:1f.2 USB Controller: Intel Corporation: Unknown device 2412 (rev 01)
+  00:1f.3 Unknown class [0c05]: Intel Corporation: Unknown device 2413 (rev 01)
+
+The SMBus controller is function 3 in device 1f. Class 0c05 is SMBus Serial
+Controller.
+
+If you do NOT see the 24x3 device at function 3, and you can't figure out
+any way in the BIOS to enable it,
+
+The ICH chips are quite similar to Intel's PIIX4 chip, at least in the
+SMBus controller.
+
+See the file i2c-piix4 for some additional information.
+
+
+Process Call Support
+--------------------
+
+Not supported.
+
+
+I2C Block Read Support
+----------------------
+
+Not supported at the moment.
+
+
+SMBus 2.0 Support
+-----------------
+
+The 82801DB (ICH4) and later chips support several SMBus 2.0 features.
+
+**********************
+The lm_sensors project gratefully acknowledges the support of Texas
+Instruments in the initial development of this driver.
+
+The lm_sensors project gratefully acknowledges the support of Intel in the
+development of SMBus 2.0 / ICH4 features of this driver.
diff -Nru a/Documentation/i2c/busses/i2c-i810 b/Documentation/i2c/busses/i2c-i810
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-i810	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,46 @@
+Kernel driver i2c-i810
+
+Supported adapters:
+  * Intel 82810, 82810-DC100, 82810E, and 82815 (GMCH)
+
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>,
+        Kyösti Mälkki <kmalkki@cc.hut.fi>,
+	Ralph Metzler <rjkm@thp.uni-koeln.de>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Main contact: Mark Studebaker <mdsxyz123@yahoo.com>
+
+Description 
+----------- 
+
+WARNING: If you have an '810' or '815' motherboard, your standard I2C
+temperature sensors are most likely on the 801's I2C bus. You want the
+i2c-i801 driver for those, not this driver.
+
+Now for the i2c-i810...
+
+The GMCH chip contains two I2C interfaces.
+
+The first interface is used for DDC (Data Display Channel) which is a
+serial channel through the VGA monitor connector to a DDC-compliant
+monitor. This interface is defined by the Video Electronics Standards
+Association (VESA). The standards are available for purchase at
+http://www.vesa.org .
+
+The second interface is a general-purpose I2C bus. It may be connected to a
+TV-out chip such as the BT869 or possibly to a digital flat-panel display.
+
+Features
+-------- 
+
+Both busses use the i2c-algo-bit driver for 'bit banging'
+and support for specific transactions is provided by i2c-algo-bit.
+
+Issues
+------
+
+If you enable bus testing in i2c-algo-bit (insmod i2c-algo-bit bit_test=1),
+the test may fail; if so, the i2c-i810 driver won't be inserted. However,
+we think this has been fixed.
diff -Nru a/Documentation/i2c/busses/i2c-nforce2 b/Documentation/i2c/busses/i2c-nforce2
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-nforce2	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,41 @@
+Kernel driver i2c-nforce2
+
+Supported adapters:
+  * nForce2 MCP                10de:0064 
+  * nForce2 Ultra 400 MCP      10de:0084 
+  * nForce3 Pro150 MCP         10de:00D4 
+  * nForce3 250Gb MCP          10de:00E4 
+  * nForce4 MCP	       	       10de:0052
+
+Datasheet: not publically available, but seems to be similar to the
+           AMD-8111 SMBus 2.0 adapter.
+
+Authors:
+	Hans-Frieder Vogt <hfvogt@arcor.de>, 
+	Thomas Leibold <thomas@plx.com>, 
+        Patrick Dreker <patrick@dreker.de>
+	
+Description
+-----------
+
+i2c-nforce2 is a driver for the SMBuses included in the nVidia nForce2 MCP.
+
+If your 'lspci -v' listing shows something like the following,
+
+00:01.1 SMBus: nVidia Corporation: Unknown device 0064 (rev a2)
+        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
+        Flags: 66Mhz, fast devsel, IRQ 5
+        I/O ports at c000 [size=32]
+        Capabilities: <available only to root>
+
+then this driver should support the SMBuses of your motherboard.
+
+
+Notes
+-----
+
+The SMBus adapter in the nForce2 chipset seems to be very similar to the
+SMBus 2.0 adapter in the AMD-8111 southbridge. However, I could only get
+the driver to work with direct I/O access, which is different to the EC
+interface of the AMD-8111. Tested on Asus A7N8X. The ACPI DSDT table of the
+Asus A7N8X lists two SMBuses, both of which are supported by this driver.
diff -Nru a/Documentation/i2c/busses/i2c-parport b/Documentation/i2c/busses/i2c-parport
--- a/Documentation/i2c/busses/i2c-parport	2005-03-31 15:17:04 -08:00
+++ b/Documentation/i2c/busses/i2c-parport	2005-03-31 15:17:04 -08:00
@@ -1,8 +1,6 @@
-==================
-i2c-parport driver
-==================
+Kernel driver i2c-parport
 
-2004-07-06, Jean Delvare
+Author: Jean Delvare <khali@linux-fr.org> 
 
 This is a unified driver for several i2c-over-parallel-port adapters,
 such as the ones made by Philips, Velleman or ELV. This driver is
@@ -126,14 +124,14 @@
 Similar (but different) drivers
 -------------------------------
 
-This driver is NOT the same as the i2c-pport driver found in the i2c package.
-The i2c-pport driver makes use of modern parallel port features so that
-you don't need additional electronics. It has other restrictions however, and
-was not ported to Linux 2.6 (yet).
+This driver is NOT the same as the i2c-pport driver found in the i2c
+package. The i2c-pport driver makes use of modern parallel port features so
+that you don't need additional electronics. It has other restrictions
+however, and was not ported to Linux 2.6 (yet).
 
 This driver is also NOT the same as the i2c-pcf-epp driver found in the
-lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port
-as an I2C bus directly. Instead, it uses it to control an external I2C bus
+lm_sensors package. The i2c-pcf-epp driver doesn't use the parallel port as
+an I2C bus directly. Instead, it uses it to control an external I2C bus
 master. That driver was not ported to Linux 2.6 (yet) either.
 
 
diff -Nru a/Documentation/i2c/busses/i2c-parport-light b/Documentation/i2c/busses/i2c-parport-light
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-parport-light	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,11 @@
+Kernel driver i2c-parport-light
+
+Author: Jean Delvare <khali@linux-fr.org> 
+
+This driver is a light version of i2c-parport. It doesn't depend        
+on the parport driver, and uses direct I/O access instead. This might be
+prefered on embedded systems where wasting memory for the clean but heavy
+parport handling is not an option. The drawback is a reduced portability
+and the impossibility to daisy-chain other parallel port devices.                 
+  
+Please see i2c-parport for documentation.
diff -Nru a/Documentation/i2c/busses/i2c-pca-isa b/Documentation/i2c/busses/i2c-pca-isa
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-pca-isa	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,23 @@
+Kernel driver i2c-pca-isa
+
+Supported adapters:
+This driver supports ISA boards using the Philips PCA 9564 
+Parallel bus to I2C bus controller 
+
+Author: Ian Campbell <icampbell@arcom.com>, Arcom Control Systems 
+
+Module Parameters
+-----------------
+
+* base int
+ I/O base address
+* irq int
+ IRQ interrupt 
+* clock int 
+ Clock rate as described in table 1 of PCA9564 datasheet
+
+Description
+-----------
+
+This driver supports ISA boards using the Philips PCA 9564 
+Parallel bus to I2C bus controller 
diff -Nru a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-piix4	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,72 @@
+Kernel driver i2c-piix4
+
+Supported adapters:
+  * Intel 82371AB PIIX4 and PIIX4E
+  * Intel 82443MX (440MX)
+    Datasheet: Publicly available at the Intel website
+  * ServerWorks OSB4, CSB5 and CSB6 southbridges
+    Datasheet: Only available via NDA from ServerWorks
+  * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
+    Datasheet: Publicly available at the SMSC website http://www.smsc.com
+
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>
+	Philip Edelbrock <phil@netroedge.com>
+
+
+Module Parameters
+-----------------
+
+* force: int
+  Forcibly enable the PIIX4. DANGEROUS!
+* force_addr: int
+  Forcibly enable the PIIX4 at the given address. EXTREMELY DANGEROUS!
+* fix_hstcfg: int
+  Fix config register. Needed on some boards (Force CPCI735).
+
+
+Description
+-----------
+
+The PIIX4 (properly known as the 82371AB) is an Intel chip with a lot of
+functionality. Among other things, it implements the PCI bus. One of its
+minor functions is implementing a System Management Bus. This is a true 
+SMBus - you can not access it on I2C levels. The good news is that it
+natively understands SMBus commands and you do not have to worry about
+timing problems. The bad news is that non-SMBus devices connected to it can
+confuse it mightily. Yes, this is known to happen...
+
+Do 'lspci -v' and see whether it contains an entry like this:
+
+0000:00:02.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
+	     Flags: medium devsel, IRQ 9
+
+Bus and device numbers may differ, but the function number must be
+identical (like many PCI devices, the PIIX4 incorporates a number of
+different 'functions', which can be considered as separate devices). If you
+find such an entry, you have a PIIX4 SMBus controller.
+
+On some computers (most notably, some Dells), the SMBus is disabled by
+default. If you use the insmod parameter 'force=1', the kernel module will
+try to enable it. THIS IS VERY DANGEROUS! If the BIOS did not set up a
+correct address for this module, you could get in big trouble (read:
+crashes, data corruption, etc.). Try this only as a last resort (try BIOS
+updates first, for example), and backup first! An even more dangerous
+option is 'force_addr=<IOPORT>'. This will not only enable the PIIX4 like
+'force' foes, but it will also set a new base I/O port address. The SMBus
+parts of the PIIX4 needs a range of 8 of these addresses to function
+correctly. If these addresses are already reserved by some other device,
+you will get into big trouble! DON'T USE THIS IF YOU ARE NOT VERY SURE
+ABOUT WHAT YOU ARE DOING!
+
+The PIIX4E is just an new version of the PIIX4; it is supported as well.
+The PIIX/PIIX3 does not implement an SMBus or I2C bus, so you can't use
+this driver on those mainboards.
+
+The ServerWorks Southbridges, the Intel 440MX, and the Victory766 are
+identical to the PIIX4 in I2C/SMBus support.
+
+A few OSB4 southbridges are known to be misconfigured by the BIOS. In this
+case, you have you use the fix_hstcfg module parameter. Do not use it
+unless you know you have to, because in some cases it also breaks
+configuration on southbridges that don't need it.
diff -Nru a/Documentation/i2c/busses/i2c-prosavage b/Documentation/i2c/busses/i2c-prosavage
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-prosavage	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,23 @@
+Kernel driver i2c-prosavage
+
+Supported adapters:
+	
+	S3/VIA KM266/VT8375 aka ProSavage8 
+	S3/VIA KM133/VT8365 aka Savage4 
+
+Author: Henk Vergonet <henk@god.dyndns.org>
+
+Description
+-----------
+
+The Savage4 chips contain two I2C interfaces (aka a I2C 'master' or
+'host'). 
+
+The first interface is used for DDC (Data Display Channel) which is a
+serial channel through the VGA monitor connector to a DDC-compliant
+monitor. This interface is defined by the Video Electronics Standards
+Association (VESA). The standards are available for purchase at
+http://www.vesa.org . The second interface is a general-purpose I2C bus.
+
+Usefull for gaining access to the TV Encoder chips.
+
diff -Nru a/Documentation/i2c/busses/i2c-savage4 b/Documentation/i2c/busses/i2c-savage4
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-savage4	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,26 @@
+Kernel driver i2c-savage4
+
+Supported adapters:
+  * Savage4
+  * Savage2000
+
+Authors: 
+	Alexander Wold <awold@bigfoot.com>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com> 
+
+Description
+-----------
+
+The Savage4 chips contain two I2C interfaces (aka a I2C 'master'
+or 'host'). 
+
+The first interface is used for DDC (Data Display Channel) which is a
+serial channel through the VGA monitor connector to a DDC-compliant
+monitor. This interface is defined by the Video Electronics Standards
+Association (VESA). The standards are available for purchase at
+http://www.vesa.org . The DDC bus is not yet supported because its register
+is not directly memory-mapped.
+
+The second interface is a general-purpose I2C bus. This is the only
+interface supported by the driver at the moment.
+
diff -Nru a/Documentation/i2c/busses/i2c-sis5595 b/Documentation/i2c/busses/i2c-sis5595
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-sis5595	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,59 @@
+Kernel driver i2c-sis5595
+
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+	Philip Edelbrock <phil@netroedge.com> 
+
+Supported adapters:
+  * Silicon Integrated Systems Corp. SiS5595 Southbridge
+    Datasheet: Publicly available at the Silicon Integrated Systems Corp. site.
+
+Note: all have mfr. ID 0x1039. 
+
+   SUPPORTED            PCI ID           
+        5595            0008 
+ 
+   Note: these chips contain a 0008 device which is incompatible with the 
+         5595. We recognize these by the presence of the listed 
+         "blacklist" PCI ID and refuse to load. 
+ 
+   NOT SUPPORTED        PCI ID          BLACKLIST PCI ID         
+         540            0008            0540 
+         550            0008            0550 
+        5513            0008            5511 
+        5581            0008            5597 
+        5582            0008            5597 
+        5597            0008            5597 
+        5598            0008            5597/5598 
+         630            0008            0630 
+         645            0008            0645 
+         646            0008            0646 
+         648            0008            0648 
+         650            0008            0650 
+         651            0008            0651 
+         730            0008            0730 
+         735            0008            0735 
+         745            0008            0745 
+         746            0008            0746 
+
+Module Parameters
+-----------------
+
+* force_addr=0xaddr	Set the I/O base address. Useful for boards
+			that don't set the address in the BIOS. Does not do a
+			PCI force; the device must still be present in lspci.
+			Don't use this unless the driver complains that the
+			base address is not set.
+
+Description
+-----------
+
+i2c-sis5595 is a true SMBus host driver for motherboards with the SiS5595
+southbridges.
+
+WARNING: If you are trying to access the integrated sensors on the SiS5595
+chip, you want the sis5595 driver for those, not this driver. This driver
+is a BUS driver, not a CHIP driver. A BUS driver is used by other CHIP
+drivers to access chips on the bus.
+
diff -Nru a/Documentation/i2c/busses/i2c-sis630 b/Documentation/i2c/busses/i2c-sis630
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-sis630	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,49 @@
+Kernel driver i2c-sis630
+
+Supported adapters:
+  * Silicon Integrated Systems Corp (SiS)
+	630 chipset (Datasheet: available at http://amalysh.bei.t-online.de/docs/SIS/)
+	730 chipset
+  * Possible other SiS chipsets ?
+
+Author: Alexander Malysh <amalysh@web.de>
+
+Module Parameters
+-----------------
+
+* force = [1|0] Forcibly enable the SIS630. DANGEROUS!
+		This can be interesting for chipsets not named
+		above to check if it works for you chipset, but DANGEROUS!
+		
+* high_clock = [1|0] Forcibly set Host Master Clock to 56KHz (default, 
+			what your BIOS use). DANGEROUS! This should be a bit 
+			faster, but freeze some systems (i.e. my Laptop).
+
+
+Description
+-----------
+
+This SMBus only driver is known to work on motherboards with the above
+named chipsets.
+
+If you see something like this:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
+00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+
+or like this:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
+00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+
+in your 'lspci' output , then this driver is for your chipset.
+
+Thank You
+---------
+Philip Edelbrock <phil@netroedge.com>
+- testing SiS730 support
+Mark M. Hoffman <mhoffman@lightlink.com>
+- bug fixes
+ 
+To anyone else which I forgot here ;), thanks!
+
diff -Nru a/Documentation/i2c/busses/i2c-sis69x b/Documentation/i2c/busses/i2c-sis69x
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-sis69x	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,73 @@
+Kernel driver i2c-sis96x
+
+Replaces 2.4.x i2c-sis645
+
+Supported adapters:
+  * Silicon Integrated Systems Corp (SiS)
+    Any combination of these host bridges:
+	645, 645DX (aka 646), 648, 650, 651, 655, 735, 745, 746
+    and these south bridges:
+    	961, 962, 963(L) 
+
+Author: Mark M. Hoffman <mhoffman@lightlink.com>
+
+Description
+-----------
+
+This SMBus only driver is known to work on motherboards with the above
+named chipset combinations. The driver was developed without benefit of a
+proper datasheet from SiS. The SMBus registers are assumed compatible with
+those of the SiS630, although they are located in a completely different
+place. Thanks to Alexander Malysh <amalysh@web.de> for providing the
+SiS630 datasheet (and  driver).
+
+The command "lspci" as root should produce something like these lines:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
+00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
+
+or perhaps this...
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0645 
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0961
+00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
+
+(kernel versions later than 2.4.18 may fill in the "Unknown"s)
+
+If you cant see it please look on quirk_sis_96x_smbus
+(drivers/pci/quirks.c) (also if southbridge detection fails)
+
+I suspect that this driver could be made to work for the following SiS
+chipsets as well: 635, and 635T. If anyone owns a board with those chips
+AND is willing to risk crashing & burning an otherwise well-behaved kernel
+in the name of progress... please contact me at <mhoffman@lightlink.com> or
+via the project's mailing list: <sensors@stimpy.netroedge.com>.  Please
+send bug reports and/or success stories as well.
+
+
+TO DOs
+------
+
+* The driver does not support SMBus block reads/writes; I may add them if a
+scenario is found where they're needed.
+
+
+Thank You
+---------
+
+Mark D. Studebaker <mdsxyz123@yahoo.com>
+ - design hints and bug fixes
+Alexander Maylsh <amalysh@web.de>
+ - ditto, plus an important datasheet... almost the one I really wanted
+Hans-Günter Lütke Uphues <hg_lu@t-online.de>
+ - patch for SiS735
+Robert Zwerus <arzie@dds.nl>
+ - testing for SiS645DX
+Kianusch Sayah Karadji <kianusch@sk-tech.net>
+ - patch for SiS645DX/962
+Ken Healy
+ - patch for SiS655
+
+To anyone else who has written w/ feedback, thanks!
+
diff -Nru a/Documentation/i2c/busses/i2c-via b/Documentation/i2c/busses/i2c-via
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-via	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,34 @@
+Kernel driver i2c-via
+
+Supported adapters:
+  * VIA Technologies, InC. VT82C586B
+    Datasheet: Publicly available at the VIA website
+
+Author: Kyösti Mälkki <kmalkki@cc.hut.fi>
+
+Description
+-----------
+
+i2c-via is an i2c bus driver for motherboards with VIA chipset.
+
+The following VIA pci chipsets are supported:
+ - MVP3, VP3, VP2/97, VPX/97 
+ - others with South bridge VT82C586B
+
+Your lspci listing must show this :
+
+ Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
+
+    Problems?
+ 
+ Q: You have VT82C586B on the motherboard, but not in the listing. 
+ 
+ A: Go to your BIOS setup, section PCI devices or similar.
+    Turn USB support on, and try again. 
+
+ Q: No error messages, but still i2c doesn't seem to work.
+
+ A: This can happen. This driver uses the pins VIA recommends in their
+    datasheets, but there are several ways the motherboard manufacturer
+    can actually wire the lines.
+
diff -Nru a/Documentation/i2c/busses/i2c-viapro b/Documentation/i2c/busses/i2c-viapro
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-viapro	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,47 @@
+Kernel driver i2c-viapro
+
+Supported adapters:
+  * VIA Technologies, Inc. VT82C596A/B
+    Datasheet: Sometimes available at the VIA website
+
+  * VIA Technologies, Inc. VT82C686A/B 
+    Datasheet: Sometimes available at the VIA website
+
+  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237
+    Datasheet: available on request from Via
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,  
+	Philip Edelbrock <phil@netroedge.com>, 
+	Kyösti Mälkki <kmalkki@cc.hut.fi>, 
+	Mark D. Studebaker <mdsxyz123@yahoo.com> 
+
+Module Parameters
+-----------------
+
+* force: int
+  Forcibly enable the SMBus controller. DANGEROUS!
+* force_addr: int
+  Forcibly enable the SMBus at the given address. EXTREMELY DANGEROUS!
+
+Description
+-----------
+
+i2c-viapro is a true SMBus host driver for motherboards with one of the
+supported VIA southbridges.
+
+Your lspci -n listing must show one of these :
+
+ device 1106:3050   (VT82C596 function 3)
+ device 1106:3051   (VT82C596 function 3)
+ device 1106:3057   (VT82C686 function 4)
+ device 1106:3074   (VT8233)
+ device 1106:3147   (VT8233A)
+ device 1106:8235   (VT8231)
+ devide 1106:3177   (VT8235)
+ devide 1106:3227   (VT8237)
+
+If none of these show up, you should look in the BIOS for settings like
+enable ACPI / SMBus or even USB.
+
+
diff -Nru a/Documentation/i2c/busses/i2c-voodoo3 b/Documentation/i2c/busses/i2c-voodoo3
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/i2c-voodoo3	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,62 @@
+Kernel driver i2c-voodoo3
+
+Supported adapters:
+  * 3dfx Voodoo3 based cards
+  * Voodoo Banshee based cards
+
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>, 
+	Ralph Metzler <rjkm@thp.uni-koeln.de>,
+	Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+Main contact: Philip Edelbrock <phil@netroedge.com>
+	
+The code is based upon Ralph's test code (he did the hard stuff ;')
+
+Description
+-----------
+
+The 3dfx Voodoo3 chip contains two I2C interfaces (aka a I2C 'master' or
+'host'). 
+
+The first interface is used for DDC (Data Display Channel) which is a
+serial channel through the VGA monitor connector to a DDC-compliant
+monitor. This interface is defined by the Video Electronics Standards
+Association (VESA). The standards are available for purchase at
+http://www.vesa.org .
+
+The second interface is a general-purpose I2C bus. The intent by 3dfx was
+to allow manufacturers to add extra chips to the video card such as a
+TV-out chip such as the BT869 or possibly even I2C based temperature
+sensors like the ADM1021 or LM75.
+
+Stability
+---------
+
+Seems to be stable on the test machine, but needs more testing on other
+machines. Simultaneous accesses of the DDC and I2C busses may cause errors.
+
+Supported Devices
+-----------------
+
+Specifically, this driver was written and tested on the '3dfx Voodoo3 AGP
+3000' which has a tv-out feature (s-video or composite).  According to the
+docs and discussions, this code should work for any Voodoo3 based cards as
+well as Voodoo Banshee based cards.  The DDC interface has been tested on a
+Voodoo Banshee card.
+	
+Issues
+------
+
+Probably many, but it seems to work OK on my system. :')
+
+
+External Device Connection
+--------------------------
+
+The digital video input jumpers give availability to the I2C bus. 
+Specifically, pins 13 and 25 (bottom row middle, and bottom right-end) are     
+the I2C clock and I2C data lines, respectively. +5V and GND are probably
+also easily available making the addition of extra I2C/SMBus devices easy
+to implement.
diff -Nru a/Documentation/i2c/busses/scx200_acb b/Documentation/i2c/busses/scx200_acb
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/busses/scx200_acb	2005-03-31 15:17:04 -08:00
@@ -0,0 +1,14 @@
+Kernel driver scx200_acb
+
+Author: Christer Weinigel <wingel@nano-system.com>
+
+Module Parameters
+-----------------
+
+* base: int
+  Base addresses for the ACCESS.bus controllers
+
+Description
+-----------
+
+Enable the use of the ACCESS.bus controllers of a SCx200 processor.

