Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265617AbSKAEye>; Thu, 31 Oct 2002 23:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265627AbSKAEyd>; Thu, 31 Oct 2002 23:54:33 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:57250 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265617AbSKAEyE>; Thu, 31 Oct 2002 23:54:04 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: linux-2.5.45-uc1 (MMU-less support)
References: <3DC14635.1000308@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 01 Nov 2002 14:00:10 +0900
In-Reply-To: <3DC14635.1000308@snapgear.com>
Message-ID: <buoiszhj351.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Here's a v850 update for 2.5.45-uc1.

Note some files are added/removed.

Thanks,

-Miles


Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.5.45-uc1-v850-20021101-dist.patch
Content-Description: linux-2.5.45-uc1-v850-20021101-dist.patch

diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/arch/v850/Kconfig arch/v850/Kconfig
--- ../orig/linux-2.5.45-uc1/arch/v850/Kconfig	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/Kconfig	2002-11-01 13:37:35.000000000 +0900
@@ -0,0 +1,488 @@
+#############################################################################
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/config-language.txt.
+#
+#############################################################################
+
+mainmenu "uClinux/v850 (w/o MMU) Kernel Configuration"
+
+config MMU
+       	bool
+	default n
+config SWAP
+	bool
+	default n
+config UID16
+	bool
+	default n
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+	default n
+
+# Turn off some random 386 crap that can affect device config
+config ISA
+	bool
+	default n
+config ISAPNP
+	bool
+	default n
+config EISA
+	bool
+	default n
+config MCA
+	bool
+	default n
+
+
+#############################################################################
+#### v850-specific config
+
+# Define the architecture
+config V850
+	bool
+	default y
+
+menu "Processor type and features"
+
+   choice
+	  prompt "Platform"
+	  default GDB
+      config RTE_CB_MA1
+      	     bool "RTE-V850E/MA1-CB"
+      config RTE_CB_NB85E
+      	     bool "RTE-V850E/NB85E-CB"
+      config V850E_SIM
+      	     bool "GDB"
+      config V850E2_SIM85E2C
+      	     bool "sim85e2c"
+      config V850E2_FPGA85E2C
+      	     bool "NA85E2C-FPGA"
+      config V850E2_ANNA
+      	     bool "Anna"
+   endchoice
+
+
+   #### V850E processor-specific config
+
+   # All CPUs currently supported use the v850e architecture
+   config V850E
+   	  bool
+	  default y
+
+   # The RTE-V850E/MA1-CB is the only type of V850E/MA1 platform we
+   # currently support
+   config V850E_MA1
+   	  bool
+	  depends RTE_CB_MA1
+	  default y
+   # Similarly for the RTE-V850E/MA1-CB - V850E/TEG
+   config V850E_TEG
+   	  bool
+	  depends RTE_CB_NB85E
+	  default y
+
+   # NB85E processor core
+   config V850E_NB85E
+   	  bool
+	  depends V850E_MA1 || V850E_TEG
+	  default y
+
+   config V850E_MA1_HIGHRES_TIMER
+   	  bool "High resolution timer support"
+  	  depends V850E_MA1
+
+
+   #### V850E2 processor-specific config
+
+   # V850E2 processors
+   config V850E2
+   	  bool
+	  depends V850E2_SIM85E2C || V850E2_FPGA85E2C || V850E2_ANNA
+	  default y
+
+   # Processors based on the NA85E2A core
+   config V850E2_NA85E2A
+   	  bool
+	  depends V850E2_ANNA
+	  default y
+
+   # Processors based on the NA85E2C core
+   config V850E2_NA85E2C
+   	  bool
+	  depends V850E2_SIM85E2C || V850E2_FPGA85E2C
+	  default y
+
+
+   #### RTE-CB platform-specific config
+
+   # Boards in the RTE-x-CB series
+   config RTE_CB
+   	  bool
+	  depends RTE_CB_MA1 || RTE_CB_NB85E
+	  default y
+
+   # Currently, we only support RTE-CB boards using the Multi debugger
+   config RTE_CB_MULTI
+   	  bool
+	  depends RTE_CB
+	  default y
+
+   config RTE_CB_MA1_KSRAM
+   	  bool "Kernel in SRAM (limits size of kernel)"
+	  depends RTE_CB_MA1 && RTE_CB_MULTI
+	  default n
+
+   config RTE_MB_A_PCI
+   	  bool "Mother-A PCI support"
+	  depends RTE_CB
+	  default y
+
+   # The GBUS is used to talk to the RTE-MOTHER-A board
+   config RTE_GBUS_INT
+   	  bool
+	  depends RTE_MB_A_PCI
+	  default y
+
+   # The only PCI bus we support is on the RTE-MOTHER-A board
+   config PCI
+   	  bool
+	  default y if RTE_MB_A_PCI
+
+
+   #### Misc config
+
+   config ROM_KERNEL
+   	  bool "Kernel in ROM"
+	  depends V850E2_ANNA || (RTE_CB && !RTE_CB_MULTI)
+
+   # Some platforms pre-zero memory, in which case the kernel doesn't need to
+   config ZERO_BSS
+   	  bool
+	  depends !V850E2_SIM85E2C
+	  default y
+
+   # The crappy-ass zone allocator requires that the start of allocatable
+   # memory be aligned to the largest possible allocation.
+   config FORCE_MAX_ZONEORDER
+   	  int
+	  default 8 if V850E2_SIM85E2C || V850E2_FPGA85E2C
+
+   config TIME_BOOTUP
+   	  bool "Time bootup"
+	  depends V850E_MA1_HIGHRES_TIMER
+
+   config RESET_GUARD
+   	  bool "Reset Guard"
+
+   config LARGE_ALLOCS
+	  bool "Allow allocating large blocks (> 1MB) of memory"
+	  help
+	     Allow the slab memory allocator to keep chains for very large
+	     memory sizes - upto 32MB. You may need this if your system has
+	     a lot of RAM, and you need to able to allocate very large
+	     contiguous chunks. If unsure, say N.
+
+endmenu
+
+
+#############################################################################
+
+source init/Kconfig
+
+#############################################################################
+
+menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+
+#    config PCI
+# 	   bool "PCI support"
+# 	   help
+# 	     Support for PCI bus.
+
+source "drivers/pci/Kconfig"
+
+config HOTPLUG
+	bool "Support for hot-pluggable device"
+	  ---help---
+	  Say Y here if you want to plug devices into your computer while
+	  the system is running, and be able to use them quickly.  In many
+	  cases, the devices can likewise be unplugged at any time too.
+
+	  One well known example of this is PCMCIA- or PC-cards, credit-card
+	  size devices such as network cards, modems or hard drives which are
+	  plugged into slots found on all modern laptop computers.  Another
+	  example, used on modern desktops as well as laptops, is USB.
+
+	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
+	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
+	  Then your kernel will automatically call out to a user mode "policy
+	  agent" (/sbin/hotplug) to load modules and set up software needed
+	  to use devices as you hotplug them.
+
+source "drivers/pcmcia/Kconfig"
+
+source "drivers/hotplug/Kconfig"
+
+endmenu
+
+menu "Executable file formats"
+
+config KCORE_AOUT
+	bool
+	default y
+
+config KCORE_ELF
+	default y
+
+config BINFMT_FLAT
+	tristate "Kernel support for flat binaries"
+	help
+	  Support uClinux FLAT format binaries.
+
+config BINFMT_ZFLAT
+	bool "  Enable ZFLAT support"
+	depends on BINFMT_FLAT
+	help
+	  Support FLAT format compressed binaries
+
+endmenu
+
+#############################################################################
+
+source drivers/mtd/Kconfig
+
+source drivers/parport/Kconfig
+
+#source drivers/pnp/Kconfig
+
+source drivers/block/Kconfig
+
+#############################################################################
+
+menu "Disk device support"
+
+config IDE
+       tristate "ATA/ATAPI/MFM/RLL device support"
+       ---help---
+	 If you say Y here, your kernel will be able to manage low cost mass
+	 storage units such as ATA/(E)IDE and ATAPI units. The most common
+	 cases are IDE hard drives and ATAPI CD-ROM drives.
+
+	 It only makes sense to choose this option if your board actually
+	 has an IDE interface. If unsure, say N.
+
+source "drivers/ide/Kconfig"
+
+config SCSI
+	tristate "SCSI device support"
+	help
+	  If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
+	  any other SCSI device under Linux, say Y and make sure that you know
+	  the name of your SCSI host adapter (the card inside your computer
+	  that "speaks" the SCSI protocol, also called SCSI controller),
+	  because you will be asked for it.
+
+source "drivers/scsi/Kconfig"
+
+endmenu
+
+#############################################################################
+
+
+source "drivers/md/Kconfig"
+
+source "drivers/message/fusion/Kconfig"
+
+source "drivers/ieee1394/Kconfig"
+
+source "drivers/message/i2o/Kconfig"
+
+source "net/Kconfig"
+
+
+menu "Network device support"
+	depends on NET
+
+config NETDEVICES
+	bool "Network device support"
+	---help---
+	  You can say N here if you don't intend to connect your Linux box to
+	  any other computer at all or if all your connections will be over a
+	  telephone line with a modem either via UUCP (UUCP is a protocol to
+	  forward mail and news between unix hosts over telephone lines; read
+	  the UUCP-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>) or dialing up a shell
+	  account or a BBS, even using term (term is a program which gives you
+	  almost full Internet connectivity if you have a regular dial up
+	  shell account on some Internet connected Unix computer. Read
+	  <http://www.bart.nl/~patrickr/term-howto/Term-HOWTO.html>).
+
+	  You'll have to say Y if your computer contains a network card that
+	  you want to use under Linux (make sure you know its name because you
+	  will be asked for it and read the Ethernet-HOWTO (especially if you
+	  plan to use more than one network card under Linux)) or if you want
+	  to use SLIP (Serial Line Internet Protocol is the protocol used to
+	  send Internet traffic over telephone lines or null modem cables) or
+	  CSLIP (compressed SLIP) or PPP (Point to Point Protocol, a better
+	  and newer replacement for SLIP) or PLIP (Parallel Line Internet
+	  Protocol is mainly used to create a mini network by connecting the
+	  parallel ports of two local machines) or AX.25/KISS (protocol for
+	  sending Internet traffic over amateur radio links).
+
+	  Make sure to read the NET-3-HOWTO. Eventually, you will have to read
+	  Olaf Kirch's excellent and free book "Network Administrator's
+	  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
+	  unsure, say Y.
+
+source "drivers/net/Kconfig"
+
+source "drivers/atm/Kconfig"
+
+endmenu
+
+source "net/ax25/Kconfig"
+
+source "net/irda/Kconfig"
+
+source "drivers/isdn/Kconfig"
+
+#source "drivers/telephony/Kconfig"
+
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source "drivers/input/Kconfig"
+
+source "drivers/char/Kconfig"
+
+#source drivers/misc/Config.in
+source "drivers/media/Kconfig"
+
+source "fs/Kconfig"
+
+
+menu "Console drivers"
+	depends on VT
+
+config VGA_CONSOLE
+	bool "VGA text console"
+	help
+	  Saying Y here will allow you to use Linux in text mode through a
+	  display that complies with the generic VGA standard. Virtually
+	  everyone wants that.
+
+	  The program SVGATextMode can be used to utilize SVGA video cards to
+	  their full potential in text mode. Download it from
+	  <ftp://ibiblio.org/pub/Linux/utils/console/>.
+
+	  If unsure, say N.
+
+config VIDEO_SELECT
+	bool "Video mode selection support"
+	---help---
+	  This enables support for text mode selection on kernel startup. If
+	  you want to take advantage of some high-resolution text mode your
+	  card's BIOS offers, but the traditional Linux utilities like
+	  SVGATextMode don't, you can say Y here and set the mode using the
+	  "vga=" option from your boot loader (lilo or loadlin) or set
+	  "vga=ask" which brings up a video mode menu on kernel startup. (Try
+	  "man bootparam" or see the documentation of your boot loader about
+	  how to pass options to the kernel.)
+
+	  Read the file <file:Documentation/svga.txt> for more information
+	  about the Video mode selection support. If unsure, say N.
+
+source "drivers/video/Kconfig"
+
+endmenu
+
+
+menu "Sound"
+
+config SOUND
+	tristate "Sound card support"
+	---help---
+	  If you have a sound card in your computer, i.e. if it can say more
+	  than an occasional beep, say Y.  Be sure to have all the information
+	  about your sound card and its configuration down (I/O port,
+	  interrupt and DMA channel), because you will be asked for it.
+
+	  You want to read the Sound-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>. General information about
+	  the modular sound system is contained in the files
+	  <file:Documentation/sound/Introduction>.  The file
+	  <file:Documentation/sound/README.OSS> contains some slightly
+	  outdated but still useful information as well.
+
+	  If you have a PnP sound card and you want to configure it at boot
+	  time using the ISA PnP tools (read
+	  <http://www.roestock.demon.co.uk/isapnptools/>), then you need to
+	  compile the sound card support as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want)
+	  and load that module after the PnP configuration is finished.  To do
+	  this, say M here and read <file:Documentation/modules.txt> as well
+	  as <file:Documentation/sound/README.modules>; the module will be
+	  called soundcore.o.
+
+	  I'm told that even without a sound card, you can make your computer
+	  say more than an occasional beep, by programming the PC speaker.
+	  Kernel patches and supporting utilities to do that are in the pcsp
+	  package, available at <ftp://ftp.infradead.org/pub/pcsp/>.
+
+source "sound/Kconfig"
+
+endmenu
+
+source "drivers/usb/Kconfig"
+
+source "net/bluetooth/Kconfig"
+
+
+menu "Kernel hacking"
+
+config FULLDEBUG
+	bool "Full Symbolic/Source Debugging support"
+	help
+	  Enable debuging symbols on kernel build.
+
+config MAGIC_SYSRQ
+	bool "Magic SysRq key"
+	help
+	  Enables console device to interprent special characters as
+	  commands to dump state information.
+
+config HIGHPROFILE
+	bool "Use fast second timer for profiling"
+	help
+	  Use a fast secondary clock to produce profiling information.
+
+config DUMPTOFLASH
+	bool "Panic/Dump to FLASH"
+	depends on COLDFIRE
+	help
+	  Dump any panic of trap output into a flash memory segment
+	  for later analysis.
+
+config NO_KERNEL_MSG
+	bool "Suppress Kernel BUG Messages"
+	help
+	  Do not output any debug BUG messages within the kernel.
+
+config BDM_DISABLE
+	bool "Disable BDM signals"
+	depends on (EXPERIMENTAL && COLDFIRE)
+	help
+	  Disable the CPU's BDM signals.
+
+endmenu
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
+
+#############################################################################
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/arch/v850/README arch/v850/README
--- ../orig/linux-2.5.45-uc1/arch/v850/README	2002-11-01 10:03:36.000000000 +0900
+++ arch/v850/README	2002-11-01 13:14:14.000000000 +0900
@@ -16,6 +16,8 @@
    + A FPGA implementation of the V850E2 NA85E2C cpu core
      (CONFIG_V850E2_FPGA85E2C).
 
+   + The `Anna' (board/chip) implementation of the V850E2 processor.
+
 Porting to anything with a V850E/MA1 or MA2 processor should be simple.
 See the file <asm-v850/machdep.h> and the files it includes for an example of
 how to add platform/chip-specific support.
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/arch/v850/config.in arch/v850/config.in
--- ../orig/linux-2.5.45-uc1/arch/v850/config.in	2002-11-01 10:03:36.000000000 +0900
+++ arch/v850/config.in	1970-01-01 09:00:00.000000000 +0900
@@ -1,390 +0,0 @@
-#############################################################################
-#
-# For a description of the syntax of this configuration file,
-# see Documentation/kbuild/config-language.txt.
-#
-# based mainly on the arch/i386/config.in and bit of the 2.0, m68knommu
-# config.in
-#
-#############################################################################
-
-mainmenu_name 'uClinux/v850 (w/o MMU) Kernel Configuration'
-
-define_bool CONFIG_MMU n
-define_bool CONFIG_SWAP n
-define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
-
-# Turn off some random 386 crap that can affect device config
-define_bool CONFIG_ISA n
-define_bool CONFIG_ISAPNP n
-define_bool CONFIG_EISA n
-define_bool CONFIG_MCA n
-
-
-#############################################################################
-#### v850-specific config
-
-# Define the architecture
-define_bool CONFIG_V850 y
-
-mainmenu_option next_comment
-   comment 'Processor type and features'
-
-   choice 'Platform'						\
-	  "RTE-V850E/MA1-CB	CONFIG_RTE_CB_MA1		\
-	   RTE-V850E/NB85E-CB	CONFIG_RTE_CB_NB85E		\
-	   GDB			CONFIG_V850E_SIM		\
-	   sim85e2c		CONFIG_V850E2_SIM85E2C		\
-	   NA85E2C-FPGA		CONFIG_V850E2_FPGA85E2C		\
-	   Anna			CONFIG_V850E2_ANNA"		\
-	  GDB
-
-
-   #### V850E processor-specific config
-
-   # All CPUs currently supported use the v850e architecture
-   define_bool CONFIG_V850E y
-
-   # The RTE-V850E/MA1-CB is the only type of V850E/MA1 platform we
-   # currently support
-   define_bool CONFIG_V850E_MA1 $CONFIG_RTE_CB_MA1
-   # Similarly for the RTE-V850E/MA1-CB - V850E/TEG
-   define_bool CONFIG_V850E_TEG $CONFIG_RTE_CB_NB85E
-
-   if [ "$CONFIG_V850E_MA1" = "y" -o "$CONFIG_V850E_TEG" = "y" ]; then
-      define_bool CONFIG_V850E_NB85E y
-   else
-      define_bool CONFIG_V850E_NB85E n
-   fi
-
-   dep_bool 'High resolution timer support' CONFIG_V850E_MA1_HIGHRES_TIMER $CONFIG_V850E_MA1
-
-
-   #### V850E2 processor-specific config
-
-   # V850E2 processors
-   if [	  "$CONFIG_V850E2_SIM85E2C" = "y"  \
-       -o "$CONFIG_V850E2_FPGA85E2C" = "y" \
-       -o "$CONFIG_V850E2_ANNA" = "y"	   ]
-   then
-      define_bool CONFIG_V850E2 y
-   else
-      define_bool CONFIG_V850E2 n
-   fi
-
-   # Processors based on the NA85E2A core
-   if [ "$CONFIG_V850E2_ANNA" = "y" ]; then
-      define_bool CONFIG_V850E2_NA85E2A y
-   else
-      define_bool CONFIG_V850E2_NA85E2A n
-   fi
-
-   # Processors based on the NA85E2C core
-   if [	  "$CONFIG_V850E2_SIM85E2C" = "y"  \
-       -o "$CONFIG_V850E2_FPGA85E2C" = "y" ]
-   then
-      define_bool CONFIG_V850E2_NA85E2C y
-   else
-      define_bool CONFIG_V850E2_NA85E2C n
-   fi
-
-
-   #### sim85e2c platform-specific config
-
-   if [ "$CONFIG_V850E2_SIM85E2C" = "y" ]; then
-      # Don't bother, as it's already zeroed by the simulator
-      define_bool CONFIG_ZERO_BSS n
-
-      # The crappy-ass zone allocator requires that the start of allocatable
-      # memory be aligned to the largest possible allocation.
-      define_int CONFIG_FORCE_MAX_ZONEORDER 8
-   fi
-
-
-   #### fpga85e2c platform-specific config
-
-   if [ "$CONFIG_V850E2_FPGA85E2C" = "y" ]; then
-      # The crappy-ass zone allocator requires that the start of allocatable
-      # memory be aligned to the largest possible allocation.
-      define_int CONFIG_FORCE_MAX_ZONEORDER 8
-   fi
-
-
-   #### Anna platform-specific config
-
-   if [ "$CONFIG_V850E2_ANNA" = "y" ]; then
-      bool 'Kernel in ROM' CONFIG_ROM_KERNEL
-   fi
-
-
-   #### RTE-CB platform-specific config
-
-   # Boards in the RTE-x-CB series
-   if [ "$CONFIG_RTE_CB_MA1" = "y" -o "$CONFIG_RTE_CB_NB85E" = "y" ]; then
-      define_bool CONFIG_RTE_CB y
-   else
-      define_bool CONFIG_RTE_CB n
-   fi
-
-   # Currently, we only support RTE-CB boards using the Multi debugger
-   #dep_bool 'Multi debugger support' CONFIG_RTE_CB_MULTI $CONFIG_RTE_CB
-   define_bool CONFIG_RTE_CB_MULTI $CONFIG_RTE_CB
-
-   dep_bool 'Kernel in SRAM (limits size of kernel)' CONFIG_RTE_CB_MA1_KSRAM \
-      $CONFIG_RTE_CB_MA1 $CONFIG_RTE_CB_MULTI
-
-   dep_bool 'Mother-A PCI support' CONFIG_RTE_MB_A_PCI $CONFIG_RTE_CB
-
-   # The GBUS is used to talk to the RTE-MOTHER-A board
-   define_bool CONFIG_RTE_GBUS_INT $CONFIG_RTE_MB_A_PCI
-
-   # The only PCI bus we support is on the RTE-MOTHER-A board
-   define_bool CONFIG_PCI $CONFIG_RTE_MB_A_PCI
-
-
-   #### Misc config
-
-   # Doesn't do anything yet
-   #if [ "$CONFIG_RTE_CB_MULTI" = "n" ]; then
-   #   bool 'Kernel in ROM' CONFIG_ROM_KERNEL
-   #fi
-
-   dep_bool 'Time bootup' CONFIG_TIME_BOOTUP $CONFIG_V850E_MA1_HIGHRES_TIMER
-
-   bool 'Reset Guard' CONFIG_RESET_GUARD
-
-   # Default some stuff
-   if [ "$CONFIG_ZERO_BSS" != "n" ]; then
-      define_bool CONFIG_ZERO_BSS y
-   fi
-
-endmenu
-
-
-#############################################################################
-
-mainmenu_option next_comment
-   comment 'Code maturity level options'
-   bool 'Prompt for development and/or incomplete code/drivers' CONFIG_EXPERIMENTAL
-endmenu
-
-mainmenu_option next_comment
-   comment 'Loadable module support'
-   bool 'Enable loadable module support' CONFIG_MODULES
-   if [ "$CONFIG_MODULES" = "y" ]; then
-       bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
-       bool '  Kernel module loader' CONFIG_KMOD
-   fi
-endmenu
-
-mainmenu_option next_comment
-   comment 'General setup'
-
-   bool 'Networking support' CONFIG_NET
-   bool 'System V IPC' CONFIG_SYSVIPC
-   bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
-   bool 'Sysctl support' CONFIG_SYSCTL
-
-   # Embedded systems often won't need any hardware disk support, so
-   # only clutter up the menus with it if really necessary
-   bool 'Disk hardware support' CONFIG_DISK
-
-   source drivers/pci/Config.in
-
-   # if [ "$CONFIG_VISWS" != "y" ]; then
-   #	bool 'MCA support' CONFIG_MCA
-   # fi
-
-   bool 'Support for hot-pluggable devices' CONFIG_HOTPLUG
-
-   if [ "$CONFIG_HOTPLUG" = "y" ] ; then
-      source drivers/pcmcia/Config.in
-   else
-      define_bool CONFIG_PCMCIA n
-   fi
-
-   if [ "$CONFIG_PROC_FS" = "y" ]; then
-      choice 'Kernel core (/proc/kcore) format' \
-	     "ELF	CONFIG_KCORE_ELF	\
-	      A.OUT	CONFIG_KCORE_AOUT" ELF
-   fi
-   tristate 'Kernel support for flat binaries' CONFIG_BINFMT_FLAT
-   dep_bool '  Enable ZFLAT support' CONFIG_BINFMT_ZFLAT $CONFIG_BINFMT_FLAT
-   #tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-   #tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
-   tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-
-   # bool 'Power Management support' CONFIG_PM
-   #
-   # dep_bool '	 ACPI support' CONFIG_ACPI $CONFIG_PM
-   # if [ "$CONFIG_ACPI" != "n" ]; then
-   #	if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   #	   bool '    ACPI interpreter (EXPERIMENTAL)' CONFIG_ACPI_INTERPRETER
-   #	   bool '    Enter S1 for sleep (EXPERIMENTAL)' CONFIG_ACPI_S1_SLEEP
-   #	fi
-   # fi
-
-   bool 'Allow allocating large blocks (> 1MB) of memory' CONFIG_LARGE_ALLOCS
-
-endmenu
-
-#############################################################################
-
-source drivers/mtd/Config.in
-
-if [ "$CONFIG_PCI" != "n" ]; then
-   source drivers/parport/Config.in
-fi
-
-#source drivers/pnp/Config.in
-
-source drivers/block/Config.in
-
-#source drivers/telephony/Config.in
-
-#############################################################################
-
-if [ "$CONFIG_DISK" = "y" ]; then
-   mainmenu_option next_comment
-      comment 'ATA/IDE/MFM/RLL support'
-
-      tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
-
-      if [ "$CONFIG_IDE" != "n" ]; then
-	 source drivers/ide/Config.in
-      else
-	 define_bool CONFIG_BLK_DEV_IDE_MODES n
-	 define_bool CONFIG_BLK_DEV_HD n
-      fi
-   endmenu
-fi
-
-#############################################################################
-
-if [ "$CONFIG_DISK" = "y" ]; then
-   mainmenu_option next_comment
-      comment 'SCSI support'
-
-      tristate 'SCSI support' CONFIG_SCSI
-
-      if [ "$CONFIG_SCSI" != "n" ]; then
-	 source drivers/scsi/Config.in
-      fi
-   endmenu
-fi
-
-#############################################################################
-
-if [ "$CONFIG_PCI" = "y" ]; then
-   source drivers/ieee1394/Config.in
-fi
-
-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-
-   mainmenu_option next_comment
-      comment 'Network device support'
-
-      bool 'Network device support' CONFIG_NETDEVICES
-      if [ "$CONFIG_NETDEVICES" = "y" ]; then
-	 source drivers/net/Config.in
-	 if [ "$CONFIG_ATM" = "y" ]; then
-	    source drivers/atm/Config.in
-	 fi
-      fi
-   endmenu
-fi
-
-if [ "$CONFIG_NET" = "y" ]; then
-   source net/ax25/Config.in
-fi
-
-source net/irda/Config.in
-
-#############################################################################
-
-if [ "$CONFIG_NET" = "y" ]; then
-   mainmenu_option next_comment
-      comment 'ISDN subsystem'
-
-      tristate 'ISDN support' CONFIG_ISDN
-      if [ "$CONFIG_ISDN" != "n" ]; then
-	 source drivers/isdn/Config.in
-      fi
-   endmenu
-fi
-
-#############################################################################
-
-mainmenu_option next_comment
-   comment 'Old CD-ROM drivers (not SCSI, not IDE)'
-
-   bool 'Support non-SCSI/IDE/ATAPI CDROM drives' CONFIG_CD_NO_IDESCSI
-   if [ "$CONFIG_CD_NO_IDESCSI" != "n" ]; then
-      source drivers/cdrom/Config.in
-   fi
-endmenu
-
-#############################################################################
-
-source drivers/char/Config.in
-
-#source drivers/misc/Config.in
-
-source fs/Config.in
-
-if [ "$CONFIG_VT" = "y" ]; then
-   mainmenu_option next_comment
-      comment 'Console drivers'
-      bool 'VGA text console' CONFIG_VGA_CONSOLE
-      bool 'Video mode selection support' CONFIG_VIDEO_SELECT
-      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 tristate 'MDA text console (dual-headed) (EXPERIMENTAL)' CONFIG_MDA_CONSOLE
-	 source drivers/video/Config.in
-      fi
-   endmenu
-fi
-
-#############################################################################
-
-mainmenu_option next_comment
-   comment 'Sound'
-
-   tristate 'Sound card support' CONFIG_SOUND
-   if [ "$CONFIG_SOUND" != "n" ]; then
-      source sound/Config.in
-   fi
-endmenu
-
-#############################################################################
-
-source drivers/input/Config.in
-source drivers/usb/Config.in
-
-#############################################################################
-
-mainmenu_option next_comment
-   comment 'Kernel hacking'
-
-   bool 'Full Symbolic/Source Debugging support' CONFIG_FULLDEBUG
-   #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
-   bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
-
-   bool 'Kernel profiling support' CONFIG_PROFILE
-   if [ "$CONFIG_PROFILE" = "y" ]; then
-      int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
-      bool 'Use fast second timer for profiling' CONFIG_HIGHPROFILE
-   fi
-
-   bool 'Suppress Kernel BUG Messages' CONFIG_NO_KERNEL_MSG
-
-endmenu
-
-#############################################################################
-
-source security/Config.in
-source lib/Config.in
-
-#############################################################################
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/arch/v850/kernel/anna.c arch/v850/kernel/anna.c
--- ../orig/linux-2.5.45-uc1/arch/v850/kernel/anna.c	2002-11-01 10:03:36.000000000 +0900
+++ arch/v850/kernel/anna.c	2002-11-01 13:14:14.000000000 +0900
@@ -38,6 +38,7 @@
 
 void __init mach_early_init (void)
 {
+	ANNA_ILBEN  = 0;
 	ANNA_CSC(0) = 0x402F;
 	ANNA_CSC(1) = 0x4000;
 	ANNA_BPC    = 0;
@@ -136,6 +137,8 @@
 #ifdef CONFIG_RESET_GUARD
 	disable_reset_guard ();
 #endif
+	local_irq_disable ();	/* Ignore all interrupts.  */
+	ANNA_PORT_IO(0) = 0xAA;	/* Note that we halted.  */
 	for (;;)
 		asm ("halt; nop; nop; nop; nop; nop");
 }
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/arch/v850/kernel/rte_cb.c arch/v850/kernel/rte_cb.c
--- ../orig/linux-2.5.45-uc1/arch/v850/kernel/rte_cb.c	2002-11-01 10:03:36.000000000 +0900
+++ arch/v850/kernel/rte_cb.c	2002-11-01 13:14:15.000000000 +0900
@@ -23,6 +23,10 @@
 
 static void led_tick (void);
 
+/* LED access routines.  */
+extern unsigned read_leds (int pos, char *buf, int len);
+extern unsigned write_leds (int pos, const char *buf, int len);
+
 #ifdef CONFIG_RTE_CB_MULTI
 extern void multi_init (void);
 #endif
@@ -104,11 +108,22 @@
 	asm ("jmp r0"); /* Jump to the reset vector.  */
 }
 
+/* This says `HALt.' in LEDese.  */
+static unsigned char halt_leds_msg[] = { 0x76, 0x77, 0x38, 0xF8 };
+
 void machine_halt (void)
 {
 #ifdef CONFIG_RESET_GUARD
 	disable_reset_guard ();
 #endif
+
+	/* Ignore all interrupts.  */
+	local_irq_disable ();
+
+	/* Write a little message.  */
+	write_leds (0, halt_leds_msg, sizeof halt_leds_msg);
+
+	/* Really halt.  */
 	for (;;)
 		asm ("halt; nop; nop; nop; nop; nop");
 }
@@ -130,10 +145,6 @@
 	{ -1 }
 };
 
