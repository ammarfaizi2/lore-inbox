Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKPP5o>; Thu, 16 Nov 2000 10:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQKPP5d>; Thu, 16 Nov 2000 10:57:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:36620 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129245AbQKPP5V>; Thu, 16 Nov 2000 10:57:21 -0500
Date: Thu, 16 Nov 2000 09:25:39 -0600
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PCI configuration changes
Message-ID: <20001116092539.A2453@wire.cadcamlab.org>
In-Reply-To: <200011151005.LAA20027@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011151005.LAA20027@green.mif.pg.gda.pl>; from ankry@green.mif.pg.gda.pl on Wed, Nov 15, 2000 at 11:05:07AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Andrzej Krzysztofowicz]
> Note, that as CONFIG_MCA is defined only for i386 the dependencies on
> $CONFIG_MCA are no-op for other architectures (in
> Configure/Menuconfig).  Either CONFIG_MCA should be defined for all
> architectures or there should be if ... fi around these lines.

The former, I think.  Less confusing in the long run.

> BTW, is there any reason for not replacing 
>    bool '  Other ISA cards' CONFIG_NET_ISA
> by
>   dep_bool '  Other ISA cards' CONFIG_NET_ISA $CONFIG_ISA
> to eliminate more drivers from non-ISA arch configs ?

Looks good to me.  Anything to remove clutter from config menus....

Peter


diff -urk.orig 2.4.0test11pre4/arch/alpha/config.in.orig 2.4.0test11pre4/arch/alpha/config.in
--- 2.4.0test11pre4/arch/alpha/config.in.orig	Mon Nov 13 01:44:55 2000
+++ 2.4.0test11pre4/arch/alpha/config.in	Thu Nov 16 09:11:23 2000
@@ -69,6 +69,7 @@
 define_bool CONFIG_ISA y
 define_bool CONFIG_EISA y
 define_bool CONFIG_SBUS n
+define_bool CONFIG_MCA n
 
 if [ "$CONFIG_ALPHA_JENSEN" = "y" ]
 then
diff -urk.orig 2.4.0test11pre4/arch/arm/config.in.orig 2.4.0test11pre4/arch/arm/config.in
--- 2.4.0test11pre4/arch/arm/config.in.orig	Mon Nov 13 01:44:02 2000
+++ 2.4.0test11pre4/arch/arm/config.in	Thu Nov 16 09:11:48 2000
@@ -7,6 +7,7 @@
 define_bool CONFIG_ARM y
 define_bool CONFIG_EISA n
 define_bool CONFIG_SBUS n
+define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
 
 
diff -urk.orig 2.4.0test11pre4/arch/ia64/config.in.orig 2.4.0test11pre4/arch/ia64/config.in
--- 2.4.0test11pre4/arch/ia64/config.in.orig	Mon Nov 13 01:44:02 2000
+++ 2.4.0test11pre4/arch/ia64/config.in	Thu Nov 16 09:17:26 2000
@@ -22,6 +22,7 @@
 
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
+define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
 
 choice 'IA-64 system type'					\
diff -urk.orig 2.4.0test11pre4/arch/m68k/config.in.orig 2.4.0test11pre4/arch/m68k/config.in
--- 2.4.0test11pre4/arch/m68k/config.in.orig	Mon Nov 13 01:44:02 2000
+++ 2.4.0test11pre4/arch/m68k/config.in	Thu Nov 16 09:17:10 2000
@@ -26,6 +26,7 @@
 
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
+define_bool CONFIG_MCA n
 define_bool CONFIG_PCMCIA n
 
 bool 'Amiga support' CONFIG_AMIGA
diff -urk.orig 2.4.0test11pre4/arch/mips/config.in.orig 2.4.0test11pre4/arch/mips/config.in
--- 2.4.0test11pre4/arch/mips/config.in.orig	Mon Nov 13 01:44:02 2000
+++ 2.4.0test11pre4/arch/mips/config.in	Thu Nov 16 09:16:45 2000
@@ -39,6 +39,7 @@
 unset CONFIG_VIDEO_G364
 unset CONFIG_PC_KEYB
 
+define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
 
 if [ "$CONFIG_ALGOR_P4032" = "y" ]; then
