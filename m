Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319120AbSHMSdV>; Tue, 13 Aug 2002 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319121AbSHMSdV>; Tue, 13 Aug 2002 14:33:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319120AbSHMSdO>;
	Tue, 13 Aug 2002 14:33:14 -0400
Date: Tue, 13 Aug 2002 11:32:39 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <akpm@zip.com.au>, <davem@redhat.com>, <davej@suse.de>,
       <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Network Options and Network Devices together
Message-ID: <Pine.LNX.4.33L2.0208131128070.5175-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[oh, who to send this to?]

This patch to 2.5.31 pushes "Networking options" and
"Network device support" together for all architectures
that have them.

They shouldn't be split apart by Telephony, I2O,
Fusion, etc.

Please apply to the next 2.5.3x kernel if it's OK
with DaveM, DaveJ, Andrew, Jeff, et al.

Thanks,
~Randy

PS:  It doesn't qualify as trivial by Rusty's latest definitions.

-- 


--- linux-2.5.31/arch/alpha/config.in.net	Sat Aug 10 18:41:23 2002
+++ linux-2.5.31/arch/alpha/config.in	Tue Aug 13 09:46:46 2002
@@ -283,10 +283,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-  source net/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'ATA/ATAPI/MFM/RLL support'

@@ -314,6 +310,8 @@
 fi

 if [ "$CONFIG_NET" = "y" ]; then
+  source net/Config.in
+
   mainmenu_option next_comment
   comment 'Network device support'

--- linux-2.5.31/arch/ppc/config.in.net	Sat Aug 10 18:41:16 2002
+++ linux-2.5.31/arch/ppc/config.in	Tue Aug 13 10:44:18 2002
@@ -419,10 +419,6 @@
 source drivers/block/Config.in
 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'

@@ -449,6 +445,8 @@
 source drivers/message/i2o/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

--- linux-2.5.31/arch/i386/config.in.net	Sat Aug 10 18:41:25 2002
+++ linux-2.5.31/arch/i386/config.in	Tue Aug 13 10:01:37 2002
@@ -332,12 +332,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
-source drivers/telephony/Config.in
-
 source drivers/message/fusion/Config.in

 source drivers/ieee1394/Config.in
@@ -345,6 +339,8 @@
 source drivers/message/i2o/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

@@ -363,6 +359,8 @@
 source net/irda/Config.in

 source drivers/isdn/Config.in
+
+source drivers/telephony/Config.in

 #
 # input before char - char/joystick depends on it. As does USB.
--- linux-2.5.31/arch/sparc/config.in.net	Sat Aug 10 18:41:19 2002
+++ linux-2.5.31/arch/sparc/config.in	Tue Aug 13 10:46:59 2002
@@ -87,10 +87,6 @@

 endmenu

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
 # Don't frighten a common SBus user
 if [ "$CONFIG_PCI" = "y" ]; then

@@ -158,6 +154,8 @@
 source drivers/fc4/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

--- linux-2.5.31/arch/sparc64/config.in.net	Sat Aug 10 18:41:25 2002
+++ linux-2.5.31/arch/sparc64/config.in	Tue Aug 13 10:45:57 2002
@@ -95,10 +95,6 @@

 endmenu

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'ATA/ATAPI/MFM/RLL device support'

@@ -207,6 +203,8 @@
 source drivers/ieee1394/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

--- linux-2.5.31/arch/m68k/config.in.net	Sat Aug 10 18:41:46 2002
+++ linux-2.5.31/arch/m68k/config.in	Tue Aug 13 10:33:49 2002
@@ -152,10 +152,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
 if [ "$CONFIG_MAC" = "y" ]; then
    source drivers/input/Config.in
 fi
@@ -271,6 +267,7 @@
 endmenu

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in

    mainmenu_option next_comment
    comment 'Network device support'
--- linux-2.5.31/arch/cris/config.in.net	Sat Aug 10 18:41:36 2002
+++ linux-2.5.31/arch/cris/config.in	Tue Aug 13 10:01:05 2002
@@ -135,12 +135,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-  source net/Config.in
-fi
-
-source drivers/telephony/Config.in
-
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'

@@ -168,6 +162,8 @@
 source drivers/message/i2o/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+  source net/Config.in
+
   mainmenu_option next_comment
   comment 'Network device support'

@@ -186,6 +182,8 @@
 source net/irda/Config.in

 source drivers/isdn/Config.in
