Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268794AbUIQOdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbUIQOdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUIQOdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:33:11 -0400
Received: from mail.convergence.de ([212.227.36.84]:4255 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268794AbUIQOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:25:42 -0400
Message-ID: <414AF399.3030708@linuxtv.org>
Date: Fri, 17 Sep 2004 16:24:25 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][2/14] documentation update
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org>
In-Reply-To: <414AF31B.1090103@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------050600030302060509060103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050600030302060509060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050600030302060509060103
Content-Type: text/plain;
 name="02-DVB-documentation-update.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="02-DVB-documentation-update.diff"

- [DVB] add udev.txt which describes how to use dvb and udev/sysfs
- [DVB] add Visionplus VisionDTV USB-Ter DVB-T adapter documentation
- [DVB] update TT USB DEC documentation
- [DVB] update various Kconfig entries

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

#diff -uraNwB xx-linux-2.6.8.1/Documentation/dvb/cards.txt linux-2.6.8.1-patched/Documentation/dvb/cards.txt
--- xx-linux-2.6.8.1/Documentation/dvb/cards.txt	2004-07-19 19:40:45.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/cards.txt	2004-06-21 00:53:32.000000000 +0200
@@ -49,7 +49,7 @@
   - "budget" cards (i.e. without hardware MPEG decoder):
     - Technotrend Budget / Hauppauge WinTV-Nova PCI Cards
     - SATELCO Multimedia PCI
-    - KNC1 DVB-S
+    - KNC1 DVB-S, Typhoon DVB-S, Terratec Cinergy 1200 DVB-S (no CI support)
     - Typhoon DVB-S budget
     - Fujitsu-Siemens Activy DVB-S budget card
 
diff -uraNwB xx-linux-2.6.8.1/Documentation/dvb/contributors.txt linux-2.6.8.1-patched/Documentation/dvb/contributors.txt
--- xx-linux-2.6.8.1/Documentation/dvb/contributors.txt	2004-07-19 19:40:45.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/contributors.txt	2004-05-02 18:30:56.000000000 +0200
@@ -69,6 +69,8 @@
 Kenneth Aafløy <ke-aa@frisurf.no>
   for adding support for Typhoon DVB-S budget card
 
+Ernst Peinlich <e.peinlich@inode.at>
+  for tuning/DiSEqC support for the DEC 3000-s
 
 (If you think you should be in this list, but you are not, drop a
  line to the DVB mailing list)
diff -uraNwB xx-linux-2.6.8.1/Documentation/dvb/firmware.txt linux-2.6.8.1-patched/Documentation/dvb/firmware.txt
--- xx-linux-2.6.8.1/Documentation/dvb/firmware.txt	2004-08-23 09:34:29.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/firmware.txt	2004-07-20 22:52:19.000000000 +0200
@@ -2,7 +2,7 @@
 binary-only firmware.
 
 The DVB drivers will be converted to use the request_firmware()
-hotplug interface (see Documentation/firmware_class/).
+hotplug interface (see linux/Documentation/firmware_class/).
 (CONFIG_FW_LOADER)
 
 The firmware can be loaded automatically via the hotplug manager
@@ -12,18 +12,45 @@
 to load their firmwares, so here's just a short list of the
 current state:
 
-- dvb-ttpci: driver uses firmware hotplug interface
+Drivers using the firmware hotplug interface:
+- dvb-ttpci
+- tda1004x:
+
+Proprietary solutions which need to be converted:
 - ttusb-budget: firmware is compiled in (dvb-ttusb-dspbootcode.h)
 - sp887x: firmware is compiled in (sp887x_firm.h)
 - alps_tdlb7: firmware is loaded from path specified by
 		"mcfile" module parameter; the binary must be
 		extracted from the Windows driver (Sc_main.mc).
-- tda1004x: firmware is loaded from path specified in
-		DVB_TDA1004X_FIRMWARE_FILE kernel config
-		variable (default /usr/lib/hotplug/firmware/tda1004x.bin); the
-		firmware binary must be extracted from the windows
-		driver
 - ttusb-dec: see "ttusb-dec.txt" for details
+- vp7041: see vp7041.txt for more information
+
+0) Getting a usable firmware file 
+
+- For the dvb-ttpci driver/av7110 card you can download the firmware files from
+http://linuxtv.org/download/dvb/firmware/
+
+Please note that in case of the dvb-ttpci driver this is *not* the "Root"
+file you probably know from the 2.4 DVB releases driver.
+
+The ttpci-firmware utility from linuxtv.org CVS can be used to
+convert Dpram and Root files into a usable firmware image.
+See dvb-kerrnel/scripts/ in http://linuxtv.org/cvs/.
+
+> wget http://www.linuxtv.org/download/dvb/firmware/dvb-ttpci-01.fw-261c
+> mv dvb-ttpci-01.fw-261c /usr/lib/hotplug/firmware/dvb-ttpci-01.fw
+
+- The tda1004x driver needs a copy of the DLL "ttlcdacc.dll" from the Haupauge or Technotrend
+windows driver. Currently the DLL from v2.15a of the technotrend driver is supported. Other versions can
+added reasonably painlessly.
+
+Windows driver URL: http://www.technotrend.de/
+
+> wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
+> unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
+
+Rename "ttlcdacc.dll" to "tda1004x.bin" -- that's currently the default name
+for the firmware file.
 
 1) Automatic firmware loading
 
@@ -44,8 +71,23 @@
   driver/firmware internal API changes (so users are free to install the
   latest firmware compatible with the driver).
 
+Currently the drivers mentionend above support firmware upload through the
+hotplug manager. If you have such a card, a simple "modprobe" of the driver
+will take care of everything, ie.
+
+> modprobe dvb-ttpci
+or
+> modprobe tda1004x
+
+If you have the hotplug firmware scripts installed, both drivers will ask the hotplug
+daemon for their default firmware. If the scripts are there, but the firmware cannot
+be found, an error message will be printed immediately. Make sure that the firmware
+are in a path where the hotplug manager can find them.
+
+Please note that the default firmware name of the tda1004x doesn't follow the
+naming conventions stated above. It's still called "tda1004x.bin".
+
 2) Manually loading the firmware into a driver