diff -urk.orig 2.4.0test11pre4/arch/mips64/config.in.orig 2.4.0test11pre4/arch/mips64/config.in
--- 2.4.0test11pre4/arch/mips64/config.in.orig	Mon Nov 13 01:44:02 2000
+++ 2.4.0test11pre4/arch/mips64/config.in	Thu Nov 16 09:16:33 2000
@@ -66,6 +66,7 @@
    define_bool CONFIG_PCI n
 fi
 
+define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
 
 mainmenu_option next_comment
diff -urk.orig 2.4.0test11pre4/arch/ppc/config.in.orig 2.4.0test11pre4/arch/ppc/config.in
--- 2.4.0test11pre4/arch/ppc/config.in.orig	Mon Nov 13 01:44:02 2000
+++ 2.4.0test11pre4/arch/ppc/config.in	Thu Nov 16 09:15:21 2000
@@ -101,6 +101,9 @@
 define_bool CONFIG_EISA n
 define_bool CONFIG_SBUS n
 
+# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
+define_bool CONFIG_MCA n
+
 if [ "$CONFIG_APUS" = "y" -o "$CONFIG_4xx" = "y" -o \
      "$CONFIG_8260" = "y" ]; then
    define_bool CONFIG_PCI n
diff -urk.orig 2.4.0test11pre4/arch/s390/config.in.orig 2.4.0test11pre4/arch/s390/config.in
--- 2.4.0test11pre4/arch/s390/config.in.orig	Mon Nov 13 01:44:03 2000
+++ 2.4.0test11pre4/arch/s390/config.in	Thu Nov 16 09:13:39 2000
@@ -5,6 +5,7 @@
 
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
+define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
 
 mainmenu_name "Linux Kernel Configuration"
diff -urk.orig 2.4.0test11pre4/arch/sh/config.in.orig 2.4.0test11pre4/arch/sh/config.in
--- 2.4.0test11pre4/arch/sh/config.in.orig	Mon Nov 13 01:44:03 2000
+++ 2.4.0test11pre4/arch/sh/config.in	Thu Nov 16 09:13:26 2000
@@ -67,6 +67,7 @@
 
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
+define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
 
 bool 'Networking support' CONFIG_NET
diff -urk.orig 2.4.0test11pre4/arch/sparc/config.in.orig 2.4.0test11pre4/arch/sparc/config.in
--- 2.4.0test11pre4/arch/sparc/config.in.orig	Mon Nov 13 01:44:03 2000
+++ 2.4.0test11pre4/arch/sparc/config.in	Thu Nov 16 09:12:31 2000
@@ -32,6 +32,7 @@
 # Global things across all Sun machines.
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
+define_bool CONFIG_MCA n
 define_bool CONFIG_PCMCIA n
 define_bool CONFIG_SBUS y
 define_bool CONFIG_SBUSCHAR y
diff -urk.orig 2.4.0test11pre4/arch/sparc64/config.in.orig 2.4.0test11pre4/arch/sparc64/config.in
--- 2.4.0test11pre4/arch/sparc64/config.in.orig	Mon Nov 13 01:44:03 2000
+++ 2.4.0test11pre4/arch/sparc64/config.in	Thu Nov 16 09:12:45 2000
@@ -30,6 +30,7 @@
 define_bool CONFIG_HAVE_DEC_LOCK y
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
+define_bool CONFIG_MCA n
 define_bool CONFIG_PCMCIA n
 define_bool CONFIG_SBUS y
 define_bool CONFIG_SBUSCHAR y
diff -urk.orig 2.4.0test11pre4/drivers/net/Config.in.orig 2.4.0test11pre4/drivers/net/Config.in
--- 2.4.0test11pre4/drivers/net/Config.in.orig	Mon Nov 13 01:44:09 2000
+++ 2.4.0test11pre4/drivers/net/Config.in	Thu Nov 16 09:20:13 2000
@@ -100,7 +100,7 @@
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
       tristate '  HP 10/100VG PCLAN (ISA, EISA, PCI) support' CONFIG_HP100
    fi
-   bool '  Other ISA cards' CONFIG_NET_ISA
+   dep_bool '  Other ISA cards' CONFIG_NET_ISA $CONFIG_ISA
    if [ "$CONFIG_NET_ISA" = "y" ]; then
       tristate '    Cabletron E21xx support' CONFIG_E2100
       if [ "$CONFIG_OBSOLETE" = "y" ]; then
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