+
+source drivers/telephony/Config.in

 mainmenu_option next_comment
 comment 'Old CD-ROM drivers (not SCSI, not IDE)'
--- linux-2.5.31/arch/mips/config.in.net	Sat Aug 10 18:41:42 2002
+++ linux-2.5.31/arch/mips/config.in	Tue Aug 13 10:39:25 2002
@@ -334,12 +334,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
-source drivers/telephony/Config.in
-
 if [ "$CONFIG_SGI_IP22" != "y" -a \
      "$CONFIG_DECSTATION" != "y" ]; then

@@ -372,6 +366,8 @@
 fi

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

@@ -390,6 +386,8 @@
 source net/irda/Config.in

 source drivers/isdn/Config.in
+
+source drivers/telephony/Config.in

 mainmenu_option next_comment
 comment 'Old CD-ROM drivers (not SCSI, not IDE)'
--- linux-2.5.31/arch/ia64/config.in.net	Sat Aug 10 18:42:09 2002
+++ linux-2.5.31/arch/ia64/config.in	Tue Aug 13 10:25:11 2002
@@ -118,10 +118,6 @@

 endmenu

-if [ "$CONFIG_NET" = "y" ]; then
-  source net/Config.in
-fi
-
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then

 source drivers/mtd/Config.in
@@ -166,6 +162,10 @@
   source drivers/scsi/Config.in
 fi
 endmenu
+
+if [ "$CONFIG_NET" = "y" ]; then
+  source net/Config.in
+fi

 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then

--- linux-2.5.31/arch/ppc64/config.in.net	Sat Aug 10 18:41:21 2002
+++ linux-2.5.31/arch/ppc64/config.in	Tue Aug 13 10:43:48 2002
@@ -87,10 +87,6 @@
 source drivers/block/Config.in
 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'ATA/ATAPI/MFM/RLL support'

@@ -118,6 +114,8 @@
 source drivers/message/i2o/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

--- linux-2.5.31/arch/x86_64/config.in.net	Sat Aug 10 18:41:24 2002
+++ linux-2.5.31/arch/x86_64/config.in	Tue Aug 13 10:47:31 2002
@@ -119,12 +119,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
-source drivers/telephony/Config.in
-
 mainmenu_option next_comment
 comment 'ATA/ATAPI/MFM/RLL support'

@@ -155,6 +149,8 @@
 #source drivers/message/i2o/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

@@ -174,6 +170,8 @@
 source net/irda/Config.in

 source drivers/isdn/Config.in
+
+source drivers/telephony/Config.in

 # no support for non IDE/SCSI cdroms as they were all ISA only

--- linux-2.5.31/arch/mips64/config.in.net	Sat Aug 10 18:41:21 2002
+++ linux-2.5.31/arch/mips64/config.in	Tue Aug 13 10:34:46 2002
@@ -132,12 +132,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
-source drivers/telephony/Config.in
-
 mainmenu_option next_comment
 comment 'ATA/ATAPI/MFM/RLL support'

@@ -163,6 +157,8 @@
 #source drivers/message/i2o/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

@@ -181,6 +177,8 @@
 source net/irda/Config.in

 source drivers/isdn/Config.in
+
+source drivers/telephony/Config.in

 mainmenu_option next_comment
 comment 'Old CD-ROM drivers (not SCSI, not IDE)'
--- linux-2.5.31/arch/sh/config.in.net	Sat Aug 10 18:41:30 2002
+++ linux-2.5.31/arch/sh/config.in	Tue Aug 13 10:45:16 2002
@@ -207,10 +207,6 @@

 source drivers/md/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'ATA/ATAPI/MFM/RLL support'

@@ -236,6 +232,8 @@
 source drivers/ieee1394/Config.in

 if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+
    mainmenu_option next_comment
    comment 'Network device support'

--- linux-2.5.31/arch/parisc/config.in.net	Sat Aug 10 18:42:09 2002
+++ linux-2.5.31/arch/parisc/config.in	Tue Aug 13 10:39:46 2002
@@ -99,10 +99,6 @@

 source drivers/block/Config.in

-if [ "$CONFIG_NET" = "y" ]; then
-  source net/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'SCSI support'

@@ -149,6 +145,8 @@
 endmenu

 if [ "$CONFIG_NET" = "y" ]; then
+  source net/Config.in
+
   mainmenu_option next_comment
   comment 'Network device support'

-- 

