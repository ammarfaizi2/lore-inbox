Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285785AbRLJTBt>; Mon, 10 Dec 2001 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285809AbRLJTBl>; Mon, 10 Dec 2001 14:01:41 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:50424 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285785AbRLJTB0>;
	Mon, 10 Dec 2001 14:01:26 -0500
Date: Mon, 10 Dec 2001 11:01:04 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.X Directory move for old Wavelan/Netwave drivers
Message-ID: <20011210110104.A20814@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011206155555.A18014@bougret.hpl.hp.com> <20011210103403.A20751@bougret.hpl.hp.com> <3C150150.3E282A1B@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C150150.3E282A1B@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Dec 10, 2001 at 01:39:12PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 01:39:12PM -0500, Jeff Garzik wrote:
> Just a suggestion, if you are moving a bunch of files around, you might
> e-mail Linus a small script he can cut-n-paste to move the files, and
> then provide a patch for the stuff that is actually changed...  I don't
> want to speak for Linus but at least for the rest of LKML it would make
> the patches smaller and easier to read.  This was a pretty large patch
> to the CC to lkml...
> 
> Even if the files are renamed then changed, IMHO a better submission
> will include 
> 	mv dir1/foo.c dir2/foo.c
> 	mv dir1/bar.c dir2/bar.c
> 
> and then patch dir2/{foo,bar}.c....
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung

	No problem. Attached are the shell script and the diff. The
diff applies *after* the shell script.

	Have fun...

	Jean

#!/bin/sh

# Wavelan ISA driver
mv drivers/net/i82586.h     drivers/net/wireless
mv drivers/net/wavelan.h    drivers/net/wireless
mv drivers/net/wavelan.p.h  drivers/net/wireless
mv drivers/net/wavelan.c    drivers/net/wireless

# Wavelan Pcmcia driver
# Warning : Rename headers because of conflict with ISA driver
mv drivers/net/pcmcia/i82593.h      drivers/net/wireless
mv drivers/net/pcmcia/wavelan.h     drivers/net/wireless/wavelan_cs.h
mv drivers/net/pcmcia/wavelan_cs.h  drivers/net/wireless/wavelan_cs.p.h
mv drivers/net/pcmcia/wavelan_cs.c  drivers/net/wireless

# Netwave Pcmcia driver
mv drivers/net/pcmcia/netwave_cs.c  drivers/net/wireless


diff -u -p -r --new-file linux/drivers/net-moved/Config.in linux/drivers/net/Config.in
--- linux/drivers/net-moved/Config.in	Mon Nov 19 15:19:42 2001
+++ linux/drivers/net/Config.in	Thu Dec  6 11:52:17 2001
@@ -293,7 +293,6 @@ comment 'Wireless LAN (non-hamradio)'
 bool 'Wireless LAN (non-hamradio)' CONFIG_NET_RADIO
 if [ "$CONFIG_NET_RADIO" = "y" ]; then
    dep_tristate '  STRIP (Metricom starmode radio IP)' CONFIG_STRIP $CONFIG_INET
-   tristate '  AT&T WaveLAN & DEC RoamAbout DS support' CONFIG_WAVELAN
    tristate '  Aironet Arlan 655 & IC2200 DS support' CONFIG_ARLAN
    tristate '  Aironet 4500/4800 series adapters' CONFIG_AIRONET4500
    dep_tristate '   Aironet 4500/4800 ISA/PCI/PNP/365 support ' CONFIG_AIRONET4500_NONCS $CONFIG_AIRONET4500
diff -u -p -r --new-file linux/drivers/net-moved/Makefile linux/drivers/net/Makefile
--- linux/drivers/net-moved/Makefile	Fri Oct 19 08:32:28 2001
+++ linux/drivers/net/Makefile	Thu Dec  6 11:32:21 2001
@@ -166,7 +166,6 @@ obj-$(CONFIG_EEXPRESS) += eexpress.o
 obj-$(CONFIG_EEXPRESS_PRO) += eepro.o
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
-obj-$(CONFIG_WAVELAN) += wavelan.o
 obj-$(CONFIG_ARLAN) += arlan.o arlan-proc.o
 obj-$(CONFIG_ZNET) += znet.o
 obj-$(CONFIG_LAN_SAA9730) += saa9730.o
