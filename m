Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270533AbTGSUKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270536AbTGSUKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:10:35 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:36569 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S270533AbTGSUKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:10:08 -0400
Message-Id: <200307192024.h6JKOqsG028133@ginger.cmf.nrl.navy.mil>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org, davem@redhat.com
Reply-To: chas3@users.sourceforge.net
Subject: Re: [BUG] 2.4.22-pre7 ATM config breakage 
In-reply-to: Your message of "Sat, 19 Jul 2003 01:30:00 +0200."
             <200307182330.h6INU0YJ029869@harpo.it.uu.se> 
Date: Sat, 19 Jul 2003 16:22:21 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200307182330.h6INU0YJ029869@harpo.it.uu.se>,Mikael Pettersson write
s:
>With CONFIG_EXPERIMENTAL disabled, CONFIG_ATM is unset, and the
>test "$CONFIG_ATM" != "n" becomes true ("" != "n").
>
>Either CONFIG_ATM shouldn't depend on CONFIG_EXPERIMENTAL, or the test
>should be "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_ATM" != "n".

not quite -- you really need to check $CONFIG_ATM = "m" -o $CONFIG_ATM = "y".
if you go into a fresh kernel and flag CONFIG_EXPERIMENTAL, then CONFIG_ATM
is still unset (setting CONFIG_EXPERIMENTAL doesnt force CONFIG_ATM to unset
until you visit the right menu) and you might be prompted for atm related
bits before atm is enabled.  (yes, you could remove the CONFIG_EXPERIMENTAL
depedency but i dont know if atm is ready for that -- it will be soon though).

the following changeset should take care of this once and for all:


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1021  -> 1.1022 
#	 net/sched/Config.in	1.5     -> 1.6    
#	drivers/net/Config.in	1.64    -> 1.65   
#	arch/sparc/config.in	1.17    -> 1.18   
#	       net/Config.in	1.14    -> 1.15   
#	arch/alpha/config.in	1.26    -> 1.27   
#	arch/ppc64/config.in	1.9     -> 1.10   
#	arch/sparc64/config.in	1.28    -> 1.29   
#	 arch/i386/config.in	1.45    -> 1.46   
#	drivers/usb/Config.in	1.37    -> 1.38   
#	   arch/sh/config.in	1.11    -> 1.12   
#	 arch/ia64/config.in	1.21    -> 1.22   
#	arch/mips/config-shared.in	1.3     -> 1.4    
#	  arch/ppc/config.in	1.39    -> 1.40   
#	 arch/cris/config.in	1.17    -> 1.18   
#	arch/x86_64/config.in	1.8     -> 1.9    
#	arch/parisc/config.in	1.8     -> 1.9    
#	 arch/sh64/config.in	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/19	chas@relax.cmf.nrl.navy.mil	1.1022
# get atm config/build dependencies correct
# --------------------------------------------
#
diff -Nru a/arch/alpha/config.in b/arch/alpha/config.in
--- a/arch/alpha/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/alpha/config.in	Sat Jul 19 16:18:33 2003
@@ -367,7 +367,7 @@
   bool 'Network device support' CONFIG_NETDEVICES
   if [ "$CONFIG_NETDEVICES" = "y" ]; then
     source drivers/net/Config.in
-    if [ "$CONFIG_ATM" != "n" ]; then
+    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
       source drivers/atm/Config.in
     fi
   fi
diff -Nru a/arch/cris/config.in b/arch/cris/config.in
--- a/arch/cris/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/cris/config.in	Sat Jul 19 16:18:33 2003
@@ -210,7 +210,7 @@
   bool 'Network device support' CONFIG_NETDEVICES
   if [ "$CONFIG_NETDEVICES" = "y" ]; then
     source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
   fi
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/i386/config.in	Sat Jul 19 16:18:33 2003
@@ -393,7 +393,7 @@
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/ia64/config.in b/arch/ia64/config.in
--- a/arch/ia64/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/ia64/config.in	Sat Jul 19 16:18:33 2003
@@ -179,7 +179,7 @@
     bool 'Network device support' CONFIG_NETDEVICES
     if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
     fi
diff -Nru a/arch/mips/config-shared.in b/arch/mips/config-shared.in
--- a/arch/mips/config-shared.in	Sat Jul 19 16:18:33 2003
+++ b/arch/mips/config-shared.in	Sat Jul 19 16:18:33 2003
@@ -686,7 +686,7 @@
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" = "y" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
 	 source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/parisc/config.in b/arch/parisc/config.in
--- a/arch/parisc/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/parisc/config.in	Sat Jul 19 16:18:33 2003
@@ -136,7 +136,7 @@
 
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/ppc/config.in	Sat Jul 19 16:18:33 2003
@@ -323,7 +323,7 @@
   bool 'Network device support' CONFIG_NETDEVICES
   if [ "$CONFIG_NETDEVICES" = "y" ]; then
     source drivers/net/Config.in
-    if [ "$CONFIG_ATM" != "n" ]; then
+    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
       source drivers/atm/Config.in
     fi
   fi