-/* LED access routines.  */
-extern unsigned read_leds (int pos, char *buf, int len);
-extern unsigned write_leds (int pos, const char *buf, int len);
-
 static void led_tick ()
 {
 	static unsigned counter = 0;
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/drivers/serial/Kconfig drivers/serial/Kconfig
--- ../orig/linux-2.5.45-uc1/drivers/serial/Kconfig	2002-11-01 10:03:37.000000000 +0900
+++ drivers/serial/Kconfig	2002-11-01 11:27:21.000000000 +0900
@@ -355,14 +355,22 @@
 	  This driver supports the built-in serial ports used on the Motorola
 	  ColdFire family of CPUs.
 
+config V850E_NB85E_UART
+       bool "NEC V850E on-chip UART support"
+       depends V850E_NB85E || V850E2_ANNA
+       default y
+config V850E_NB85E_UART_CONSOLE
+       bool "Use NEC V850E on-chip UART for console"
+       depends V850E_NB85E_UART
+
 config SERIAL_CORE
 	tristate
 	default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && !SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && (SERIAL_AMBA=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m)
-	default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SERIAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_ROCKETPORT || SERIAL_SUNCORE
+	default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SERIAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_ROCKETPORT || SERIAL_SUNCORE || V850E_NB85E_UART
 
 config SERIAL_CORE_CONSOLE
 	bool
-	depends on SERIAL_AMBA_CONSOLE || SERIAL_CLPS711X_CONSOLE || SERIAL_21285_CONSOLE || SERIAL_SA1100_CONSOLE || SERIAL_ANAKIN_CONSOLE || SERIAL_UART00_CONSOLE || SERIAL_8250_CONSOLE || SERIAL_SUNCORE
+	depends on SERIAL_AMBA_CONSOLE || SERIAL_CLPS711X_CONSOLE || SERIAL_21285_CONSOLE || SERIAL_SA1100_CONSOLE || SERIAL_ANAKIN_CONSOLE || SERIAL_UART00_CONSOLE || SERIAL_8250_CONSOLE || SERIAL_SUNCORE || V850E_NB85E_UART_CONSOLE
 	default y
 
 endmenu
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/include/asm-v850/anna.h include/asm-v850/anna.h
--- ../orig/linux-2.5.45-uc1/include/asm-v850/anna.h	2002-11-01 10:03:39.000000000 +0900
+++ include/asm-v850/anna.h	2002-11-01 13:14:15.000000000 +0900
@@ -72,6 +72,8 @@
 #define ANNA_SCR3			(*(volatile u16 *)ANNA_SCR3_ADDR)
 #define ANNA_RFS3_ADDR			0xFFFFF4AE
 #define ANNA_RFS3			(*(volatile u16 *)ANNA_RFS3_ADDR)
+#define ANNA_ILBEN_ADDR			0xFFFFF7F2
+#define ANNA_ILBEN			(*(volatile u16 *)ANNA_ILBEN_ADDR)
 
 
 /* I/O port P0-P3. */
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/include/asm-v850/cacheflush.h include/asm-v850/cacheflush.h
--- ../orig/linux-2.5.45-uc1/include/asm-v850/cacheflush.h	2002-11-01 10:03:40.000000000 +0900
+++ include/asm-v850/cacheflush.h	2002-11-01 11:54:30.000000000 +0900
@@ -14,6 +14,9 @@
 #ifndef __V850_CACHEFLUSH_H__
 #define __V850_CACHEFLUSH_H__
 
+/* Somebody depends on this; sigh...  */
+#include <linux/mm.h>
+
 #include <asm/setup.h>
 #include <asm/machdep.h>
 
diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/include/asm-v850/poll.h include/asm-v850/poll.h
--- ../orig/linux-2.5.45-uc1/include/asm-v850/poll.h	2002-11-01 10:03:40.000000000 +0900
+++ include/asm-v850/poll.h	2002-11-01 12:25:25.000000000 +0900
@@ -12,6 +12,7 @@
 #define POLLRDBAND	0x0080
 #define POLLWRBAND	0x0100
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;

--=-=-=



-- 
I'm beginning to think that life is just one long Yoko Ono album; no rhyme
or reason, just a lot of incoherent shrieks and then it's over.  --Ian Wolff

--=-=-=--
