Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVIDLFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVIDLFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 07:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVIDLFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 07:05:42 -0400
Received: from smtp1.libero.it ([193.70.192.51]:26867 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S1750746AbVIDLFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 07:05:41 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 13:05:21 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C5B151.4E8AE540"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C5B151.4E8AE540
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dears,

thanks to Jiri Slaby who found a bug in the AAL0 handling of the ATMSAR =
module.

I attach a fixed version of the atmsar patch as a diff against the =
2.6.13 kernel tree.

Now the sources are also fully-delethalized by avoiding any line wrap in =
the Linus' 80-column monitor and the danger due to whitespaces at end of =
lines is prevented.

However, I'm still hearing for your comments about the usefulness of an =
ATMSAR layer. I'm also trying hard to get in touch with Duncan Sands =
(SpeedTouch USB Driver maintainer) and Chas Williams (ATM maintainer) in =
order to get this patch reviewed and, eventually, committed.

How am I supposed to contact them? I had no reply to the mails I sent =
them...

Thanks for your interest in this,

-----------------------------------
Giampaolo Tomassoni - IT Consultant
Piazza VIII Aprile 1948, 4
I-53044 Chiusi (SI) - Italy
Ph: +39-0578-21100

------=_NextPart_000_0005_01C5B151.4E8AE540
Content-Type: application/octet-stream;
	name="patch-2.6.13+atmsar.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-2.6.13+atmsar.diff"

diff -Nurd linux-2.6.13/MAINTAINERS linux-2.6.13+atmsar/MAINTAINERS=0A=
--- linux-2.6.13/MAINTAINERS	2005-08-29 01:41:01.000000000 +0200=0A=
+++ linux-2.6.13+atmsar/MAINTAINERS	2005-09-04 12:28:06.000000000 +0200=0A=
@@ -370,6 +370,12 @@=0A=
 W:	http://atmelwlandriver.sourceforge.net/=0A=
 S:	Maintained=0A=
 =0A=
+ATMSAR SUPPORT=0A=
+P:      Giampaolo Tomassoni=0A=
+M:      g.tomassoni@libero.it=0A=
+W:      http://www.tomassoni.biz=0A=
+S:      Maintained=0A=
+=0A=
 AUDIT SUBSYSTEM=0A=
 L:	linux-audit@redhat.com (subscribers-only)=0A=
 S:	Maintained=0A=
diff -Nurd linux-2.6.13/drivers/atm/Kconfig =
linux-2.6.13+atmsar/drivers/atm/Kconfig=0A=
--- linux-2.6.13/drivers/atm/Kconfig	2005-08-29 01:41:01.000000000 +0200=0A=
+++ linux-2.6.13+atmsar/drivers/atm/Kconfig	2005-09-04 =
11:55:16.000000000 +0200=0A=
@@ -444,5 +444,18 @@=0A=
 	  Support for the S/UNI-Ultra and S/UNI-622 found in the ForeRunner=0A=
 	  HE cards.  This driver provides carrier detection some statistics.=0A=
 =0A=
-endmenu=0A=
+config ATM_SAR=0A=
+	tristate "SAR support (EXPERIMENTAL)"=0A=
+	depends on ATM && CRC32=0A=
+	help=0A=
+	  This is experimental code which supplies a SAR (Segment And=0A=
+	  Reassembly) layer to the ATM stack.=0A=
 =0A=
+	  The SAR layer can be used by various "dumb" ATM devices (notably=0A=
+	  ADSL modems) whose firmware lacks of SAR capabilities.=0A=
+=0A=
+	  For further details see: <file:include/linux/atmsar.h>=0A=
+=0A=
+	  If unsure, say N.=0A=
+=0A=
+endmenu=0A=
diff -Nurd linux-2.6.13/drivers/atm/Makefile =
linux-2.6.13+atmsar/drivers/atm/Makefile=0A=
--- linux-2.6.13/drivers/atm/Makefile	2005-08-29 01:41:01.000000000 +0200=0A=
+++ linux-2.6.13+atmsar/drivers/atm/Makefile	2005-09-04 =
11:52:51.000000000 +0200=0A=
@@ -70,3 +70,6 @@=0A=
 $(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(src)/%.data=0A=
 	objcopy -Iihex $< -Obinary $@.gz=0A=
 	gzip -n -df $@.gz=0A=
+=0A=
+obj-$(CONFIG_ATM_SAR)		+=3D atmsar.o=0A=
+atmsar-objs			+=3D sar.o saraalr.o saraal0.o saraal5.o=0A=
diff -Nurd linux-2.6.13/drivers/atm/sar.c =
linux-2.6.13+atmsar/drivers/atm/sar.c=0A=
--- linux-2.6.13/drivers/atm/sar.c	1970-01-01 01:00:00.000000000 +0100=0A=
+++ linux-2.6.13+atmsar/drivers/atm/sar.c	2005-09-04 12:34:26.000000000 =
+0200=0A=
@@ -0,0 +1,837 @@=0A=
+/* ATM SAR layer=0A=
+ *=0A=
+ * Copyright (C) 2005 Giampaolo Tomassoni=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA=0A=
+ *=0A=
+ * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian=0A=
+ * system and in the file COPYING in the Linux kernel source.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * CREDITS go to the following people:=0A=
+ *=0A=
+ * - Johan Verrept, for its previous work on a SAR library in Linux;=0A=
+ * - Charles Michael Heard for its tutorial on CRC-8 Error Correction.=0A=
+ * - Chas Williams for its help in integrating this with the ATM module.=0A=
+ *=0A=
+ *=0A=
+ * Theory of operation and api description in include/linux/atmsar.h=0A=
+ */=0A=
+#include <linux/version.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/moduleparam.h>=0A=
+#include <linux/gfp.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/wait.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/skbuff.h>=0A=
+#include <linux/atm.h>=0A=
+#include <linux/atmdev.h>=0A=
+=0A=
+#include <linux/atmsar.h>=0A=
+#include "sar.h"=0A=
+=0A=
+=0A=
+#define	VERSION		"1.0.0"=0A=
+=0A=
+#undef	ATM_SAR_DBG=0A=
+=0A=
+=0A=
+#define	SARDEV(atmdev)	((atmsar_dev_t*)((atmdev)->dev_data))=0A=
+#define	SARVCC(atmvcc)	((atmsar_vcc_t*)((atmvcc)->dev_data))=0A=
+=0A=
+#define	ASAR_MSG	"ATMSAR if#%d: "=0A=
+=0A=
+#define	D(v)		printk(KERN_ALERT "AtmSar: checkpoint " v " passed\n")=0A=
+=0A=
+#define	VPIVCI(vpi, vci)	(	\=0A=
+	(((vpi)<<ATM_HDR_VPI_SHIFT)&ATM_HDR_VPI_MASK) |	\=0A=
+	(((vci)<<ATM_HDR_VCI_SHIFT)&ATM_HDR_VCI_MASK)	\=0A=
+)=0A=
+=0A=
+=0A=
+typedef enum _HECSTS    {=0A=
+        HS_OK           =3D 0,=0A=
+        HS_CORRECTED,=0A=
+        HS_UNCORRECTIBLE=0A=
+}       HECSTS;=0A=
+=0A=
+=0A=
+#define	SRCSKB(skb)	(*(struct sk_buff**)(skb)->cb)=0A=
+=0A=
+=0A=
+extern const atmsar_aalops_t	opsAALR;=0A=
+extern const atmsar_aalops_t	opsAAL0;=0A=
+extern const atmsar_aalops_t	opsAAL5;=0A=
+static const atmsar_aalops_t*	aOps[] =3D {=0A=
+	&opsAALR,=0A=
+	&opsAAL0,=0A=
+	&opsAAL5,=0A=
+	NULL=0A=
+};=0A=
+=0A=
+=0A=
+static int	chbad =3D 0;=0A=
+=0A=
+module_param(chbad, bool, 0444);=0A=
+MODULE_PARM_DESC(=0A=
+	chbad,=0A=
+	"Treat cells having a correctible header as bad (default=3Dno)"=0A=
+);=0A=
+=0A=
+=0A=
+#if	0=0A=
+// This is still to be done=0A=
+static int	stats =3D 0;=0A=
+=0A=
+module_param(stats, bool, 0444);=0A=
+MODULE_PARM_DESC(=0A=
+	stats,=0A=
+	"Waste a bit of cpu to maintain useful statistical data"=0A=
+);=0A=
+#endif=0A=
+=0A=
+=0A=
+static const unsigned char tabSyn[256] =3D {=0A=
+	0x00,	0x07,	0x0e,	0x09,	0x1c,	0x1b,	0x12,	0x15,=0A=
+	0x38,	0x3f,	0x36,	0x31,	0x24,	0x23,	0x2a,	0x2d,=0A=
+	0x70,	0x77,	0x7e,	0x79,	0x6c,	0x6b,	0x62,	0x65,=0A=
+	0x48,	0x4f,	0x46,	0x41,	0x54,	0x53,	0x5a,	0x5d,=0A=
+	0xe0,	0xe7,	0xee,	0xe9,	0xfc,	0xfb,	0xf2,	0xf5,=0A=
+	0xd8,	0xdf,	0xd6,	0xd1,	0xc4,	0xc3,	0xca,	0xcd,=0A=
+	0x90,	0x97,	0x9e,	0x99,	0x8c,	0x8b,	0x82,	0x85,=0A=
+	0xa8,	0xaf,	0xa6,	0xa1,	0xb4,	0xb3,	0xba,	0xbd,=0A=
+=0A=
+	0xc7,	0xc0,	0xc9,	0xce,	0xdb,	0xdc,	0xd5,	0xd2,=0A=
+	0xff,	0xf8,	0xf1,	0xf6,	0xe3,	0xe4,	0xed,	0xea,=0A=
+	0xb7,	0xb0,	0xb9,	0xbe,	0xab,	0xac,	0xa5,	0xa2,=0A=
+	0x8f,	0x88,	0x81,	0x86,	0x93,	0x94,	0x9d,	0x9a,=0A=
+	0x27,	0x20,	0x29,	0x2e,	0x3b,	0x3c,	0x35,	0x32,=0A=
+	0x1f,	0x18,	0x11,	0x16,	0x03,	0x04,	0x0d,	0x0a,=0A=
+	0x57,	0x50,	0x59,	0x5e,	0x4b,	0x4c,	0x45,	0x42,=0A=
+	0x6f,	0x68,	0x61,	0x66,	0x73,	0x74,	0x7d,	0x7a,=0A=
+=0A=
+	0x89,	0x8e,	0x87,	0x80,	0x95,	0x92,	0x9b,	0x9c,=0A=
+	0xb1,	0xb6,	0xbf,	0xb8,	0xad,	0xaa,	0xa3,	0xa4,=0A=
+	0xf9,	0xfe,	0xf7,	0xf0,	0xe5,	0xe2,	0xeb,	0xec,=0A=
+	0xc1,	0xc6,	0xcf,	0xc8,	0xdd,	0xda,	0xd3,	0xd4,=0A=
+	0x69,	0x6e,	0x67,	0x60,	0x75,	0x72,	0x7b,	0x7c,=0A=
+	0x51,	0x56,	0x5f,	0x58,	0x4d,	0x4a,	0x43,	0x44,=0A=
+	0x19,	0x1e,	0x17,	0x10,	0x05,	0x02,	0x0b,	0x0c,=0A=
+	0x21,	0x26,	0x2f,	0x28,	0x3d,	0x3a,	0x33,	0x34,=0A=
+=0A=
+	0x4e,	0x49,	0x40,	0x47,	0x52,	0x55,	0x5c,	0x5b,=0A=
+	0x76,	0x71,	0x78,	0x7f,	0x6a,	0x6d,	0x64,	0x63,=0A=
+	0x3e,	0x39,	0x30,	0x37,	0x22,	0x25,	0x2c,	0x2b,=0A=
+	0x06,	0x01,	0x08,	0x0f,	0x1a,	0x1d,	0x14,	0x13,=0A=
+	0xae,	0xa9,	0xa0,	0xa7,	0xb2,	0xb5,	0xbc,	0xbb,=0A=
+	0x96,	0x91,	0x98,	0x9f,	0x8a,	0x8d,	0x84,	0x83,=0A=
+	0xde,	0xd9,	0xd0,	0xd7,	0xc2,	0xc5,	0xcc,	0xcb,=0A=
+	0xe6,	0xe1,	0xe8,	0xef,	0xfa,	0xfd,	0xf4,	0xf3=0A=
+};=0A=
+=0A=
+#define	COSET_LEADER	0x55=0A=
+=0A=
+=0A=
+#if     defined(__i386__) || defined(__x86_64__)=0A=
+static unsigned char inline	hecCompute(const unsigned char* hdr) {=0A=
+	register unsigned char hec;=0A=
+=0A=
+        __asm__ (=0A=
+                "\=0A=
+			movl (%%edx), %%ecx;\n\=0A=
+			movb %%cl, %%al; shrl $8, %%ecx; xlatb\n\=0A=
+			xorb %%cl, %%al; shrl $8, %%ecx; xlatb\n\=0A=
+			xorb %%cl, %%al; shrl $8, %%ecx; xlatb\n\=0A=
+			xorb %%cl, %%al;		 xlatb\n\=0A=
+			xorb $0x55, %%al\n\=0A=
+                "=0A=
+        :=0A=
+		"=3Da" (hec)=0A=
+	:=0A=
+                "b" (tabSyn),=0A=
+                "d" (hdr)=0A=
+        :=0A=
+		"ecx"=0A=
+        );=0A=
+=0A=
+	return(hec);=0A=
+}=0A=
+#else=0A=
+static unsigned char inline	hecCompute(const unsigned char* hdr) {=0A=
+	register unsigned char hec;=0A=
+=0A=
+	hec =3D tabSyn[*hdr++];=0A=
+	hec =3D tabSyn[hec ^ (*hdr++)];=0A=
+	hec =3D tabSyn[hec ^ (*hdr++)];=0A=
+	hec =3D tabSyn[hec ^ *hdr];=0A=
+	return(hec ^ COSET_LEADER);=0A=
+}=0A=
+#endif=0A=
+=0A=
+static void inline	hecGenerate(unsigned char* hdr)=0A=
+{ hdr[4] =3D hecCompute(hdr); }=0A=
+=0A=
+=0A=
+#define	SYN_OK	0xff=0A=
+#define	SYN_ER	0x80=0A=
+=0A=
+static const unsigned char tabPos[256] =3D {=0A=
+	SYN_OK,	    39,	    38,	SYN_ER,	    37,	SYN_ER,	SYN_ER,	    31,=0A=
+	    36,	SYN_ER,	SYN_ER,	     8,	SYN_ER,	SYN_ER,	    30,	SYN_ER,=0A=
+	    35,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	    23,	     7,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	    29,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	    34,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	    22,	SYN_ER,	     6,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	     0,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	    28,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+=0A=
+	    33,	SYN_ER,	SYN_ER,	    10,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	    12,	SYN_ER,	SYN_ER,	    21,	SYN_ER,	SYN_ER,	    19,=0A=
+	     5,	SYN_ER,	SYN_ER,	    17,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	     3,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	    15,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	    27,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+=0A=
+	    32,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	     9,	SYN_ER,=0A=
+	SYN_ER,	    24,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	     1,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	    11,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	    20,	SYN_ER,	SYN_ER,	    13,	SYN_ER,	SYN_ER,	    18,	SYN_ER,=0A=
+	     4,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	    16,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	    25,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	     2,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	    14,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	    26,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,=0A=
+	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER,	SYN_ER=0A=
+};=0A=
+=0A=
+=0A=
+static void		putHdrNoHec(struct sk_buff* skb, unsigned hdr)=0A=
+{ *(unsigned*)skb_put(skb, sizeof(hdr)) =3D htonl(hdr); }=0A=
+=0A=
+static void		putHdrWithHec(struct sk_buff* skb, unsigned hdr) {=0A=
+	unsigned char* buf =3D skb_put(skb, sizeof(hdr) + 1);=0A=
+=0A=
+	*(unsigned*)buf =3D htonl(hdr);=0A=
+	hecGenerate(buf);=0A=
+}=0A=
+=0A=
+=0A=
+static void inline	txSkbFree(struct sk_buff *skbSrc) {=0A=
+	struct atm_vcc *vcc =3D ATM_SKB(skbSrc)->vcc;=0A=
+	if(vcc !=3D NULL && vcc->pop !=3D NULL)=0A=
+		vcc->pop(vcc, skbSrc);=0A=
+	else=0A=
+		kfree_skb(skbSrc);=0A=
+}=0A=
+=0A=
+=0A=
+#if	defined(ATM_SAR_DBG)=0A=
+static void inline	dumpCell(char* dst, const ATM_CELL* cell) {=0A=
+	const unsigned char *src =3D (unsigned char*)cell;=0A=
+	int n;=0A=
+	for(n =3D 52; --n >=3D 0; dst +=3D 2)=0A=
+		sprintf(dst, "%02x", *src++);=0A=
+}=0A=
+#endif=0A=
+=0A=
+static int	atmProcRead(struct atm_dev *atmdev, loff_t *pos, char *page) =
{=0A=
+	atmsar_dev_t* dev =3D SARDEV(atmdev);=0A=
+	loff_t skip =3D *pos;=0A=
+=0A=
+	if(skip-- =3D=3D 0)=0A=
+		return(sprintf(page, "sarver:\t" VERSION "\n"));=0A=
+=0A=
+	if(skip-- =3D=3D 0) {=0A=
+		strcpy(page, "signal:\t");=0A=
+		switch(atmdev->signal) {=0A=
+		case ATM_PHY_SIG_LOST:=0A=
+			strcat(page, "down\n");=0A=
+			break;=0A=
+=0A=
+		case ATM_PHY_SIG_FOUND:=0A=
+			strcat(page, "synched\n");=0A=
+			break;=0A=
+=0A=
+		default:=0A=
+			strcat(page, "unknown\n");=0A=
+			break;=0A=
+		}=0A=
+=0A=
+		return(strlen(page));=0A=
+	}=0A=
+=0A=
+	if(skip-- =3D=3D 0) {=0A=
+		strcpy(page, "dnrate:\t");=0A=
+		if(dev->rx_speed !=3D ATMSAR_SPEED_UNSPEC)=0A=
+			sprintf(=0A=
+				&page[strlen(page)],=0A=
+				"%ld kbps\n",=0A=
+				dev->rx_speed=0A=
+			);=0A=
+		else=0A=
+			strcat(page, "unknown\n");=0A=
+		return(strlen(page));=0A=
+	}=0A=
+=0A=
+	if(skip-- =3D=3D 0) {=0A=
+		strcpy(page, "uprate:\t");=0A=
+		if(dev->tx_speed !=3D ATMSAR_SPEED_UNSPEC)=0A=
+			sprintf(=0A=
+				&page[strlen(page)],=0A=
+				"%ld kbps\n",=0A=
+				dev->tx_speed=0A=
+			);=0A=
+		else=0A=
+			strcat(page, "unknown\n");=0A=
+		return(strlen(page));=0A=
+	}=0A=
+=0A=
+#if	defined(ATM_SAR_DBG)=0A=
+	if(skip-- =3D=3D 0) {=0A=
+		strcpy(page, " rxlst:\t");=0A=
+		dumpCell(&page[strlen(page)], &dev->cellLastRx);=0A=
+		strcat(page, "\n");=0A=
+		return(strlen(page));=0A=
+	}=0A=
+=0A=
+	if(skip-- =3D=3D 0) {=0A=
+		strcpy(page, " txlst:\t");=0A=
+		dumpCell(&page[strlen(page)], &dev->cellLastTx);=0A=
+		strcat(page, "\n");=0A=
+		return(strlen(page));=0A=
+	}=0A=
+#endif=0A=
+=0A=
+	if(skip-- =3D=3D 0)=0A=
+		return(sprintf(page, "  vccs:\t%d\n", dev->vccs_count));=0A=
+=0A=
+	if(dev->ops->proc_read !=3D NULL)=0A=
+		return(dev->ops->proc_read(dev, &skip, page));=0A=
+=0A=
+	return(0);=0A=
+}=0A=
+=0A=
+static int	atmIOCtl(struct atm_dev *atmdev, unsigned int cmd, void =
__user *arg) {=0A=
+	atmsar_dev_t *dev =3D SARDEV(atmdev);=0A=
+	if(dev->ops->ioctl !=3D NULL)=0A=
+		return(dev->ops->ioctl(dev, cmd, arg));=0A=
+=0A=
+	return(-EINVAL);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * __atmSend - Sends a packet out from our device=0A=
+ * @vcc:	the atm_vcc from which the send had been invoked=0A=
+ * @skb:	the data to be sent, formatted according to the vcc AAL=0A=
+ *=0A=
+ * atmSend is our implementation of the atm_vcc's send op.=0A=
+ *=0A=
+ * The ATM code invokes this function during process context, but it =
seems=0A=
+ * we are not supposed to use schedule() to pace the transmission.=0A=
+ * What we do is to create a further skb which will contain the AAL0 =
(raw)=0A=
+ * version of the skb sent to us, as well as a pointer to the original=0A=
+ * skb. When data will be delivered out of the device, the original skb=0A=
+ * will be released. This way, the sock implementation of the ATM code=0A=
+ * will (should?) take care of tx pacing and such.=0A=
+ */=0A=
+static int	atmSend(struct atm_vcc* vcc, struct sk_buff* skbSrc) {=0A=
+	atmsar_vcc_t* sar =3D SARVCC(vcc);=0A=
+	atmsar_dev_t* dev =3D SARDEV(vcc->dev);=0A=
+	int ecode;=0A=
+=0A=
+	if(dev->atmdev->signal =3D=3D ATM_PHY_SIG_FOUND) {=0A=
+		ecode =3D sar->ops->encodeGetCellCount(sar, skbSrc);=0A=
+		if(ecode > 0) {=0A=
+			struct sk_buff *skb =3D alloc_skb(=0A=
+				dev->tx_head_reserve=0A=
+				+ ecode*dev->tx_cell_size=0A=
+				+ dev->tx_tail_reserve,=0A=
+				GFP_ATOMIC=0A=
+			);=0A=
+			if(skb !=3D NULL) {=0A=
+				// Attaches source skb=0A=
+				SRCSKB(skb) =3D skbSrc;=0A=
+=0A=
+				// Reserve header space=0A=
+				skb_reserve(skb, dev->tx_head_reserve);=0A=
+=0A=
+				// Encode packet into cells=0A=
+				sar->ops->encode(=0A=
+					skb,=0A=
+					(dev->flags&ATMSAR_FLG_53BYTE_CELL) ?=0A=
+						putHdrWithHec=0A=
+					:=0A=
+						putHdrNoHec,=0A=
+					sar,=0A=
+					skbSrc=0A=
+				);=0A=
+=0A=
+				// Queue it up=0A=
+				if(dev->ops->tx_restart !=3D NULL) {=0A=
+					unsigned long sts;=0A=
+					int needsTxWakeup;=0A=
+=0A=
+					spin_lock_irqsave(=0A=
+						&dev->skq_tx.lock,=0A=
+						sts=0A=
+					);=0A=
+					needsTxWakeup =3D skb_queue_empty(=0A=
+						&dev->skq_tx=0A=
+					);=0A=
+					__skb_queue_tail(&dev->skq_tx, skb);=0A=
+					spin_unlock_irqrestore(=0A=
+						&dev->skq_tx.lock,=0A=
+						sts=0A=
+					);=0A=
+=0A=
+					// Restart tx if needed=0A=
+					if(needsTxWakeup)=0A=
+						dev->ops->tx_restart(dev);=0A=
+				} else=0A=
+					skb_queue_tail(&dev->skq_tx, skb);=0A=
+=0A=
+				// Done with it=0A=
+				return(0);=0A=
+			} else=0A=
+				// No more memory=0A=
+				ecode =3D -ENOMEM;=0A=
+		}=0A=
+=0A=
+		// Is it right to report this?=0A=
+		atomic_inc(&vcc->stats->tx_err);=0A=
+	} else=0A=
+		// Well, few ideas...=0A=
+		// We refuse the packet giving back an ENOLINK.=0A=
+		// Is it wrong? What are we supposed to do?=0A=
+		ecode =3D -ENOLINK;=0A=
+=0A=
+=0A=
+	txSkbFree(skbSrc);=0A=
+	return(ecode);=0A=
+}=0A=
+=0A=
+=0A=
+static inline int	ocMutexTry(atmsar_dev_t* dev) {=0A=
+	if(atomic_dec_and_test(&dev->mtx_openclose))=0A=
+		// Mutex acquired!=0A=
+		return(1);=0A=
+=0A=
+	// Mutex acquired by someone else. Release=0A=
+	// our attempt and fail try.=0A=
+	atomic_inc(&dev->mtx_openclose);=0A=
+	return(0);=0A=
+}=0A=
+=0A=
+=0A=
+static inline atmsar_vcc_t**	GetSARPtr(atmsar_dev_t* dev, unsigned =
vpivci) {=0A=
+	atmsar_vcc_t **psar;=0A=
+	for(=0A=
+		psar =3D &dev->vccs_hash[vpivci%ATMSAR_N_HASHVCCS];=0A=
+		*psar !=3D NULL && (*psar)->vpivci !=3D vpivci;=0A=
+		psar =3D &(*psar)->next=0A=
+	);=0A=
+=0A=
+	return(psar);=0A=
+}=0A=
+=0A=
+=0A=
+static void	atmClose(struct atm_vcc *vcc) {=0A=
+	atmsar_dev_t *dev =3D SARDEV(vcc->dev);=0A=
+	const unsigned vpivci =3D VPIVCI(vcc->vpi, vcc->vci);=0A=
+	atmsar_vcc_t **psar;=0A=
+=0A=
+	clear_bit(ATM_VF_READY, &vcc->flags);=0A=
+=0A=
+	// Wait for Open/Close mutex acquisition=0A=
+	wait_event(dev->wqh_openclose, ocMutexTry(dev));=0A=
+=0A=
+	psar =3D GetSARPtr(dev, vpivci);=0A=
+	if(unlikely(*psar =3D=3D NULL))=0A=
+		// We have no sar pointer for this vcc, so this vcc wasn't=0A=
+		// opened with us or it had been already closed.=0A=
+		printk(=0A=
+			KERN_ERR=0A=
+			ASAR_MSG "atm close on an unknown vpi/vci (%d/%d)\n",=0A=
+			dev->atmdev->number,=0A=
+			vcc->vpi, vcc->vci=0A=
+		);=0A=
+	else if(unlikely((*psar)->vcc !=3D vcc))=0A=
+		// The vcc we know being assigned to this vpi/vci pair is=0A=
+		// not the one for which a close has been asked.=0A=
+		// This is quite a weird error, since the atm layer should=0A=
+		// ensure vcc uniqueness on vpi/vci...=0A=
+		printk(=0A=
+			KERN_ERR=0A=
+			ASAR_MSG "atm close on an unmatched vpi/vci (%d/%d)\n",=0A=
+			dev->atmdev->number,=0A=
+			vcc->vpi, vcc->vci=0A=
+		);=0A=
+	else {=0A=
+		atmsar_vcc_t *sar =3D *psar;=0A=
+		unsigned long sts;=0A=
+		int lastClose;=0A=
+=0A=
+		write_lock_irqsave(&dev->rwl_vccs, sts);=0A=
+		*psar =3D sar->next;=0A=
+		lastClose =3D (--dev->vccs_count =3D=3D 0);=0A=
+		write_unlock_irqrestore(&dev->rwl_vccs, sts);=0A=
+=0A=
+		sar->ops->end(sar);=0A=
+		kfree(sar);=0A=
+		if(lastClose && dev->ops->last_close !=3D NULL)=0A=
+			// Last close.=0A=
+			// There is no spinlock hold and local irqs are in=0A=
+			// normal shape, so our client may schedule() and do=0A=
+			// (almost) whatever he/she wants...=0A=
+			dev->ops->last_close(dev);=0A=
+	}=0A=
+=0A=
+	clear_bit(ATM_VF_ADDR, &vcc->flags);=0A=
+=0A=
+	// Yield control to next open/close function=0A=
+	atomic_inc(&dev->mtx_openclose);=0A=
+	wake_up(&dev->wqh_openclose);=0A=
+}=0A=
+=0A=
+=0A=
+static inline int	__atmOpen(atmsar_dev_t* dev, struct atm_vcc* vcc) {=0A=
+	const atmsar_aalops_t** ops;=0A=
+	int ecode;=0A=
+=0A=
+	for(ops =3D aOps; *ops !=3D NULL && (*ops)->aal !=3D vcc->qos.aal; =
++ops);=0A=
+	if(*ops =3D=3D NULL)=0A=
+		// We don't handle this aal, yet...=0A=
+		ecode =3D -ENOTSUPP;=0A=
+	else if(vcc->vpi =3D=3D ATM_VPI_UNSPEC || vcc->vci =3D=3D =
ATM_VCI_UNSPEC)=0A=
+		// We need an address to be spec.=0A=
+		ecode =3D -EDESTADDRREQ;=0A=
+	else {=0A=
+		const unsigned vpivci =3D VPIVCI(vcc->vpi, vcc->vci);=0A=
+		atmsar_vcc_t **psar =3D GetSARPtr(dev, vpivci);=0A=
+=0A=
+		if(*psar =3D=3D NULL) {=0A=
+			atmsar_vcc_t *sar =3D (*ops)->init(vcc);=0A=
+			if(sar !=3D NULL) {=0A=
+				// There is no spinlock hold and local irqs are=0A=
+				// in normal shape, so our client may schedule()=0A=
+				// and do (almost) whatever it wants...=0A=
+				if(=0A=
+					dev->vccs_count !=3D 0		||=0A=
+					dev->ops->first_open =3D=3D NULL	||=0A=
+					(ecode =3D dev->ops->first_open(dev)) >=3D 0=0A=
+				) {=0A=
+					unsigned long sts;=0A=
+=0A=
+					sar->vpivci	=3D vpivci;=0A=
+=0A=
+					sar->dev	=3D dev;=0A=
+					sar->vcc	=3D vcc;=0A=
+					sar->ops	=3D *ops;=0A=
+=0A=
+					write_lock_irqsave(&dev->rwl_vccs, sts);=0A=
+					sar->next	=3D *psar;=0A=
+					*psar		=3D sar;=0A=
+					++dev->vccs_count;=0A=
+					write_unlock_irqrestore(=0A=
+						&dev->rwl_vccs,=0A=
+						sts=0A=
+					);=0A=
+=0A=
+					vcc->dev_data	=3D sar;=0A=
+=0A=
+					// Soldout!=0A=
+					set_bit(ATM_VF_ADDR,	&vcc->flags);=0A=
+					set_bit(ATM_VF_READY,	&vcc->flags);=0A=
+					return(0);=0A=
+				}=0A=
+=0A=
+				(*ops)->end(sar);=0A=
+				kfree(sar);=0A=
+			} else=0A=
+				// Most possible cause.=0A=
+				ecode =3D -ENOMEM;=0A=
+		} else=0A=
+			// VPI/VCI already present. This case shouln't be, since=0A=
+			// the atm layer handles this for us. Anyway...=0A=
+			ecode =3D -EADDRINUSE;=0A=
+	}=0A=
+=0A=
+	return(ecode);=0A=
+}	=0A=
+=0A=
+static int atmOpen(struct atm_vcc *vcc) {=0A=
+	atmsar_dev_t *dev =3D SARDEV(vcc->dev);=0A=
+	int ecode;=0A=
+=0A=
+	// Wait for Open/Close mutex acquisition=0A=
+	wait_event(dev->wqh_openclose, ocMutexTry(dev));=0A=
+=0A=
+	// Invoke the "true" open=0A=
+	ecode =3D __atmOpen(dev, vcc);=0A=
+=0A=
+	// Yield control to next open/close function=0A=
+	atomic_inc(&dev->mtx_openclose);=0A=
+	wake_up(&dev->wqh_openclose);=0A=
+=0A=
+	return(ecode);=0A=
+}	=0A=
+=0A=
+=0A=
+static const struct atmdev_ops	atmops =3D {=0A=
+	.owner	=3D THIS_MODULE,=0A=
+=0A=
+	.open	=3D atmOpen,=0A=
+	.close	=3D atmClose,=0A=
+	.send	=3D atmSend,=0A=
+	.ioctl	=3D atmIOCtl,=0A=
+=0A=
+	.proc_read =3D atmProcRead=0A=
+};=0A=
+=0A=
+=0A=
+void			atmsar_tx_skb_complete(struct sk_buff *skb) {=0A=
+	struct sk_buff* skbSrc =3D SRCSKB(skb);=0A=
+=0A=
+	atomic_inc(&ATM_SKB(skbSrc)->vcc->stats->tx);=0A=
+=0A=
+	txSkbFree(skbSrc);=0A=
+	kfree_skb(skb);=0A=
+}=0A=
+=0A=
+void			atmsar_tx_skb_discard(struct sk_buff *skb) {=0A=
+	struct sk_buff* skbSrc =3D SRCSKB(skb);=0A=
+=0A=
+	atomic_inc(&ATM_SKB(skbSrc)->vcc->stats->tx_err);=0A=
+=0A=
+	txSkbFree(skbSrc);=0A=
+	kfree_skb(skb);=0A=
+}=0A=
+=0A=
+void			atmsar_tx_purge(atmsar_dev_t* dev) {=0A=
+	struct sk_buff *skb;=0A=
+	unsigned long sts;=0A=
+=0A=
+	spin_lock_irqsave(&dev->skq_tx.lock, sts);=0A=
+	while((skb =3D __skb_dequeue(&dev->skq_tx)) !=3D NULL)=0A=
+		atmsar_tx_skb_discard(skb);=0A=
+	spin_unlock_irqrestore(&dev->skq_tx.lock, sts);=0A=
+}=0A=
+=0A=
+=0A=
+void		atmsar_rx_purge(atmsar_dev_t *dev) {=0A=
+	int i;=0A=
+	unsigned long sts;=0A=
+=0A=
+	read_lock_irqsave(&dev->rwl_vccs, sts);=0A=
+	for(i =3D 0; i < ATMSAR_N_HASHVCCS; ++i) {=0A=
+		atmsar_vcc_t* sar;=0A=
+		for(sar =3D dev->vccs_hash[i]; sar !=3D NULL; sar =3D sar->next)=0A=
+			sar->ops->decodeReset(sar);=0A=
+	}=0A=
+	read_unlock_irqrestore(&dev->rwl_vccs, sts);=0A=
+}=0A=
+=0A=
+static void	sarDecode(=0A=
+	atmsar_dev_t*	dev,=0A=
+	unsigned	hdr,=0A=
+	const void*	payload=0A=
+) {=0A=
+	atmsar_vcc_t*	sar;=0A=
+	unsigned long	sts;=0A=
+=0A=
+	read_lock_irqsave(&dev->rwl_vccs, sts);=0A=
+	sar =3D *GetSARPtr(dev, hdr&(ATM_HDR_VPI_MASK|ATM_HDR_VCI_MASK));=0A=
+	if(sar !=3D NULL) {=0A=
+		struct sk_buff* skb =3D sar->ops->decode(sar, hdr, payload);=0A=
+		read_unlock_irqrestore(&dev->rwl_vccs, sts);=0A=
+=0A=
+		if(skb !=3D NULL) {=0A=
+			// We got a (reassembled) packet.=0A=
+			if(likely(atm_charge(sar->vcc, skb->truesize))) {=0A=
+				// Push it up to upper layers=0A=
+				sar->vcc->push(sar->vcc, skb);=0A=
+				atomic_inc(&sar->vcc->stats->rx);=0A=
+			} else=0A=
+				// atm_charge() increments rx_drop=0A=
+				dev_kfree_skb(skb);=0A=
+		}=0A=
+	} else=0A=
+		// An 'empty' cell (which are mostly tagged by a (0,0)=0A=
+		// (VPI,VCI), but this may be device-specific), or even=0A=
+		// a cell for an unopened vcc.=0A=
+		// We just discard it without any further notification.=0A=
+		read_unlock_irqrestore(&dev->rwl_vccs, sts);=0A=
+}=0A=
+=0A=
+void		atmsar_rx_decode_52bytes(atmsar_dev_t* dev, const void* cell)=0A=
+{ sarDecode(dev, ntohl(*(unsigned*)cell), &((char*)cell)[4]); }=0A=
+=0A=
+void		atmsar_rx_decode_53bytes(atmsar_dev_t* dev, const void* cell) {=0A=
+	const unsigned posErr =3D=0A=
+		tabPos[hecCompute(cell) ^ ((unsigned char*)cell)[4]]=0A=
+	;=0A=
+	unsigned hdr;=0A=
+=0A=
+	if(posErr =3D=3D SYN_OK)=0A=
+		hdr =3D ntohl(*(unsigned*)cell);=0A=
+	else if(posErr =3D=3D SYN_ER || !chbad) {=0A=
+		// Cell discarded due to hec error.=0A=
+		atomic_inc(&dev->atmdev->stats.aal0.rx_err);=0A=
+		return;=0A=
+	} else=0A=
+		// Correcting header error=0A=
+		hdr =3D ntohl(*(unsigned*)cell)^(0x80000000 >> (posErr%8));=0A=
+=0A=
+	// Decode!=0A=
+	sarDecode(dev, hdr, &((char*)cell)[5]);=0A=
+}=0A=
+=0A=
+void		atmsar_rx_decode_53bytes_skiphec(=0A=
+	atmsar_dev_t*	dev,=0A=
+	const void*	cell=0A=
+) { sarDecode(dev, ntohl(*(unsigned*)cell), &((char*)cell)[5]); }=0A=
+=0A=
+=0A=
+void		atmsar_dev_deregister(atmsar_dev_t *dev) {=0A=
+	int i;=0A=
+=0A=
+	atm_dev_deregister(dev->atmdev);=0A=
+=0A=
+	for(i =3D 0; i < ATMSAR_N_HASHVCCS; ++i)=0A=
+		while(dev->vccs_hash[i] !=3D NULL)=0A=
+			atmClose(dev->vccs_hash[i]->vcc);=0A=
+=0A=
+	kfree(dev);=0A=
+}=0A=
+=0A=
+=0A=
+static const atmsar_ops_t nullOps =3D { NULL };=0A=
+=0A=
+atmsar_dev_t*		atmsar_dev_register(=0A=
+	const char		*name,=0A=
+	const unsigned char	*esi,=0A=
+	const atmsar_ops_t	*ops,=0A=
+	const struct atmphy_ops	*phy_ops,=0A=
+	unsigned		flags,=0A=
+	size_t			tx_head_reserve,=0A=
+	size_t			tx_tail_reserve,=0A=
+	size_t			tx_cell_size=0A=
+) {=0A=
+	const size_t szCell =3D=0A=
+		(flags&ATMSAR_FLG_53BYTE_CELL) ? ATM_CELL_SIZE : ATM_AAL0_SDU=0A=
+	;=0A=
+	if(=0A=
+		(flags&~(ATMSAR_FLG_53BYTE_CELL)) =3D=3D 0	&&=0A=
+		tx_head_reserve >=3D 0			&&=0A=
+		tx_tail_reserve >=3D 0			&&=0A=
+		tx_cell_size >=3D szCell=0A=
+	) {=0A=
+		atmsar_dev_t* dev =3D kmalloc(sizeof(*dev), GFP_KERNEL);=0A=
+		if(dev !=3D NULL) {=0A=
+			memset(dev, 0, sizeof(*dev));=0A=
+=0A=
+			dev->atmdev =3D atm_dev_register(name, &atmops, -1, NULL);=0A=
+			if(dev->atmdev !=3D NULL) {=0A=
+				if(esi !=3D NULL)=0A=
+					memcpy(dev->atmdev->esi, esi, ESI_LEN);=0A=
+=0A=
+				// The 'classical' sizes for vpi/vci fields.=0A=
+				// Since we are using this module, our hardware=0A=
+				// has seldom any preference about this. This=0A=
+				// not holding, just change these fields right=0A=
+				// after your call to atmsar_dev_register()=0A=
+				dev->atmdev->ci_range.vpi_bits =3D  8;=0A=
+				dev->atmdev->ci_range.vci_bits =3D 16;=0A=
+=0A=
+				dev->atmdev->phy =3D phy_ops;=0A=
+				dev->atmdev->dev_data =3D dev;=0A=
+=0A=
+				dev->data  =3D NULL;=0A=
+				dev->flags =3D flags;=0A=
+				dev->ops   =3D ops !=3D NULL ? ops : &nullOps;=0A=
+=0A=
+				// Parameters for tx buffers adjusting=0A=
+				dev->tx_head_reserve =3D tx_head_reserve;=0A=
+				dev->tx_tail_reserve =3D tx_tail_reserve;=0A=
+				dev->tx_cell_size =3D tx_cell_size;=0A=
+				dev->tx_cell_gap  =3D tx_cell_size - szCell;=0A=
+=0A=
+				memset(dev->vccs_hash, 0, sizeof(dev->vccs_hash));=0A=
+				dev->rwl_vccs =3D RW_LOCK_UNLOCKED;=0A=
+=0A=
+				atomic_set(&dev->mtx_openclose, 1);=0A=
+				init_waitqueue_head(&dev->wqh_openclose);=0A=
+=0A=
+				skb_queue_head_init(&dev->skq_tx);=0A=
+=0A=
+				dev->rx_speed =3D ATMSAR_SPEED_UNSPEC;=0A=
+				dev->tx_speed =3D ATMSAR_SPEED_UNSPEC;=0A=
+=0A=
+				// Sold out!=0A=
+				return(dev);=0A=
+			}=0A=
+=0A=
+			kfree(dev);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return(NULL);=0A=
+}=0A=
+=0A=
+=0A=
+static int __init	initModule(void) {=0A=
+	printk(KERN_INFO "ATMSAR module v." VERSION " loaded.\n");=0A=
+	return(0);=0A=
+}=0A=
+=0A=
+module_init(initModule);=0A=
+=0A=
+=0A=
+static void __exit	endModule(void)=0A=
+{ printk(KERN_INFO "ATMSAR module removed.\n"); }=0A=
+=0A=
+module_exit(endModule);=0A=
+=0A=
+=0A=
+EXPORT_SYMBOL_GPL(atmsar_tx_skb_complete);=0A=
+EXPORT_SYMBOL_GPL(atmsar_tx_skb_discard);=0A=
+EXPORT_SYMBOL_GPL(atmsar_tx_purge);=0A=
+EXPORT_SYMBOL_GPL(atmsar_rx_purge);=0A=
+EXPORT_SYMBOL_GPL(atmsar_rx_decode_52bytes);=0A=
+EXPORT_SYMBOL_GPL(atmsar_rx_decode_53bytes);=0A=
+EXPORT_SYMBOL_GPL(atmsar_rx_decode_53bytes_skiphec);=0A=
+EXPORT_SYMBOL_GPL(atmsar_dev_deregister);=0A=
+EXPORT_SYMBOL_GPL(atmsar_dev_register);=0A=
+=0A=
+MODULE_DESCRIPTION("An ATM SAR library for AAL-unaware ATM devices");=0A=
+MODULE_LICENSE("GPL");=0A=
+MODULE_AUTHOR("Giampaolo Tomassoni");=0A=
+MODULE_VERSION(VERSION);=0A=
diff -Nurd linux-2.6.13/drivers/atm/sar.h =
linux-2.6.13+atmsar/drivers/atm/sar.h=0A=
--- linux-2.6.13/drivers/atm/sar.h	1970-01-01 01:00:00.000000000 +0100=0A=
+++ linux-2.6.13+atmsar/drivers/atm/sar.h	2005-09-04 12:08:25.000000000 =
+0200=0A=
@@ -0,0 +1,81 @@=0A=
+/* ATM SAR layer=0A=
+ *=0A=
+ * Copyright (C) 2005 Giampaolo Tomassoni=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA=0A=
+ *=0A=
+ * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian=0A=
+ * system and in the file COPYING in the Linux kernel source.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * CREDITS go to the following people:=0A=
+ *=0A=
+ * - Johan Verrept, for its previous work on a SAR library in Linux;=0A=
+ * - Charles Michael Heard for its tutorial on CRC-8 Error Correction.=0A=
+ * - Chas Williams for its help in integrating this with the ATM module.=0A=
+ *=0A=
+ *=0A=
+ * Theory of operation and api description in include/linux/atmsar.h=0A=
+ */=0A=
+#if	!defined(_SAR_H__INCLUDED)=0A=
+#define	_SAR_H__INCLUDED=0A=
+=0A=
+=0A=
+#define	SZAALENCODESTS	32=0A=
+=0A=
+struct	atmsar_vcc_base	{=0A=
+	struct atmsar_vcc_base	*next;=0A=
+	unsigned		vpivci;=0A=
+=0A=
+	atmsar_dev_t		*dev;=0A=
+	struct atm_vcc		*vcc;=0A=
+	const atmsar_aalops_t	*ops;=0A=
+};=0A=
+=0A=
+typedef	void		SARPUTHDR(struct sk_buff* skb, unsigned hdr);=0A=
+=0A=
+typedef	atmsar_vcc_t*	AALINIT(struct atm_vcc* vcc);=0A=
+typedef	void		AALEND(atmsar_vcc_t* sar);=0A=
+typedef void		AALDECODERRESET(atmsar_vcc_t* sar);=0A=
+typedef struct sk_buff*	AALDECODER(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	unsigned	hdr,=0A=
+	const void*	payload=0A=
+);=0A=
+typedef int     	AALENCODERGCC(atmsar_vcc_t* sar, struct sk_buff* =
skbIn);=0A=
+typedef void		AALENCODER(=0A=
+	struct sk_buff*	skbOut,=0A=
+	SARPUTHDR*	putHdr,=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+);=0A=
+=0A=
+struct	atmsar_aalops	{=0A=
+	unsigned char	aal;=0A=
+=0A=
+	char*		name;=0A=
+=0A=
+	AALINIT*	init;=0A=
+	AALEND*		end;=0A=
+=0A=
+	AALDECODERRESET* decodeReset;=0A=
+	AALDECODER*	decode;=0A=
+=0A=
+	AALENCODERGCC*	encodeGetCellCount;=0A=
+	AALENCODER*	encode;=0A=
+};=0A=
+=0A=
+#endif	// defined(_SAR_H__INCLUDED)=0A=
diff -Nurd linux-2.6.13/drivers/atm/saraal0.c =
linux-2.6.13+atmsar/drivers/atm/saraal0.c=0A=
--- linux-2.6.13/drivers/atm/saraal0.c	1970-01-01 01:00:00.000000000 =
+0100=0A=
+++ linux-2.6.13+atmsar/drivers/atm/saraal0.c	2005-09-04 =
12:34:36.000000000 +0200=0A=
@@ -0,0 +1,148 @@=0A=
+/* ATM SAR layer=0A=
+ *=0A=
+ * Copyright (C) 2005 Giampaolo Tomassoni=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA=0A=
+ *=0A=
+ * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian=0A=
+ * system and in the file COPYING in the Linux kernel source.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * CREDITS go to the following people:=0A=
+ *=0A=
+ * - Johan Verrept, for its previous work on a SAR library in Linux;=0A=
+ * - Charles Michael Heard for its tutorial on CRC-8 Error Correction.=0A=
+ * - Chas Williams for its help in integrating this with the ATM module.=0A=
+ *=0A=
+ *=0A=
+ * Theory of operation and api description in include/linux/atmsar.h=0A=
+ */=0A=
+#include <linux/version.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/moduleparam.h>=0A=
+#include <linux/gfp.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/wait.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/skbuff.h>=0A=
+#include <linux/atm.h>=0A=
+#include <linux/atmdev.h>=0A=
+=0A=
+#include <linux/atmsar.h>=0A=
+#include "sar.h"=0A=
+=0A=
+=0A=
+static int	aal0EncodeGetCellCount(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+) {=0A=
+	atomic_inc(&sar->vcc->stats->tx);=0A=
+	return((skbIn->len + ATM_CELL_PAYLOAD - 1)/ATM_CELL_PAYLOAD);=0A=
+}=0A=
+=0A=
+static void	aal0Encode(=0A=
+	struct sk_buff*	skbOut,=0A=
+	SARPUTHDR*	putHdr,=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+) {=0A=
+	size_t len =3D skbIn->len;=0A=
+	unsigned hdr =3D sar->vpivci;=0A=
+=0A=
+	if(len =3D=3D 0) {=0A=
+		putHdr(skbOut, hdr|(ATM_PTI_US1|ATM_HDR_PTI_SHIFT));=0A=
+		memset(skb_put(skbOut, ATM_CELL_PAYLOAD), 0, ATM_CELL_PAYLOAD);=0A=
+	} else {=0A=
+		unsigned char* payload;=0A=
+=0A=
+		do {=0A=
+			if(len > ATM_CELL_PAYLOAD)=0A=
+				len =3D ATM_CELL_PAYLOAD;=0A=
+			else=0A=
+				hdr |=3D ATM_PTI_US1<<ATM_HDR_PTI_SHIFT;=0A=
+=0A=
+			putHdr(skbOut, hdr);=0A=
+=0A=
+			payload =3D skb_put(skbOut, ATM_CELL_PAYLOAD);=0A=
+=0A=
+			if(sar->dev->tx_cell_gap !=3D 0)=0A=
+				memset(=0A=
+					skb_put(skbOut, sar->dev->tx_cell_gap),=0A=
+					0,=0A=
+					sar->dev->tx_cell_gap=0A=
+				);=0A=
+=0A=
+			if(len > 0)=0A=
+				memcpy(payload, skb_pull(skbIn, len), len);=0A=
+=0A=
+			len =3D skbIn->len;=0A=
+		} while(len !=3D 0);=0A=
+=0A=
+		if(len < ATM_CELL_PAYLOAD)=0A=
+			memset(&payload[len], 0, ATM_CELL_PAYLOAD - len);=0A=
+	}=0A=
+}=0A=
+=0A=
+=0A=
+static void	aal0DecodeReset(atmsar_vcc_t* sar)=0A=
+{}=0A=
+=0A=
+static struct sk_buff*	aal0Decode(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	unsigned	hdr,=0A=
+	const void*	payload=0A=
+) {=0A=
+	struct sk_buff *skb =3D dev_alloc_skb(ATM_CELL_PAYLOAD);=0A=
+	if(skb =3D=3D NULL) {=0A=
+		atomic_inc(&sar->vcc->stats->rx_drop);=0A=
+		return(NULL);=0A=
+	}=0A=
+=0A=
+	memcpy(skb_put(skb, ATM_CELL_PAYLOAD), payload, ATM_CELL_PAYLOAD);=0A=
+	atomic_inc(&sar->vcc->stats->rx);=0A=
+	return(skb);=0A=
+}=0A=
+=0A=
+=0A=
+static atmsar_vcc_t*	aal0Init(struct atm_vcc* vcc) {=0A=
+	atmsar_vcc_t* sar =3D (atmsar_vcc_t*)kmalloc(sizeof(*sar), GFP_KERNEL);=0A=
+	if(sar !=3D NULL)=0A=
+		memset(sar, 0, sizeof(*sar));=0A=
+=0A=
+	return(sar);=0A=
+}=0A=
+=0A=
+static void	aal0End(atmsar_vcc_t* sarvcc)=0A=
+{/* kfree() in atmsarmod.c */}=0A=
+=0A=
+=0A=
+const atmsar_aalops_t opsAAL0 =3D {=0A=
+	ATM_NO_AAL,=0A=
+	"0",=0A=
+=0A=
+	aal0Init,=0A=
+	aal0End,=0A=
+=0A=
+	aal0DecodeReset,=0A=
+	aal0Decode,=0A=
+=0A=
+	aal0EncodeGetCellCount,=0A=
+	aal0Encode=0A=
+};=0A=
diff -Nurd linux-2.6.13/drivers/atm/saraal5.c =
linux-2.6.13+atmsar/drivers/atm/saraal5.c=0A=
--- linux-2.6.13/drivers/atm/saraal5.c	1970-01-01 01:00:00.000000000 =
+0100=0A=
+++ linux-2.6.13+atmsar/drivers/atm/saraal5.c	2005-09-04 =
12:21:11.000000000 +0200=0A=
@@ -0,0 +1,445 @@=0A=
+/* ATM SAR layer=0A=
+ *=0A=
+ * Copyright (C) 2005 Giampaolo Tomassoni=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA=0A=
+ *=0A=
+ * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian=0A=
+ * system and in the file COPYING in the Linux kernel source.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * CREDITS go to the following people:=0A=
+ *=0A=
+ * - Johan Verrept, for its previous work on a SAR library in Linux;=0A=
+ * - Charles Michael Heard for its tutorial on CRC-8 Error Correction.=0A=
+ * - Chas Williams for its help in integrating this with the ATM module.=0A=
+ *=0A=
+ *=0A=
+ * Theory of operation and api description in include/linux/atmsar.h=0A=
+ */=0A=
+#include <linux/version.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/moduleparam.h>=0A=
+#include <linux/gfp.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/wait.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/skbuff.h>=0A=
+#include <linux/crc32.h>=0A=
+#include <linux/atm.h>=0A=
+#include <linux/atmdev.h>=0A=
+=0A=
+#include <linux/atmsar.h>=0A=
+#include "sar.h"=0A=
+=0A=
+=0A=
+/* SZ_FIRST_AAL5SDU=0A=
+ * This is the initial size of an AAL5 assembly buffer.=0A=
+ * The initial size is large enough to allow for common AAL5 SDUs, ie: =
the=0A=
+ * more-or-less 1544 bytes of an IP-Over-ATM link.=0A=
+ * If the receiving packets and the vcc MTU dictate for a greater SDU,=0A=
+ * the buffer is allowed to progressively double in size up to 64KB at =
cell=0A=
+ * reception until the SDU needs are satisfied or the vcc MTU limit is =
reached.=0A=
+ * This buffer is basicly per-vcc and is released at vcc close, so at =
any=0A=
+ * time its size is due to the largest SDU received compatible with the =
MTU.=0A=
+ */=0A=
+#define	SZ_FIRST_AAL5SDU	(2*1024)=0A=
+=0A=
+/* CRC32_REMAINDER=0A=
+ * This is the remainder 32-bit word expected to be returned by the =
crc32=0A=
+ * function on valid ATM SDU.=0A=
+ */=0A=
+#define CRC32_REMAINDER	0xc704dd7b=0A=
+=0A=
+=0A=
+typedef	struct _atmsar_vcc_t5 {=0A=
+	atmsar_vcc_t	com;=0A=
+=0A=
+	// Decoder status=0A=
+	size_t		rxMtu;	// Maximum (incoming) Transmit Unit=0A=
+	unsigned char	*rxBuf;=0A=
+	size_t		rxSize;=0A=
+	size_t		rxLen;=0A=
+	unsigned int	rxHead;=0A=
+	unsigned int	rxTail;=0A=
+=0A=
+	// Encoder status=0A=
+	size_t		txMtu;	// Maximum (outgoing) Transmit Unit=0A=
+}	atmsar_vcc_t5;=0A=
+=0A=
+=0A=
+#pragma	pack(1)=0A=
+typedef struct	_aal5pdu {=0A=
+	unsigned char	pl[ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER];=0A=
+	unsigned char	uu;=0A=
+	unsigned char	cpi;=0A=
+	unsigned short	len;=0A=
+	unsigned int	crc;=0A=
+}	aal5pdu_t;=0A=
+#pragma	pack()=0A=
+=0A=
+=0A=
+static int	aal5EncodeGetCellCount(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+) {=0A=
+	if(skbIn->len > ((atmsar_vcc_t5*)sar)->txMtu)=0A=
+		return(-EMSGSIZE);=0A=
+=0A=
+	return(=0A=
+		(skbIn->len + ATM_AAL5_TRAILER + ATM_CELL_PAYLOAD - 1)=0A=
+		/ATM_CELL_PAYLOAD=0A=
+	);=0A=
+}=0A=
+=0A=
+static void	aal5Encode(=0A=
+	struct sk_buff*	skbOut,=0A=
+	SARPUTHDR*	putHdr,=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+) {=0A=
+	const size_t tx_cell_gap =3D sar->dev->tx_cell_gap;=0A=
+	const size_t len =3D skbIn->len;=0A=
+	aal5pdu_t *pdu;=0A=
+	size_t trLen;=0A=
+	unsigned crc =3D ~0;=0A=
+=0A=
+	while(skbIn->len >=3D ATM_CELL_PAYLOAD) {=0A=
+		unsigned char* payload;=0A=
+=0A=
+		putHdr(skbOut, sar->vpivci);=0A=
+		payload =3D skb_put(skbOut, ATM_CELL_PAYLOAD);=0A=
+=0A=
+		memcpy(payload, skbIn->data, ATM_CELL_PAYLOAD);=0A=
+		crc =3D crc32_be(crc, payload, ATM_CELL_PAYLOAD);=0A=
+		skb_pull(skbIn, ATM_CELL_PAYLOAD);=0A=
+=0A=
+		if(tx_cell_gap !=3D 0)=0A=
+			memset(skb_put(skbOut, tx_cell_gap), 0, tx_cell_gap);=0A=
+	}=0A=
+=0A=
+	// Now skbIn->len is assured to be < ATM_CELL_PAYLOAD=0A=
+=0A=
+	if(skbIn->len > ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER) {=0A=
+		unsigned char* payload;=0A=
+=0A=
+		putHdr(skbOut, sar->vpivci);=0A=
+		payload =3D skb_put(skbOut, ATM_CELL_PAYLOAD);=0A=
+=0A=
+		trLen =3D skbIn->len;=0A=
+		memcpy(payload, skbIn->data, trLen);=0A=
+		memset(&payload[trLen], 0, ATM_CELL_PAYLOAD - trLen);=0A=
+		crc =3D crc32_be(crc, payload, ATM_CELL_PAYLOAD);=0A=
+		skb_pull(skbIn, trLen);=0A=
+=0A=
+		if(tx_cell_gap !=3D 0)=0A=
+			memset(skb_put(skbOut, tx_cell_gap), 0, tx_cell_gap);=0A=
+	}=0A=
+=0A=
+	putHdr(skbOut, sar->vpivci|(ATM_PTI_US1<<ATM_HDR_PTI_SHIFT));=0A=
+	pdu =3D (aal5pdu_t*)skb_put(skbOut, sizeof(*pdu));=0A=
+=0A=
+	trLen =3D skbIn->len;=0A=
+	if(trLen !=3D 0) {=0A=
+		memcpy(pdu->pl, skbIn->data, trLen);=0A=
+		skb_pull(skbIn, trLen);=0A=
+	}=0A=
+=0A=
+	if(trLen < ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER)=0A=
+		memset(&pdu->pl[trLen], 0, ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER - =
trLen);=0A=
+=0A=
+	pdu->uu =3D pdu->cpi =3D 0;=0A=
+	pdu->len =3D htons((unsigned short)len);=0A=
+	pdu->crc =3D htonl(=0A=
+		~crc32_be(crc, pdu->pl, sizeof(*pdu) - sizeof(pdu->crc))=0A=
+	);=0A=
+=0A=
+	if(tx_cell_gap !=3D 0)=0A=
+		memset(skb_put(skbOut, tx_cell_gap), 0, tx_cell_gap);=0A=
+}=0A=
+=0A=
+=0A=
+static void inline	aal5DecodeDoReset(atmsar_vcc_t5* ctx)=0A=
+{ ctx->rxLen =3D ctx->rxHead =3D ctx->rxTail =3D 0; }=0A=
+=0A=
+static void		aal5DecodeReset(atmsar_vcc_t* sar) {=0A=
+	atmsar_vcc_t5 *ctx =3D (atmsar_vcc_t5*)sar;=0A=
+	if(ctx->rxLen !=3D 0) {=0A=
+		atomic_inc(&sar->vcc->stats->rx_err);=0A=
+		aal5DecodeDoReset(ctx);=0A=
+	}=0A=
+}=0A=
+=0A=
+static struct sk_buff*	aal5Decode(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	unsigned	hdr,=0A=
+	const void*	payload=0A=
+) {=0A=
+	atmsar_vcc_t5* ctx =3D (atmsar_vcc_t5*)sar;=0A=
+=0A=
+	const unsigned pti =3D hdr&ATM_HDR_PTI_MASK;=0A=
+	if(=0A=
+		pti =3D=3D (ATM_PTI_US1<<ATM_HDR_PTI_SHIFT)	||=0A=
+		pti =3D=3D (ATM_PTI_UCES1<<ATM_HDR_PTI_SHIFT)=0A=
+	) {=0A=
+		// Last cell=0A=
+		const aal5pdu_t *pdu =3D (aal5pdu_t*)payload;=0A=
+		const size_t lenTotal =3D (size_t)ntohs(pdu->len);=0A=
+		int lenLeft =3D lenTotal;=0A=
+		int hadDiscardedCells =3D 0;=0A=
+		unsigned crc =3D ~0;=0A=
+		struct sk_buff *skb;=0A=
+=0A=
+		const int nMissingCells =3D ctx->rxLen/ATM_CELL_PAYLOAD - (=0A=
+			(lenTotal + ATM_AAL5_TRAILER + ATM_CELL_PAYLOAD - 1)=0A=
+			/ATM_CELL_PAYLOAD - 1=0A=
+		);=0A=
+		if(nMissingCells > 0) {=0A=
+			// Too few cells in buffer=0A=
+			aal5DecodeReset(sar);=0A=
+			return(NULL);=0A=
+		} else if(nMissingCells < 0) {=0A=
+			// Too many cells in buffer=0A=
+			const size_t lenDiff =3D -nMissingCells*ATM_CELL_PAYLOAD;=0A=
+			ctx->rxTail =3D (ctx->rxTail + lenDiff)%ctx->rxSize;=0A=
+			ctx->rxLen -=3D lenDiff;=0A=
+=0A=
+			hadDiscardedCells =3D 1;=0A=
+		}=0A=
+=0A=
+		// A bit of optimism: we alloc an skb right now,=0A=
+		// while SDU content is not yet validated.=0A=
+		skb =3D dev_alloc_skb(lenTotal);=0A=
+		if(skb =3D=3D NULL) {=0A=
+			// skb allocation failed=0A=
+			atomic_inc(&sar->vcc->stats->rx_drop);=0A=
+			aal5DecodeDoReset(ctx);=0A=
+			return(NULL);=0A=
+		}=0A=
+=0A=
+		// Copy SDU data from buffer=0A=
+		while(ctx->rxLen !=3D 0 && lenLeft !=3D 0) {=0A=
+			size_t len =3D ctx->rxLen;=0A=
+			if(len > ctx->rxSize - ctx->rxTail)=0A=
+				// Start with first chunk=0A=
+				len =3D ctx->rxSize - ctx->rxTail;=0A=
+			if(len > lenLeft)=0A=
+				len =3D lenLeft;=0A=
+=0A=
+			crc =3D crc32_be(=0A=
+				crc,=0A=
+				memcpy(=0A=
+					skb_put(skb, len),=0A=
+					&ctx->rxBuf[ctx->rxTail],=0A=
+					len=0A=
+				),=0A=
+				len=0A=
+			);=0A=
+=0A=
+			ctx->rxTail =3D (ctx->rxTail + len)%ctx->rxSize;=0A=
+			ctx->rxLen -=3D len;=0A=
+			lenLeft	   -=3D len;=0A=
+		}=0A=
+=0A=
+		// At this point, rxLen and lenLeft can't be both non-zero=0A=
+		if(ctx->rxLen !=3D 0)=0A=
+			// SDU end: no copy but do crc on padding.=0A=
+			// There should be only one cell left in buffer,=0A=
+			// but we can't assume rxTail will not cross=0A=
+			// buffer boundaries since the buffer size is not=0A=
+			// necessarly a multiple of a cell's payload size.=0A=
+			do {=0A=
+				size_t len =3D ctx->rxLen;=0A=
+				if(len > ctx->rxSize - ctx->rxTail)=0A=
+					len =3D ctx->rxSize - ctx->rxTail;=0A=
+=0A=
+				crc =3D crc32_be(=0A=
+					crc,=0A=
+					&ctx->rxBuf[ctx->rxTail],=0A=
+					len=0A=
+				);=0A=
+=0A=
+				ctx->rxTail =3D (ctx->rxTail + len)%ctx->rxSize;=0A=
+				ctx->rxLen -=3D len;=0A=
+			} while(ctx->rxLen !=3D 0);=0A=
+		else if(lenLeft !=3D 0)=0A=
+			// Buffer end: now copy data from PTI cell=0A=
+			crc =3D crc32_be(=0A=
+				crc,=0A=
+				memcpy(skb_put(skb, lenLeft), pdu->pl, lenLeft),=0A=
+				lenLeft=0A=
+			);=0A=
+=0A=
+		// We don't need the rx buffer anymore=0A=
+		aal5DecodeDoReset(ctx);=0A=
+=0A=
+		// Crc on padding, uu, cpi, len, and crc in PTI cell=0A=
+		crc =3D crc32_be(=0A=
+			crc,=0A=
+			&pdu->pl[lenLeft],=0A=
+			ATM_CELL_PAYLOAD - lenLeft=0A=
+		);=0A=
+=0A=
+		if(crc !=3D CRC32_REMAINDER) {=0A=
+			// SDU unreliable. Discard it!=0A=
+			dev_kfree_skb(skb);=0A=
+			atomic_inc(&sar->vcc->stats->rx_err);=0A=
+			return(NULL);=0A=
+		} else if(hadDiscardedCells)=0A=
+			// This is because we don't want to increase=0A=
+			// rx_err twice when there are discarder cells=0A=
+			// AND the SDU content isn't reliable...=0A=
+			atomic_inc(&sar->vcc->stats->rx_err);=0A=
+=0A=
+		// SDU reliable. Give it back!=0A=
+		return(skb);=0A=
+	} else {=0A=
+		// Start or middle cell=0A=
+		size_t newLen;=0A=
+=0A=
+		if(ctx->rxSize =3D=3D 0) {=0A=
+			ctx->rxBuf =3D kmalloc(SZ_FIRST_AAL5SDU, GFP_ATOMIC);=0A=
+			if(ctx->rxBuf =3D=3D NULL) {=0A=
+				atomic_inc(&sar->vcc->stats->rx_drop);=0A=
+				return(NULL);=0A=
+			}=0A=
+=0A=
+			ctx->rxSize =3D SZ_FIRST_AAL5SDU;=0A=
+		}=0A=
+=0A=
+		newLen =3D ctx->rxLen + ATM_CELL_PAYLOAD;=0A=
+ 		if(newLen > ctx->rxMtu) {=0A=
+			ctx->rxTail =3D=0A=
+				(ctx->rxTail + ATM_CELL_PAYLOAD)%ctx->rxSize=0A=
+			;=0A=
+			atomic_inc(&sar->vcc->stats->rx_err);=0A=
+		} else if(newLen > ctx->rxSize) {=0A=
+			// This case is invoked only few times (at most 5 during=0A=
+			// the whole vcc life). It is meant to increase the=0A=
+			// buffer size when a new packet arrives and the rxMtu=0A=
+			// allows for a buffer increase. Vccs should reach a=0A=
+			// stable buffer size almost early. The buffer size will=0A=
+			// be a tradeoff between speed and memory consumption.=0A=
+			// Please note that the buffer doubles its size only=0A=
+			// when packets seem to really need it. Ie: their rxMtu=0A=
+			// limit is not reached...=0A=
+			const size_t newSize =3D 2*ctx->rxSize;=0A=
+			unsigned char* oldRxBuf =3D ctx->rxBuf;=0A=
+=0A=
+			ctx->rxBuf =3D kmalloc(newSize, GFP_ATOMIC);=0A=
+			if(ctx->rxBuf =3D=3D NULL) {=0A=
+				// Undo things. We discard this cell.=0A=
+				ctx->rxBuf =3D oldRxBuf;=0A=
+=0A=
+				atomic_inc(&sar->vcc->stats->rx_drop);=0A=
+				return(NULL);=0A=
+			} else if(ctx->rxLen > 0) {=0A=
+				if(ctx->rxTail >=3D ctx->rxHead) {=0A=
+					const size_t len =3D=0A=
+						ctx->rxSize - ctx->rxTail=0A=
+					;=0A=
+=0A=
+					memcpy(=0A=
+						ctx->rxBuf,=0A=
+						&oldRxBuf[ctx->rxTail],=0A=
+						len=0A=
+					);=0A=
+					if(ctx->rxLen > len)=0A=
+						memcpy(=0A=
+							&ctx->rxBuf[len],=0A=
+							oldRxBuf,=0A=
+							ctx->rxLen - len=0A=
+						);=0A=
+				} else=0A=
+					memcpy(=0A=
+						ctx->rxBuf,=0A=
+						&oldRxBuf[ctx->rxTail],=0A=
+						ctx->rxLen=0A=
+					);=0A=
+			}=0A=
+=0A=
+			ctx->rxTail =3D 0;=0A=
+			ctx->rxHead =3D ctx->rxLen;=0A=
+			ctx->rxSize =3D newSize;=0A=
+=0A=
+			// Time to give back our quaint buffer...=0A=
+			kfree(oldRxBuf);=0A=
+		}=0A=
+=0A=
+		// Transfers received cell=0A=
+		memcpy(&ctx->rxBuf[ctx->rxHead], payload, ATM_CELL_PAYLOAD);=0A=
+		ctx->rxHead =3D (ctx->rxHead + ATM_CELL_PAYLOAD)%ctx->rxSize;=0A=
+		ctx->rxLen  =3D newLen;=0A=
+		return(NULL);=0A=
+	}=0A=
+}=0A=
+=0A=
+=0A=
+static atmsar_vcc_t*	aal5Init(struct atm_vcc* vcc) {=0A=
+	if(=0A=
+		vcc->qos.rxtp.max_sdu <=3D ATM_MAX_AAL5_PDU	&&=0A=
+		vcc->qos.txtp.max_sdu <=3D ATM_MAX_AAL5_PDU=0A=
+	) {=0A=
+		atmsar_vcc_t5 *sarvcc =3D (atmsar_vcc_t5*)kmalloc(=0A=
+			sizeof(atmsar_vcc_t5),=0A=
+			GFP_KERNEL=0A=
+		);=0A=
+		if(sarvcc !=3D NULL) {=0A=
+			memset(sarvcc, 0, sizeof(*sarvcc));=0A=
+			sarvcc->rxMtu =3D (=0A=
+				vcc->qos.rxtp.max_sdu =3D=3D 0=0A=
+			?=0A=
+				ATM_MAX_AAL5_PDU=0A=
+			:=0A=
+				vcc->qos.rxtp.max_sdu=0A=
+			);=0A=
+			sarvcc->txMtu =3D (=0A=
+				vcc->qos.txtp.max_sdu =3D=3D 0=0A=
+			?=0A=
+				ATM_MAX_AAL5_PDU=0A=
+			:=0A=
+				vcc->qos.txtp.max_sdu=0A=
+			);=0A=
+			return((atmsar_vcc_t*)sarvcc);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return(NULL);=0A=
+}=0A=
+=0A=
+static void	aal5End(atmsar_vcc_t* sarvcc) {=0A=
+	atmsar_vcc_t5* ctx =3D (atmsar_vcc_t5*)sarvcc;=0A=
+	if(ctx->rxSize !=3D 0)=0A=
+		kfree(ctx->rxBuf);=0A=
+}=0A=
+=0A=
+=0A=
+const atmsar_aalops_t opsAAL5 =3D {=0A=
+	ATM_AAL5, "5",=0A=
+=0A=
+	aal5Init,=0A=
+	aal5End,=0A=
+=0A=
+	aal5DecodeReset,=0A=
+	aal5Decode,=0A=
+=0A=
+	aal5EncodeGetCellCount,=0A=
+	aal5Encode=0A=
+};=0A=
diff -Nurd linux-2.6.13/drivers/atm/saraalr.c =
linux-2.6.13+atmsar/drivers/atm/saraalr.c=0A=
--- linux-2.6.13/drivers/atm/saraalr.c	1970-01-01 01:00:00.000000000 =
+0100=0A=
+++ linux-2.6.13+atmsar/drivers/atm/saraalr.c	2005-09-04 =
12:22:24.000000000 +0200=0A=
@@ -0,0 +1,144 @@=0A=
+/* ATM SAR layer=0A=
+ *=0A=
+ * Copyright (C) 2005 Giampaolo Tomassoni=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA=0A=
+ *=0A=
+ * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian=0A=
+ * system and in the file COPYING in the Linux kernel source.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * CREDITS go to the following people:=0A=
+ *=0A=
+ * - Johan Verrept, for its previous work on a SAR library in Linux;=0A=
+ * - Charles Michael Heard for its tutorial on CRC-8 Error Correction.=0A=
+ * - Chas Williams for its help in integrating this with the ATM module.=0A=
+ *=0A=
+ *=0A=
+ * Theory of operation and api description in include/linux/atmsar.h=0A=
+ */=0A=
+#include <linux/version.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/moduleparam.h>=0A=
+#include <linux/gfp.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/wait.h>=0A=
+#include <linux/list.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/skbuff.h>=0A=
+#include <linux/atm.h>=0A=
+#include <linux/atmdev.h>=0A=
+=0A=
+#include <linux/atmsar.h>=0A=
+#include "sar.h"=0A=
+=0A=
+=0A=
+static int	aalREncodeGetCellCount(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+) {=0A=
+	// skbIn must contain correctly-sized cells=0A=
+	if((skbIn->len%ATM_AAL0_SDU) !=3D 0) {=0A=
+		// Size is not a multiple of 52 bytes=0A=
+		atomic_inc(&sar->vcc->stats->tx_err);=0A=
+		return(-EMSGSIZE);=0A=
+	} else {=0A=
+		atomic_inc(&sar->vcc->stats->tx);=0A=
+		return(skbIn->len/ATM_AAL0_SDU);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void	aalREncode(=0A=
+	struct sk_buff*	skbOut,=0A=
+	SARPUTHDR*	putHdr,=0A=
+	atmsar_vcc_t*	sar,=0A=
+	struct sk_buff*	skbIn=0A=
+) {=0A=
+	while(skbIn->len > 0) {=0A=
+		const unsigned char* cell =3D skb_pull(skbIn, ATM_AAL0_SDU);=0A=
+=0A=
+		putHdr(skbOut, *(unsigned*)cell);=0A=
+		memcpy(=0A=
+			skb_put(skbOut, ATM_CELL_PAYLOAD),=0A=
+			&cell[4],=0A=
+			ATM_CELL_PAYLOAD=0A=
+		);=0A=
+=0A=
+		if(sar->dev->tx_cell_gap !=3D 0)=0A=
+			memset(=0A=
+				skb_put(skbOut, sar->dev->tx_cell_gap),=0A=
+				0,=0A=
+				sar->dev->tx_cell_gap=0A=
+			);=0A=
+	}=0A=
+}=0A=
+=0A=
+=0A=
+static void	aalRDecodeReset(atmsar_vcc_t* sarvcc)=0A=
+{}=0A=
+=0A=
+static struct sk_buff*	aalRDecode(=0A=
+	atmsar_vcc_t*	sar,=0A=
+	unsigned	hdr,=0A=
+	const void*	payload=0A=
+) {=0A=
+	unsigned char* buf;=0A=
+	struct sk_buff *skb =3D dev_alloc_skb(ATM_AAL0_SDU);=0A=
+	if(skb =3D=3D NULL) {=0A=
+		atomic_inc(&sar->vcc->stats->rx_drop);=0A=
+		return(NULL);=0A=
+	}=0A=
+=0A=
+	buf =3D skb_put(skb, ATM_AAL0_SDU);=0A=
+	*(unsigned*)buf =3D hdr;=0A=
+	memcpy(&buf[4], payload, ATM_CELL_PAYLOAD);=0A=
+=0A=
+	atomic_inc(&sar->vcc->stats->rx);=0A=
+	return(skb);=0A=
+}=0A=
+=0A=
+=0A=
+static atmsar_vcc_t*	aalRInit(struct atm_vcc* vcc) {=0A=
+	atmsar_vcc_t* sar =3D (atmsar_vcc_t*)kmalloc(=0A=
+		sizeof(atmsar_vcc_t),=0A=
+		GFP_KERNEL=0A=
+	);=0A=
+	if(sar !=3D NULL)=0A=
+		memset(sar, 0, sizeof(*sar));=0A=
+=0A=
+	return(sar);=0A=
+}=0A=
+=0A=
+static void	aalREnd(atmsar_vcc_t* sarvcc)=0A=
+{ /* kfree() is in atmsarmod.c */ }=0A=
+=0A=
+=0A=
+const atmsar_aalops_t opsAALR =3D {=0A=
+	ATM_AAL0,=0A=
+	"raw",=0A=
+=0A=
+	aalRInit,=0A=
+	aalREnd,=0A=
+=0A=
+	aalRDecodeReset,=0A=
+	aalRDecode,=0A=
+=0A=
+	aalREncodeGetCellCount,=0A=
+	aalREncode=0A=
+};=0A=
diff -Nurd linux-2.6.13/include/linux/atmsar.h =
linux-2.6.13+atmsar/include/linux/atmsar.h=0A=
--- linux-2.6.13/include/linux/atmsar.h	1970-01-01 01:00:00.000000000 =
+0100=0A=
+++ linux-2.6.13+atmsar/include/linux/atmsar.h	2005-09-04 =
12:25:03.000000000 +0200=0A=
@@ -0,0 +1,736 @@=0A=
+/* ATM SAR layer=0A=
+ *=0A=
+ * Copyright (C) 2005 Giampaolo Tomassoni=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA=0A=
+ *=0A=
+ * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian=0A=
+ * system and in the file COPYING in the Linux kernel source.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * CREDITS go to the following people:=0A=
+ *=0A=
+ * - Johan Verrept, for its previous work on a SAR library in Linux;=0A=
+ * - Charles Michael Heard for its tutorial on CRC-8 Error Correction.=0A=
+ * - Chas Williams for its help in integrating this with the ATM module.=0A=
+ *=0A=
+ *=0A=
+ * Purposes, theory of operation and module interfacing details=0A=
+ *=0A=
+ * This is yet another Segment And Reassembly (SAR) layer for the=0A=
+ * linux ATM stack.=0A=
+ *=0A=
+ * The differences from other solutions, as well as its power, are that:=0A=
+ *=0A=
+ * - it is mind to be shared by any atm interface, instead of being =
somehow=0A=
+ *   embedded in a bus-wide module (see usb_atm) or, much worse, in=0A=
+ *   a single device driver (see pulsar). The usb_atm solution is =
restricted=0A=
+ *   to usb devices. ADSL modems are often USB, so usb_atm is =
effectively=0A=
+ *   an interesting solution, but why not devise a more general =
solution?=0A=
+ *   The atmsar module wants to be this bus-unspecific solution.=0A=
+ *=0A=
+ * - supplies a coherent interface which allows the device driver to=0A=
+ *   bypass almost any interaction with the atm layer;=0A=
+ *=0A=
+ * - supports ATM header&hec check, correction and generation, which is=0A=
+ *   most useful for dumb atm devices (ie: most ADSL modems);=0A=
+ *=0A=
+ * - supports automatic and fast routing of received cells to =
destinating=0A=
+ *   vcc;=0A=
+ *=0A=
+ * - actually supports AALraw, AAL0 and AAL5;=0A=
+ *=0A=
+ * - aal decoding/encoding routines are designed as atmsar plug-ins, so=0A=
+ *   that further types may easily be supported;=0A=
+ *=0A=
+ * - implements speed- and memory-concerned techniques for per-vcc=0A=
+ *   decoding;=0A=
+ *=0A=
+ * - allows using dma-streaming techniques in sending cells to device;=0A=
+ *=0A=
+ * - supports tx buffer adjusting against device needs;=0A=
+ *=0A=
+ * - avoids vcc open/close paradigm handling in device driver;=0A=
+ *=0A=
+ * - yields a uniform view to SAR status in /proc.=0A=
+ *=0A=
+ *=0A=
+ * Ok. That said, Theory of operation=0A=
+ *=0A=
+ * The atmsar module is designed as a middle layer between the atm=0A=
+ * stack and the device driver.=0A=
+ *=0A=
+ * As with an usual atm-based solution, the device driver will be=0A=
+ * responsible for handling all the hardware details regarding bus=0A=
+ * interfacing, device interfacing, interrupt handling and the like.=0A=
+ *=0A=
+ * Not like usual atm-based solutions, the device driver will=0A=
+ * not need anymore to directly handle cell decoding and encoding,=0A=
+ * packet segmenting and reassembly, and vcc open/close handling.=0A=
+ * At init time the driver will register itself with the atmsar=0A=
+ * layer by calling atmsar_dev_register() instead of registering=0A=
+ * with atm_dev_register().=0A=
+ *=0A=
+ * The atmsar_dev_register() invocation gives a chance to the=0A=
+ * driver to specify some tuning values about wanted tx buffers,=0A=
+ * tx cells structure and supported operations (atmsar_ops_t type).=0A=
+ *=0A=
+ * The driver interacts with the atmsar layer both through=0A=
+ * callbacks (very useful but completely optional) and functions=0A=
+ * call.=0A=
+ *=0A=
+ * The callbacks which the driver may specify in the=0A=
+ * atmsar_dev_register() ops parameter are:=0A=
+ *=0A=
+ * - ATMSAR_FIRST_OPEN=0A=
+ *   The driver callback will be invoked when the device is=0A=
+ *   first opened by the atm layer. Further opens will not be=0A=
+ *   propagated to the device. Also, a mutex is used to avoid=0A=
+ *   any race condition by the open/close paradigm.=0A=
+ *=0A=
+ *   In this callback, the device is given the chance to report=0A=
+ *   any failure in initializing things, thereby allowing it=0A=
+ *   to avoid further operations;=0A=
+ *=0A=
+ * - ATMSAR_LAST_CLOSE=0A=
+ *   This is the callback dual to ATMSAR_FIRST_OPEN. It is invo-=0A=
+ *   ked when the last vcc on the device get closed by the atm=0A=
+ *   layer. On SMP and preemptive contexts, this callback is=0A=
+ *   assured to be atomic with respect to ATMSAR_FIRST_OPEN;=0A=
+ *=0A=
+ * - ATMSAR_TX_RESTART=0A=
+ *   This callback is invoked when new outgoing cells are ready=0A=
+ *   for delivery. The implementing driver may use this callback=0A=
+ *   to restart cell transmission;=0A=
+ *=0A=
+ * - ATMSAR_IOCTL=0A=
+ *   A chance for the driver to receive ioctls from userspace;=0A=
+ *=0A=
+ * - ATMSAR_PROCREAD=0A=
+ *   A chance for the driver to report status data through /proc.=0A=
+ *=0A=
+ *=0A=
+ * These are the most important functions supplied by atmsar:=0A=
+ *=0A=
+ * - atmsar_rx_decode_52bytes(),=0A=
+ *   atmsar_rx_decode_53bytes(),=0A=
+ *   atmsar_rx_decode_53bytes_skiphec()=0A=
+ *=0A=
+ *   The driver may use one of three functions above in order to=0A=
+ *   get a received cell synchronously processed.=0A=
+ *=0A=
+ *   Please note that the atmsar_rx_decode_*() beasts do process=0A=
+ *   a single cell synchronously. You may find their processing=0A=
+ *   time to be acceptable for direct cell decoding at rx=0A=
+ *   interrupt time. However, to allow for slow architectures to=0A=
+ *   benefit from your driver, it is better to write a tasklet=0A=
+ *   for this purpose.=0A=
+ *=0A=
+ * - atmsar_tx_skb_fetch()=0A=
+ *   The driver may use this function to obtain the next buffer=0A=
+ *   to be transmitted out of the device.=0A=
+ *=0A=
+ * - atmsar_dev_hassignal()/atmsar_dev_setsignal()=0A=
+ *   Allow the driver to specify the current state of the carrier=0A=
+ *   signal, as well as to inspect the state known to atmsar.=0A=
+ *   When the driver marks the carrier as lost, no more cells will=0A=
+ *   be queued to the tx queue until it marks the carrier present=0A=
+ *   again.=0A=
+ *=0A=
+ *   Please note that after atmsar_dev_register(), the atmsar=0A=
+ *   layer assumes the carrier signal to be lost. The driver has=0A=
+ *   to issue an atmsar_dev_setsignal() call to set it as present=0A=
+ *   if it wants to process outgoing cells (and if it is the case).=0A=
+ *=0A=
+ *=0A=
+ * Tx operations:=0A=
+ *=0A=
+ * atmsar packs encoded cells in struct sk_buff buffers, which are=0A=
+ * queued in the field skq_tx in atmsar_dev_t.=0A=
+ *=0A=
+ * Tx skbs are shaped according to the tuning parameters specified=0A=
+ * to atmsar_dev_register().=0A=
+ *=0A=
+ * These parameters allow for a buffer prefix area, a buffer=0A=
+ * postfix area, as well as non-standard cell sizes (better said,=0A=
+ * standard cells with gaps at their ends).=0A=
+ *=0A=
+ * Buffer prefix spans from skb->data to skb->head-1, buffer=0A=
+ * postfix spans from skb->tail to the end of the data.=0A=
+ *=0A=
+ * Both prefix and postfix are given to uninitialized to the driver,=0A=
+ * while cell gaps are zeroed. Prefix and postfix are thereby supposed=0A=
+ * to be filled by the driver with usefull content, before streaming=0A=
+ * the whole buffer to the device.=0A=
+ *=0A=
+ * When a driver is ready to send cells out of the device, it invokes=0A=
+ * atmsar_tx_skb_fetch() which returns the next available buffer.=0A=
+ *=0A=
+ * If the device has specific needs, the driver may setup the buffer=0A=
+ * prefix and postfix areas in order to fullfil them.=0A=
+ *=0A=
+ * The driver may then use whatever mean it likes in order to send=0A=
+ * the buffer content to the device. One of the most effective ways=0A=
+ * is streaming DMA, but this is left to the driver developer and=0A=
+ * device limits.=0A=
+ *=0A=
+ * Once the skb has been completely sent to the device, it may be=0A=
+ * released. The driver is required to use atmsar_tx_skb_*()=0A=
+ * to do so. Never use kfree_skb(), or you'll cause memory leakage.=0A=
+ */=0A=
+=0A=
+/* ATMSAR_N_HASHVCCS=0A=
+ * This is the size of the hash of open atm vccs.=0A=
+ * Being it the size of a hash table, a prime works better.=0A=
+ */=0A=
+#define	ATMSAR_N_HASHVCCS	7=0A=
+=0A=
+=0A=
+/* atmsar_dev_t=0A=
+ * A forward declaration to struct atmsar_dev=0A=
+ */=0A=
+typedef	struct	atmsar_dev	atmsar_dev_t;=0A=
+=0A=
+/* atmsar_vcc_t=0A=
+ * A forward declaration to some AAL-dependent=0A=
+ * structures devoted to tracking the state of=0A=
+ * the aal routine in charge of a vcc.=0A=
+ * This is an opaque type to users of this module.=0A=
+ */=0A=
+typedef	struct	atmsar_vcc_base	atmsar_vcc_t;=0A=
+=0A=
+/* atmsar_aalops_t=0A=
+ * Another opaque type to users of this module.=0A=
+ */=0A=
+typedef	struct	atmsar_aalops	atmsar_aalops_t;=0A=
+=0A=
+=0A=
+/* ATMSAR_FIRSTOPEN=0A=
+ * This is the typedef for the first_open callback.=0A=
+ * Devices implementing the first_open method should=0A=
+ * conform to it.=0A=
+ *=0A=
+ * @dev:	the device instance as returned by=0A=
+ *		atmsar_dev_register()=0A=
+ *=0A=
+ * return:	>=3D 0 on success, <0 in case of an=0A=
+ *		error detected by the upper layer.=0A=
+ *=0A=
+ * The atmsar module invokes this callback when=0A=
+ * the first vcc is opened on the device.=0A=
+ *=0A=
+ * When an error is returned by the first_open()=0A=
+ * callback, this driver unwinds initialization and=0A=
+ * returns the error code to the downstream open()=0A=
+ * function.=0A=
+ *=0A=
+ * This callback is invoked with no spinlock held=0A=
+ * and interrupts enabled, so that the implementor=0A=
+ * may schedule().=0A=
+ */=0A=
+typedef	int	ATMSAR_FIRSTOPEN(atmsar_dev_t *dev);=0A=
+=0A=
+/* ATMSAR_LASTCLOSE=0A=
+ * This is the typedef for the last_close callback.=0A=
+ * Devices implementing the last_close method should=0A=
+ * conform to it.=0A=
+ *=0A=
+ * @dev:	the device instance as returned by=0A=
+ *=0A=
+ * The atmsar module invokes this callback when=0A=
+ * the last vcc is closed.=0A=
+ *=0A=
+ * This callback is invoked with no spinlock held=0A=
+ * and interrupts enabled, so that the implementor=0A=
+ * may schedule().=0A=
+ */=0A=
+typedef	void	ATMSAR_LASTCLOSE(atmsar_dev_t *dev);=0A=
+=0A=
+/* ATMSAR_IOCTL=0A=
+ * This is the typedef for the ioctl() callback.=0A=
+ * Devices implementing the ioctl() method should=0A=
+ * conform to it.=0A=
+ *=0A=
+ * @dev:	the device instance as returned by=0A=
+ *		atmsar_dev_register().=0A=
+ * @cmd:	the user-invoked ioctl command.=0A=
+ * @arg:	the ioctl argument, which may be=0A=
+ *		a pointer to user-space data.=0A=
+ *=0A=
+ * return:	Whatever the upper code wants to=0A=
+ *		yield back to the user.=0A=
+ *=0A=
+ * This callback is invoked in the same runtime=0A=
+ * status of the atm ioctl callback. This should=0A=
+ * generally mean that no spinlock is held and=0A=
+ * that interrupts are enabled.=0A=
+ */=0A=
+typedef	int	ATMSAR_IOCTL(=0A=
+	atmsar_dev_t	*dev,=0A=
+	unsigned	cmd,=0A=
+	void __user	*arg=0A=
+);=0A=
+=0A=
+/* ATMSAR_PROCREAD=0A=
+ * This is the typedef for the proread() callback.=0A=
+ * Devices implementing the aioctl() method should=0A=
+ * conform to it.=0A=
+ *=0A=
+ * @dev:	the device instance as returned by=0A=
+ *		atmsar_dev_register().=0A=
+ * @pos:	a pointer to the skipping position.=0A=
+ *		The procread implementation is sup-=0A=
+ *		posed to emit its message on page=0A=
+ *		when *pos is 0, then decrement it.=0A=
+ * @page:	a pointer to the character buffer=0A=
+ *		which will be emitted by the module.=0A=
+ *=0A=
+ * return:	the number of characters written to page.=0A=
+ *=0A=
+ * This callback is invoked with no spinlock held=0A=
+ * and interrupts enabled, so that the implementor=0A=
+ * may schedule().=0A=
+ */=0A=
+typedef	int	ATMSAR_PROCREAD(=0A=
+	atmsar_dev_t*	dev,=0A=
+	loff_t*		pos,=0A=
+	char*		page=0A=
+);=0A=
+=0A=
+/* ATMSAR_TX_RESTART=0A=
+ * This is the typedef for the tx_restart() callback.=0A=
+ * Devices implementing the tx_restart() method should=0A=
+ * conform to it.=0A=
+ *=0A=
+ * @dev:	the device instance as returned by=0A=
+ *		atmsar_dev_register().=0A=
+ *=0A=
+ * When implemented, this callback will be invoked=0A=
+ * when atmsar appends new SKBs are appended to an=0A=
+ * empty dev->skq_tx.=0A=
+ *=0A=
+ * This callback is invoked in the same context as=0A=
+ * the atm send callback. This means that most of the=0A=
+ * time no spinlock is held and interrupts are enabled,=0A=
+ * but there are cases in which this doesn't hold=0A=
+ * (pppoatm?). Implementors better avoid schedule()=0A=
+ * and such.=0A=
+ */=0A=
+typedef	void	ATMSAR_TX_RESTART(atmsar_dev_t *dev);=0A=
+=0A=
+=0A=
+/* atmsar_ops_t=0A=
+ * An envelope for all the above mentioned callbacks.=0A=
+ */=0A=
+typedef	struct	atmsar_ops	{=0A=
+	ATMSAR_TX_RESTART*	tx_restart;=0A=
+	ATMSAR_FIRSTOPEN*	first_open;=0A=
+	ATMSAR_LASTCLOSE*	last_close;=0A=
+	ATMSAR_IOCTL*		ioctl;=0A=
+	ATMSAR_PROCREAD*	proc_read;=0A=
+}	atmsar_ops_t;=0A=
+=0A=
+=0A=
+/* ATMSAR_FLG_53BYTE_CELL=0A=
+ * This flag may be used in atmsar_dev_register() to=0A=
+ * indicate that a full cell (ie: one containing also=0A=
+ * the HEC field) must be generated during encoding.=0A=
+ * Its assertion generally means that the device=0A=
+ * using this module has no support for hec generation.=0A=
+ */=0A=
+#define	ATMSAR_FLG_53BYTE_CELL	(1<<0)	// Cell must contain hec=0A=
+=0A=
+/* ATMSAR_SPEED_UNSPEC=0A=
+ * This is the value returned by get_*_speed() when=0A=
+ * the speed is not known.=0A=
+ */=0A=
+#define	ATMSAR_SPEED_UNSPEC	((unsigned long)0)=0A=
+=0A=
+/* atmsar_dev_t=0A=
+ * This is the incarnation of the atmsar_dev_t type,=0A=
+ * which is the device instance as returned by the=0A=
+ * atmsar_dev_register() function.=0A=
+ */=0A=
+struct	atmsar_dev	{=0A=
+	// General infos=0A=
+	struct atm_dev*		atmdev;		// ATM device=0A=
+	void*			data;		// Upper device data=0A=
+=0A=
+	// Configuration=0A=
+	const atmsar_ops_t*	ops;		// Upper device ops=0A=
+	unsigned		flags;		// Flags defined by u-d=0A=
+	size_t			tx_head_reserve; // head size in tx skb=0A=
+	size_t			tx_tail_reserve; // tail size in tx skb=0A=
+	size_t			tx_cell_size;	// A device cell size=0A=
+	size_t			tx_cell_gap;	// The gap between cells=0A=
+=0A=
+	// Open/Close and Send/Receive data=0A=
+	atmsar_vcc_t*		vccs_hash[ATMSAR_N_HASHVCCS];=0A=
+	int			vccs_count;=0A=
+	rwlock_t		rwl_vccs;=0A=
+	atomic_t		mtx_openclose;=0A=
+	wait_queue_head_t	wqh_openclose;=0A=
+=0A=
+	// Transmit queue=0A=
+	struct sk_buff_head	skq_tx;=0A=
+=0A=
+	// Status=0A=
+	unsigned long		rx_speed;	// cells/sec=0A=
+	unsigned long		tx_speed;	// cells/sec=0A=
+};=0A=
+=0A=
+=0A=
+/* atmsar_dev_register=0A=
+ * Register a device with this module.=0A=
+ *=0A=
+ * @name:	the mnemonic name of the device/driver=0A=
+ * @esi:	the esi field, or NULL if unknown=0A=
+ * @ops:	the callback ops. May be NULL.=0A=
+ * @phy_ops:	physical ops, passed to atm_dev_register()=0A=
+ * @flags:	registration flags, actually may be just=0A=
+ *		0 or ATMSAR_FLG_53BYTE_CELL=0A=
+ * @tx_head_reserve:	reserve this amount of uninizialied=0A=
+ *			bytes at the beginning of tx SKBs=0A=
+ *			queued to dev->skq_tx	[0,)=0A=
+ * @tx_tail_reserve:	reserve this amount of uninizialized=0A=
+ *			bytes at the end of tx SKBs queued=0A=
+ *			to dev->skq_tx		[0,)=0A=
+ * @tx_cell_size:	the tx cell size as expected by=0A=
+ *			the device		[ATM_AAL0_SDU,)=0A=
+ * return:	a pointer to an atmsar_dev_t instance, to=0A=
+ *		be specified in almost every other atmsar=0A=
+ *		functions. If the registration fails,=0A=
+ *		NULL is returned.=0A=
+ *=0A=
+ * Registering a device with atmsar is the first operation=0A=
+ * to be accomplished by the driver.=0A=
+ *=0A=
+ * This function will in turn register the device with the=0A=
+ * atm layer, so you don't need to do it. A pointer to the=0A=
+ * instance of the atm_dev struct may be obtained by the=0A=
+ * atmdev field of the atmsar_dev_t element.=0A=
+ *=0A=
+ * In order to increase speed, the module is designed to=0A=
+ * adjust for device diversity. This is accomplished in=0A=
+ * the "outgoing" direction by generating SKBs immediately=0A=
+ * suitable for streaming DMA or otherwise output to the=0A=
+ * device. This is the purpose of tx_head_reserve,=0A=
+ * tx_tail_reserve and tx_cell_size: the driver calling=0A=
+ * this function must specify the values expected by the=0A=
+ * device for them. tx_head_reserve specifies the number=0A=
+ * of bytes to be reserved at the beginning of a tx skb;=0A=
+ * tx_tail_reserve specifies the number of bytes to be=0A=
+ * reserved at the end of the tx skb, while tx_cell_size=0A=
+ * specifies the size of a cell as expected by the=0A=
+ * device. The latter value may be suitable for any cell=0A=
+ * padding needed by the device.=0A=
+ *=0A=
+ * This function cannot be called at interrupt time.=0A=
+ */=0A=
+extern atmsar_dev_t*	atmsar_dev_register(=0A=
+	const char*		name,=0A=
+	const unsigned char*	esi,=0A=
+	const atmsar_ops_t*	ops,=0A=
+	const struct atmphy_ops* phy_ops,=0A=
+	unsigned		flags,=0A=
+	size_t			tx_head_reserve,=0A=
+	size_t			tx_tail_reserve,=0A=
+	size_t			tx_cell_size=0A=
+);=0A=
+=0A=
+/* atmsar_dev_deregister=0A=
+ * Deregisters a device with atmsar.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance to=0A=
+ *		be deregistered.=0A=
+ *=0A=
+ * Deregistering a device is the last operation to be invoked=0A=
+ * by a device, just before it removes.=0A=
+ *=0A=
+ * This function in turn deregisters the device with the=0A=
+ * atm layer, so you don't have to.=0A=
+ *=0A=
+ * Invoking this function implies shutting down any reference=0A=
+ * with the atm layer, as well as releasing any open vcc.=0A=
+ *=0A=
+ * This function cannot be called at interrupt time.=0A=
+ */=0A=
+extern void		atmsar_dev_deregister(atmsar_dev_t *dev);=0A=
+=0A=
+/* atmsar_dev_getatm=0A=
+ * Gives a pointer to the atm_dev structure tied to the=0A=
+ * given device.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * return:	the pointer to the atm_dev structure=0A=
+ */=0A=
+static inline struct atm_dev* atmsar_dev_getatm(const atmsar_dev_t* dev)=0A=
+{ return(dev->atmdev); }=0A=
+=0A=
+/* atmsar_dev_getdata=0A=
+ * Functions to get driver data.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * return:	the device data=0A=
+ *=0A=
+ * See atmsar_dev_setdata() below=0A=
+ */=0A=
+static inline void*	atmsar_dev_getdata(const atmsar_dev_t* dev)=0A=
+{ return(dev->data); }=0A=
+=0A=
+/* atmsar_dev_setdata=0A=
+ * Functions to set driver data.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * @data:	the data to be set=0A=
+ *=0A=
+ * This function allows the upper driver to store driver data=0A=
+ * into the atmsar_dev_t instance.=0A=
+ *=0A=
+ * This allows the data to be recerenced lather when a callback=0A=
+ * is schedule by the atmsar module.=0A=
+ *=0A=
+ * This way, data private to the driver can be stored in a=0A=
+ * structure and its pointer saved into the atmsar_dev_t instance.=0A=
+ */=0A=
+static inline void	atmsar_dev_setdata(atmsar_dev_t* dev, void* data)=0A=
+{ dev->data =3D data; }=0A=
+=0A=
+/* atmsar_rx_purge=0A=
+ * Resets the rx state of all the opened vccs.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ */=0A=
+extern void		atmsar_rx_purge(atmsar_dev_t *dev);=0A=
+=0A=
+/* atmsar_rx_decode_*=0A=
+ * Decodes a received cell=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * @cell:	pointer to the cell data=0A=
+ *=0A=
+ * These are the main functions for cell reception. The=0A=
+ * cell data to be decoded is given to the atmsar driver=0A=
+ * which synchronously decodes and eventually dispatches=0A=
+ * the result to the atm layer.=0A=
+ *=0A=
+ * There are three version of this method:=0A=
+ *=0A=
+ * atmsar_rx_decode_52bytes assumes that the device=0A=
+ * supplies cells without the HEC field to the driver.=0A=
+ * This kind of cells is 52 bytes long (not counting any=0A=
+ * cell padding).=0A=
+ *=0A=
+ * atmsar_rx_decode_53bytes assumes that the device=0A=
+ * supplies cells WITH the HEC field to the driver.=0A=
+ * Also, the device is assumed not to be smart enough=0A=
+ * to have checked or corrected the cell header against=0A=
+ * the HEC field itself, so this too is performed by=0A=
+ * the function.=0A=
+ *=0A=
+ * atmsar_rx_decode_53bytes_skiphec assumes that the=0A=
+ * device supplies cells having a placeholder as HEC=0A=
+ * field: the device already checked and corrected the=0A=
+ * cell header against the HEC field and this will be=0A=
+ * simply skipped by the function.=0A=
+ *=0A=
+ * Your driver will most probably need to call only=0A=
+ * one version of this method, since this depends on=0A=
+ * the device you are working on.=0A=
+ *=0A=
+ * Please note that any buffer heading, trailing and=0A=
+ * cell padding doesn't apply to atmsar_rx_decode_*,=0A=
+ * since you are expected to call this function for=0A=
+ * each cell received, passing a pointer to the=0A=
+ * beginning of the cell (ie: the cell header) as=0A=
+ * the cell parameter.=0A=
+ *=0A=
+ * These functions can be called at interrupt time.=0A=
+ */=0A=
+extern void		atmsar_rx_decode_52bytes(=0A=
+	atmsar_dev_t		*dev,=0A=
+	const void		*cell=0A=
+);=0A=
+extern void		atmsar_rx_decode_53bytes(=0A=
+	atmsar_dev_t		*dev,=0A=
+	const void		*cell=0A=
+);=0A=
+extern void		atmsar_rx_decode_53bytes_skiphec(=0A=
+	atmsar_dev_t		*dev,=0A=
+	const void		*cell=0A=
+);=0A=
+=0A=
+=0A=
+/* atmsar_tx_isempty=0A=
+ * Returns true if tx queue is empty=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * return:	true if the tx queue is empty, false=0A=
+ *		otherwise=0A=
+ *=0A=
+ * This function can be called at interrupt time.=0A=
+ */=0A=
+static inline int	atmsar_tx_isempty(const atmsar_dev_t* dev)=0A=
+{ return(skb_queue_empty(&dev->skq_tx)); }=0A=
+=0A=
+/* atmsar_tx_skb_fetch=0A=
+ * Fetches the next tx skb to be transmitted by the=0A=
+ * device, if any.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * return:	the skb to be transmitted, or NULL if the=0A=
+ *		tx queue is empty=0A=
+ *=0A=
+ * When the atm layer sends packets through atmsar, the latter=0A=
+ * converts them into ready-to-send atm cells which are packed=0A=
+ * into SKBs. These tx skbs are then queued into a tx queue=0A=
+ * (dev->skq_tx).=0A=
+ *=0A=
+ * This function may be invoked to fetch the next skb to be=0A=
+ * transmitted out by the device.=0A=
+ *=0A=
+ * Please note that the tx SKBs are tied to the originating ones,=0A=
+ * so you can't simply invoke kfree_skb() to release them: use=0A=
+ * atmsar_tx_skb_*() instead.=0A=
+ *=0A=
+ * This function can be invoked at interrupt time.=0A=
+ */=0A=
+static inline struct sk_buff* atmsar_tx_skb_fetch(atmsar_dev_t* dev)=0A=
+{ return(skb_dequeue(&dev->skq_tx)); }=0A=
+=0A=
+/* atmsar_tx_purge=0A=
+ * Purges the whole tx queue=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ *=0A=
+ * This function purges the tx queue associated to the given=0A=
+ * atmsar_dev_t instance.=0A=
+ *=0A=
+ * Purging the tx queue will end discarding all the memory associated=0A=
+ * to the contained SKBs.=0A=
+ *=0A=
+ * This function may be used when the tx queue content is too old=0A=
+ * to be useful. In example, after a synch loss.=0A=
+ *=0A=
+ * This function can be called at interrupt time.=0A=
+ */=0A=
+extern void		atmsar_tx_purge(atmsar_dev_t *dev);=0A=
+=0A=
+/* atmsar_tx_skb_*=0A=
+ * Releases the memory allocated by a tx skb=0A=
+ *=0A=
+ * @skb:	a pointer to the tx skb to be freed=0A=
+ *=0A=
+ * When you need to free a tx skb, don't use kfree_skb(). Use one=0A=
+ * of these function, instead.=0A=
+ *=0A=
+ * This function releases the given skb and the originating one=0A=
+ * (whose pointer is stored into it).=0A=
+ *=0A=
+ * The _complete version of this function increments the tx field=0A=
+ * of the aal status field. The _discard version increments instead=0A=
+ * the tx_err field.=0A=
+ *=0A=
+ * The suggested usage of the first is when the transmission of the=0A=
+ * skb is completed and the skb itself is not needed anymore. The=0A=
+ * latter would instead be used when the transmission can't be=0A=
+ * completed for whatever reason. Note that the atmsar_tx_purge()=0A=
+ * function uses the atmsar_tx_skb_discard() version.=0A=
+ *=0A=
+ * This function can be called at interrupt time.=0A=
+ */=0A=
+extern void		atmsar_tx_skb_complete(struct sk_buff *skb);=0A=
+extern void		atmsar_tx_skb_discard(struct sk_buff *skb);=0A=
+=0A=
+/* atmsar_dev_hassignal=0A=
+ * Returns true when the "signal" of the device is reported to be=0A=
+ * present.=0A=
+ *=0A=
+ * @dev:	a pointer to the atmsar_dev_t instance=0A=
+ * return:	true when the signal is present, false otherwise=0A=
+ *=0A=
+ * Every atm device is supposed to exchange data through some kind=0A=
+ * of (carrier) signal. This function reports its state, which=0A=
+ * is in turn to be defined by the driver itself (see=0A=
+ * atmsar_dev_setsignal()).=0A=
+ *=0A=
+ * This function can be called at interrupt time.=0A=
+ */=0A=
+static int inline	atmsar_dev_hassignal(const atmsar_dev_t* dev)=0A=
+{ return(dev->atmdev->signal =3D=3D ATM_PHY_SIG_FOUND); }=0A=
+=0A=
+/* atmsar_dev_setsignal=0A=
+ * Returns true when the "signal" of the device is reported to be=0A=
+ * present.=0A=
+ *=0A=
+ * @dev:		a pointer to the atmsar_dev_t instance=0A=
+ * @signal_present:	1 if signal present, 0 otherwhise.=0A=
+ *=0A=
+ * Every atm device is supposed to exchange data through some kind=0A=
+ * of (carrier) signal.=0A=
+ *=0A=
+ * The driver is in turn supposed to know the state of the carrier=0A=
+ * signal used by its device, so it MUST inform of its changes the=0A=
+ * atmsar layer.=0A=
+ *=0A=
+ * When the driver informs the atmsar module that the carrier signal=0A=
+ * is not anymore present, the atmsar stops queueing more outgoing=0A=
+ * packets to the device.=0A=
+ *=0A=
+ * When the carrier signal gets back and the driver invokes=0A=
+ * atmsar_dev_setsignal(dev, 1), the transmitting packed encoding=0A=
+ * resumes and queueing may restart.=0A=
+ *=0A=
+ * After atmsar_dev_register(), the signal is supposed to be lost.=0A=
+ *=0A=
+ * Please note that you are supposed to flush tx buffers by invoking=0A=
+ * atmsar_tx_purge() sometime after reporting the device signal as lost.=0A=
+ *=0A=
+ * This function can be called at interrupt time.=0A=
+ */=0A=
+static void inline	atmsar_dev_setsignal(=0A=
+	atmsar_dev_t*	dev,=0A=
+	int		signal_present=0A=
+) {=0A=
+	dev->atmdev->signal =3D (=0A=
+		signal_present=0A=
+	?=0A=
+		ATM_PHY_SIG_FOUND=0A=
+	:=0A=
+		ATM_PHY_SIG_LOST=0A=
+	);=0A=
+}=0A=
+=0A=
+=0A=
+/*=0A=
+ * TODO: Speed inspection and control. Not yet implemented=0A=
+ */=0A=
+static unsigned long inline	atmsar_rx_get_speed(const atmsar_dev_t *dev)=0A=
+{ return(dev->rx_speed); }=0A=
+=0A=
+extern void			atmsar_rx_set_speed(=0A=
+	atmsar_dev_t*	dev,=0A=
+	unsigned long	speed=0A=
+);=0A=
+=0A=
+=0A=
+static unsigned long inline	atmsar_tx_get_speed(const atmsar_dev_t *dev)=0A=
+{ return(dev->tx_speed); }=0A=
+=0A=
+extern void			atmsar_tx_set_speed(=0A=
+	atmsar_dev_t* dev,=0A=
+	unsigned long speed=0A=
+);=0A=

------=_NextPart_000_0005_01C5B151.4E8AE540--

