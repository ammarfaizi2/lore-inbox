Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbULBCnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbULBCnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 21:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULBCnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 21:43:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25350 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261573AbULBCmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 21:42:55 -0500
Date: Thu, 2 Dec 2004 03:42:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] select HOTPLUG
Message-ID: <20041202024254.GL5148@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below changes all dependencies on HOTPLUG to selects.

The help text of HOTPLUG is adjusted in a way, that manually selecting 
it is only required for external modules.

If an option already depends on PCMCIA or selects FW_LOADER an explicit 
select of HOTPLUG is not required.


diffstat output:
 arch/i386/Kconfig             |    3 ++-
 arch/ia64/Kconfig             |   13 +++++++------
 arch/ppc64/Kconfig            |    3 ++-
 arch/s390/Kconfig             |    3 ++-
 drivers/base/Kconfig          |    2 +-
 drivers/net/pcmcia/Kconfig    |    2 +-
 drivers/net/tokenring/Kconfig |    2 +-
 drivers/net/wireless/Kconfig  |    2 +-
 drivers/parport/Kconfig       |    2 +-
 drivers/pci/hotplug/Kconfig   |    2 +-
 drivers/pcmcia/Kconfig        |    2 +-
 init/Kconfig                  |   17 +++--------------
 12 files changed, 23 insertions(+), 30 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/init/Kconfig.old	2004-12-02 03:30:27.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/init/Kconfig	2004-12-02 03:36:04.000000000 +0100
@@ -195,20 +195,9 @@
 	bool "Support for hot-pluggable devices" if !ARCH_S390
 	default ARCH_S390
 	help
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+	  This option is provided for the case where no in-kernel-tree
+	  modules require HOTPLUG functionality, but a module built
+	  outside the kernel tree does. Such modules require Y here.
 
 config KOBJECT_UEVENT
 	bool "Kernel Userspace Events"
--- linux-2.6.10-rc2-mm4-full/drivers/base/Kconfig.old	2004-12-02 03:20:45.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/base/Kconfig	2004-12-02 03:20:59.000000000 +0100
@@ -20,7 +20,7 @@
 
 config FW_LOADER
 	tristate "Hotplug firmware loading support"
-	depends on HOTPLUG
+	select HOTPLUG
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
 	  require hotplug firmware loading support, but a module built outside
--- linux-2.6.10-rc2-mm4-full/drivers/net/wireless/Kconfig.old	2004-12-02 03:21:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/wireless/Kconfig	2004-12-02 03:21:37.000000000 +0100
@@ -311,7 +311,7 @@
 	depends on NET_RADIO && PCI
 config PRISM54
 	tristate 'Intersil Prism GT/Duette/Indigo PCI/Cardbus' 
-	depends on PCI && NET_RADIO && EXPERIMENTAL && HOTPLUG
+	depends on PCI && NET_RADIO && EXPERIMENTAL
 	select FW_LOADER
 	---help---
 	  Enable PCI and Cardbus support for the following chipset based cards:
--- linux-2.6.10-rc2-mm4-full/drivers/net/pcmcia/Kconfig.old	2004-12-02 03:21:47.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/pcmcia/Kconfig	2004-12-02 03:38:54.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 menu "PCMCIA network device support"
-	depends on NETDEVICES && HOTPLUG && PCMCIA!=n
+	depends on NETDEVICES && PCMCIA!=n
 
 config NET_PCMCIA
 	bool "PCMCIA network device support"
--- linux-2.6.10-rc2-mm4-full/drivers/net/tokenring/Kconfig.old	2004-12-02 03:22:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/tokenring/Kconfig	2004-12-02 03:22:29.000000000 +0100
@@ -84,7 +84,7 @@
 
 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR && (PCI || ISA) && HOTPLUG
+	depends on TR && (PCI || ISA)
 	select FW_LOADER
 	---help---
 	  This driver provides generic support for token ring adapters
--- linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/Kconfig.old	2004-12-02 03:22:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/Kconfig	2004-12-02 03:23:19.000000000 +0100
@@ -3,11 +3,11 @@
 #
 
 menu "PCI Hotplug Support"
-	depends on HOTPLUG
 
 config HOTPLUG_PCI
 	tristate "Support for PCI Hotplug (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
+	select HOTPLUG
 	---help---
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
--- linux-2.6.10-rc2-mm4-full/drivers/parport/Kconfig.old	2004-12-02 03:26:56.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/Kconfig	2004-12-02 03:27:11.000000000 +0100
@@ -83,7 +83,7 @@
 
 config PARPORT_PC_PCMCIA
 	tristate "Support for PCMCIA management for PC-style ports"
-	depends on PARPORT!=n && HOTPLUG && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
+	depends on PARPORT!=n && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
 	help
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.
--- linux-2.6.10-rc2-mm4-full/drivers/pcmcia/Kconfig.old	2004-12-02 03:27:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pcmcia/Kconfig	2004-12-02 03:28:08.000000000 +0100
@@ -6,10 +6,10 @@
 #
 
 menu "PCCARD (PCMCIA/CardBus) support"
-	depends on HOTPLUG
 
 config PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
+	select HOTPLUG
 	---help---
 	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
 	  computer.  These are credit-card size devices such as network cards,
--- linux-2.6.10-rc2-mm4-full/arch/i386/Kconfig.old	2004-12-02 03:28:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/Kconfig	2004-12-02 03:28:29.000000000 +0100
@@ -1240,7 +1240,8 @@
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on SMP && EXPERIMENTAL
+	select HOTPLUG
 	---help---
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
--- linux-2.6.10-rc2-mm4-full/arch/ia64/Kconfig.old	2004-12-02 03:28:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/ia64/Kconfig	2004-12-02 03:29:14.000000000 +0100
@@ -249,13 +249,14 @@
 	  performance hit.
 
 config HOTPLUG_CPU
-    bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-    depends on SMP && HOTPLUG && EXPERIMENTAL
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && EXPERIMENTAL
+	select HOTPLUG
 	default n
-    ---help---
-      Say Y here to experiment with turning CPUs off and on.  CPUs
-      can be controlled through /sys/devices/system/cpu/cpu#.
-      Say N if you want to disable CPU hotplug.
+	---help---
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu/cpu#.
+	  Say N if you want to disable CPU hotplug.
 
 config PREEMPT
 	bool "Preemptible Kernel"
--- linux-2.6.10-rc2-mm4-full/arch/ppc64/Kconfig.old	2004-12-02 03:29:24.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/ppc64/Kconfig	2004-12-02 03:29:36.000000000 +0100
@@ -305,7 +305,8 @@
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PSERIES
+	depends on SMP && EXPERIMENTAL && PPC_PSERIES
+	select HOTPLUG
 	---help---
 	  Say Y here to be able to turn CPUs off and on.
 
--- linux-2.6.10-rc2-mm4-full/arch/s390/Kconfig.old	2004-12-02 03:30:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/s390/Kconfig	2004-12-02 03:30:16.000000000 +0100
@@ -85,7 +85,8 @@
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on SMP && EXPERIMENTAL
+	select HOTPLUG
 	default n
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs

