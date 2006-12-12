Return-Path: <linux-kernel-owner+w=401wt.eu-S932565AbWLLXsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWLLXsj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWLLXsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:48:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4887 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932565AbWLLXsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:48:38 -0500
X-Greylist: delayed 794 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 18:48:37 EST
Date: Wed, 13 Dec 2006 00:48:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20061212234846.GC28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:

Alistair John Strachan (1):
      include/linux/compiler.h: reject gcc 3 < gcc 3.2

Cal Peake (1):
      Fix inotify maintainers entry

Dave Jones (2):
      Jon needs a new shift key.
      Fix typo in new debug options.

Jan Engelhardt (1):
      EXT{2,3,4}_FS: remove outdated part of the help text

Jesper Juhl (1):
      Kconfig: fix spelling error in config KALLSYMS help text

Peter Zijlstra (1):
      fix typo in net/ipv4/ip_fragment.c

Robert P. J. Day (3):
      kconfig: Standardize "depends" -> "depends on" in Kconfig files
      configfs.h: Remove dead macro definitions.
      fs: Convert kmalloc() + memset() to kzalloc() in fs/.

Rolf Eike Beer (1):
      Remove duplicate "have to" in comment

Samuel Tardieu (1):
      Use consistent casing in help message

Thomas Hisch (1):
      Fix small typo in drivers/serial/icom.c

Yan Burman (2):
      um: replace kmalloc+memset with kzalloc
      e100: replace kmalloc with kcalloc


 Documentation/kbuild/kconfig-language.txt  |    8 +++---
 MAINTAINERS                                |    6 +++-
 Makefile                                   |    4 +--
 arch/arm/mach-pxa/Kconfig                  |   16 ++++++------
 arch/arm/plat-omap/Kconfig                 |    2 -
 arch/powerpc/platforms/4xx/Kconfig         |    2 -
 arch/powerpc/platforms/embedded6xx/Kconfig |    2 -
 arch/ppc/Kconfig                           |    4 +--
 arch/ppc/platforms/4xx/Kconfig             |    2 -
 arch/um/drivers/net_kern.c                 |    3 --
 arch/v850/Kconfig                          |   28 ++++++++++-----------
 drivers/char/Kconfig                       |    2 -
 drivers/ide/Kconfig                        |    2 -
 drivers/leds/Kconfig                       |   22 ++++++++--------
 drivers/media/video/ov7670.c               |    2 -
 drivers/net/e100.c                         |    3 --
 drivers/serial/Kconfig                     |    4 +--
 drivers/serial/icom.c                      |    2 -
 fs/Kconfig                                 |   14 +++-------
 fs/binfmt_elf_fdpic.c                      |    3 --
 include/linux/compiler.h                   |    2 -
 include/linux/configfs.h                   |   25 ------------------
 include/linux/sysctl.h                     |    2 -
 init/Kconfig                               |    2 -
 lib/Kconfig.debug                          |    2 -
 net/ipv4/ip_fragment.c                     |    2 -
 sound/aoa/fabrics/Kconfig                  |    2 -
 27 files changed, 68 insertions(+), 100 deletions(-)


diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index 125093c..536d5bf 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -29,7 +29,7 @@ them. A single configuration option is defined like this:
 
 config MODVERSIONS
 	bool "Set version information on all module symbols"
-	depends MODULES
+	depends on MODULES
 	help
 	  Usually, modules have to be recompiled whenever you switch to a new
 	  kernel.  ...
@@ -163,7 +163,7 @@ The position of a menu entry in the tree is determined in two ways. First
 it can be specified explicitly:
 
 menu "Network device support"
-	depends NET
+	depends on NET
 
 config NETDEVICES
 	...
@@ -188,10 +188,10 @@ config MODULES
 
 config MODVERSIONS
 	bool "Set version information on all module symbols"
-	depends MODULES
+	depends on MODULES
 
 comment "module support disabled"
-	depends !MODULES
+	depends on !MODULES
 
 MODVERSIONS directly depends on MODULES, this means it's only visible if
 MODULES is different from 'n'. The comment on the other hand is always
diff --git a/MAINTAINERS b/MAINTAINERS
index b202493..9649ed9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1504,8 +1504,10 @@ T:	git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained
 
 INOTIFY