diff -u -p -r --new-file linux/drivers/net-moved/pcmcia/Config.in linux/drivers/net/pcmcia/Config.in
--- linux/drivers/net-moved/pcmcia/Config.in	Mon Nov 12 09:35:43 2001
+++ linux/drivers/net/pcmcia/Config.in	Thu Dec  6 11:54:59 2001
@@ -28,8 +28,6 @@ if [ "$CONFIG_NET_PCMCIA" = "y" ]; then
    bool '  Pcmcia Wireless LAN' CONFIG_NET_PCMCIA_RADIO
    if [ "$CONFIG_NET_PCMCIA_RADIO" = "y" ]; then
       dep_tristate '    Aviator/Raytheon 2.4MHz wireless support' CONFIG_PCMCIA_RAYCS $CONFIG_PCMCIA
-      dep_tristate '    Xircom Netwave AirSurfer wireless support' CONFIG_PCMCIA_NETWAVE $CONFIG_PCMCIA
-      dep_tristate '    AT&T/Lucent Wavelan wireless support' CONFIG_PCMCIA_WAVELAN $CONFIG_PCMCIA
       dep_tristate '    Aironet 4500/4800 PCMCIA support' CONFIG_AIRONET4500_CS $CONFIG_AIRONET4500 $CONFIG_PCMCIA
    fi
 fi
diff -u -p -r --new-file linux/drivers/net-moved/pcmcia/Makefile linux/drivers/net/pcmcia/Makefile
--- linux/drivers/net-moved/pcmcia/Makefile	Mon Nov 12 09:35:43 2001
+++ linux/drivers/net/pcmcia/Makefile	Thu Dec  6 11:55:59 2001
@@ -27,8 +27,6 @@ obj-$(CONFIG_PCMCIA_AXNET)	+= axnet_cs.o
 
 # 16-bit wireless client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
-obj-$(CONFIG_PCMCIA_NETWAVE)	+= netwave_cs.o
-obj-$(CONFIG_PCMCIA_WAVELAN)	+= wavelan_cs.o
 obj-$(CONFIG_AIRONET4500_CS)	+= aironet4500_cs.o
 
 # Cardbus client drivers
diff -u -p -r --new-file linux/drivers/net-moved/wireless/Config.in linux/drivers/net/wireless/Config.in
--- linux/drivers/net-moved/wireless/Config.in	Tue Oct  9 15:13:03 2001
+++ linux/drivers/net/wireless/Config.in	Thu Dec  6 15:34:51 2001
@@ -2,6 +2,12 @@
 # Wireless LAN device configuration
 #
 