-   (currently only the dvb-ttpci / av7110 driver supports this)
    
 Step a) Mount sysfs-filesystem.
 
@@ -73,29 +115,17 @@
 
 > echo "180" > /sys/class/firmware/timeout
 
-Step c) Getting a usable firmware file for the dvb-ttpci driver/av7110 card.
-
-You can download the firmware files from
-http://linuxtv.org/download/dvb/
-
-Please note that in case of the dvb-ttpci driver this is *not* the "Root"
-file you probably know from the 2.4 DVB releases driver.
-
-The ttpci-firmware utility from linuxtv.org CVS can be used to
-convert Dpram and Root files into a usable firmware image.
-See dvb-kerrnel/scripts/ in http://linuxtv.org/cvs/.
-
-> wget http://www.linuxtv.org/download/dvb/dvb-ttpci-01.fw
-gets you the version 01 of the firmware fot the ttpci driver.
-
-Step d) Loading the dvb-ttpci driver and loading the firmware
+Step c) Loading the driver and uploading the firmware manually
 
 "modprobe" will take care that every needed module will be loaded
-automatically (except the frontend driver)
+automatically 
 
 > modprobe dvb-ttpci
+or
+> modprobe tda1004x
 
-The "modprobe" process will hang until
+If you don't have the hotplug subsystem running, the "modprobe" process will
+now hang until
 a) you upload the firmware or
 b) the timeout occurs.
 
@@ -107,14 +137,24 @@
 drwxr-xr-x    2 root     root            0 Jul 29 11:00 0000:03:05.0
 -rw-r--r--    1 root     root            0 Jul 29 10:41 timeout
 
-"0000:03:05.0" is the id for my dvb-c card. It depends on the pci slot,
-so it changes if you plug the card to different slots.
+"0000:03:05.0" is the id of the device that needs an firmware upload.
+
+In this example, this is the pci id of my dvb-c card. It depends on the pci slot,
+so it changes if you plug the card to different slots. For the tda1004x,
+the id will be an artifical number consisting on the i2c bus the device is on.
 
 You can upload the firmware like that:
 
 > export DEVDIR=/sys/class/firmware/0000\:03\:05.0
 > echo 1 > $DEVDIR/loading
+
+For the dvb-ttpci card:
 > cat dvb-ttpci-01.fw > $DEVDIR/data
+
+For the tda1004x frontend, the path above might be different, but the other things
+are the same:
+> cat tda1004x.bin > $DEVDIR/data
+
 > echo 0 > $DEVDIR/loading
 
 That's it. The driver should be up and running now.
diff -uraNwB xx-linux-2.6.8.1/Documentation/dvb/readme.txt linux-2.6.8.1-patched/Documentation/dvb/readme.txt
--- xx-linux-2.6.8.1/Documentation/dvb/readme.txt	2004-07-19 19:40:45.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/readme.txt	2004-08-06 13:23:24.000000000 +0200
@@ -41,4 +41,11 @@
 various bt8xx based "budget" DVB cards
 (Nebula, Pinnacle PCTV, Twinhan DST)
 
+"vp7041.txt"
+contains detailed informations about the
+Visionplus VisionDTV USB-Ter DVB-T adapter.
+
+"udev.txt"
+how to get DVB and udev up and running.
+
 Good luck and have fun!
diff -uraNwB xx-linux-2.6.8.1/Documentation/dvb/ttusb-dec.txt linux-2.6.8.1-patched/Documentation/dvb/ttusb-dec.txt
--- xx-linux-2.6.8.1/Documentation/dvb/ttusb-dec.txt	2004-08-23 09:34:29.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/ttusb-dec.txt	2004-05-02 18:30:56.000000000 +0200
@@ -6,6 +6,8 @@
 
 Supported:
 	DEC2000-t
+	DEC2450-t
+	DEC3000-s
 	Linux Kernels 2.4 and 2.6
 	Video Streaming
 	Audio Streaming
@@ -13,14 +15,11 @@
 	Channel Zapping
 	Hotplug firmware loader under 2.6 kernels
 
-In Progress:
-	DEC2540-t
-	DEC3000-s
-
 To Do:
 	Tuner status information
 	DVB network interface
 	Streaming video PC->DEC
+	Conax support for 2450-t
 
 Getting the Firmware
 --------------------
@@ -57,7 +56,7 @@
 Hotplug Firmware Loading for 2.6 kernels
 ----------------------------------------
 For 2.6 kernels the firmware is loaded at the point that the driver module is
-loaded.  See Documentation/dvb/firmware.txt for more information.
+loaded.  See linux/Documentation/dvb/firmware.txt for more information.
 
 mv STB_PC_T.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2000t.fw
 mv STB_PC_X.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2540t.fw
