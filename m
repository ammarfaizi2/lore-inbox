Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbTCIVIf>; Sun, 9 Mar 2003 16:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbTCIVIf>; Sun, 9 Mar 2003 16:08:35 -0500
Received: from ns.suse.de ([213.95.15.193]:29190 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262627AbTCIVIc>;
	Sun, 9 Mar 2003 16:08:32 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Marcelo Tossati <marcelo@conectiva.com.br>
Subject: [PATCH] Syntax errors in 2.4.21pre5 configure scripts
Date: Sun, 9 Mar 2003 22:19:37 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Adrian Schroeter <adrian@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p/6a+6nPj+KehBx"
Message-Id: <200303092219.37107.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_p/6a+6nPj+KehBx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Marcelo,

please find attached a patch against 2.4.21pre5 that fixes a number of syntax 
errors in the pre5 kernel. Without this, several architectures cannot be 
configured with "make xconfig", or the KDE kernel configurator.

Cheers,
Andreas Gruenbacher.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

--Boundary-00=_p/6a+6nPj+KehBx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="config-syntax-errors"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config-syntax-errors"

Fix some syntax errors in kernel configure scripts
(Sent to Marcelo on 9 March 2003.)

This patch against 2.4.21pre5 fixes a number of syntax errors in
configure scripts of various (non-i386) architectures. The KDE
kernel configurator in kcontrol as well as `make xconfig' puke
on them.

Andreas Gruenbacher <agruen@suse.de>


--- drivers/s390/Config.in.orig 2003-03-09 21:44:08.000000000 +0100
+++ drivers/s390/Config.in      2003-03-09 21:44:13.000000000 +0100
@@ -17,7 +17,7 @@
   dep_tristate '   Support for ECKD Disks' CONFIG_DASD_ECKD $CONFIG_DASD
   if [ "$CONFIG_DASD_ECKD" = "m" ]; then
     bool     '   Automatic activation of ECKD module' CONFIG_DASD_AUTO_ECKD
-  fi;
+  fi
   dep_tristate '   Support for FBA  Disks' CONFIG_DASD_FBA $CONFIG_DASD
   if [ "$CONFIG_DASD_FBA" = "m" ]; then
     bool     '   Automatic activation of FBA  module' CONFIG_DASD_AUTO_FBA
--- arch/m68k/config.in.orig	2003-03-09 21:46:27.000000000 +0100
+++ arch/m68k/config.in	2003-03-09 21:47:19.000000000 +0100
@@ -502,7 +502,7 @@
      "$CONFIG_SUN3X_ZS" = "y" -o "$CONFIG_SERIAL" = "y" -o \
      "$CONFIG_MVME147_SCC" -o "$CONFIG_SERIAL167" = "y" -o \
      "$CONFIG_MVME162_SCC" -o "$CONFIG_BVME6000_SCC" = "y" -o \
-     "$CONFIG_DN_SERIAL" -o ]; then
+     "$CONFIG_DN_SERIAL" ]; then
    bool 'Support for serial port console' CONFIG_SERIAL_CONSOLE
 fi
 bool 'Support for user serial device modules' CONFIG_USERIAL
--- arch/mips/config-shared.in.orig	2003-03-09 21:48:27.000000000 +0100
+++ arch/mips/config-shared.in	2003-03-09 21:48:49.000000000 +0100
@@ -479,7 +479,7 @@
 if [ "$CONFIG_CPU_SB1" = "y" ]; then
    choice 'SB1 Pass' \
 	 "Pass1   CONFIG_CPU_SB1_PASS_1  \
-	  Pass2   CONFIG_CPU_SB1_PASS_2
+	  Pass2   CONFIG_CPU_SB1_PASS_2  \
 	  Pass2.2 CONFIG_CPU_SB1_PASS_2_2" Pass1
    if [ "$CONFIG_CPU_SB1_PASS_1" = "y" ]; then
       define_bool CONFIG_SB1_PASS_1_WORKAROUNDS y
--- drivers/s390/Config.in.orig	2003-03-09 21:49:47.000000000 +0100
+++ drivers/s390/Config.in	2003-03-09 21:50:18.000000000 +0100
@@ -21,14 +21,14 @@
   dep_tristate '   Support for FBA  Disks' CONFIG_DASD_FBA $CONFIG_DASD
   if [ "$CONFIG_DASD_FBA" = "m" ]; then
     bool     '   Automatic activation of FBA  module' CONFIG_DASD_AUTO_FBA
-  fi;
+  fi
 #  dep_tristate '   Support for CKD  Disks' CONFIG_DASD_CKD $CONFIG_DASD
   if [ "$CONFIG_ARCH_S390X" != "y" ]; then
     dep_tristate '   Support for DIAG access to CMS reserved Disks' CONFIG_DASD_DIAG $CONFIG_DASD
     if [ "$CONFIG_DASD_DIAG" = "m" ]; then
       bool     '   Automatic activation of DIAG module' CONFIG_DASD_AUTO_DIAG
-    fi;
-  fi; 
+    fi
+  fi
 fi
 
 endmenu
--- arch/arm/config.in.orig	2003-03-09 21:55:00.000000000 +0100
+++ arch/arm/config.in	2003-03-09 21:55:03.000000000 +0100
@@ -538,7 +538,7 @@
 endmenu
 
 if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
-   source drivers/ssi/Config.in
+   source drivers/scsi/Config.in
 fi
 
 source drivers/ieee1394/Config.in

--Boundary-00=_p/6a+6nPj+KehBx--