+comment 'Wireless ISA/PCI cards support' 
+
+# Good old obsolete Wavelan.
+tristate '  AT&T/Lucent old WaveLAN & DEC RoamAbout DS ISA support' CONFIG_WAVELAN
+
+# 802.11b cards
 if [ "$CONFIG_ISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
    tristate '  Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards' CONFIG_AIRO
 fi
@@ -18,8 +24,13 @@ fi
 
 # If Pcmcia is compiled in, offer Pcmcia cards...
 if [ "$CONFIG_PCMCIA" != "n" ]; then
-   comment 'Wireless Pcmcia cards support' 
+   comment 'Wireless Pcmcia/Cardbus cards support' 
+
+# Obsolete cards
+   dep_tristate '  Xircom Netwave AirSurfer Pcmcia wireless support' CONFIG_PCMCIA_NETWAVE $CONFIG_PCMCIA
+   dep_tristate '  AT&T/Lucent old Wavelan Pcmcia wireless support' CONFIG_PCMCIA_WAVELAN $CONFIG_PCMCIA
 
+# 802.11b cards
    dep_tristate '  Hermes PCMCIA card support' CONFIG_PCMCIA_HERMES $CONFIG_HERMES
    tristate '  Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards' CONFIG_AIRO_CS
 fi
diff -u -p -r --new-file linux/drivers/net-moved/wireless/Makefile linux/drivers/net/wireless/Makefile
--- linux/drivers/net-moved/wireless/Makefile	Tue Oct  9 15:13:03 2001
+++ linux/drivers/net/wireless/Makefile	Thu Dec  6 11:55:43 2001
@@ -14,6 +14,11 @@ obj-		:=
 # Things that need to export symbols
 export-objs	:= airo.o orinoco.o hermes.o
 
+# Obsolete cards
+obj-$(CONFIG_WAVELAN)		+= wavelan.o
+obj-$(CONFIG_PCMCIA_NETWAVE)	+= netwave_cs.o
+obj-$(CONFIG_PCMCIA_WAVELAN)	+= wavelan_cs.o
+
 obj-$(CONFIG_HERMES)		+= orinoco.o hermes.o
 obj-$(CONFIG_PCMCIA_HERMES)	+= orinoco_cs.o
 obj-$(CONFIG_APPLE_AIRPORT)	+= airport.o
diff -u -p -r --new-file linux/drivers/net-moved/wireless/todo.txt linux/drivers/net/wireless/todo.txt
--- linux/drivers/net-moved/wireless/todo.txt	Mon May  7 19:42:14 2001
+++ linux/drivers/net/wireless/todo.txt	Thu Dec  6 15:32:35 2001
@@ -4,21 +4,26 @@
 1) Bring other kernel Wireless LAN drivers here
 	Already done :
 	 o hermes.c/orinoco.c	-> Wavelan IEEE driver + Airport driver
-	Drivers I have control over :
+	 o airo.c/airo_cs.c	-> Ben's Aironet driver
 	 o wavelan.c		-> old Wavelan ISA driver
-	 o wavelan_cs.c		-> old Wavelan Pcmcia driver (warning : header)
+	 o wavelan_cs.c		-> old Wavelan Pcmcia driver
 	 o netwave_cs.c		-> Netwave Pcmcia driver
 	Drivers likely to go :
 	 o ray_cs.c		-> Raytheon/Aviator driver (maintainer MIA)
 	Drivers I have absolutely no control over :
 	 o arlan.c		-> old Aironet Arlan 655 (need to ask Elmer)
 	 o aironet4500_xxx.c	-> Elmer's Aironet driver (need to ask Elmer)
-	 o airo.c/airo_cs.c	-> Ben's Aironet driver (not yet in kernel)
 	 o strip.c		-> Metricom's stuff. Not a wlan. Hum...
 
 	ETA : Kernel 2.5.X
 
 2) Bring new Wireless LAN driver not yet in the kernel there
 	See my web page for details
+
+3) Misc
+	o Mark wavelan, wavelan_cs, netwave_cs drivers as obsolete
+	o Maybe arlan.c, ray_cs.c and strip.c also deserve to be obsolete
+	o Use new Probe/module stuff in wavelan.c
+	o New Wireless Extension API (pending)
 
 	Jean II
diff -u -p -r --new-file linux/drivers/net-moved/wireless/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net-moved/wireless/wavelan_cs.c	Fri Nov  9 15:22:54 2001
+++ linux/drivers/net/wireless/wavelan_cs.c	Thu Dec  6 14:06:00 2001
@@ -4,7 +4,7 @@
  *		Jean II - HPLB '96
  *
  * Reorganisation and extension of the driver.
- * Original copyright follow. See wavelan_cs.h for details.
+ * Original copyright follow. See wavelan_cs.p.h for details.
  *
  * This code is derived from Anthony D. Joseph's code and all the changes here
  * are also under the original copyright below.
