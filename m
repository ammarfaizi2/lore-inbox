Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSLaHRj>; Tue, 31 Dec 2002 02:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSLaHRj>; Tue, 31 Dec 2002 02:17:39 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:28092 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267200AbSLaHRh>; Tue, 31 Dec 2002 02:17:37 -0500
Date: Tue, 31 Dec 2002 08:25:44 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my observations about 2.4.21-pre2
Message-ID: <20021231072544.GO21097@louise.pinerecords.com>
References: <Pine.LNX.4.44.0212301304150.25855-100000@dell> <1041279053.13684.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041279053.13684.41.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Robert P. J. Day wrote:
>
> > Why can't I deactivate all gigabit ethernet settings in one click,
> >   like I can with 10/100 Mbit settings?  as the choices for 
> >   gigabit ethernet grow, that list is going to get inconveniently
> >   long.  a single top option to deselect all of them would be nice.
> 
> [alan@lxorguk.ukuu.org.uk]
> Follow the example for 10/100 and fix it then send a patch

diff -urN linux-2.4.21-pre2/drivers/net/Config.in linux-2.4.21-pre2.x/drivers/net/Config.in
--- linux-2.4.21-pre2/drivers/net/Config.in	2002-12-31 08:16:11.000000000 +0100
+++ linux-2.4.21-pre2.x/drivers/net/Config.in	2002-12-31 08:13:24.000000000 +0100
@@ -237,21 +237,22 @@
 
 mainmenu_option next_comment
 comment 'Ethernet (1000 Mbit)'
-
-dep_tristate 'Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support' CONFIG_ACENIC $CONFIG_PCI
-if [ "$CONFIG_ACENIC" != "n" ]; then
-   bool '  Omit support for old Tigon I based AceNICs' CONFIG_ACENIC_OMIT_TIGON_I
-fi
-dep_tristate 'D-Link DL2000-based Gigabit Ethernet support' CONFIG_DL2K $CONFIG_PCI
-dep_tristate 'Intel(R) PRO/1000 Gigabit Ethernet support' CONFIG_E1000 $CONFIG_PCI
-dep_tristate 'MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS $CONFIG_SBUS
-dep_tristate 'National Semiconductor DP83820 support' CONFIG_NS83820 $CONFIG_PCI
-dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONFIG_PCI
-dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)' CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
-dep_tristate 'Realtek 8169 Gigabit Ethernet support' CONFIG_R8169 $CONFIG_PCI
-dep_tristate 'SysKonnect SK-98xx support' CONFIG_SK98LIN $CONFIG_PCI
-dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI
-
+bool 'Ethernet (1000 Mbit)' CONFIG_NET_GIGABIT_ETH
+if [ "$CONFIG_NET_GIGABIT_ETH" = "y" ]; then
+   dep_tristate 'Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support' CONFIG_ACENIC $CONFIG_PCI
+   if [ "$CONFIG_ACENIC" != "n" ]; then
+      bool '  Omit support for old Tigon I based AceNICs' CONFIG_ACENIC_OMIT_TIGON_I
+   fi
+   dep_tristate 'D-Link DL2000-based Gigabit Ethernet support' CONFIG_DL2K $CONFIG_PCI
+   dep_tristate 'Intel(R) PRO/1000 Gigabit Ethernet support' CONFIG_E1000 $CONFIG_PCI
+   dep_tristate 'MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS $CONFIG_SBUS
+   dep_tristate 'National Semiconductor DP83820 support' CONFIG_NS83820 $CONFIG_PCI
+   dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONFIG_PCI
+   dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)' CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
+   dep_tristate 'Realtek 8169 Gigabit Ethernet support' CONFIG_R8169 $CONFIG_PCI
+   dep_tristate 'SysKonnect SK-98xx support' CONFIG_SK98LIN $CONFIG_PCI
+   dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI
+fi
 endmenu
 
 if [ "$CONFIG_PPC_ISERIES" = "y" ]; then