diff -uraNwB xx-linux-2.6.8.1/Documentation/dvb/udev.txt linux-2.6.8.1-patched/Documentation/dvb/udev.txt
--- xx-linux-2.6.8.1/Documentation/dvb/udev.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/Documentation/dvb/udev.txt	2004-08-11 11:44:45.000000000 +0200
@@ -0,0 +1,46 @@
+The DVB subsystem currently registers to the sysfs subsystem using the
+"class_simple" interface.
+
+This means that only the basic informations like module loading parameters
+are presented through sysfs. Other things that might be interesting are
+currently *not* available.
+
+Nevertheless it's now possible to add proper udev rules so that the
+DVB device nodes are created automatically.
+
+We assume that you have udev already up and running and that have been
+creating the DVB device nodes manually up to now due to the missing sysfs
+support.
+
+0. Don't forget to disable your current method of creating the
+device nodes manually.
+
+1. Unfortunately, you'll need a helper script to transform the kernel
+sysfs device name into the well known dvb adapter / device naming scheme.
+The script should be called "dvb.sh" and should be placed into a script
+dir where udev can execute it, most likely /etc/udev/scripts/
+
+So, create a new file /etc/udev/scripts/dvb.sh and add the following:
+------------------------------schnipp------------------------------------------------
+#!/bin/sh
+/bin/echo $1 | /bin/sed -e 's,dvb\([0-9]\)\.\([^0-9]*\)\([0-9]\),dvb/adapter\1/\2\3,'
+------------------------------schnipp------------------------------------------------
+
+Don't forget to make the script executable with "chmod".
+
+1. You need to create a proper udev rule that will create the device nodes
+like you know them. All real distributions out there scan the /etc/udev/rules.d
+directory for rule files. The main udev configuration file /etc/udev/udev.conf
+will tell you the directory where the rules are, most likely it's /etc/udev/rules.d/
+
+Create a new rule file in that directory called "dvb.rule" and add the following line:
+------------------------------schnipp------------------------------------------------
+KERNEL="dvb*", PROGRAM="/etc/udev/scripts/dvb.sh %k", NAME="%c"
+------------------------------schnipp------------------------------------------------
+
+If you want more control over the device nodes (for example a special group membership)
+have a look at "man udev".
+
+For every device that registers to the sysfs subsystem with a "dvb" prefix,
+the helper script /etc/udev/scripts/dvb.sh is invoked, which will then
+create the proper device node in your /dev/ directory.
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/avermedia.txt linux-2.6.8.1-patched/Documentation/dvb/avermedia.txt
--- linux-2.6.8.1-dvb1/Documentation/dvb/avermedia.txt	2004-09-15 15:34:48.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/avermedia.txt	2004-09-01 12:18:59.000000000 +0200
@@ -6,7 +6,6 @@
    Assumptions and Introduction
    The Avermedia DVB-T
    Getting the card going
-   Getting the Firmware
    Receiving DVB-T in Australia
    Known Limitations
    Further Update
@@ -149,28 +148,9 @@
    to start accessing the card with utilities such as scan, tzap,
    dvbstream etc.
 
-   The  current version of the frontend module sp887x.o, contains
-   no firmware drivers?, so the first time you open it with a DVB
-   utility  the driver will try to download some initial firmware
-   to  the card. You will need to download this firmware from the
-   web,  or  copy  it from an installation of the Windows drivers
-   that probably came with your card, before you can use it.
-
-   The  default  Linux  filesystem  location for this firmware is
-   /usr/lib/hotplug/firmware/sc_main.mc .
-     _________________________________________________________
-
-Getting the Firmware
-
-   As the firmware for the card is no longer contained within the
-   driver,  it  is  necessary  to  extract  it  from  the windows
-   drivers.
-
-   The  Windows  drivers  for the Avermedia DVB-T can be obtained
-   from: http://babyurl.com/H3U970 and you can get an application
-   to extract the firmware from:
-   http://www.kyz.uklinux.net/cabextract.php.
-     _________________________________________________________
+   The frontend module sp887x.o, requires an external   firmware.
+   Please use  the  command "get_dvb_firmware sp887x" to download
+   it. Then copy it to /usr/lib/hotplug/firmware.
 
 Receiving DVB-T in Australia
 
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/cards.txt linux-2.6.8.1-patched/Documentation/dvb/cards.txt
--- linux-2.6.8.1-dvb1/Documentation/dvb/cards.txt	2004-09-17 12:27:25.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/cards.txt	2004-09-15 10:26:44.000000000 +0200
@@ -38,6 +38,7 @@
                		  Comtech DVBT-6k07 (SP5730 PLL)
                		  (NxtWave Communications NXT6000 demodulator)
    - sp887x		: Microtune 7202D
+   - dib3000mb	: DiBcom 3000-MB Frontend
   DVB-S/C/T:
    - dst		: TwinHan DST Frontend
 
@@ -66,4 +67,9 @@
   - Nova USB
   - DEC 2000-T, 3000-S, 2540-T
 
+o DiBcom DVB-T USB based devices:
+  - Twinhan VisionPlus VisionDTV USB-Ter DVB-T Device
+  - KWorld V-Stream XPERT DTV - DVB-T USB
+  - HAMA DVB-T USB device
+
 o Experimental support for the analog module of the Siemens DVB-C PCI card
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/firmware.txt linux-2.6.8.1-patched/Documentation/dvb/firmware.txt
--- linux-2.6.8.1-dvb1/Documentation/dvb/firmware.txt	2004-09-17 12:27:25.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/firmware.txt	2004-09-15 15:36:15.000000000 +0200
@@ -2,7 +2,7 @@
 binary-only firmware.
 
 The DVB drivers will be converted to use the request_firmware()
-hotplug interface (see linux/Documentation/firmware_class/).
+hotplug interface (see Documentation/firmware_class/).
 (CONFIG_FW_LOADER)
 
 The firmware can be loaded automatically via the hotplug manager
@@ -12,45 +12,18 @@
 to load their firmwares, so here's just a short list of the
 current state:
 
-Drivers using the firmware hotplug interface:
-- dvb-ttpci
-- tda1004x:
-
-Proprietary solutions which need to be converted:
+- dvb-ttpci: driver uses firmware hotplug interface
 - ttusb-budget: firmware is compiled in (dvb-ttusb-dspbootcode.h)
 - sp887x: firmware is compiled in (sp887x_firm.h)
 - alps_tdlb7: firmware is loaded from path specified by
 		"mcfile" module parameter; the binary must be
 		extracted from the Windows driver (Sc_main.mc).
+- tda1004x: firmware is loaded from path specified in
+		DVB_TDA1004X_FIRMWARE_FILE kernel config
+		variable (default /usr/lib/hotplug/firmware/tda1004x.bin); the
+		firmware binary must be extracted from the windows
+		driver
 - ttusb-dec: see "ttusb-dec.txt" for details