@@ -62,7 +62,7 @@
  *
  */
 
-#include "wavelan_cs.h"		/* Private header */
+#include "wavelan_cs.p.h"		/* Private header */
 
 /************************* MISC SUBROUTINES **************************/
 /*
diff -u -p -r --new-file linux/drivers/net-moved/wireless/wavelan_cs.h linux/drivers/net/wireless/wavelan_cs.h
--- linux/drivers/net-moved/wireless/wavelan_cs.h	Fri Mar  2 11:02:15 2001
+++ linux/drivers/net/wireless/wavelan_cs.h	Thu Dec  6 14:04:00 2001
@@ -52,8 +52,8 @@
  *       Robert Morris' BSDI driver for the PCMCIA WaveLAN adapter
  */
 
-#ifndef _WAVELAN_H
-#define	_WAVELAN_H
+#ifndef _WAVELAN_CS_H
+#define	_WAVELAN_CS_H
 
 /************************** MAGIC NUMBERS ***************************/
 
@@ -380,4 +380,4 @@ typedef union mm_t
   struct mmr_t	r;	/* Read from the mmc */
 } mm_t;
 
-#endif /* _WAVELAN_H */
+#endif /* _WAVELAN_CS_H */
diff -u -p -r --new-file linux/drivers/net-moved/wireless/wavelan_cs.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net-moved/wireless/wavelan_cs.p.h	Fri Oct 12 14:21:18 2001
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Thu Dec  6 16:08:22 2001
@@ -10,8 +10,8 @@
  * be included only on wavelan_cs.c !!!
  */
 
-#ifndef WAVELAN_CS_H
-#define WAVELAN_CS_H
+#ifndef WAVELAN_CS_P_H
+#define WAVELAN_CS_P_H
 
 /************************** DOCUMENTATION **************************/
 /*
@@ -57,7 +57,7 @@
  *	The detection code of the wavelan chech that the first 3
  *	octets of the MAC address fit the company code. This type of
  *	detection work well for AT&T cards (because the AT&T code is
- *	hardcoded in wavelan.h), but of course will fail for other
+ *	hardcoded in wavelan_cs.p.h), but of course will fail for other
  *	manufacturer.
  *
  *	If you are sure that your card is derived from the wavelan,
@@ -67,7 +67,7 @@
  *		b) With the driver :
  *			o compile the kernel with DEBUG_CONFIG_INFO enabled
  *			o Boot and look the card messages
- *	2) Set your MAC code (3 octets) in MAC_ADDRESSES[][3] (wavelan.h)
+ *	2) Set your MAC code (3 octets) in MAC_ADDRESSES[][3] (wavelan_cs.h)
  *	3) Compile & verify
  *	4) Send me the MAC code - I will include it in the next version...
  *
@@ -92,9 +92,9 @@
 /*
  * wavelan_cs.c :	The actual code for the driver - C functions
  *
- * wavelan_cs.h :	Private header : local types / vars for the driver
+ * wavelan_cs.p.h :	Private header : local types / vars for the driver
  *
- * wavelan.h :		Description of the hardware interface & structs
+ * wavelan_cs.h :	Description of the hardware interface & structs
  *
  * i82593.h :		Description if the Ethernet controller
  */
@@ -397,7 +397,7 @@
 /* Wavelan declarations */
 #include "i82593.h"	/* Definitions for the Intel chip */
 
-#include "wavelan.h"	/* Others bits of the hardware */
+#include "wavelan_cs.h"	/* Others bits of the hardware */
 
 /************************** DRIVER OPTIONS **************************/
 /*
@@ -774,5 +774,5 @@ static int	do_roaming;
 MODULE_PARM(do_roaming, "i");
 #endif	/* WAVELAN_ROAMING */
 
-#endif	/* WAVELAN_CS_H */
+#endif	/* WAVELAN_CS_P_H */
 