-P:	John McCutchan and Robert Love
-M:	ttb@tentacle.dhs.org and rml@novell.com
+P:	John McCutchan
+M:	ttb@tentacle.dhs.org
+P:	Robert Love
+M:	rml@novell.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
diff --git a/Makefile b/Makefile
index 73e825b..4eabaa8 100644
--- a/Makefile
+++ b/Makefile
@@ -1100,9 +1100,9 @@ boards := $(notdir $(boards))
 
 help:
 	@echo  'Cleaning targets:'
-	@echo  '  clean		  - remove most generated files but keep the config and'
+	@echo  '  clean		  - Remove most generated files but keep the config and'
 	@echo  '                    enough build support to build external modules'
-	@echo  '  mrproper	  - remove all generated files + config + various backup files'
+	@echo  '  mrproper	  - Remove all generated files + config + various backup files'
 	@echo  '  distclean	  - mrproper + remove editor backup and patch files'
 	@echo  ''
 	@echo  'Configuration targets:'
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 9e3d0bd..5c0a100 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -75,28 +75,28 @@ endmenu
 
 config MACH_POODLE
 	bool "Enable Sharp SL-5600 (Poodle) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select SHARP_LOCOMO
 	select PXA_SSP
 
 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx
 
 config MACH_SHEPHERD
 	bool "Enable Sharp SL-C750 (Shepherd) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx
 
 config MACH_HUSKY
 	bool "Enable Sharp SL-C760 (Husky) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx
 
 config MACH_AKITA
 	bool "Enable Sharp SL-1000 (Akita) Support"
-	depends PXA_SHARPSL_27x
+	depends on PXA_SHARPSL_27x
 	select PXA_SHARP_Cxx00
 	select MACH_SPITZ
 	select I2C
@@ -104,17 +104,17 @@ config MACH_AKITA
 
 config MACH_SPITZ
 	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
-	depends PXA_SHARPSL_27x
+	depends on PXA_SHARPSL_27x
 	select PXA_SHARP_Cxx00
 
 config MACH_BORZOI
 	bool "Enable Sharp Zaurus SL-3100 (Borzoi) Support"
-	depends PXA_SHARPSL_27x
+	depends on PXA_SHARPSL_27x
 	select PXA_SHARP_Cxx00
 
 config MACH_TOSA
 	bool "Enable Sharp SL-6000x (Tosa) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 
 config PXA25x
 	bool
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ec752e1..f2dc363 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -113,7 +113,7 @@ endchoice
 
 config OMAP_SERIAL_WAKE
 	bool "Enable wake-up events for serial ports"
-	depends OMAP_MUX
+	depends on OMAP_MUX
 	default y
 	help
 	  Select this option if you want to have your system wake up
diff --git a/arch/powerpc/platforms/4xx/Kconfig b/arch/powerpc/platforms/4xx/Kconfig
index ed39d6a..2f2a13e 100644
--- a/arch/powerpc/platforms/4xx/Kconfig
+++ b/arch/powerpc/platforms/4xx/Kconfig
@@ -179,7 +179,7 @@ config BIOS_FIXUP
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
 config 403GCX
 	bool
-	depends OAK
+	depends on OAK
 	default y
 
 config 405EP
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index ddbe398..b3c2ce4 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -35,7 +35,7 @@ config HDPU
 	  Select HDPU if configuring a Sky Computers Compute Blade.
 
 config HDPU_FEATURES
-	depends HDPU
+	depends on HDPU
 	tristate "HDPU-Features"
 	help
 	  Select to enable HDPU enhanced features.
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 692b5ba..8eb82ef 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -624,7 +624,7 @@ config HDPU
 	  Select HDPU if configuring a Sky Computers Compute Blade.
 
 config HDPU_FEATURES
-	depends HDPU
+	depends on HDPU
 	tristate "HDPU-Features"
 	help
 	  Select to enable HDPU enhanced features.
@@ -735,7 +735,7 @@ config LITE5200
 
 config LITE5200B
 	bool "Freescale LITE5200B"
-	depends LITE5200
+	depends on LITE5200
 	help
 	  Support for the LITE5200B dev board for the MPC5200 from Freescale.
 	  This is the new board with 2 PCI slots.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 293bd48..6980de4 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -189,7 +189,7 @@ config BIOS_FIXUP
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
 config 403GCX
 	bool