-- vp7041: see vp7041.txt for more information
-
-0) Getting a usable firmware file 
-
-- For the dvb-ttpci driver/av7110 card you can download the firmware files from
-http://linuxtv.org/download/dvb/firmware/
-
-Please note that in case of the dvb-ttpci driver this is *not* the "Root"
-file you probably know from the 2.4 DVB releases driver.
-
-The ttpci-firmware utility from linuxtv.org CVS can be used to
-convert Dpram and Root files into a usable firmware image.
-See dvb-kerrnel/scripts/ in http://linuxtv.org/cvs/.
-
-> wget http://www.linuxtv.org/download/dvb/firmware/dvb-ttpci-01.fw-261c
-> mv dvb-ttpci-01.fw-261c /usr/lib/hotplug/firmware/dvb-ttpci-01.fw
-
-- The tda1004x driver needs a copy of the DLL "ttlcdacc.dll" from the Haupauge or Technotrend
-windows driver. Currently the DLL from v2.15a of the technotrend driver is supported. Other versions can
-added reasonably painlessly.
-
-Windows driver URL: http://www.technotrend.de/
-
-> wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
-> unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
-
-Rename "ttlcdacc.dll" to "tda1004x.bin" -- that's currently the default name
-for the firmware file.
 
 1) Automatic firmware loading
 
@@ -71,23 +44,8 @@
   driver/firmware internal API changes (so users are free to install the
   latest firmware compatible with the driver).
 
-Currently the drivers mentionend above support firmware upload through the
-hotplug manager. If you have such a card, a simple "modprobe" of the driver
-will take care of everything, ie.
-
-> modprobe dvb-ttpci
-or
-> modprobe tda1004x
-
-If you have the hotplug firmware scripts installed, both drivers will ask the hotplug
-daemon for their default firmware. If the scripts are there, but the firmware cannot
-be found, an error message will be printed immediately. Make sure that the firmware
-are in a path where the hotplug manager can find them.
-
-Please note that the default firmware name of the tda1004x doesn't follow the
-naming conventions stated above. It's still called "tda1004x.bin".
-
 2) Manually loading the firmware into a driver
+   (currently only the dvb-ttpci / av7110 driver supports this)
    
 Step a) Mount sysfs-filesystem.
 
@@ -115,17 +73,29 @@
 
 > echo "180" > /sys/class/firmware/timeout
 
-Step c) Loading the driver and uploading the firmware manually
+Step c) Getting a usable firmware file for the dvb-ttpci driver/av7110 card.
+
+You can download the firmware files from
+http://linuxtv.org/download/dvb/
+
+Please note that in case of the dvb-ttpci driver this is *not* the "Root"
+file you probably know from the 2.4 DVB releases driver.
+
+The ttpci-firmware utility from linuxtv.org CVS can be used to
+convert Dpram and Root files into a usable firmware image.
+See dvb-kerrnel/scripts/ in http://linuxtv.org/cvs/.
+
+> wget http://www.linuxtv.org/download/dvb/dvb-ttpci-01.fw
+gets you the version 01 of the firmware fot the ttpci driver.
+
+Step d) Loading the dvb-ttpci driver and loading the firmware
 
 "modprobe" will take care that every needed module will be loaded
-automatically 
+automatically (except the frontend driver)
 
 > modprobe dvb-ttpci
-or
-> modprobe tda1004x
 
-If you don't have the hotplug subsystem running, the "modprobe" process will
-now hang until
+The "modprobe" process will hang until
 a) you upload the firmware or
 b) the timeout occurs.
 
@@ -137,24 +107,14 @@
 drwxr-xr-x    2 root     root            0 Jul 29 11:00 0000:03:05.0
 -rw-r--r--    1 root     root            0 Jul 29 10:41 timeout
 
-"0000:03:05.0" is the id of the device that needs an firmware upload.
-
-In this example, this is the pci id of my dvb-c card. It depends on the pci slot,
-so it changes if you plug the card to different slots. For the tda1004x,
-the id will be an artifical number consisting on the i2c bus the device is on.
+"0000:03:05.0" is the id for my dvb-c card. It depends on the pci slot,
+so it changes if you plug the card to different slots.
 
 You can upload the firmware like that:
 
 > export DEVDIR=/sys/class/firmware/0000\:03\:05.0
 > echo 1 > $DEVDIR/loading
-
-For the dvb-ttpci card:
 > cat dvb-ttpci-01.fw > $DEVDIR/data