diff -Nru a/arch/ppc64/config.in b/arch/ppc64/config.in
--- a/arch/ppc64/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/ppc64/config.in	Sat Jul 19 16:18:33 2003
@@ -141,7 +141,7 @@
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/sh/config.in b/arch/sh/config.in
--- a/arch/sh/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/sh/config.in	Sat Jul 19 16:18:33 2003
@@ -311,7 +311,7 @@
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/sh64/config.in b/arch/sh64/config.in
--- a/arch/sh64/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/sh64/config.in	Sat Jul 19 16:18:33 2003
@@ -198,7 +198,7 @@
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
          source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/sparc/config.in b/arch/sparc/config.in
--- a/arch/sparc/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/sparc/config.in	Sat Jul 19 16:18:33 2003
@@ -209,8 +209,8 @@
         dep_tristate '  PPP BSD-Compress compression' CONFIG_PPP_BSDCOMP m
 	if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
 	  dep_tristate '  PPP over Ethernet (EXPERIMENTAL)' CONFIG_PPPOE $CONFIG_PPP
-	  if [ "$CONFIG_ATM" != "n" ]; then
-	    dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP
+	  if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+	    dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP $CONFIG_ATM
 	  fi
 	fi
       fi
diff -Nru a/arch/sparc64/config.in b/arch/sparc64/config.in
--- a/arch/sparc64/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/sparc64/config.in	Sat Jul 19 16:18:33 2003
@@ -234,7 +234,7 @@
    bool 'Network device support' CONFIG_NETDEVICES
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
-      if [ "$CONFIG_ATM" != "n" ]; then
+      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
 	source drivers/atm/Config.in
       fi
    fi
diff -Nru a/arch/x86_64/config.in b/arch/x86_64/config.in
--- a/arch/x86_64/config.in	Sat Jul 19 16:18:33 2003
+++ b/arch/x86_64/config.in	Sat Jul 19 16:18:33 2003
@@ -168,7 +168,7 @@
    if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
 # seems to be largely not 64bit safe	   
-#      if [ "$CONFIG_ATM" != "n" ]; then
+#      if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
 #         source drivers/atm/Config.in
 #      fi
    fi
diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
--- a/drivers/net/Config.in	Sat Jul 19 16:18:33 2003
+++ b/drivers/net/Config.in	Sat Jul 19 16:18:33 2003
@@ -311,8 +311,8 @@
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       dep_tristate '  PPP over Ethernet (EXPERIMENTAL)' CONFIG_PPPOE $CONFIG_PPP
    fi
-   if [ ! "$CONFIG_ATM" = "n" ]; then
-      dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP $CONFIG_EXPERIMENTAL $CONFIG_ATM
+   if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+      dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP $CONFIG_ATM
    fi
 fi
 
diff -Nru a/drivers/usb/Config.in b/drivers/usb/Config.in
--- a/drivers/usb/Config.in	Sat Jul 19 16:18:33 2003
+++ b/drivers/usb/Config.in	Sat Jul 19 16:18:33 2003
@@ -106,6 +106,8 @@
    dep_tristate '  Texas Instruments Graph Link USB (aka SilverLink) cable support' CONFIG_USB_TIGL $CONFIG_USB
    dep_tristate '  Tieman Voyager USB Braille display support (EXPERIMENTAL)' CONFIG_USB_BRLVGER $CONFIG_USB $CONFIG_EXPERIMENTAL
    dep_tristate '  USB LCD device support' CONFIG_USB_LCD $CONFIG_USB
-   dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB
+   if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
+      dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB
+   fi
 fi
 endmenu
diff -Nru a/net/Config.in b/net/Config.in
--- a/net/Config.in	Sat Jul 19 16:18:33 2003
+++ b/net/Config.in	Sat Jul 19 16:18:33 2003
@@ -32,7 +32,7 @@
 fi
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    tristate 'Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)' CONFIG_ATM
-   if [ "$CONFIG_ATM" != "n" ]; then
+   if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
       if [ "$CONFIG_INET" = "y" ]; then
 	 dep_tristate '  Classical IP over ATM' CONFIG_ATM_CLIP $CONFIG_ATM
 	 if [ "$CONFIG_ATM_CLIP" != "n" ]; then
diff -Nru a/net/sched/Config.in b/net/sched/Config.in
--- a/net/sched/Config.in	Sat Jul 19 16:18:33 2003
+++ b/net/sched/Config.in	Sat Jul 19 16:18:33 2003
@@ -6,7 +6,7 @@
 tristate '  CSZ packet scheduler' CONFIG_NET_SCH_CSZ
 #tristate '  H-PFQ packet scheduler' CONFIG_NET_SCH_HPFQ
 #tristate '  H-FSC packet scheduler' CONFIG_NET_SCH_HFCS
-if [ "$CONFIG_ATM" != "n" ]; then
+if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
    dep_tristate '  ATM pseudo-scheduler' CONFIG_NET_SCH_ATM $CONFIG_ATM
 fi
 tristate '  The simplest PRIO pseudoscheduler' CONFIG_NET_SCH_PRIO
