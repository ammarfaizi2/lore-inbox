Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTLSMah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLSMag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:30:36 -0500
Received: from mail.dietlibc.org ([212.84.236.4]:33210 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262902AbTLSM2s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:48 -0500
Subject: [PATCH 12/12] Add DVB documentation
In-Reply-To: <1071836925779@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:46 +0100
Message-Id: <10718369262578@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - add some valuable documentation about the DVB subsystem, the supported cards, a faq, ...
diff -uNrwB --new-file xx-linux-2.6.0/Documentation/dvb/cards.txt linux-2.6.0.p2/Documentation/dvb/cards.txt
--- xx-linux-2.6.0/Documentation/dvb/cards.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0.p2/Documentation/dvb/cards.txt	2003-12-19 11:54:08.000000000 +0100
@@ -0,0 +1,63 @@
+Hardware supported by the linuxtv.org DVB drivers
+=================================================
+
+  Generally, the DVB hardware manufacturers frequently change the
+  frontends (i.e. tuner / demodulator units) used, usually without
+  changing the product name, revision number or specs. Some cards
+  are also available in versions with different frontends for
+  DVB-S/DVB-C/DVB-T. Thus the frontend drivers are listed seperately.
+
+  Note 1: There is no guarantee that every frontend driver works
+  out-of-the box with every card, because of different wiring.
+
+  Note 2: The demodulator chips can be used with a variety of
+  tuner/PLL chips, and not all combinations are supported. Often
+  the demodulator and tuner/PLL chip are inside a metal box for
+  shielding, and the whole metal box has its own part number.
+
+
+o Frontends drivers: 
+  - dvb_dummy_fe: for testing...
+  DVB-S:
+   - alps_bsrv2		: Alps BSRV2 (ves1893 demodulator)
+   - cx24110		: Conexant HM1221/HM1811 (cx24110 or cx24106 demod, cx24108 PLL)
+   - grundig_29504-491	: Grundig 29504-491 (Philips TDA8083 demodulator), tsa5522 PLL
+   - mt312		: Zarlink mt312 or Mitel vp310 demodulator, sl1935 or tsa5059 PLL
+   - stv0299		: Alps BSRU6 (tsa5059 PLL), LG TDQB-S00x (tsa5059 PLL),
+   			  LG TDQF-S001F (sl1935 PLL), Philips SU1278 (tua6100 PLL), 
+			  Philips SU1278SH (tsa5059 PLL)
+  DVB-C:
+   - ves1820		: various (ves1820 demodulator, sp5659c or spXXXX PLL)
+   - at76c651		: Atmel AT76c651(B) with DAT7021 PLL
+  DVB-T:
+   - alps_tdlb7		: Alps TDLB7 (sp8870 demodulator, sp5659 PLL)
+   - alps_tdmb7		: Alps TDMB7 (cx22700 demodulator)
+   - grundig_29504-401	: Grundig 29504-401 (LSI L64781 demodulator), tsa5060 PLL
+   - tda1004x		: Philips tda10045h (td1344 or tdm1316l PLL)
+   - nxt6000 		: Alps TDME7 (MITEL SP5659 PLL), Alps TDED4 (TI ALP510 PLL),
+               		  Comtech DVBT-6k07 (SP5730 PLL)
+               		  (NxtWave Communications NXT6000 demodulator)
+
+
+o Cards based on the Phillips saa7146 multimedia PCI bridge chip:
+  - TI AV7110 based cards (i.e. with hardware MPEG decoder):
+    - Siemens/Technotrend/Hauppauge PCI DVB card revision 1.1, 1.3, 1.5, 1.6, 2.1
+      (aka Hauppauge Nexus)
+  - "budget" cards (i.e. without hardware MPEG decoder):
+    - Technotrend Budget / Hauppauge WinTV-Nova PCI Cards
+    - SATELCO Multimedia PCI
+    - KNC1 DVB-S
+
+o Cards based on the B2C2 Inc. FlexCopII:
+  - Technisat SkyStar2 PCI DVB
+
+o Cards based on the Conexant Bt8xx PCI bridge:
+  - Pinnacle PCTV Sat DVB
+  - Nebula Electronics DigiTV
+
+o Technotrend / Hauppauge DVB USB devices:
+  - Nova USB
+  - DEC 2000-T
+
+o Preliminary support for the analog module of the Siemens DVB-C PCI card
+
diff -uNrwB --new-file xx-linux-2.6.0/Documentation/dvb/contributors.txt linux-2.6.0.p2/Documentation/dvb/contributors.txt
--- xx-linux-2.6.0/Documentation/dvb/contributors.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0.p2/Documentation/dvb/contributors.txt	2003-12-19 11:54:08.000000000 +0100
@@ -0,0 +1,54 @@
+Thanks go to the following people for patches and contributions:
+
+Michael Hunold <m.hunold@gmx.de>
+  for the initial saa7146 driver and it's recent overhaul
+
+Christian Theiss
+  for his work on the initial Linux DVB driver
+
+Marcus Metzler <mocm@metzlerbros.de>
+Ralph Metzler <rjkm@metzlerbros.de>
+  for their contining work on the DVB driver
+
+Michael Holzt <kju@debian.org>
+  for his contributions to the dvb-net driver
+
+Diego Picciani <d.picciani@novacomp.it>
+  for CyberLogin for Linux which allows logging onto EON
+  (in case you are wondering where CyberLogin is, EON changed its login 
+  procedure and CyberLogin is no longer used.)
+
+Martin Schaller <martin@smurf.franken.de>
+  for patching the cable card decoder driver
+
+Klaus Schmidinger <Klaus.Schmidinger@cadsoft.de>
+  for various fixes regarding tuning, OSD and CI stuff and his work on VDR
+
+Steve Brown <sbrown@cortland.com>
+  for his AFC kernel thread
+
+Christoph Martin <martin@uni-mainz.de>
+  for his LIRC infrared handler
+
+Andreas Oberritter <andreas@oberritter.de>
+Florian Schirmer <jolt@tuxbox.org>
+...and all the other dBox2 people
+  for many bugfixes in the generic DVB Core and their work on the 
+  dBox2 port of the DVB driver
+
+Oliver Endriss <o.endriss@gmx.de>
+  for many bugfixes
+
+Andrew de Quincey <adq_dvb@lidskialf.net>
+  for the tda1004x frontend driver, and various bugfixes
+
+Peter Schildmann <peter.schildmann@web.de>
+  for the driver for the Technisat SkyStar2 PCI DVB card
+
+Vadim Catana <skystar@moldova.cc>
+Roberto Ragusa <r.ragusa@libero.it>
+Augusto Cardoso <augusto@carhil.net>
+  for all the work for the FlexCopII chipset by B2C2,Inc.
+
+(If you think you should be in this list, but you are not, drop a
+ line to the DVB mailing list)
diff -uNrwB --new-file xx-linux-2.6.0/Documentation/dvb/faq.txt linux-2.6.0.p2/Documentation/dvb/faq.txt
--- xx-linux-2.6.0/Documentation/dvb/faq.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0.p2/Documentation/dvb/faq.txt	2003-12-19 11:54:08.000000000 +0100
@@ -0,0 +1,109 @@
+Some very frequently asked questions about linuxtv-dvb
+
+1. The signal seems to die a few seconds after tuning.
+
+	It's not a bug, it's a feature. Because the frontends have
+	significant power requirements (and hence get very hot), they
+	are powered down if they are unused (i.e. if the frontend device
+	is closed). The dvb-core.o module paramter "dvb_shutdown_timeout"
+	allow you to change the timeout (default 5 seconds). Setting the
+	timeout to 0 disables the timeout feature.
+
+2. How can I watch TV?
+
+	The driver distribution includes some simple utilities which
+	are mainly intended for testing and to demonstrate how the
+	DVB API works.
+
+	Depending on whether you have a DVB-S, DVB-C or DVB-T card, use
+	apps/szap/szap, czap or tzap. You must supply a channel list
+	in ~/.[sct]zap/channels.conf. If you are lucky you can just copy
+	one of the supplied channel lists, or you can create a new one
+	by running apps/scan/scan. If you run scan on an unknown network
+	you might have to supply some start data in apps/scan/initial.h.
+
+	If you have a card with a built-in hardware MPEG-decoder the
+	drivers create a video4linux device (/dev/v4l/video0) which
+	you can use to watch TV with any v4l application. xawtv is known
+	to work. Note that you cannot change channels with xawtv, you
+	have to zap using [sct]zap. If you want a nice application for
+	TV watching and record/playback, have a look at VDR.
+
+	If your card does not have a hardware MPEG decoder you need
+	a software MPEG decoder. Mplayer or xine are known to work.
+	Newsflash: MythTV also has DVB support now.
+	Note: Only very recent versions of Mplayer and xine can decode.
+	MPEG2 transport streams (TS) directly. Then, run
+	'[sct]zap channelname -r' in one xterm, and keep it running,
+	and start 'mplayer - < /dev/dvb/adapter0/dvr0' or 
+	'xine stdin://mpeg2 < /dev/dvb/adapter0/dvr0' in a second xterm.
+	That's all far from perfect, but it seems no one has written
+	a nice DVB application which includes a builtin software MPEG
+	decoder yet.
+
+	Newsflash: Newest xine directly supports DVB. Just copy your
+	channels.conf to ~/.xine and start 'xine dvb://', or select
+	the DVB button in the xine GUI. Channel switching works using the
+	numpad pgup/pgdown (NP9 / NP3) keys to scroll through the channel osd
+	menu and pressing numpad-enter to switch to the selected channel.
+
+	Note: Older versions of xine and mplayer understand MPEG program
+	streams (PS) only, and can be used in conjunction with the
+	ts2ps tool from the Metzler Brother's dvb-mpegtools package.
+
+3. Which other DVB applications exist?
+
+	http://www.cadsoft.de/people/kls/vdr/
+		Klaus Schmidinger's Video Disk Recorder
+
+	http://www.metzlerbros.org/dvb/
+		Metzler Bros. DVB development; alternate drivers and
+		DVB utilities, include dvb-mpegtools and tuxzap.
+
+	http://www.linuxstb.org/
+	http://sourceforge.net/projects/dvbtools/
+		Dave Chapman's dvbtools package, including
+		dvbstream and dvbtune
+
+	http://www.linuxdvb.tv/
+		Henning Holtschneider's site with many interesting
+		links and docs
+
+	http://www.dbox2.info/
+		LinuxDVB on the dBox2
+
+	http://www.tuxbox.org/
+	http://cvs.tuxbox.org/
+		the TuxBox CVS many interesting DVB applications and the dBox2
+		DVB source
+
+	http://sourceforge.net/projects/dvbsak/
+		DVB Swiss Army Knife library and utilities
+
+	http://www.nenie.org/misc/mpsys/
+		MPSYS: a MPEG2 system library and tools
+
+	http://mplayerhq.hu/
+		mplayer
+
+	http://xine.sourceforge.net/
+	http://xinehq.de/
+		xine
+
+	http://www.mythtv.org/
+		MythTV - analog TV PVR, but now with DVB support, too
+		(with software MPEG decode)
+
+4. Can't get a signal tuned correctly
+
+	If you are using a Technotrend/Hauppauge DVB-C card *without* analog
+	module, you might have to use module parameter adac=-1 (dvb-ttpci.o).
+
+5. The dvb_net device doesn't give me any multicast packets
+
+	Check your routes if they include the multicast address range.
+	Additionally make sure that "source validation by reversed path
+	lookup" is disabled:
+	  $ "echo 0 > /proc/sys/net/ipv4/conf/dvb0/rp_filter"
+
+eof
diff -uNrwB --new-file xx-linux-2.6.0/Documentation/dvb/firmware.txt linux-2.6.0.p2/Documentation/dvb/firmware.txt
--- xx-linux-2.6.0/Documentation/dvb/firmware.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0.p2/Documentation/dvb/firmware.txt	2003-12-19 11:54:08.000000000 +0100
@@ -0,0 +1,116 @@
+Some DVB cards and many newer frontends require proprietary,
+binary-only firmware.
+
+The DVB drivers will be converted to use the request_firmware()
+hotplug interface (see linux/Documentation/firmware_class/).
+(CONFIG_FW_LOADER)
+
+The firmware can be loaded automatically via the hotplug manager
+or manually with the steps described below.
+
+Currently the drivers still use various different methods
+to load their firmwares, so here's just a short list of the
+current state:
+
+- dvb-ttpci: driver uses firmware hotplug interface
+- ttusb-budget: firmware is compiled in (dvb-ttusb-dspbootcode.h)
+- sp887x: firmware is compiled in (sp887x_firm.h)
+- alps_tdlb7: firmware is loaded from path specified by
+		"mcfile" module parameter; the binary must be
+		extracted from the Windows driver (Sc_main.mc).
+- tda1004x: firmware is loaded from path specified in
+		DVB_TDA1004X_FIRMWARE_FILE kernel config
+		variable (default /etc/dvb/tda1004x.bin); the
+		firmware binary must be extracted from the windows
+		driver
+- ttusb-dec: see "ttusb-dec.txt" for details
+
+1) Automatic firmware loading
+
+You need to install recent hotplug scripts if your distribution did not do it
+for you already, especially the  /etc/hotplug/firmware.agent.
+http://linux-hotplug.sourceforge.net/ (Call /sbin/hotplug without arguments
+to find out if the firmware agent is installed.)
+
+The firmware.agent script expects firmware binaries in
+/usr/lib/hotplug/firmware/. To avoid naming and versioning
+conflicts we propose the following naming scheme:
+
+  /usr/lib/hotplug/firmware/dvb-{driver}-{ver}.fw	for MPEG decoders etc.
+  /usr/lib/hotplug/firmware/dvb-fe-{driver}-{ver}.fw	for frontends
+
+  {driver} name is the basename of the driver kernel module (e.g. dvb-ttpci)
+  {ver} is a version number/name that should change only when the
+  driver/firmware internal API changes (so users are free to install the
+  latest firmware compatible with the driver).
+
+2) Manually loading the firmware into a driver
+   (currently only the dvb-ttpci / av7110 driver supports this)
+   
+Step a) Mount sysfs-filesystem.
+
+Sysfs provides a means to export kernel data structures, their attributes,
+and the linkages between them to userspace. 
+
+For detailed informations have a look at Documentation/filesystems/sysfs.txt 
+All you need to know at the moment is that firmware loading only works through
+sysfs.
+
+> mkdir /sys
+> mount -t sysfs sysfs /sys
+
+Step b) Exploring the firmware loading facilities
+
+Firmware_class support is located in
+/sys/class/firmware
+
+> dir /sys/class/firmware
+
+The "timeout" values specifies the amount of time that is waited before the
+firmware upload  process is cancelled. The default values is 10 seconds. If
+you use a hotplug script for the firmware upload, this is sufficient. If
+you want to upload the firmware by hand, however, this might be too fast.
+
+> echo "180" > /sys/class/firmware/timeout
+
+Step c) Getting a usable firmware file for the dvb-ttpci driver/av7110 card.
+
+You can download the firmware files from
+http://www.linuxtv.org/download/dvb/
+
+Please note that in case of the dvb-ttpci driver this is *not* the "Root"
+file you probably know from the 2.4 DVB releases driver.
+
+> wget http://www.linuxtv.org/download/dvb/dvb-ttpci-01.fw
+gets you the version 01 of the firmware fot the ttpci driver.
+
+Step d) Loading the dvb-ttpci driver and loading the firmware
+
+"modprobe" will take care that every needed module will be loaded
+automatically (except the frontend driver)
+
+> modprobe dvb-ttpci
+
+The "modprobe" process will hang until
+a) you upload the firmware or
+b) the timeout occurs.
+
+Change to another terminal and have a look at 
+
+> dir /sys/class/firmware/
+
+total 0
+drwxr-xr-x    2 root     root            0 Jul 29 11:00 0000:03:05.0
+-rw-r--r--    1 root     root            0 Jul 29 10:41 timeout
+
+"0000:03:05.0" is the id for my dvb-c card. It depends on the pci slot,
+so it changes if you plug the card to different slots.
+
+You can upload the firmware like that:
+
+> export DEVDIR=/sys/class/firmware/0000\:03\:05.0
+> echo 1 > $DEVDIR/loading
+> cat dvb-ttpci-01.fw > $DEVDIR/data
+> echo 0 > $DEVDIR/loading
+
+That's it. The driver should be up and running now.
diff -uNrwB --new-file xx-linux-2.6.0/Documentation/dvb/readme.txt linux-2.6.0.p2/Documentation/dvb/readme.txt
--- xx-linux-2.6.0/Documentation/dvb/readme.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0.p2/Documentation/dvb/readme.txt	2003-12-19 11:54:08.000000000 +0100
@@ -0,0 +1,39 @@
+Linux Digital Video Broadcast (DVB) subsystem
+=============================================
+
+The main development site and CVS repository for these
+drivers is http://linuxtv.org/.
+
+The developer mailing list linux-dvb is also hosted there,
+see http://linuxtv.org/mailinglists.xml. Please check
+the archive http://linuxtv.org/mailinglists/linux-dvb/
+before asking newbie questions on the list.
+
+API documentation, utilities and test/example programs
+are available as part of the old driver package for Linux 2.4
+(linuxtv-dvb-1.0.x.tar.gz), or from CVS (module DVB).
+We plan to split this into separate packages, but it's not
+been done yet.
+
+http://linuxtv.org/download/dvb/
+
+What's inside this directory:
+
+"cards.txt" 
+contains a list of supported hardware.
+
+"contributors.txt"
+is the who-is-who of DVB development
+
+"faq.txt"
+contains frequently asked questions and their answers.
+
+"firmware.txt" 
+contains informations for required external firmware
+files and where to get them.
+
+"ttusb-dec.txt"
+contains detailed informations about the
+TT DEC2000/DEC3000 USB DVB hardware.
+
+Good luck and have fun!
diff -uNrwB --new-file xx-linux-2.6.0/Documentation/dvb/ttusb-dec.txt linux-2.6.0.p2/Documentation/dvb/ttusb-dec.txt
--- xx-linux-2.6.0/Documentation/dvb/ttusb-dec.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0.p2/Documentation/dvb/ttusb-dec.txt	2003-12-19 11:54:08.000000000 +0100
@@ -0,0 +1,52 @@
+TechnoTrend/Hauppauge DEC USB Driver
+====================================
+
+Driver Status
+-------------
+
+Supported:
+	DEC2000-t
+	Linux Kernels 2.4 and 2.6
+	Video Streaming
+	Audio Streaming
+	Channel Zapping
+	Hotplug firmware loader under 2.6 kernels
+
+In Progress:
+	DEC3000-s
+
+To Do:
+	Section data
+	Teletext streams
+	Tuner status information
+	DVB network interface
+	Streaming video PC->DEC
+
+Note:	Since section data can not be retreived yet, scan apps will not work.
+
+Getting the Firmware
+--------------------
+Currently, the driver only works with v2.15a of the firmware.  The firmwares
+can be obtained in this way:
+
+wget http://hauppauge.lightpath.net/de/dec215a.exe
+unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_T.bin
+unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_S.bin
+
+
+Compilation Notes for 2.4 kernels
+---------------------------------
+For 2.4 kernels the firmware for the DECs is compiled into the driver itself.
+The firmwares are expected to be in /etc/dvb at compilation time.
+
+mv STB_PC_T.bin /etc/dvb/dec2000t.bin
+mv STB_PC_S.bin /etc/dvb/dec3000s.bin
+
+
+Hotplug Firmware Loading for 2.6 kernels
+----------------------------------------
+For 2.6 kernels the firmware is loaded at the point that the driver module is
+loaded.  See linux/Documentation/dvb/FIRMWARE for more information.
+
+mv STB_PC_T.bin /usr/lib/hotplug/firmware/dec2000t.bin
+mv STB_PC_S.bin /usr/lib/hotplug/firmware/dec3000s.bin