-	depends OAK
+	depends on OAK
 	default y
 
 config 405EP
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 286bc0b..b2e9762 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -334,13 +334,12 @@ static int eth_configure(int n, void *init, char *mac,
 	size = transport->private_size + sizeof(struct uml_net_private) + 
 		sizeof(((struct uml_net_private *) 0)->user);
 
-	device = kmalloc(sizeof(*device), GFP_KERNEL);
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
 		printk(KERN_ERR "eth_configure failed to allocate uml_net\n");
 		return(1);
 	}
 
-	memset(device, 0, sizeof(*device));
 	INIT_LIST_HEAD(&device->list);
 	device->index = n;
 
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index bcf8258..f0d4d72 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -105,17 +105,17 @@ menu "Processor type and features"
    # currently support
    config V850E_MA1
    	  bool
-	  depends RTE_CB_MA1
+	  depends on RTE_CB_MA1
 	  default y
    # Similarly for the RTE-V850E/NB85E-CB - V850E/TEG
    config V850E_TEG
    	  bool
-	  depends RTE_CB_NB85E
+	  depends on RTE_CB_NB85E
 	  default y
    # ... and the RTE-V850E/ME2-CB - V850E/ME2
    config V850E_ME2
    	  bool
-	  depends RTE_CB_ME2
+	  depends on RTE_CB_ME2
 	  default y
 
 
@@ -123,7 +123,7 @@ menu "Processor type and features"
 
    config V850E2_SIM85E2
    	  bool
-	  depends V850E2_SIM85E2C || V850E2_SIM85E2S
+	  depends on V850E2_SIM85E2C || V850E2_SIM85E2S
 	  default y
 
 
@@ -132,7 +132,7 @@ menu "Processor type and features"
    # V850E2 processors
    config V850E2
    	  bool
-	  depends V850E2_SIM85E2 || V850E2_FPGA85E2C || V850E2_ANNA
+	  depends on V850E2_SIM85E2 || V850E2_FPGA85E2C || V850E2_ANNA
 	  default y
 
 
@@ -141,7 +141,7 @@ menu "Processor type and features"
    # Boards in the RTE-x-CB series
    config RTE_CB
    	  bool
-	  depends RTE_CB_MA1 || RTE_CB_NB85E || RTE_CB_ME2
+	  depends on RTE_CB_MA1 || RTE_CB_NB85E || RTE_CB_ME2
 	  default y
 
    config RTE_CB_MULTI
@@ -149,28 +149,28 @@ menu "Processor type and features"
 	  # RTE_CB_NB85E can either have multi ROM support or not, but
 	  # other platforms (currently only RTE_CB_MA1) require it.
 	  prompt "Multi monitor ROM support" if RTE_CB_NB85E
-	  depends RTE_CB_MA1 || RTE_CB_NB85E
+	  depends on RTE_CB_MA1 || RTE_CB_NB85E
 	  default y
 
    config RTE_CB_MULTI_DBTRAP
    	  bool "Pass illegal insn trap / dbtrap to kernel"
-	  depends RTE_CB_MULTI
+	  depends on RTE_CB_MULTI
 	  default n
 
    config RTE_CB_MA1_KSRAM
    	  bool "Kernel in SRAM (limits size of kernel)"
-	  depends RTE_CB_MA1 && RTE_CB_MULTI
+	  depends on RTE_CB_MA1 && RTE_CB_MULTI
 	  default n
 
    config RTE_MB_A_PCI
    	  bool "Mother-A PCI support"
-	  depends RTE_CB
+	  depends on RTE_CB
 	  default y
 
    # The GBUS is used to talk to the RTE-MOTHER-A board
    config RTE_GBUS_INT
    	  bool
-	  depends RTE_MB_A_PCI
+	  depends on RTE_MB_A_PCI
 	  default y
 
    # The only PCI bus we support is on the RTE-MOTHER-A board
@@ -209,7 +209,7 @@ menu "Processor type and features"
 
    config ROM_KERNEL
    	  bool "Kernel in ROM"
-	  depends V850E2_ANNA || V850E_AS85EP1 || RTE_CB_ME2
+	  depends on V850E2_ANNA || V850E_AS85EP1 || RTE_CB_ME2
 
    # Some platforms pre-zero memory, in which case the kernel doesn't need to
    config ZERO_BSS
