Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbTHAKoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270717AbTHAKoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:44:23 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:54289 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270712AbTHAKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] Cleanup Ethernet 1000mbit menu
Date: Fri, 1 Aug 2003 12:39:37 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Message-Id: <200307312214.52219.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pNkK/5SIwnDS3/U"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_pNkK/5SIwnDS3/U
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

I've been getting complaints about the menu structure from the linux kernel 
config subsystem for a _long time_. As a start, let's clean up the Ethernet 
1000mbit menu first. It's now possible to select/deselect 1000mbit NICs at 
once.

More cleanups for different menu's are following.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_pNkK/5SIwnDS3/U
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-net-gbit-config-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-net-gbit-config-cleanup.patch"

--- a/drivers/net/Config.in	2003-07-31 01:45:46.000000000 +0200
+++ b/drivers/net/Config.in	2003-07-31 22:09:03.000000000 +0200
@@ -250,23 +250,26 @@ endmenu
 
 mainmenu_option next_comment
 comment 'Ethernet (1000 Mbit)'
+bool 'Ethernet (1000 Mbit)' CONFIG_NET_GIGABIT_ETH
+if [ "$CONFIG_NET_GIGABIT_ETH" = "y" ]; then
 
-dep_tristate 'Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support' CONFIG_ACENIC $CONFIG_PCI
-if [ "$CONFIG_ACENIC" != "n" ]; then
-   bool '  Omit support for old Tigon I based AceNICs' CONFIG_ACENIC_OMIT_TIGON_I
-fi
-dep_tristate 'D-Link DL2000-based Gigabit Ethernet support' CONFIG_DL2K $CONFIG_PCI
-dep_tristate 'Intel(R) PRO/1000 Gigabit Ethernet support' CONFIG_E1000 $CONFIG_PCI
-if [ "$CONFIG_E1000" != "n" ]; then
-   bool '  Use Rx Polling (NAPI)' CONFIG_E1000_NAPI
-fi
-dep_tristate 'MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS $CONFIG_SBUS
-dep_tristate 'National Semiconductor DP83820 support' CONFIG_NS83820 $CONFIG_PCI
-dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONFIG_PCI
-dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)' CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
-dep_tristate 'Realtek 8169 Gigabit Ethernet support' CONFIG_R8169 $CONFIG_PCI
-dep_tristate 'SysKonnect SK-98xx and SK-95xx Gigabit Ethernet Adapter family support' CONFIG_SK98LIN $CONFIG_PCI
-dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI
+   dep_tristate 'Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support' CONFIG_ACENIC $CONFIG_PCI
+   if [ "$CONFIG_ACENIC" != "n" ]; then
+      bool '  Omit support for old Tigon I based AceNICs' CONFIG_ACENIC_OMIT_TIGON_I
+   fi
+   dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI
+   dep_tristate 'D-Link DL2000-based Gigabit Ethernet support' CONFIG_DL2K $CONFIG_PCI
+   dep_tristate 'Intel(R) PRO/1000 Gigabit Ethernet support' CONFIG_E1000 $CONFIG_PCI
+   if [ "$CONFIG_E1000" != "n" ]; then
+      bool '  Use Rx Polling (NAPI)' CONFIG_E1000_NAPI
+   fi
+   dep_tristate 'MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS $CONFIG_SBUS
+   dep_tristate 'National Semiconductor DP83820 support' CONFIG_NS83820 $CONFIG_PCI
+   dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONFIG_PCI
+   dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)' CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
+   dep_tristate 'Realtek 8169 Gigabit Ethernet support' CONFIG_R8169 $CONFIG_PCI
+   dep_tristate 'SysKonnect SK-98xx and SK-95xx Gigabit Ethernet Adapter family support' CONFIG_SK98LIN $CONFIG_PCI
+fi
 
 endmenu
 

--Boundary-00=_pNkK/5SIwnDS3/U--


