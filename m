Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVAHHHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVAHHHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVAHHGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:06:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:12166 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261919AbVAHFsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:45 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632591441@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <11051632593220@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.4, 2004/12/15 11:15:21-08:00, bunk@stusta.de

[PATCH] select HOTPLUG

The patch below changes all dependencies on HOTPLUG to selects.

The help text of HOTPLUG is adjusted in a way, that manually selecting
it is only required for external modules.

If an option already depends on PCMCIA or selects FW_LOADER an explicit
select of HOTPLUG is not required.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


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
 11 files changed, 21 insertions(+), 29 deletions(-)


diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/arch/ia64/Kconfig	2005-01-07 15:51:45 -08:00
@@ -241,13 +241,14 @@
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
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/arch/ppc64/Kconfig	2005-01-07 15:51:45 -08:00
@@ -301,7 +301,8 @@
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PSERIES
+	depends on SMP && EXPERIMENTAL && PPC_PSERIES
+	select HOTPLUG
 	---help---
 	  Say Y here to be able to turn CPUs off and on.
 
diff -Nru a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/arch/s390/Kconfig	2005-01-07 15:51:45 -08:00
@@ -81,7 +81,8 @@
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on SMP && EXPERIMENTAL
+	select HOTPLUG
 	default n
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
diff -Nru a/drivers/base/Kconfig b/drivers/base/Kconfig
--- a/drivers/base/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/base/Kconfig	2005-01-07 15:51:45 -08:00
@@ -20,7 +20,7 @@
 
 config FW_LOADER
 	tristate "Hotplug firmware loading support"
-	depends on HOTPLUG
+	select HOTPLUG
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
 	  require hotplug firmware loading support, but a module built outside
diff -Nru a/drivers/net/pcmcia/Kconfig b/drivers/net/pcmcia/Kconfig
--- a/drivers/net/pcmcia/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/net/pcmcia/Kconfig	2005-01-07 15:51:45 -08:00
@@ -3,7 +3,7 @@
 #
 
 menu "PCMCIA network device support"
-	depends on NETDEVICES && HOTPLUG && PCMCIA!=n
+	depends on NETDEVICES && PCMCIA!=n
 
 config NET_PCMCIA
 	bool "PCMCIA network device support"
diff -Nru a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/net/tokenring/Kconfig	2005-01-07 15:51:45 -08:00
@@ -84,7 +84,7 @@
 
 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR && (PCI || ISA) && HOTPLUG
+	depends on TR && (PCI || ISA)
 	select FW_LOADER
 	---help---
 	  This driver provides generic support for token ring adapters
diff -Nru a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/net/wireless/Kconfig	2005-01-07 15:51:45 -08:00
@@ -311,7 +311,7 @@
 	depends on NET_RADIO && PCI
 config PRISM54
 	tristate 'Intersil Prism GT/Duette/Indigo PCI/Cardbus' 
-	depends on PCI && NET_RADIO && EXPERIMENTAL && HOTPLUG
+	depends on PCI && NET_RADIO && EXPERIMENTAL
 	select FW_LOADER
 	---help---
 	  Enable PCI and Cardbus support for the following chipset based cards:
diff -Nru a/drivers/parport/Kconfig b/drivers/parport/Kconfig
--- a/drivers/parport/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/parport/Kconfig	2005-01-07 15:51:45 -08:00
@@ -83,7 +83,7 @@
 
 config PARPORT_PC_PCMCIA
 	tristate "Support for PCMCIA management for PC-style ports"
-	depends on PARPORT!=n && HOTPLUG && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
+	depends on PARPORT!=n && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
 	help
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.
diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/pci/hotplug/Kconfig	2005-01-07 15:51:45 -08:00
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
diff -Nru a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/drivers/pcmcia/Kconfig	2005-01-07 15:51:45 -08:00
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
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2005-01-07 15:51:45 -08:00
+++ b/init/Kconfig	2005-01-07 15:51:45 -08:00
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