@@ -225,10 +225,10 @@ menu "Processor type and features"
 
    config V850E_HIGHRES_TIMER
    	  bool "High resolution timer support"
-	  depends V850E_TIMER_D
+	  depends on V850E_TIMER_D
    config TIME_BOOTUP
    	  bool "Time bootup"
-	  depends V850E_HIGHRES_TIMER
+	  depends on V850E_HIGHRES_TIMER
 
    config RESET_GUARD
    	  bool "Reset Guard"
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index b10f4d8..0a3aee2 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -867,7 +867,7 @@ config SONYPI
 
 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
-	depends TANBAC_TB022X
+	depends on TANBAC_TB022X
 	select GPIO_VR41XX
 
 source "drivers/char/agp/Kconfig"
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index e23bc0d..3f82805 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -796,7 +796,7 @@ endchoice
 config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        int "Maximum transfer size (KB) per request (up to 128)"
        default "128"
-       depends BLK_DEV_IDE_AU1XXX
+       depends on BLK_DEV_IDE_AU1XXX
 
 config IDE_ARM
 	def_bool ARM && (ARCH_A5K || ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 176142c..7399ba7 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -12,7 +12,7 @@ config NEW_LEDS
 
 config LEDS_CLASS
 	tristate "LED Class Support"
-	depends NEW_LEDS
+	depends on NEW_LEDS
 	help
 	  This option enables the led sysfs class in /sys/class/leds.  You'll
 	  need this to do anything useful with LEDs.  If unsure, say N.
@@ -21,28 +21,28 @@ comment "LED drivers"
 
 config LEDS_CORGI
 	tristate "LED Support for the Sharp SL-C7x0 series"
-	depends LEDS_CLASS && PXA_SHARP_C7xx
+	depends on LEDS_CLASS && PXA_SHARP_C7xx
 	help
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-C7x0 series (C700, C750, C760, C860).
 
 config LEDS_LOCOMO
 	tristate "LED Support for Locomo device"
-	depends LEDS_CLASS && SHARP_LOCOMO
+	depends on LEDS_CLASS && SHARP_LOCOMO
 	help
 	  This option enables support for the LEDs on Sharp Locomo.
 	  Zaurus models SL-5500 and SL-5600.
 
 config LEDS_SPITZ
 	tristate "LED Support for the Sharp SL-Cxx00 series"
-	depends LEDS_CLASS && PXA_SHARP_Cxx00
+	depends on LEDS_CLASS && PXA_SHARP_Cxx00
 	help
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-Cxx00 series (C1000, C3000, C3100).
 
 config LEDS_IXP4XX
 	tristate "LED Support for GPIO connected LEDs on IXP4XX processors"
-	depends LEDS_CLASS && ARCH_IXP4XX
+	depends on LEDS_CLASS && ARCH_IXP4XX
 	help
 	  This option enables support for the LEDs connected to GPIO
 	  outputs of the Intel IXP4XX processors.  To be useful the
@@ -51,7 +51,7 @@ config LEDS_IXP4XX
 
 config LEDS_TOSA
 	tristate "LED Support for the Sharp SL-6000 series"
-	depends LEDS_CLASS && PXA_SHARPSL
+	depends on LEDS_CLASS && PXA_SHARPSL
 	help
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-6000 series.
@@ -65,7 +65,7 @@ config LEDS_S3C24XX
 
 config LEDS_AMS_DELTA
 	tristate "LED Support for the Amstrad Delta (E3)"
-	depends LEDS_CLASS && MACH_AMS_DELTA
+	depends on LEDS_CLASS && MACH_AMS_DELTA
 	help
 	  This option enables support for the LEDs on Amstrad Delta (E3).
 
@@ -86,7 +86,7 @@ comment "LED Triggers"
 
 config LEDS_TRIGGERS
 	bool "LED Trigger support"
-	depends NEW_LEDS
+	depends on NEW_LEDS
 	help
 	  This option enables trigger support for the leds class.
 	  These triggers allow kernel events to drive the LEDs and can
@@ -94,21 +94,21 @@ config LEDS_TRIGGERS
 
 config LEDS_TRIGGER_TIMER
 	tristate "LED Timer Trigger"
-	depends LEDS_TRIGGERS
+	depends on LEDS_TRIGGERS
 	help
 	  This allows LEDs to be controlled by a programmable timer
 	  via sysfs. If unsure, say Y.
 
 config LEDS_TRIGGER_IDE_DISK
 	bool "LED IDE Disk Trigger"
-	depends LEDS_TRIGGERS && BLK_DEV_IDEDISK
+	depends on LEDS_TRIGGERS && BLK_DEV_IDEDISK
 	help
 	  This allows LEDs to be controlled by IDE disk activity.
 	  If unsure, say Y.
 
 config LEDS_TRIGGER_HEARTBEAT
 	tristate "LED Heartbeat Trigger"
-	depends LEDS_TRIGGERS
+	depends on LEDS_TRIGGERS
 	help
 	  This allows LEDs to be controlled by a CPU load average.
 	  The flash frequency is a hyperbolic function of the 1-minute
diff --git a/drivers/media/video/ov7670.c b/drivers/media/video/ov7670.c
index 89dd18c..5ed0adc 100644
--- a/drivers/media/video/ov7670.c
+++ b/drivers/media/video/ov7670.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 
 
-MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net.");
+MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net>");
 MODULE_DESCRIPTION("A low-level driver for OmniVision ov7670 sensors");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 03bf164..c2ae2a2 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -1930,9 +1930,8 @@ static int e100_rx_alloc_list(struct nic *nic)
 	nic->rx_to_use = nic->rx_to_clean = NULL;
 	nic->ru_running = RU_UNINITIALIZED;
 
-	if(!(nic->rxs = kmalloc(sizeof(struct rx) * count, GFP_ATOMIC)))
+	if(!(nic->rxs = kcalloc(count, sizeof(struct rx), GFP_ATOMIC)))
 		return -ENOMEM;
-	memset(nic->rxs, 0, sizeof(struct rx) * count);
 
 	for(rx = nic->rxs, i = 0; i < count; rx++, i++) {
 		rx->next = (i + 1 < count) ? rx + 1 : nic->rxs;
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 0b36dd5..2978c09 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -663,7 +663,7 @@ config V850E_UART
 
 config V850E_UARTB
         bool
-	depends V850E_UART && V850E_ME2
+	depends on V850E_UART && V850E_ME2
 	default y
 
 config V850E_UART_CONSOLE
@@ -909,7 +909,7 @@ config SERIAL_M32R_PLDSIO
 
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends HAS_TXX9_SERIAL
+	depends on HAS_TXX9_SERIAL
 	select SERIAL_CORE
 	default y
 
diff --git a/drivers/serial/icom.c b/drivers/serial/icom.c
index 7d62300..71e6a24 100644
--- a/drivers/serial/icom.c
+++ b/drivers/serial/icom.c
@@ -1510,7 +1510,7 @@ static int __devinit icom_probe(struct pci_dev *dev,
 	}
 
 	if ( (retval = pci_request_regions(dev, "icom"))) {
-		 dev_err(&dev->dev, "pci_request_region FAILED\n");
+		 dev_err(&dev->dev, "pci_request_regions FAILED\n");
 		 pci_disable_device(dev);
 		 return retval;
 	 }
diff --git a/fs/Kconfig b/fs/Kconfig
index b3b5aa0..276ff3b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -12,9 +12,7 @@ config EXT2_FS
 	  Ext2 is a standard Linux file system for hard disks.
 
 	  To compile this file system support as a module, choose M here: the
-	  module will be called ext2.  Be aware however that the file system
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this could be dangerous.
+	  module will be called ext2.
 
 	  If unsure, say Y.
 
@@ -98,9 +96,7 @@ config EXT3_FS
 	  (available at <http://sourceforge.net/projects/e2fsprogs/>).
 
 	  To compile this file system support as a module, choose M here: the
-	  module will be called ext3.  Be aware however that the file system
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this may be dangerous.
+	  module will be called ext3.
 
 config EXT3_FS_XATTR
 	bool "Ext3 extended attributes"
@@ -163,9 +159,7 @@ config EXT4DEV_FS
 	  features will be added to ext4dev gradually.
 
 	  To compile this file system support as a module, choose M here. The
-	  module will be called ext4dev.  Be aware, however, that the filesystem
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this could be dangerous.
+	  module will be called ext4dev.
 
 	  If unsure, say N.
 
@@ -1008,7 +1002,7 @@ config TMPFS_POSIX_ACL
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
+	depends on X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 76f06f6..6e6d456 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -706,12 +706,11 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 		return -ELIBBAD;
 
 	size = sizeof(*loadmap) + nloads * sizeof(*seg);
-	loadmap = kmalloc(size, GFP_KERNEL);
+	loadmap = kzalloc(size, GFP_KERNEL);
 	if (!loadmap)
 		return -ENOMEM;
 
 	params->loadmap = loadmap;
-	memset(loadmap, 0, size);
 
 	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
 	loadmap->nsegs = nloads;
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 538423d..aca6698 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -40,7 +40,7 @@ extern void __chk_io_ptr(void __iomem *);
 #error no compiler-gcc.h file for this gcc version
 #elif __GNUC__ == 4
 # include <linux/compiler-gcc4.h>
-#elif __GNUC__ == 3
+#elif __GNUC__ == 3 && __GNUC_MINOR__ >= 2
 # include <linux/compiler-gcc3.h>
 #else
 # error Sorry, your compiler is too old/not recognized.
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index a7f0150..fef6f3d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -160,31 +160,6 @@ struct configfs_group_operations {
 	void (*drop_item)(struct config_group *group, struct config_item *item);
 };
 
-
-
-/**
- * Use these macros to make defining attributes easier. See include/linux/device.h
- * for examples..
- */
-
-#if 0
-#define __ATTR(_name,_mode,_show,_store) { \
-	.attr = {.ca_name = __stringify(_name), .ca_mode = _mode, .ca_owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-}
-
-#define __ATTR_RO(_name) { \
-	.attr	= { .ca_name = __stringify(_name), .ca_mode = 0444, .ca_owner = THIS_MODULE },	\
-	.show	= _name##_show,	\
-}
-
-#define __ATTR_NULL { .attr = { .name = NULL } }
-
-#define attr_name(_attr) (_attr).attr.name
-#endif
-
-
 struct configfs_subsystem {
 	struct config_group	su_group;
 	struct semaphore	su_sem;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6d8846e..81480e6 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -11,7 +11,7 @@
  **  the sysctl() binary interface.  Do *NOT* change the
  **  numbering of any existing values here, and do not change
  **  any numbers within any one set of values.  If you have to
- **  have to redefine an existing interface, use a new number for it.
+ **  redefine an existing interface, use a new number for it.
  **  The kernel will then return -ENOTDIR to any application using
  **  the old binary interface.
  **
diff --git a/init/Kconfig b/init/Kconfig
index 9edf103..f000edb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -348,7 +348,7 @@ config SYSCTL_SYSCALL
 	  If unsure say Y here.
 
 config KALLSYMS
-	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
+	 bool "Load all symbols for debugging/ksymoops" if EMBEDDED
 	 default y
 	 help
 	   Say Y here to let the kernel print out symbolic crash information and
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0701ddd..818e458 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -437,7 +437,7 @@ config FAIL_PAGE_ALLOC
 	  Provide fault-injection capability for alloc_pages().
 
 config FAIL_MAKE_REQUEST
-	bool "Fault-injection capabilitiy for disk IO"
+	bool "Fault-injection capability for disk IO"
 	depends on FAULT_INJECTION
 	help
 	  Provide fault-injection capability for disk IO.
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 74046ef..8ce00d3 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -565,7 +565,7 @@ static void ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 		} else {
 			struct sk_buff *free_it = next;
 
-			/* Old fragmnet is completely overridden with
+			/* Old fragment is completely overridden with
 			 * new one drop it.
 			 */
 			next = next->next;
diff --git a/sound/aoa/fabrics/Kconfig b/sound/aoa/fabrics/Kconfig
index c3bc770..50d7021 100644
--- a/sound/aoa/fabrics/Kconfig
+++ b/sound/aoa/fabrics/Kconfig
@@ -1,6 +1,6 @@
 config SND_AOA_FABRIC_LAYOUT
 	tristate "layout-id fabric"
-	depends SND_AOA
+	depends on SND_AOA
 	select SND_AOA_SOUNDBUS
 	select SND_AOA_SOUNDBUS_I2S
 	---help---