-
-For the tda1004x frontend, the path above might be different, but the other things
-are the same:
-> cat tda1004x.bin > $DEVDIR/data
-
 > echo 0 > $DEVDIR/loading
 
 That's it. The driver should be up and running now.
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/get_dvb_firmware linux-2.6.8.1-patched/Documentation/dvb/get_dvb_firmware
--- linux-2.6.8.1-dvb1/Documentation/dvb/get_dvb_firmware	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/Documentation/dvb/get_dvb_firmware	2004-09-15 10:26:44.000000000 +0200
@@ -0,0 +1,339 @@
+#!/usr/bin/perl
+#     DVB firmware extractor
+#  
+#     (c) 2004 Andrew de Quincey
+#  
+#     This program is free software; you can redistribute it and/or modify
+#       it under the terms of the GNU General Public License as published by
+#       the Free Software Foundation; either version 2 of the License, or
+#       (at your option) any later version.
+#  
+#     This program is distributed in the hope that it will be useful,
+#       but WITHOUT ANY WARRANTY; without even the implied warranty of
+#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  
+#     GNU General Public License for more details.
+#  
+#     You should have received a copy of the GNU General Public License
+#       along with this program; if not, write to the Free Software
+#       Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+use File::Temp qw/ tempdir /;
+use IO::Handle;
+
+@components = ( "alps_tdlb7", "sp887x", "tda10045", "tda10046", "av7110", "dec2000t", "dec2540t", "dec3000s", "vp7041", "dibusb" );
+
+# Check args
+syntax() if (scalar(@ARGV) != 1);
+$cid = $ARGV[0];
+
+# Do it!
+for($i=0; $i < scalar(@components); $i++) {
+    if ($cid eq $components[$i]) {
+	$outfile = eval($cid);
+	die $@ if $@;
+	print STDERR "Firmware $outfile extracted successfully. Now copy it to /usr/lib/hotplug/firmware/.\n";
+	exit(0);
+    }
+}
+
+# If we get here, it wasn't found
+print STDERR "Unknown component \"$cid\"\n";
+syntax();
+
+
+
+
+# ---------------------------------------------------------------
+# Firmware-specific extraction subroutines
+
+sub alps_tdlb7 {
+    my $sourcefile = "tt_Premium_217g.zip";
+    my $url = "http://www.technotrend.de/new/217g/$sourcefile";
+    my $hash = "53970ec17a538945a6d8cb608a7b3899";
+    my $outfile = "dvb-fe-tdlb7.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    verify("$tmpdir/software/OEM/HE/App/boot/SC_MAIN.MC", $hash);
+    copy("$tmpdir/software/OEM/HE/App/boot/SC_MAIN.MC", $outfile);
+    
+    $outfile;
+}
+
+sub sp887x {
+    my $sourcefile = "Dvbt1.3.57.6.zip";
+    my $url = "http://www.avermedia.com/software/$sourcefile";
+    my $cabfile = "DVBT Net  Ver1.3.57.6/disk1/data1.cab";
+    my $hash = "237938d53a7f834c05c42b894ca68ac3";
+    my $outfile = "dvb-fe-sp887x.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+    
+    checkstandard();
+    checkunshield();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    unshield("$tmpdir/$cabfile", $tmpdir);
+    verify("$tmpdir/sc_main.mc", $hash);
+    copy("$tmpdir/sc_main.mc", $outfile);
+    
+    $outfile;
+}
+
+sub tda10045 {
+    my $sourcefile = "tt_budget_217g.zip";
+    my $url = "http://www.technotrend.de/new/217g/$sourcefile";
+    my $hash = "2105fd5bf37842fbcdfa4bfd58f3594a";
+    my $outfile = "dvb-fe-tda10045.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();    
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    extract("$tmpdir/software/OEM/PCI/App/ttlcdacc.dll", 0x37ef9, 30555, "$tmpdir/fwtmp");
+    verify("$tmpdir/fwtmp", $hash);
+    copy("$tmpdir/fwtmp", $outfile);
+    
+    $outfile;
+}
+
+sub tda10046 {
+    my $sourcefile = "tt_budget_217g.zip";
+    my $url = "http://www.technotrend.de/new/217g/$sourcefile";
+    my $hash = "a25b579e37109af60f4a36c37893957c";
+    my $outfile = "dvb-fe-tda10046.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    extract("$tmpdir/software/OEM/PCI/App/ttlcdacc.dll", 0x3f731, 24479, "$tmpdir/fwtmp");
+    verify("$tmpdir/fwtmp", $hash);
+    copy("$tmpdir/fwtmp", $outfile);
+    
+    $outfile;
+}
+
+sub av7110 {
+    my $sourcefile = "dvb-ttpci-01.fw-261c";
+    my $url = "http://www.linuxtv.org/download/dvb/firmware/$sourcefile";
+    my $hash = "7b263de6b0b92d2347319c65adc7d4fb";
+    my $outfile = "dvb-ttpci-01.fw";
+
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    verify($sourcefile, $hash);
+    copy($sourcefile, $outfile);
+    
+    $outfile;
+}
+
+sub dec2000t {
+    my $sourcefile = "dec217g.exe";
+    my $url = "http://hauppauge.lightpath.net/de/$sourcefile";
+    my $hash = "bd86f458cee4a8f0a8ce2d20c66215a9";
+    my $outfile = "dvb-ttusb-dec-2000t.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    verify("$tmpdir/software/OEM/STB/App/Boot/STB_PC_T.bin", $hash);
+    copy("$tmpdir/software/OEM/STB/App/Boot/STB_PC_T.bin", $outfile);
+
+    $outfile;
+}
+
+sub dec2540t {
+    my $sourcefile = "dec217g.exe";
+    my $url = "http://hauppauge.lightpath.net/de/$sourcefile";
+    my $hash = "53e58f4f5b5c2930beee74a7681fed92";
+    my $outfile = "dvb-ttusb-dec-2540t.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    verify("$tmpdir/software/OEM/STB/App/Boot/STB_PC_X.bin", $hash);
+    copy("$tmpdir/software/OEM/STB/App/Boot/STB_PC_X.bin", $outfile);
+
+    $outfile;
+}
+
+sub dec3000s {
+    my $sourcefile = "dec217g.exe";
+    my $url = "http://hauppauge.lightpath.net/de/$sourcefile";
+    my $hash = "b013ececea83f4d6d8d2a29ac7c1b448";
+    my $outfile = "dvb-ttusb-dec-3000s.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    verify("$tmpdir/software/OEM/STB/App/Boot/STB_PC_S.bin", $hash);
+    copy("$tmpdir/software/OEM/STB/App/Boot/STB_PC_S.bin", $outfile);
+
+    $outfile;
+}
+
+sub vp7041 {
+    my $sourcefile = "2.422.zip";
+    my $url = "http://www.twinhan.com/files/driver/USB-Ter/$sourcefile";
+    my $hash = "e88c9372d1f66609a3e7b072c53fbcfe";
+    my $outfile = "dvb-vp7041-2.422.fw";
+    my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
+    
+    checkstandard();
+    
+    wgetfile($sourcefile, $url);
+    unzip($sourcefile, $tmpdir);
+    extract("$tmpdir/VisionDTV/Drivers/Win2K&XP/UDTTload.sys", 12503, 3036, "$tmpdir/fwtmp1");
+    extract("$tmpdir/VisionDTV/Drivers/Win2K&XP/UDTTload.sys", 2207, 10274, "$tmpdir/fwtmp2");
+
+    my $CMD = "\000\001\000\222\177\000";
+    my $PAD = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000";
+    my ($FW);
+    open $FW, ">$tmpdir/fwtmp3";
+    print $FW "$CMD\001$PAD";
+    print $FW "$CMD\001$PAD";
+    appendfile($FW, "$tmpdir/fwtmp1");
+    print $FW "$CMD\000$PAD";
+    print $FW "$CMD\001$PAD";
+    appendfile($FW, "$tmpdir/fwtmp2");
+    print $FW "$CMD\001$PAD";
+    print $FW "$CMD\000$PAD";
+    close($FW);
+
+    verify("$tmpdir/fwtmp3", $hash);
+    copy("$tmpdir/fwtmp3", $outfile);
+
+    $outfile;
+}
+
+sub dibusb {
+	my $url = "http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/firmware/dvb-dibusb-5.0.0.11.fw?rev=1.1&content-type=text/plain";
+	my $outfile = "dvb-dibusb-5.0.0.11.fw";
+	my $hash = "fa490295a527360ca16dcdf3224ca243";
+
+	checkstandard();
+
+	wgetfile($outfile, $url);
+	verify($outfile,$hash);
+
+	$outfile;
+}
+
+# ---------------------------------------------------------------
+# Utilities
+
+sub checkstandard {
+    if (system("which unzip > /dev/null 2>&1")) {
+	die "This firmware requires the unzip command - see ftp://ftp.info-zip.org/pub/infozip/UnZip.html\n";
+    }
+    if (system("which md5sum > /dev/null 2>&1")) {
+	die "This firmware requires the md5sum command - see http://www.gnu.org/software/coreutils/\n";
+    }
+    if (system("which wget > /dev/null 2>&1")) {
+	die "This firmware requires the wget command - see http://wget.sunsite.dk/\n";
+    }
+}
+
+sub checkunshield {
+    if (system("which unshield > /dev/null 2>&1")) {
+	die "This firmware requires the unshield command - see http://sourceforge.net/projects/synce/\n";
+    }
+}
+
+sub wgetfile {
+    my ($sourcefile, $url) = @_;
+
+    if (! -f $sourcefile) {
+	system("wget -O \"$sourcefile\" \"$url\"") and die "wget failed - unable to download firmware";
+    }
+}
+
+sub unzip {
+    my ($sourcefile, $todir) = @_;
+
+    $status = system("unzip -q -o -d \"$todir\" \"$sourcefile\" 2>/dev/null" );
+    if ((($status >> 8) > 2) || (($status & 0xff) != 0)) {
+	die ("unzip failed - unable to extract firmware");
+    }
+}
+
+sub unshield {
+    my ($sourcefile, $todir) = @_;
+
+    system("unshield -d \"$todir\" \"$sourcefile\" > /dev/null" ) and die ("unshield failed - unable to extract firmware");
+}
+
+sub verify {
+    my ($filename, $hash) = @_;
+    my ($testhash);
+
+    open(CMD, "md5sum \"$filename\"|");
+    $testhash = <CMD>;
+    $testhash =~ /([a-zA-Z0-9]*)/;
+    $testhash = $1;
+    close CMD;
+    die "Hash of extracted file does not match!\n" if ($testhash ne $hash);
+}
+
+sub copy {
+    my ($from, $to) = @_;
+    
+    system("cp -f \"$from\" \"$to\"") and die ("cp failed");
+}
+
+sub extract {
+    my ($infile, $offset, $length, $outfile) = @_;
+    my ($chunklength, $buf, $rcount);
+    
+    open INFILE, "<$infile";
+    open OUTFILE, ">$outfile";
+    sysseek(INFILE, $offset, SEEK_SET);
+    while($length > 0) {
+	# Calc chunk size
+	$chunklength = 2048;
+	$chunklength = $length if ($chunklength > $length);
+	
+	$rcount = sysread(INFILE, $buf, $chunklength);
+	die "Ran out of data\n" if ($rcount != $chunklength);
+	syswrite(OUTFILE, $buf);
+	$length -= $rcount;
+    }
+    close INFILE;
+    close OUTFILE;
+}
+
+sub appendfile {
+    my ($FH, $infile) = @_;
+    my ($buf);
+    
+    open INFILE, "<$infile";
+    while(1) {
+	$rcount = sysread(INFILE, $buf, 2048);
+	last if ($rcount == 0);
+	print $FH $buf;
+    }
+    close(INFILE);
+}
+
+sub syntax() {
+    print STDERR "syntax: get_dvb_firmware <component>\n";
+    print STDERR "Supported components:\n";
+    for($i=0; $i < scalar(@components); $i++) {
+	print STDERR "\t" . $components[$i] . "\n";
+    }
+    exit(1);
+}
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/README.dibusb linux-2.6.8.1-patched/Documentation/dvb/README.dibusb
--- linux-2.6.8.1-dvb1/Documentation/dvb/README.dibusb	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/Documentation/dvb/README.dibusb	2004-09-17 12:25:15.000000000 +0200
@@ -0,0 +1,152 @@
+Documentation for dib3000mb frontend driver and dibusb device driver
+
+The drivers should work with 
+
+- Twinhan VisionPlus VisionDTV USB-Ter DVB-T Device (VP7041)
+	http://www.twinhan.com/visiontv-2_4.htm
+	
+- CTS Portable (Chinese Television System)
+	http://www.2cts.tv/ctsportable/
+
+- KWorld V-Stream XPERT DTV - DVB-T USB
+	http://www.kworld.com.tw/asp/pindex.asp?id=4&pid=13
+
+- HAMA DVB-T USB device
+	http://www.hama.de/portal/articleId*110620/action*2598
+ 
+- DiBcom USB DVB-T reference device
+
+- Ultima Electronic/Artec T1 USB TVBOX
+	http://www.arteceuro.com/products-tvbox.html
+
+
+Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de), 
+
+both drivers based on GPL code, which has
+
+Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
+
+This program is free software; you can redistribute it and/or
+modify it under the terms of the GNU General Public License as
+published by the Free Software Foundation, version 2.
+
+
+NEWS:
+  2004-09-13 - added support for a new device (Artec T1 USB TVBOX), thanks
+               to Christian Motschke for reporting
+  2004-09-05 - released the dibusb device and dib3000mb-frontend driver
+
+  (old news for vp7041.c)
+  2004-07-15 - found out, by accident, that the device has a TUA6010XS for 
+               frequency generator
+  2004-07-12 - figured out, that the driver should also work with the
+               CTS Portable (Chinese Television System)
+  2004-07-08 - firmware-extraction-2.422-problem solved, driver is now working 
+               properly with firmware extracted from 2.422
+			 - #if for 2.6.4 (dvb), compile issue
+			 - changed firmware handling, see vp7041.txt sec 1.1
+  2004-07-02 - some tuner modifications, v0.1, cleanups, first public
+  2004-06-28 - now using the dvb_dmx_swfilter_packets, everything 
+               runs fine now
+  2004-06-27 - able to watch and switching channels (pre-alpha)
+             - no section filtering yet
+  2004-06-06 - first TS received, but kernel oops :/
+  2004-05-14 - firmware loader is working
+  2004-05-11 - start writing the driver
+
+1. How to use?
+NOTE: This driver was developed using Linux 2.6.6., 
+it is working with 2.6.7, 2.6.8.1.
+
+Linux 2.4.x support is not planned, but patches are very welcome.
+
+NOTE: I'm using Debian testing, so the following explaination (especially
+the hotplug-path) needn't match your system, but probably it will :).
+
+1.1. Firmware
+
+The USB driver needs to download a firmware to start working.
+
+You can either use "get_dvb_firmware dibusb" to download the firmware or you
+can get it directly via 
+
+http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/firmware/dvb-dibusb-5.0.0.11.fw?rev=1.1&content-type=text/plain
+
+1.2. Compiling
+
+Since the driver is in the linux kernel, activating the driver in
+your favorite config-environment should sufficient. I recommend
+to compile the driver as module. Hotplug does the rest.
+
+1.3. Loading the drivers
+
+Hotplug is able to load the driver, when it is needed (because you plugged
+in the device).
+
+If you want to enable debug output, you have to load the driver manually.
+
+modprobe dvb-dibusb debug=1 
+modprobe dib3000mb debug=1
+
+should do the trick.
+
+When the driver is loaded successfully, the firmware file was in 
+the right place and the device is connected, the "Power"-LED should be
+turned on.
+
+At this point you should be able to start a dvb-capable application. For myself
+I used mplayer, dvbscan, tzap and kaxtv, they are working. Using the device
+as a slave device in vdr, was not working for me. Some work has to be done 
+(patches and comments are very welcome).
+
+2. Known problems and bugs
+
+TODO: 
+- add some additional URBs for USB data transfer
+- due a firmware problem i2c writes during mpeg transfers destroy the stream
+  no i2c writes during streaming, interrupt streaming, when adding another pid
+
+2.1. Adding new devices 
+
+It is not possible to determine the range of devices based on the DiBcom 
+reference design. This is because the reference design of DiBcom can be sold
+to third persons, without telling DiBcom (so done with the Twinhan VP7041 and 
+the HAMA device).
+
+When you think you have a device like this and the driver does not recognizes it,
+please send the ****load.inf and the ****cap.inf of the Windows driver to me.
+
+Sometimes the Vendor or Product ID is identical to the ones of Twinhan, even 
+though it is not a Twinhan device (e.g. HAMA), then please send me the name 
+of the device. I will add it to this list in order to make this clear to 
+others.
+
+If you are familar with C you can also add the VID and PID of the device to 
+the dvb-dibusb.[hc]-files and create a patch and send it over to me or to 
+the linux-dvb mailing list, _after_ you have tried compiling and modprobing
+it.
+
+2.2. Comments
+  
+Patches, comments and suggestions are very very welcome
+
+3. Acknowledgements
+	Amaury Demol (ademol@dibcom.fr) and Francois Kanounnikoff from DiBcom for 
+	providing specs, code and help, on which the dvb-dibusb and dib3000mb are 
+	based.
+  
+   Alex Woods for frequently answering question about usb and dvb
+    stuff, a big thank you
+
+   Bernd Wagner for helping with huge bug reports and discussions.
+   
+   Some guys on the linux-dvb mailing list for encouraging me
+   
+   Peter Schildmann >peter.schildmann-nospam-at-web.de< for his 
+    user-level firmware loader, which saves a lot of time 
+    (when writing the vp7041 driver)
+
+   Ulf Hermenau for helping me out with traditional chinese.
+   
+   André Smoktun and Christian Frömmel for supporting me with
+    hardware and listening to my problems very patient
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/readme.txt linux-2.6.8.1-patched/Documentation/dvb/readme.txt
--- linux-2.6.8.1-dvb1/Documentation/dvb/readme.txt	2004-09-17 12:27:25.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/readme.txt	2004-09-01 12:19:00.000000000 +0200
@@ -28,9 +28,9 @@
 "faq.txt"
 contains frequently asked questions and their answers.
 
-"firmware.txt" 
-contains informations for required external firmware
-files and where to get them.
+"get_dvb_firmware"
+script to download and extract firmware for those devices
+that require it.
 
 "ttusb-dec.txt"
 contains detailed informations about the
diff -uraNwB linux-2.6.8.1-dvb1/Documentation/dvb/ttusb-dec.txt linux-2.6.8.1-patched/Documentation/dvb/ttusb-dec.txt
--- linux-2.6.8.1-dvb1/Documentation/dvb/ttusb-dec.txt	2004-09-17 12:27:25.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/dvb/ttusb-dec.txt	2004-09-01 12:19:00.000000000 +0200
@@ -23,34 +23,17 @@
 
 Getting the Firmware
 --------------------
-The firmware can be found in the software update zip files on this page:
-http://www.hauppauge.de/sw_dec.htm
-
-The firmwares are named as follows:
-DEC2000-t:	STB_PC_T.bin
-DEC2540-t:	STB_PC_X.bin
-DEC3000-s:	STB_PC_S.bin
-
-Note that firmwares since version 2.16 beta2 for the DEC2000-t give the device
-the USB ID of the DEC3000-s.  The driver copes with this.
-
-Instructions follow for retrieving version 2.16 of the firmware:
-
-wget http://hauppauge.lightpath.net/de/dec216.exe
-unzip -j dec216.exe software/OEM/STB/App/Boot/STB_PC_T.bin
-unzip -j dec216.exe software/OEM/STB/App/Boot/STB_PC_X.bin
-unzip -j dec216.exe software/OEM/STB/App/Boot/STB_PC_S.bin
+To download the firmware, use the following commands:
+"get_dvb_firmware dec2000t"
+"get_dvb_firmware dec2540t"
+"get_dvb_firmware dec3000s"
 
 
 Compilation Notes for 2.4 kernels
 ---------------------------------
 For 2.4 kernels the firmware for the DECs is compiled into the driver itself.
