Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTIJHzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbTIJHzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:55:01 -0400
Received: from dp.samba.org ([66.70.73.150]:3049 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264987AbTIJHwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:52:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Andrew J. Robinson" <arobinso@nyx.net>, B Huisman <bhuism@cs.utwente.nl>,
       Peter Pregler <Peter_Pregler@email.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Christoph Lameter <christoph@lameter.com>,
       Claus-Justus Heine <claus@momo.math.rwth-aachen.de>,
       Frodo Looijaard <frodol@dds.nl>, Gerd Knorr <kraxel@bytesex.org>,
       Jaroslav Kysela <perex@suse.cz>,
       Abramo Bagnara <abramo@alsa-project.org>,
       Ralph Metzler <ralph@convergence.de>,
       Simon Vogl <simon@tk.uni-linz.ac.at>, Stelian Pop <stelian@popies.net>,
       Takashi Iwai <tiwai@suse.de>, "Theodore Ts'o" <tytso@mit.edu>,
       Tigran Aivazian <tigran@veritas.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Wade Hampton <whampton@staffnet.com>, jgarzik@pobox.com,
       linux-scsi@vger.kernel.org, axboe@suse.de, paulus@samba.org,
       schwidefsky@de.ibm.com, trini@kernel.crashing.org, rz@linux-m68k.org
Subject: [PATCH] More MODULE_ALIAS work, and documentation updates.
Date: Wed, 10 Sep 2003 17:52:11 +1000
Message-Id: <20030910075240.E128A2C74F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I know this is something of a megapatch, but I'm trying to get
all the module aliases people expect into the modules before 2.6.0.  I
got most of these by reading the documentation: review appreciated.

	If noone NAKs, I'll send to Linus in a couple of days.  I'm
sure you can think of other aliases which should be added, too.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Remove alias references
Author: Rusty Russell
Status: Trivial

D: Add more MODULE_ALIASes, and remove reference from documentation.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/Changes .2432-linux-2.6.0-test5.updated/Documentation/Changes
--- .2432-linux-2.6.0-test5/Documentation/Changes	2003-09-09 10:34:21.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/Changes	2003-09-10 17:09:49.000000000 +1000
@@ -217,13 +217,6 @@ chmod 0644 /dev/cpu/microcode
 as root before you can use this.  You'll probably also want to
 get the user-space microcode_ctl utility to use with this.
 
-If you have compiled the driver as a module you may need to add
-the following line:
-
-alias char-major-10-184 microcode
-
-to your /etc/modules.conf file.
-
 Powertweak
 ----------
 
@@ -258,19 +251,12 @@ mknod /dev/ppp c 108 0
 
 as root.
 
-If you build ppp support as modules, you will need the following in
-your /etc/modules.conf file:
+If you build ppp support as modules, and you are using devfs, you
+should add this to your /etc/modprobe.conf file:
 
-alias char-major-108	ppp_generic
 alias /dev/ppp		ppp_generic
-alias tty-ldisc-3	ppp_async
-alias tty-ldisc-14	ppp_synctty
-alias ppp-compress-21	bsd_comp
-alias ppp-compress-24	ppp_deflate
-alias ppp-compress-26	ppp_deflate
 
-If you use devfsd and build ppp support as modules, you will need
-the following in your /etc/devfsd.conf file:
+and the following in your /etc/devfsd.conf file:
 
 LOOKUP	PPP	MODLOAD
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/cdrom/sbpcd .2432-linux-2.6.0-test5.updated/Documentation/cdrom/sbpcd
--- .2432-linux-2.6.0-test5/Documentation/cdrom/sbpcd	2003-08-12 06:57:34.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/cdrom/sbpcd	2003-09-10 14:56:09.000000000 +1000
@@ -271,18 +271,17 @@ Using sbpcd as a "loadable module":
 -----------------------------------
 
 If you do NOT select "Matsushita/Panasonic CDROM driver support" during the
-"make config" of your kernel, you can build the "loadable module" sbpcd.o.
-Read /usr/src/linux/Documentation/modules.txt on this.
+"make config" of your kernel, you can build the "loadable module" sbpcd.ko.
 
 If sbpcd gets used as a module, the support of more than one interface
 card (i.e. drives 4...15) is disabled.
 
-You can specify interface address and type with the "insmod" command like:
- # insmod /usr/src/linux/modules/sbpcd.o sbpcd=0x340,0
+You can specify interface address and type with the "modprobe" command like:
+ # modprobe sbpcd sbpcd=0x340,0
 or
- # insmod /usr/src/linux/modules/sbpcd.o sbpcd=0x230,1
+ # modprobe sbpcd sbpcd=0x230,1
 or
- # insmod /usr/src/linux/modules/sbpcd.o sbpcd=0x338,2
+ # modprobe sbpcd sbpcd=0x338,2
 where the last number represents the SBPRO setting (no strings allowed here).
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/computone.txt .2432-linux-2.6.0-test5.updated/Documentation/computone.txt
--- .2432-linux-2.6.0-test5/Documentation/computone.txt	2003-08-12 06:57:34.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/computone.txt	2003-09-10 16:58:17.000000000 +1000
@@ -149,11 +149,8 @@ and recompile or just insert and options
 The options line is equivalent to the command line and takes precidence over 
 what is in ip2.c. 
 
-/etc/modules.conf sample:
+/etc/modprobe.conf sample:
 	options ip2 io=1,0x328 irq=1,10
-	alias char-major-71 ip2
-	alias char-major-72 ip2
-	alias char-major-73 ip2
 
 The equivalent in ip2.c:
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/digiboard.txt .2432-linux-2.6.0-test5.updated/Documentation/digiboard.txt
--- .2432-linux-2.6.0-test5/Documentation/digiboard.txt	2000-08-29 15:23:02.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/digiboard.txt	2003-09-10 16:49:29.000000000 +1000
@@ -91,17 +91,11 @@ devices following that board, you can em
 
 The remaining board still uses ttyD8-ttyD15 and cud8-cud15.
 
-Example line for /etc/modules.conf for use with kerneld and as default
-parameters for modprobe:
+Example line for /etc/modprobe.conf for use with module autoloading
+and as default parameters for modprobe:
 
 options pcxx           io=0x200 numports=8
 
-For kerneld to work you will likely need to add these two lines to your
-/etc/modules.conf:
-
-alias char-major-22    pcxx
-alias char-major-23    pcxx
-
 
 Boot-time configuration when linked into the kernel
 ---------------------------------------------------
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/ftape.txt .2432-linux-2.6.0-test5.updated/Documentation/ftape.txt
--- .2432-linux-2.6.0-test5/Documentation/ftape.txt	1999-11-07 05:38:40.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/ftape.txt	2003-09-10 17:28:20.000000000 +1000
@@ -246,7 +246,7 @@ C. Boot and load time configuration
 
    or by editing the file `/etc/modules.conf' in which case they take
    effect each time when the module is loaded with `modprobe' (please
-   refer to the modules documentation, i.e. `modules.txt' and the
+   refer to the modules documentation, the
    respective manual pages). Thus, you should add a line
 
    options ftape ft_tracing=4
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/hayes-esp.txt .2432-linux-2.6.0-test5.updated/Documentation/hayes-esp.txt
--- .2432-linux-2.6.0-test5/Documentation/hayes-esp.txt	1999-11-07 05:38:40.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/hayes-esp.txt	2003-09-10 16:55:41.000000000 +1000
@@ -48,9 +48,9 @@ irq=[0x100],[0x140],[0x180],[0x200],[0x2
 The address in brackets is the base address of the card.  The IRQ of
 nonexistent cards can be set to 0.  If an IRQ of a card that does exist is set
 to 0, the driver will attempt to guess at the correct IRQ.  For example, to set
-the IRQ of the card at address 0x300 to 12, the insmod command would be:
+the IRQ of the card at address 0x300 to 12, the modprobe command would be:
 
-insmod esp irq=0,0,0,0,0,0,12,0
+modprobe esp irq=0,0,0,0,0,0,12,0
 
 The custom divisor can be set by using the divisor= option.  The format is the
 same as for the irq= option.  Each divisor value is a series of hex digits,
@@ -59,65 +59,60 @@ divisor value is constructed RIGHT TO LE
 will automatically set the spd_cust flag.  To calculate the divisor to use for
 a certain baud rate, divide the port's base baud (generally 921600) by the
 desired rate.  For example, to set the divisor of the primary port at 0x300 to
-4 and the divisor of the secondary port at 0x308 to 8, the insmod command would
+4 and the divisor of the secondary port at 0x308 to 8, the modprobe command would
 be:
 
-insmod esp divisor=0,0,0,0,0,0,0x84,0
+modprobe esp divisor=0,0,0,0,0,0,0x84,0
 
 The dma= option can be used to set the DMA channel.  The channel can be either
 1 or 3.  Specifying any other value will force the driver to use PIO mode.
-For example, to set the DMA channel to 3, the insmod command would be:
+For example, to set the DMA channel to 3, the modprobe command would be:
 
-insmod esp dma=3
+modprobe esp dma=3
 
 The rx_trigger= and tx_trigger= options can be used to set the FIFO trigger
 levels.  They specify when the ESP card should send an interrupt.  Larger
 values will decrease the number of interrupts; however, a value too high may
 result in data loss.  Valid values are 1 through 1023, with 768 being the
 default.  For example, to set the receive trigger level to 512 bytes and the
-transmit trigger level to 700 bytes, the insmod command would be:
+transmit trigger level to 700 bytes, the modprobe command would be:
 
-insmod esp rx_trigger=512 tx_trigger=700
+modprobe esp rx_trigger=512 tx_trigger=700
 
 The flow_off= and flow_on= options can be used to set the hardware flow off/
 flow on levels.  The flow on level must be lower than the flow off level, and
 the flow off level should be higher than rx_trigger.  Valid values are 1
 through 1023, with 1016 being the default flow off level and 944 being the
 default flow on level.  For example, to set the flow off level to 1000 bytes
-and the flow on level to 935 bytes, the insmod command would be:
+and the flow on level to 935 bytes, the modprobe command would be:
 
-insmod esp flow_off=1000 flow_on=935
+modprobe esp flow_off=1000 flow_on=935
 
 The rx_timeout= option can be used to set the receive timeout value.  This
 value indicates how long after receiving the last character that the ESP card
 should wait before signalling an interrupt.  Valid values are 0 though 255,
 with 128 being the default.  A value too high will increase latency, and a
 value too low will cause unnecessary interrupts.  For example, to set the
-receive timeout to 255, the insmod command would be:
+receive timeout to 255, the modprobe command would be:
 
-insmod esp rx_timeout=255
+modprobe esp rx_timeout=255
 
 The pio_threshold= option sets the threshold (in number of characters) for
 using PIO mode instead of DMA mode.  For example, if this value is 32,
 transfers of 32 bytes or less will always use PIO mode.
 
-insmod esp pio_threshold=32
+modprobe esp pio_threshold=32
 
-Multiple options can be listed on the insmod command line by separating each
+Multiple options can be listed on the modprobe command line by separating each
 option with a space.  For example:
 
-insmod esp dma=3 trigger=512
+modprobe esp dma=3 trigger=512
 
-The esp module can be automatically loaded when needed.  To cause this to
-happen, add the following lines to /etc/modules.conf (replacing the last line
-with options for your configuration):
+The esp module can be automatically loaded when needed.  You will need
+to place the options in /etc/modprobe.conf.  For example:
 
-alias char-major-57 esp
-alias char-major-58 esp
 options esp irq=0,0,0,0,0,0,3,0 divisor=0,0,0,0,0,0,0x4,0
 
-You may also need to run 'depmod -a'.
-
 Devices must be created manually.  To create the devices, note the output from
 the module after it is inserted.  The output will appear in the location where
 kernel messages usually appear (usually /var/adm/messages).  Create two devices
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/ide.txt .2432-linux-2.6.0-test5.updated/Documentation/ide.txt
--- .2432-linux-2.6.0-test5/Documentation/ide.txt	2003-09-09 10:34:22.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/ide.txt	2003-09-10 17:04:25.000000000 +1000
@@ -198,18 +198,11 @@ drivers can always be compiled as loadab
 can only be compiled into the kernel, and the core code (ide.c) can be
 compiled as a loadable module provided no chipset support is needed.
 
-When using ide.c/ide-tape.c as modules in combination with kerneld, add:
-
-	alias block-major-3 ide-probe
-	alias char-major-37 ide-tape
-
-respectively to /etc/modules.conf.
-
 When ide.c is used as a module, you can pass command line parameters to the
-driver using the "options=" keyword to insmod, while replacing any ',' with
+driver using the "options=" keyword to modprobe, while replacing any ',' with
 ';'.  For example:
 
-	insmod ide.o options="ide0=serialize ide1=serialize ide2=0x1e8;0x3ee;11"
+	modprobe ide options="ide0=serialize ide1=serialize ide2=0x1e8;0x3ee;11"
 
 
 ================================================================================
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/input/joystick.txt .2432-linux-2.6.0-test5.updated/Documentation/input/joystick.txt
--- .2432-linux-2.6.0-test5/Documentation/input/joystick.txt	2003-01-02 12:23:14.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/input/joystick.txt	2003-09-10 15:14:08.000000000 +1000
@@ -108,9 +108,7 @@ usually you'll have an analog joystick:
   For automatic module loading, something like this might work - tailor to
 your needs:
 
-	alias tty-ldisc-2 serport
-	alias char-major-13 input
-	above input joydev ns558 analog
+	install input /sbin/modprobe -q joydev; /sbin/modprobe -q ns558; /sbin/modprobe -q analog; /sbin/modprobe --ignore-install input
 	options analog js=gamepad
 
 2.5 Verifying that it works
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/kbuild/makefiles.txt .2432-linux-2.6.0-test5.updated/Documentation/kbuild/makefiles.txt
--- .2432-linux-2.6.0-test5/Documentation/kbuild/makefiles.txt	2003-08-12 06:57:35.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/kbuild/makefiles.txt	2003-09-10 14:56:21.000000000 +1000
@@ -212,7 +212,6 @@ more details, with real examples.
 
 	No special notation is required in the makefiles for
 	modules exporting symbols.
-	See also Documentation/modules.txt.
 
 --- 3.5 Library file goals - lib-y
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/networking/tuntap.txt .2432-linux-2.6.0-test5.updated/Documentation/networking/tuntap.txt
--- .2432-linux-2.6.0-test5/Documentation/networking/tuntap.txt	2003-03-18 12:21:29.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/networking/tuntap.txt	2003-09-10 15:19:04.000000000 +1000
@@ -45,13 +45,8 @@ Copyright (C) 1999-2000 Maxim Krasnyansk
      bogus network interfaces to trick firewalls or administrators.
 
   Driver module autoloading
-     Make sure that "Kernel module loader" - module auto-loading support is enabled 
-     in your kernel. 
-
-     Add the following line to the /etc/modules.conf:
-	alias char-major-10-200 tun
-     and run
-        depmod -a 
+     Make sure that "Kernel module loader" - module auto-loading
+     support is enabled in your kernel.
   
   Manual loading 
      insert the module by hand:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/s390/3270.txt .2432-linux-2.6.0-test5.updated/Documentation/s390/3270.txt
--- .2432-linux-2.6.0-test5/Documentation/s390/3270.txt	2003-08-12 06:57:35.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/s390/3270.txt	2003-09-10 15:26:27.000000000 +1000
@@ -84,7 +84,8 @@ Here are the installation steps in detai
 		make modules_install
 
 	2. (Perform this step only if you have configured tub3270 as a
-	module.)  Add a line to /etc/modules.conf to automatically
+	module, and have a kernel prior to 2.6: 2.6 does this automatically).
+	Add a line to /etc/modules.conf to automatically
 	load the driver when it's needed.  With this line added,
 	you will see login prompts appear on your 3270s as soon as
 	boot is complete (or with emulated 3270s, as soon as you dial
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/scsi/osst.txt .2432-linux-2.6.0-test5.updated/Documentation/scsi/osst.txt
--- .2432-linux-2.6.0-test5/Documentation/scsi/osst.txt	2003-01-02 12:35:05.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/scsi/osst.txt	2003-09-10 15:32:43.000000000 +1000
@@ -59,16 +59,13 @@ depending on your choice during kernel c
 the device nodes by calling the Makedevs.sh script (see below) manually,
 unless you use a devfs kernel, where this won't be needed.
 
-To load your module, you may use the command 
+If you have automatic kernel module loading set to Y, the module
+should be autoatically loaded whenever you access /dev/osst.  To load
+your module manually, you may use the command
 modprobe osst
 as root. dmesg should show you, whether your OnStream tapes have been
 recognized.
 
-If you want to have the module autoloaded on access to /dev/osst, you may
-add something like
-alias char-major-206 osst
-to your /etc/modules.conf (old name: conf.modules).
-
 You may find it convenient to create a symbolic link 
 ln -s nosst0 /dev/tape
 to make programs assuming a default name of /dev/tape more convenient to
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/sound/alsa/ALSA-Configuration.txt .2432-linux-2.6.0-test5.updated/Documentation/sound/alsa/ALSA-Configuration.txt
--- .2432-linux-2.6.0-test5/Documentation/sound/alsa/ALSA-Configuration.txt	2003-08-25 11:58:10.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/sound/alsa/ALSA-Configuration.txt	2003-09-10 16:28:09.000000000 +1000
@@ -1123,29 +1123,8 @@ When the kernel is configured without IS
 will be not built in.
 
 
-modprobe/kmod support
-=====================
-
-The modprobe program must know which modules are used for the
-device major numbers.
-Native ALSA devices have got default number 116. Thus a line like
-'alias char-major-116 snd' must be added to /etc/modules.conf. If you have 
-compiled the ALSA driver with the OSS/Free emulation code, then you
-will need to add lines as explained below:
-
-The ALSA driver uses soundcore multiplexer for 2.2+ kernels and OSS compatible
-devices. You should add line like 'alias char-major-14 soundcore'.
-
-Example with OSS/Free emulation turned on:
-
------ /etc/modules.conf
-
-# ALSA portion
-alias char-major-116 snd
-# OSS/Free portion
-alias char-major-14 soundcore
-
------ /etc/modules.conf
+modprobe/module autoloading support
+===================================
 
 After the main multiplexer is loaded, its code requests top-level soundcard
 module. String 'snd-card-%i' is requested for native devices where %i is
@@ -1153,75 +1132,42 @@ soundcard number from zero to seven. Str
 for native devices where %i is slot number (for ALSA owner this means soundcard
 number).
 
------ /etc/modules.conf
+----- /etc/modprobe.conf
 
 # ALSA portion
 alias snd-card-0 snd-interwave
 alias snd-card-1 snd-ens1371
 # OSS/Free portion
-alias sound-slot-0 snd-card-0
-alias sound-slot-1 snd-card-1
-
------ /etc/modules.conf
-
-We are finished at this point with the configuration for ALSA native devices,
-but you may also need autoloading for ALSA's add-on OSS/Free emulation
-modules. At this time only one module does not depend on any others, thus
-must be loaded separately - snd-pcm-oss. String 'sound-service-%i-%i'
-is requested for OSS/Free service where first %i means slot number
-(e.g. card number) and second %i means service number.
-
------ /etc/modules.conf
-
-# OSS/Free portion - card #1
-alias sound-service-0-0 snd-mixer-oss
-alias sound-service-0-1 snd-seq-oss
-alias sound-service-0-3 snd-pcm-oss
-alias sound-service-0-8 snd-seq-oss
-alias sound-service-0-12 snd-pcm-oss
-# OSS/Free portion - card #2
-alias sound-service-1-0 snd-mixer-oss
-alias sound-service-1-3 snd-pcm-oss
-alias sound-service-1-12 snd-pcm-oss
+alias sound-slot-0 snd-interwave
+alias sound-slot-1 snd-ens1371
 
------ /etc/modules.conf
+----- /etc/modprobe.conf
 
 A complete example for Gravis UltraSound PnP soundcard:
 
------ /etc/modules.conf
+----- /etc/modprobe.conf
 
 # ISA PnP support (don't use IRQs 9,10,11,12,13)
 options isapnp isapnp_reserve_irq=9,10,11,12,13
 
 # ALSA native device support
-alias char-major-116 snd
-options snd major=116 cards_limit=1
+options snd cards_limit=1
 alias snd-card-0 snd-interwave
 options snd-interwave index=0 id="GusPnP"
 
-# OSS/Free setup
-alias char-major-14 soundcore
-alias sound-slot-0 snd-card-0
-alias sound-service-0-0 snd-mixer-oss
-alias sound-service-0-1 snd-seq-oss
-alias sound-service-0-3 snd-pcm-oss
-alias sound-service-0-8 snd-seq-oss
-alias sound-service-0-12 snd-pcm-oss
-
 -----
 
 A complete example if you want to use more soundcards in one machine
 (the configuration below is for Sound Blaster 16 and Gravis UltraSound Classic):
 
------ /etc/modules.conf
+----- /etc/modprobe.conf
 
 # ISA PnP support (don't use IRQs 9,10,11,12,13)
 # it's only an example to reserve some IRQs for another hardware
 options isapnp isapnp_reserve_irq=9,10,11,12,13
 
 # ALSA native device support
-alias char-major-116 snd
-options snd major=116 cards_limit=2
+options snd cards_limit=2
 alias snd-card-0 snd-gusclassic
 alias snd-card-1 snd-sb16
 options snd-gusclassic index=0 id="Gus" \
@@ -1229,53 +1175,28 @@ options snd-gusclassic index=0 id="Gus" 
 options snd-sb16 index=1 id="SB16"
 
 # OSS/Free setup
-alias char-major-14 soundcore
-alias sound-slot-0 snd-card-0
-alias sound-service-0-0 snd-mixer-oss
-alias sound-service-0-1 snd-seq-oss
-alias sound-service-0-3 snd-pcm-oss
-alias sound-service-0-8 snd-seq-oss
-alias sound-service-0-12 snd-pcm-oss
-alias sound-slot-1 snd-card-1
-alias sound-service-1-0 snd-mixer-oss
-alias sound-service-1-3 snd-pcm-oss
-alias sound-service-1-12 snd-pcm-oss
+alias sound-slot-0 snd-gusclassic
+alias sound-slot-1 snd-sb16
 
 -----
 
 A complete example, two Gravis UltraSound Classic soundcards are installed
 in the system:
 
------ /etc/modules.conf
+----- /etc/modprobe.conf
 
-# ALSA native device support
-alias char-major-116 snd
-options snd major=116 cards_limit=2
+options snd cards_limit=2
 alias snd-card-0 snd-gusclassic
 alias snd-card-1 snd-gusclassic
 options snd-gusclassic index=0,1 id="Gus1","Gus2" \
         port=0x220,0x240 irq=5,7 dma1=1,5 dma2=3,6
 
 # OSS/Free setup
-alias char-major-14 soundcore
-alias sound-slot-0 snd-card-0
-alias sound-service-0-0 snd-mixer-oss
-alias sound-service-0-1 snd-seq-oss
-alias sound-service-0-3 snd-pcm-oss
-alias sound-service-0-8 snd-seq-oss
-alias sound-service-0-12 snd-pcm-oss
-alias sound-slot-1 snd-card-1
-alias sound-service-1-0 snd-mixer-oss
-alias sound-service-1-3 snd-pcm-oss
-alias sound-service-1-12 snd-pcm-oss
+alias sound-slot-0 snd-gusclassic
+alias sound-slot-1 snd-gusclassic
 
 -----
 
-If you want to autoclean your modules, you should put below line to your
-/etc/crontab:
-
-*/10 * * * *   root  /sbin/modprobe -rs snd-card-0 snd-card-1; /sbin/rmmod -as
-
 You may also want to extend the soundcard list to follow your requirements.
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/sound/oss/Introduction .2432-linux-2.6.0-test5.updated/Documentation/sound/oss/Introduction
--- .2432-linux-2.6.0-test5/Documentation/sound/oss/Introduction	2003-08-12 06:57:35.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/sound/oss/Introduction	2003-09-10 14:57:17.000000000 +1000
@@ -431,8 +431,7 @@ options bttv  card=0 radio=0 pll=0
 
 For More Information (RTFM):
 ============================
-1)  Information on kernel modules:  linux/Documentation/modules.txt
-    and manual pages for insmod and modprobe.
+1)  Information on kernel modules: the manual page for modprobe.
 
 2)  Information on PnP, RTFM manual pages for isapnp.
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/sound/oss/Opti .2432-linux-2.6.0-test5.updated/Documentation/sound/oss/Opti
--- .2432-linux-2.6.0-test5/Documentation/sound/oss/Opti	2003-01-02 11:58:51.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/Documentation/sound/oss/Opti	2003-09-10 16:33:54.000000000 +1000
@@ -18,7 +18,7 @@ force the card into a mode in which it c
 If you have another OS installed on your computer it is recommended
 that Linux and the other OS use the same resources.
 
-Also, it is recommended that resources specified in /etc/modules.conf
+Also, it is recommended that resources specified in /etc/modprobe.conf
 and resources specified in /etc/isapnp.conf agree.
 
 Compiling the sound driver
@@ -65,12 +65,9 @@ The driver has one limitation with respe
 IO3 base must be 0x0E0C.  Although isapnp allows other ports, this
 address is hard-coded into the driver.
 
-Using kmod and autoloading the sound driver
+Autoloading the sound driver
 -------------------------------------------
-Comment: as of linux-2.1.90 kmod is replacing kerneld.
-The config file '/etc/modules.conf' is used as before.
-
-This is the sound part of my /etc/modules.conf file.
+This is the sound part of my /etc/modprobe.conf file.
 Following that I will explain each line.
 
 alias mixer0 mad16
@@ -80,7 +77,7 @@ alias synth0 opl3
 options sb mad16=1
 options mad16 irq=10 dma=0 dma16=1 io=0x530 joystick=1 cdtype=0
 options opl3 io=0x388
-post-install mad16 /sbin/ad1848_mixer_reroute 14 8 15 3 16 6
+install mad16 /sbin/modprobe --ignore-install mad16 && /sbin/ad1848_mixer_reroute 14 8 15 3 16 6
 
 If you have an MPU daughtercard or onboard MPU you will want to add to the
 "options mad16" line - eg 
@@ -97,9 +94,9 @@ alias audio0 mad16
 alias midi0  mad16
 alias synth0 opl3
 
-When any sound device is opened the kernel requests auto-loading
-of char-major-14. There is a built-in alias that translates this
-request to loading the main sound module.
+When any sound device is opened the kernel requests auto-loading of
+char-major-14. This loads the mail sound module by default, but can
+be overriden in /etc/modprobe.conf.
 
 The sound module in its turn will request loading of a sub-driver
 for mixer, audio, midi or synthesizer device. The first 3 are
@@ -120,7 +117,7 @@ for a SB card but to wait for the mad16 
 options mad16 irq=10 dma=0 dma16=1 io=0x530 joystick=1 cdtype=0
 options opl3 io=0x388
 
-post-install mad16 /sbin/ad1848_mixer_reroute 14 8 15 3 16 6
+install mad16 /sbin/modprobe --ignore-install mad16 && /sbin/ad1848_mixer_reroute 14 8 15 3 16 6
 
 This sets resources and options for the mad16 and opl3 drivers.
 I use two DMA channels (only one is required) to enable full duplex.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/video4linux/CQcam.txt .2432-linux-2.6.0-test5.updated/Documentation/video4linux/CQcam.txt
--- .2432-linux-2.6.0-test5/Documentation/video4linux/CQcam.txt	2003-08-12 06:57:35.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/video4linux/CQcam.txt	2003-09-10 14:57:47.000000000 +1000
@@ -71,7 +71,7 @@ these procedures.
 2.1 Module Configuration  
 
   Using modules requires a bit of work to install and pass the
-parameters.  Do read ../modules.txt, and understand that entries
+parameters.  Read the modprobe.conf man page, and understand that entries
 in /etc/modules.conf of:
 
    alias parport_lowlevel parport_pc
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/Documentation/video4linux/bttv/Modprobe.conf .2432-linux-2.6.0-test5.updated/Documentation/video4linux/bttv/Modprobe.conf
--- .2432-linux-2.6.0-test5/Documentation/video4linux/bttv/Modprobe.conf	1970-01-01 10:00:00.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/Documentation/video4linux/bttv/Modprobe.conf	2003-09-10 16:40:45.000000000 +1000
@@ -0,0 +1,10 @@
+# In 2.6.0, modules know their own char numbers.
+
+# i2c
+options i2c-core	i2c_debug=1
+options i2c-algo-bit	bit_test=1
+
+# bttv
+options	bttv		card=2 radio=1
+options	tuner		debug=1
+
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/arch/i386/kernel/microcode.c .2432-linux-2.6.0-test5.updated/arch/i386/kernel/microcode.c
--- .2432-linux-2.6.0-test5/arch/i386/kernel/microcode.c	2003-08-25 11:58:12.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/arch/i386/kernel/microcode.c	2003-09-10 17:05:26.000000000 +1000
@@ -80,6 +80,7 @@ static spinlock_t microcode_update_lock 
 MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(MICROCODE_MINOR);
 
 #define MICRO_DEBUG 0
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/esp.c .2432-linux-2.6.0-test5.updated/drivers/char/esp.c
--- .2432-linux-2.6.0-test5/drivers/char/esp.c	2003-08-25 11:58:16.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/esp.c	2003-09-10 16:53:26.000000000 +1000
@@ -94,6 +94,9 @@ MODULE_PARM(flow_on, "i");
 MODULE_PARM(rx_timeout, "i");
 MODULE_PARM(pio_threshold, "i");
 
+MODULE_ALIAS_CHARDEV_MAJOR(ESP_IN_MAJOR);
+MODULE_ALIAS_CHARDEV_MAJOR(ESP_OUT_MAJOR); /* hayes-esp claimed this, too? */
+
 /* END */
 
 static char *dma_buffer;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/ftape/zftape/zftape-init.c .2432-linux-2.6.0-test5.updated/drivers/char/ftape/zftape/zftape-init.c
--- .2432-linux-2.6.0-test5/drivers/char/ftape/zftape/zftape-init.c	2003-09-09 10:34:31.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/ftape/zftape/zftape-init.c	2003-09-10 17:13:31.000000000 +1000
@@ -55,7 +55,7 @@ MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
 		   "VFS interface for the Linux floppy tape driver. "
 		   "Support for QIC-113 compatible volume table "
 		   "and builtin compression (lzrw3 algorithm)");
-MODULE_SUPPORTED_DEVICE("char-major-27");
+MODULE_ALIAS_CHARDEV_MAJOR(QIC117_TAPE_MAJOR);
 MODULE_LICENSE("GPL");
 
 /*      Global vars.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/genrtc.c .2432-linux-2.6.0-test5.updated/drivers/char/genrtc.c
--- .2432-linux-2.6.0-test5/drivers/char/genrtc.c	2003-07-14 16:58:36.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/genrtc.c	2003-09-10 17:12:14.000000000 +1000
@@ -526,4 +526,4 @@ static int gen_rtc_read_proc(char *page,
 
 MODULE_AUTHOR("Richard Zidlicky");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS_MISCDEV(RTC_MINOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/ip2.c .2432-linux-2.6.0-test5.updated/drivers/char/ip2.c
--- .2432-linux-2.6.0-test5/drivers/char/ip2.c	2003-07-31 01:50:09.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/ip2.c	2003-09-10 16:57:56.000000000 +1000
@@ -47,6 +47,9 @@ MODULE_PARM_DESC(io,"I/O ports for Intel
 MODULE_PARM(poll_only,"1i");
 MODULE_PARM_DESC(poll_only,"Do not use card interrupts");
 
+MODULE_ALIAS_CHARDEV_MAJOR(IP2_IPL_MAJOR);
+MODULE_ALIAS_CHARDEV_MAJOR(IP2_TTY_MAJOR);
+MODULE_ALIAS_CHARDEV_MAJOR(IP2_CALLOUT_MAJOR);
 
 //======================================================================
 int
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/lp.c .2432-linux-2.6.0-test5.updated/drivers/char/lp.c
--- .2432-linux-2.6.0-test5/drivers/char/lp.c	2003-09-09 10:34:31.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/lp.c	2003-09-10 17:14:27.000000000 +1000
@@ -965,5 +965,5 @@ __setup("lp=", lp_setup);
 module_init(lp_init_module);
 module_exit(lp_cleanup_module);
 
-MODULE_ALIAS("char-major-" __stringify(LP_MAJOR));
+MODULE_ALIAS_CHARDEV_MAJOR(LP_MAJOR);
 MODULE_LICENSE("GPL");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/pcxx.c .2432-linux-2.6.0-test5.updated/drivers/char/pcxx.c
--- .2432-linux-2.6.0-test5/drivers/char/pcxx.c	2003-09-09 10:34:32.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/pcxx.c	2003-09-10 16:48:39.000000000 +1000
@@ -120,7 +120,7 @@ MODULE_PARM(membase,     "1-4i");
 MODULE_PARM(memsize,     "1-4i");
 MODULE_PARM(altpin,      "1-4i");
 MODULE_PARM(numports,    "1-4i");
-
+MODULE_ALIAS_CHARDEV_MAJOR(DIGI_MAJOR);
 #endif /* MODULE */
 
 static int numcards = 1;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/rocket.c .2432-linux-2.6.0-test5.updated/drivers/char/rocket.c
--- .2432-linux-2.6.0-test5/drivers/char/rocket.c	2003-09-09 10:34:32.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/rocket.c	2003-09-10 17:11:23.000000000 +1000
@@ -224,6 +224,10 @@ module_exit(rp_cleanup_module);
 MODULE_LICENSE("Dual BSD/GPL");
 #endif
 
+#ifdef MODULE_ALIAS_CHARDEV_MAJOR
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_ROCKET_MAJOR);
+#endif
+
 /*************************************************************************/
 /*                     Module code starts here                           */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/char/sonypi.c .2432-linux-2.6.0-test5.updated/drivers/char/sonypi.c
--- .2432-linux-2.6.0-test5/drivers/char/sonypi.c	2003-09-09 10:34:32.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/char/sonypi.c	2003-09-10 16:50:56.000000000 +1000
@@ -876,7 +876,6 @@ MODULE_AUTHOR("Stelian Pop <stelian@popi
 MODULE_DESCRIPTION("Sony Programmable I/O Control Device driver");
 MODULE_LICENSE("GPL");
 
-
 MODULE_PARM(minor,"i");
 MODULE_PARM_DESC(minor, "minor number of the misc device, default is -1 (automatic)");
 MODULE_PARM(verbose,"i");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/i2c/i2c-dev.c .2432-linux-2.6.0-test5.updated/drivers/i2c/i2c-dev.c
--- .2432-linux-2.6.0-test5/drivers/i2c/i2c-dev.c	2003-09-09 10:34:33.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/i2c/i2c-dev.c	2003-09-10 16:38:03.000000000 +1000
@@ -536,6 +536,7 @@ MODULE_AUTHOR("Frodo Looijaard <frodol@d
 		"Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(I2C_MAJOR);
 
 module_init(i2c_dev_init);
 module_exit(i2c_dev_exit);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/ide/ide-probe.c .2432-linux-2.6.0-test5.updated/drivers/ide/ide-probe.c
--- .2432-linux-2.6.0-test5/drivers/ide/ide-probe.c	2003-09-09 10:34:33.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/ide/ide-probe.c	2003-09-10 17:02:46.000000000 +1000
@@ -1372,3 +1372,6 @@ void cleanup_module (void)
 }
 MODULE_LICENSE("GPL");
 #endif /* MODULE */
+
+/* We put alias here, so we get loaded if ide is needed. */
+MODULE_ALIAS_BLOCKDEV_MAJOR(IDE0_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/ide/ide-tape.c .2432-linux-2.6.0-test5.updated/drivers/ide/ide-tape.c
--- .2432-linux-2.6.0-test5/drivers/ide/ide-tape.c	2003-09-09 10:34:33.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/ide/ide-tape.c	2003-09-10 17:03:48.000000000 +1000
@@ -6424,6 +6424,7 @@ failed:
 
 MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(IDETAPE_MAJOR);
 
 static void __exit idetape_exit (void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/input/input.c .2432-linux-2.6.0-test5.updated/drivers/input/input.c
--- .2432-linux-2.6.0-test5/drivers/input/input.c	2003-09-09 10:34:34.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/input/input.c	2003-09-10 15:10:39.000000000 +1000
@@ -28,6 +28,7 @@
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(INPUT_MAJOR);
 
 EXPORT_SYMBOL(input_register_device);
 EXPORT_SYMBOL(input_unregister_device);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/media/dvb/Kconfig .2432-linux-2.6.0-test5.updated/drivers/media/dvb/Kconfig
--- .2432-linux-2.6.0-test5/drivers/media/dvb/Kconfig	2003-07-31 01:50:10.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/media/dvb/Kconfig	2003-09-10 17:26:30.000000000 +1000
@@ -18,13 +18,14 @@ config DVB
 	  Please report problems regarding this driver to the LinuxDVB 
 	  mailing list.
 
-	  You might want add the following lines to your /etc/modules.conf:
-	  	
-	  	alias char-major-250 dvb
-	  	alias dvb dvb-ttpci
-	  	below dvb-ttpci alps_bsru6 alps_bsrv2 \
+	  You might want add the following lines to your /etc/modprobe.conf:
+
+	  	alias char-major-250 dvb-ttpci
+		
+	  	install dvb-ttpci for f in alps_bsru6 alps_bsrv2 \
 	  			grundig_29504-401 grundig_29504-491 \
-	  			ves1820
+	  			ves1820; do /sbin/modprobe $f; done; \
+				/sbin/modprobe --ignore-install dvb-ttpci
 
 	  If unsure say N.
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.c .2432-linux-2.6.0-test5.updated/drivers/media/dvb/dvb-core/dvbdev.c
--- .2432-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.c	2003-09-09 10:34:36.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/media/dvb/dvb-core/dvbdev.c	2003-09-10 17:23:16.000000000 +1000
@@ -325,4 +325,4 @@ MODULE_LICENSE("GPL");
 
 MODULE_PARM(dvbdev_debug,"i");
 MODULE_PARM_DESC(dvbdev_debug, "enable verbose debug messages");
-
+MODULE_ALIAS_CHARDEV_MAJOR(DVB_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/media/video/bttv-driver.c .2432-linux-2.6.0-test5.updated/drivers/media/video/bttv-driver.c
--- .2432-linux-2.6.0-test5/drivers/media/video/bttv-driver.c	2003-09-09 10:34:36.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/media/video/bttv-driver.c	2003-09-10 16:44:00.000000000 +1000
@@ -115,7 +115,7 @@ MODULE_PARM(v4l2,"i");
 MODULE_DESCRIPTION("bttv - v4l/v4l2 driver module for bt848/878 based cards");
 MODULE_AUTHOR("Ralph Metzler & Marcus Metzler & Gerd Knorr");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV_MAJOR(VIDEO_MAJOR);
+MODULE_ALIAS_CHARDEV(VIDEO_MAJOR,0);
 
 /* kernel args */
 #ifndef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/media/video/cpia_pp.c .2432-linux-2.6.0-test5.updated/drivers/media/video/cpia_pp.c
--- .2432-linux-2.6.0-test5/drivers/media/video/cpia_pp.c	2003-05-27 15:02:10.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/media/video/cpia_pp.c	2003-09-10 16:45:49.000000000 +1000
@@ -79,6 +79,7 @@ static int parport_nr[PARPORT_MAX] __ini
 	{[0 ... PARPORT_MAX - 1] = PPCPIA_PARPORT_UNSPEC};
 static int parport_ptr = 0;
 #endif
+MODULE_ALIAS_CHARDEV(VIDEO_MAJOR,0);
 
 struct pp_cam_entry {
 	struct pardevice *pdev;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/media/video/videodev.c .2432-linux-2.6.0-test5.updated/drivers/media/video/videodev.c
--- .2432-linux-2.6.0-test5/drivers/media/video/videodev.c	2003-09-09 10:34:36.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/media/video/videodev.c	2003-09-10 16:38:53.000000000 +1000
@@ -399,7 +399,7 @@ EXPORT_SYMBOL(video_device_release);
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS_CHARDEV_MAJOR(VIDEO_DEV);
 
 /*
  * Local variables:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/media/video/zoran_card.c .2432-linux-2.6.0-test5.updated/drivers/media/video/zoran_card.c
--- .2432-linux-2.6.0-test5/drivers/media/video/zoran_card.c	2003-09-09 10:34:36.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/media/video/zoran_card.c	2003-09-10 16:44:42.000000000 +1000
@@ -1577,3 +1577,4 @@ unload_dc10_cards (void)
 
 module_init(init_dc10_cards);
 module_exit(unload_dc10_cards);
+MODULE_ALIAS_CHARDEV(VIDEO_MAJOR,0);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/net/bsd_comp.c .2432-linux-2.6.0-test5.updated/drivers/net/bsd_comp.c
--- .2432-linux-2.6.0-test5/drivers/net/bsd_comp.c	2003-05-05 12:37:02.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/net/bsd_comp.c	2003-09-10 17:08:02.000000000 +1000
@@ -1176,3 +1176,4 @@ void __exit bsdcomp_cleanup(void)
 module_init(bsdcomp_init);
 module_exit(bsdcomp_cleanup);
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_PPP_COMPRESS(CI_BSD_COMPRESS);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/net/ppp_deflate.c .2432-linux-2.6.0-test5.updated/drivers/net/ppp_deflate.c
--- .2432-linux-2.6.0-test5/drivers/net/ppp_deflate.c	2003-06-15 11:29:55.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/net/ppp_deflate.c	2003-09-10 17:08:32.000000000 +1000
@@ -655,3 +655,5 @@ void __exit deflate_cleanup(void)
 module_init(deflate_init);
 module_exit(deflate_cleanup);
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_PPP_COMPRESS(CI_DEFLATE);
+MODULE_ALIAS_PPP_COMPRESS(CI_DEFLATE_DRAFT);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/s390/char/tubfs.c .2432-linux-2.6.0-test5.updated/drivers/s390/char/tubfs.c
--- .2432-linux-2.6.0-test5/drivers/s390/char/tubfs.c	2003-05-27 15:02:13.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/s390/char/tubfs.c	2003-09-10 15:22:47.000000000 +1000
@@ -471,3 +471,7 @@ do_cleanup:
 	kfree(idalp);
 	return len;
 }
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0))
+MODULE_ALIAS_CHARDEV_MAJOR(IBM_FS3270_MAJOR);
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/s390/char/tubtty.c .2432-linux-2.6.0-test5.updated/drivers/s390/char/tubtty.c
--- .2432-linux-2.6.0-test5/drivers/s390/char/tubtty.c	2003-06-15 11:29:57.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/s390/char/tubtty.c	2003-09-10 15:23:31.000000000 +1000
@@ -953,3 +953,6 @@ tty3270_show_tube(int minor, char *buf, 
 
 	return len;
 }
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0))
+MODULE_ALIAS_CHARDEV_MAJOR(IBM_TTY3270_MAJOR);
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/drivers/scsi/osst.c .2432-linux-2.6.0-test5.updated/drivers/scsi/osst.c
--- .2432-linux-2.6.0-test5/drivers/scsi/osst.c	2003-09-09 10:34:42.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/drivers/scsi/osst.c	2003-09-10 15:28:04.000000000 +1000
@@ -5603,3 +5603,4 @@ static void __exit exit_osst (void)
 
 module_init(init_osst);
 module_exit(exit_osst);
+MODULE_ALIAS_CHARDEV_MAJOR(OSST_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/include/linux/device.h .2432-linux-2.6.0-test5.updated/include/linux/device.h
--- .2432-linux-2.6.0-test5/include/linux/device.h	2003-09-09 10:35:01.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/include/linux/device.h	2003-09-10 15:09:56.000000000 +1000
@@ -402,5 +402,5 @@ extern void firmware_unregister(struct s
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
 #define MODULE_ALIAS_CHARDEV_MAJOR(major) \
-	MODULE_ALIAS("char-major-" __stringify(major) "-*")
+	MODULE_ALIAS("char-major-" __stringify(major) "*")
 #endif /* _DEVICE_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/include/linux/ppp_defs.h .2432-linux-2.6.0-test5.updated/include/linux/ppp_defs.h
--- .2432-linux-2.6.0-test5/include/linux/ppp_defs.h	2003-05-27 15:02:22.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/include/linux/ppp_defs.h	2003-09-10 17:07:19.000000000 +1000
@@ -185,4 +185,7 @@ struct ppp_idle {
 #endif
 #endif
 
+#define MODULE_ALIAS_PPP_COMPRESS(num) \
+	MODULE_ALIAS("ppp-compress-" __stringify(num))
+
 #endif /* _PPP_DEFS_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/include/sound/minors.h .2432-linux-2.6.0-test5.updated/include/sound/minors.h
--- .2432-linux-2.6.0-test5/include/sound/minors.h	2003-01-02 12:02:06.000000000 +1100
+++ .2432-linux-2.6.0-test5.updated/include/sound/minors.h	2003-09-10 16:17:53.000000000 +1000
@@ -81,6 +81,8 @@
 #define SNDRV_OSS_DEVICE_TYPE_SNDSTAT	5
 #define SNDRV_OSS_DEVICE_TYPE_MUSIC	6
 
+#define MODULE_ALIAS_SNDRV_MINOR(type) \
+	MODULE_ALIAS("sound-service-?-" __stringify(type))
 #endif
 
 #endif /* __SOUND_MINORS_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/sound/core/oss/mixer_oss.c .2432-linux-2.6.0-test5.updated/sound/core/oss/mixer_oss.c
--- .2432-linux-2.6.0-test5/sound/core/oss/mixer_oss.c	2003-09-09 10:35:11.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/sound/core/oss/mixer_oss.c	2003-09-10 16:18:20.000000000 +1000
@@ -33,6 +33,7 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Mixer OSS emulation for ALSA.");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_MIXER);
 
 static int snd_mixer_oss_open(struct inode *inode, struct file *file)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/sound/core/oss/pcm_oss.c .2432-linux-2.6.0-test5.updated/sound/core/oss/pcm_oss.c
--- .2432-linux-2.6.0-test5/sound/core/oss/pcm_oss.c	2003-09-09 10:35:11.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/sound/core/oss/pcm_oss.c	2003-09-10 16:24:18.000000000 +1000
@@ -56,7 +56,8 @@ MODULE_PARM_DESC(adsp_map, "PCM device n
 MODULE_PARM_SYNTAX(adsp_map, "default:1,skill:advanced");
 MODULE_PARM(nonblock_open, "i");
 MODULE_PARM_DESC(nonblock_open, "Don't block opening busy PCM devices.");
-MODULE_PARM_SYNTAX(nonblock_open, "default:0,skill:advanced");
+MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM);
+MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM1);
 
 extern int snd_mixer_oss_ioctl_card(snd_card_t *card, unsigned int cmd, unsigned long arg);
 static int snd_pcm_oss_get_rate(snd_pcm_oss_file_t *pcm_oss_file);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/sound/core/seq/oss/seq_oss.c .2432-linux-2.6.0-test5.updated/sound/core/seq/oss/seq_oss.c
--- .2432-linux-2.6.0-test5/sound/core/seq/oss/seq_oss.c	2003-09-09 10:35:11.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/sound/core/seq/oss/seq_oss.c	2003-09-10 16:22:15.000000000 +1000
@@ -35,6 +35,8 @@ MODULE_AUTHOR("Takashi Iwai <tiwai@suse.
 MODULE_DESCRIPTION("OSS-compatible sequencer module");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
+MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_SEQUENCER);
+MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_MUSIC);
 
 #ifdef SNDRV_SEQ_OSS_DEBUG
 MODULE_PARM(seq_oss_debug, "i");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/sound/core/sound.c .2432-linux-2.6.0-test5.updated/sound/core/sound.c
--- .2432-linux-2.6.0-test5/sound/core/sound.c	2003-09-09 10:35:11.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/sound/core/sound.c	2003-09-10 16:04:07.000000000 +1000
@@ -58,6 +58,7 @@ MODULE_PARM(device_mode, "i");
 MODULE_PARM_DESC(device_mode, "Device file permission mask for devfs.");
 MODULE_PARM_SYNTAX(device_mode, "default:0666,base:8");
 #endif
+MODULE_ALIAS_CHARDEV_MAJOR(CONFIG_SND_MAJOR);
 
 int snd_ecards_limit;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2432-linux-2.6.0-test5/sound/sound_core.c .2432-linux-2.6.0-test5.updated/sound/sound_core.c
--- .2432-linux-2.6.0-test5/sound/sound_core.c	2003-09-09 10:35:12.000000000 +1000
+++ .2432-linux-2.6.0-test5.updated/sound/sound_core.c	2003-09-10 16:01:08.000000000 +1000
@@ -547,6 +547,7 @@ EXPORT_SYMBOL(mod_firmware_load);
 MODULE_DESCRIPTION("Core sound module");
 MODULE_AUTHOR("Alan Cox");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
 
 static void __exit cleanup_soundcore(void)
 {