-The firmwares are expected to be in the build-2.4 directory at compilation
-time.
 
-mv STB_PC_T.bin build-2.4/dvb-ttusb-dec-2000t.fw
-mv STB_PC_X.bin build-2.4/dvb-ttusb-dec-2540t.fw
-mv STB_PC_S.bin build-2.4/dvb-ttusb-dec-3000s.fw
+Copy the three files downloaded above into the build-2.4 directory.
 
 
 Hotplug Firmware Loading for 2.6 kernels
@@ -58,6 +41,4 @@
 For 2.6 kernels the firmware is loaded at the point that the driver module is
 loaded.  See linux/Documentation/dvb/firmware.txt for more information.
 
-mv STB_PC_T.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2000t.fw
-mv STB_PC_X.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2540t.fw
-mv STB_PC_S.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-3000s.fw
+Copy the three files downloaded above into the /usr/lib/hotplug/firmware directory.
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/Kconfig
--- linux-2.6.8.1-dvb1/drivers/media/dvb/Kconfig	2004-09-15 15:34:22.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/Kconfig	2004-09-15 10:26:44.000000000 +0200
@@ -12,20 +12,11 @@
 	  own a DVB adapter and want to use it or if you compile Linux for 
 	  a digital SetTopBox.
 
-	  API specs and user tools are available from
-	  <http://www.linuxtv.org/>. 
+	  API specs and user tools are available from <http://www.linuxtv.org/>.
 
 	  Please report problems regarding this driver to the LinuxDVB 
 	  mailing list.
 
-	  You might want add the following lines to your /etc/modules.conf:
-	  	
-	  	alias char-major-250 dvb
-	  	alias dvb dvb-ttpci
-	  	below dvb-ttpci alps_bsru6 alps_bsrv2 \
-	  			grundig_29504-401 grundig_29504-491 \
-	  			ves1820
-
 	  If unsure say N.
 
 source "drivers/media/dvb/dvb-core/Kconfig"
@@ -40,6 +31,7 @@
 	depends on DVB_CORE && USB
 source "drivers/media/dvb/ttusb-budget/Kconfig"
 source "drivers/media/dvb/ttusb-dec/Kconfig"
+source "drivers/media/dvb/dibusb/Kconfig"
 
 comment "Supported FlexCopII (B2C2) Adapters"
 	depends on DVB_CORE && PCI
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttusb-dec/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/ttusb-dec/Kconfig
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttusb-dec/Kconfig	2004-09-15 15:34:22.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttusb-dec/Kconfig	2004-09-01 12:19:01.000000000 +0200
@@ -12,8 +12,10 @@
 	  only compressed MPEG data over the USB bus, so you need
 	  an external software decoder to watch TV on your computer.	  
 
-	  The DEC devices require firmware in order to boot into a mode in
-	  which they are slaves to the PC.  See
-	  <file:Documentation/dvb/ttusb-dec.txt> for details.
+          This driver needs external firmware. Please use the commands
+          "<kerneldir>/Documentation/dvb/get_dvb_firmware dec2000t",
+          "<kerneldir>/Documentation/dvb/get_dvb_firmware dec2540t",	
+          "<kerneldir>/Documentation/dvb/get_dvb_firmware dec3000s",
+          download/extract them, and then copy them to /usr/lib/hotplug/firmware.
 
 	  Say Y if you own such a device and want to use it.
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/ttpci/Kconfig
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/Kconfig	2004-09-15 15:34:22.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/Kconfig	2004-09-15 10:26:45.000000000 +0200
@@ -11,11 +11,16 @@
 	  This driver only supports the fullfeatured cards with
 	  onboard MPEG2 decoder.
 
+          This driver needs an external firmware. Please use the script
+          "<kerneldir>/Documentation/dvb/get_dvb_firmware av7110" to
+          download/extract it, and then copy it to /usr/lib/hotplug/firmware.
+
 	  Say Y if you own such a card and want to use it.
 
 config DVB_AV7110_FIRMWARE
 	bool "Compile AV7110 firmware into the driver"
 	depends on DVB_AV7110 && !STANDALONE
+	default y if DVB_AV7110=y
 	help
 	  The AV7110 firmware is normally loaded by the firmware hotplug manager.
 	  If you want to compile the firmware into the driver you need to say
@@ -33,6 +38,7 @@
 config DVB_AV7110_OSD
 	bool "AV7110 OSD support"
 	depends on DVB_AV7110
+	default y if DVB_AV7110=y || DVB_AV7110=m
 	help
 	  The AV7110 firmware provides some code to generate an OnScreenDisplay
 	  on the video output. This is kind of nonstandard and not guaranteed to
@@ -91,7 +97,7 @@
 
 config DVB_BUDGET_PATCH
 	tristate "AV7110 cards with Budget Patch"
-	depends on DVB_BUDGET
+	depends on DVB_CORE && DVB_BUDGET
 	select DVB_AV7110
 	help
 	  Support for Budget Patch (full TS) modification on 

--------------050600030302060509060103--
