Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUEXInA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUEXInA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUEXInA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:43:00 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17311 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264153AbUEXIc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:32:58 -0400
Date: Mon, 24 May 2004 04:32:20 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 5/14 linux-2.6.7-rc1] prism54: new prism54 kernel compatibility
Message-ID: <20040524083220.GF3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jmkJtp15SxLq1SbD"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jmkJtp15SxLq1SbD
Content-Type: multipart/mixed; boundary="SqJDPA0lBYgnDFWV"
Content-Disposition: inline


--SqJDPA0lBYgnDFWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-03-20      Margit Schubert-While <margitsw@t-online.de>

* isl_38xx.[ch], isl_ioctl.c, islpci_dev.[ch], islpci_eth.c
  islpci_hotplug.c, islpci_mgt.[ch], oid_mgt.c: Adopt new
  prism54 kernel compatibility.

* prismcompat.h, prismcompat24.h: New compatibility work


--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--SqJDPA0lBYgnDFWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="05-new_kernel_compatibility.patch"
Content-Transfer-Encoding: quoted-printable

2004-03-20	Margit Schubert-While <margitsw@t-online.de>

	* isl_38xx.[ch], isl_ioctl.c, islpci_dev.[ch], islpci_eth.c
	islpci_hotplug.c, islpci_mgt.[ch], oid_mgt.c: Adopt new=20
	prism54 kernel compatibility.=20

	* prismcompat.h, prismcompat24.h: New compatibility work

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_38xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_38xx.c,v
retrieving revision 1.25
retrieving revision 1.26
diff -u -r1.25 -r1.26
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_38xx.c	18 Mar 2004 05:=
25:24 -0000	1.25
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_38xx.c	20 Mar 2004 16:=
58:36 -0000	1.26
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_38xx.c,v 1.22 2004/02/28 03:=
06:07 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_38xx.c,v 1.26 2004/03/20 16:=
58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003-2004 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>_
@@ -25,17 +25,11 @@
 #include <linux/types.h>
 #include <linux/delay.h>
=20
-#include "isl_38xx.h"
-#include <linux/firmware.h>
-
 #include <asm/uaccess.h>
 #include <asm/io.h>
=20
-#include <linux/config.h>
-#if !defined(CONFIG_FW_LOADER) && !defined(CONFIG_FW_LOADER_MODULE)
-#error No Firmware Loading configured in the kernel !
-#endif
-
+#include "prismcompat.h"
+#include "isl_38xx.h"
 #include "islpci_dev.h"
 #include "islpci_mgt.h"
=20
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_38xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_38xx.h,v
retrieving revision 1.24
retrieving revision 1.25
diff -u -r1.24 -r1.25
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_38xx.h	18 Mar 2004 05:=
25:24 -0000	1.24
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_38xx.h	20 Mar 2004 16:=
58:36 -0000	1.25
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_38xx.h,v 1.22 2004/02/28 03:=
06:07 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_38xx.h,v 1.25 2004/03/20 16:=
58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *
@@ -22,14 +22,6 @@
=20
 #include <linux/version.h>
 #include <asm/io.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,75))
-#include <linux/device.h>
-# define _REQ_FW_DEV_T struct device *
-#else
-# define _REQ_FW_DEV_T char *
-#endif
-
 #include <asm/byteorder.h>
=20
 #define ISL38XX_CB_RX_QSIZE                     8
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.148
retrieving revision 1.149
diff -u -r1.148 -r1.149
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	19 Mar 2004 23=
:03:58 -0000	1.148
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	20 Mar 2004 16=
:58:36 -0000	1.149
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.148 2004/03/19 2=
3:03:58 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.149 2004/03/20 1=
6:58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -25,10 +25,10 @@
 #include <linux/kernel.h>
 #include <linux/if_arp.h>
 #include <linux/pci.h>
-#include <linux/moduleparam.h>
=20
 #include <asm/uaccess.h>
=20
+#include "prismcompat.h"
 #include "isl_ioctl.h"
 #include "islpci_mgt.h"
 #include "isl_oid.h"		/* additional types and defs for isl38xx fw */
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.72
retrieving revision 1.73
diff -u -r1.72 -r1.73
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	19 Mar 2004 2=
0:54:33 -0000	1.72
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	20 Mar 2004 1=
6:58:36 -0000	1.73
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.72 2004/03/19 2=
0:54:33 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.73 2004/03/20 1=
6:58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -30,6 +30,7 @@
=20
 #include <asm/io.h>
=20
+#include "prismcompat.h"
 #include "isl_38xx.h"
 #include "isl_ioctl.h"
 #include "islpci_dev.h"
@@ -37,12 +38,6 @@
 #include "islpci_eth.h"
 #include "oid_mgt.h"
=20
-#if LINUX_VERSION_CODE <=3D KERNEL_VERSION(2,5,0)
-#define prism54_synchronize_irq(irq) synchronize_irq()
-#else
-#define prism54_synchronize_irq(irq) synchronize_irq(irq)
-#endif
-
 #define ISL3877_IMAGE_FILE	"isl3877"
 #define ISL3890_IMAGE_FILE	"isl3890"
=20
@@ -325,11 +320,7 @@
 	printk(KERN_DEBUG "%s: uploading firmware...\n", priv->ndev->name);
=20
 	rc =3D isl38xx_upload_firmware(priv->firmware,
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,75))
-		&priv->pdev->dev,
-#else
-		pci_name(priv->pdev),
-#endif
+		PRISM_FW_PDEV,
 		priv->device_base,
 		priv->device_host_address);
 	if (rc) {
@@ -357,15 +348,7 @@
 	int result =3D -ETIME;
 	int count;
=20
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
-	/* This is 2.6 specific, nicer, shorter, but not in 2.4 yet */
-	DEFINE_WAIT(wait);
-	prepare_to_wait(&priv->reset_done, &wait, TASK_UNINTERRUPTIBLE);
-#else
-	DECLARE_WAITQUEUE(wait, current);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&priv->reset_done, &wait);
-#endif
+	PRISM_DEFWAITQ(priv->reset_done, wait);
 =09
 	/* now the last step is to reset the interface */
 	isl38xx_interface_reset(priv->device_base, priv->device_host_address);
@@ -390,13 +373,7 @@
=20
 	}
=20
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
-	/* 2.6 specific too */
-	finish_wait(&priv->reset_done, &wait);
-#else
-	remove_wait_queue(&priv->reset_done, &wait);
-	set_current_state(TASK_RUNNING);
-#endif
+	PRISM_ENDWAITQ(priv->reset_done, wait);
=20
 	if(result)
 		return result;
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v
retrieving revision 1.58
retrieving revision 1.59
diff -u -r1.58 -r1.59
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	19 Mar 2004 2=
0:54:33 -0000	1.58
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	20 Mar 2004 1=
6:58:36 -0000	1.59
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.58 2004/03/19 2=
0:54:33 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.59 2004/03/20 1=
6:58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.=20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -29,20 +29,6 @@
 #include <net/iw_handler.h>
 #include <linux/list.h>
=20
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,41)
-# include <linux/workqueue.h>
-#else
-# include <linux/tqueue.h>
-# define work_struct tq_struct
-# define INIT_WORK INIT_TQUEUE
-# define schedule_work schedule_task
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
-#define free_netdev(x) kfree(x)=20
-#define pci_name(x) x->slot_name=20
-#endif
-
 #include "isl_38xx.h"
 #include "isl_oid.h"
 #include "islpci_mgt.h"
@@ -210,12 +196,6 @@
=20
 #define ISLPCI_TX_TIMEOUT               (2*HZ)
=20
-#if (LINUX_VERSION_CODE <=3D KERNEL_VERSION(2,5,75))
-# define irqreturn_t void
-# define IRQ_HANDLED
-# define IRQ_NONE
-#endif
-
 irqreturn_t islpci_interrupt(int, void *, struct pt_regs *);
=20
 int prism54_post_setup(islpci_private *, int);
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v
retrieving revision 1.33
retrieving revision 1.35
diff -u -r1.33 -r1.35
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	19 Mar 2004 2=
3:03:58 -0000	1.33
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	20 Mar 2004 1=
6:58:36 -0000	1.35
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/19 2=
3:03:58 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.35 2004/03/20 1=
6:58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2004 Aurelien Alleaume <slts@free.fr>
@@ -26,6 +26,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
=20
+#include "prismcompat.h"
 #include "isl_38xx.h"
 #include "islpci_eth.h"
 #include "islpci_mgt.h"
@@ -261,9 +262,9 @@
 	if (priv->ndev->type =3D=3D ARPHRD_IEEE80211_PRISM) {
 		struct avs_80211_1_header *avs;
 		/* extract the relevant data from the header */
-		u32 clock =3D hdr->clock;
+		u32 clock =3D le32_to_cpu(hdr->clock);
 		u8 rate =3D hdr->rate;
-		u16 freq =3D be16_to_cpu(hdr->freq);
+		u16 freq =3D le16_to_cpu(hdr->freq);
 		u8 rssi =3D hdr->rssi;
=20
 		skb_pull(*skb, sizeof (struct rfmon_header));
@@ -286,21 +287,21 @@
 		    (struct avs_80211_1_header *) skb_push(*skb,
 							   sizeof (struct
 								   avs_80211_1_header));
-
-		avs->version =3D htonl(P80211CAPTURE_VERSION);
-		avs->length =3D htonl(sizeof (struct avs_80211_1_header));
-		avs->mactime =3D __cpu_to_be64(clock);
-		avs->hosttime =3D __cpu_to_be64(jiffies);
-		avs->phytype =3D htonl(6);	/*OFDM: 6 for (g), 8 for (a) */
-		avs->channel =3D htonl(channel_of_freq(freq));
-		avs->datarate =3D htonl(rate * 5);
-		avs->antenna =3D htonl(0);	/*unknown */
-		avs->priority =3D htonl(0);	/*unknown */
-		avs->ssi_type =3D htonl(2);	/*2: dBm, 3: raw RSSI */
-		avs->ssi_signal =3D htonl(rssi);
-		avs->ssi_noise =3D htonl(priv->local_iwstatistics.qual.noise);	/*better =
than 'undefined', I assume */
-		avs->preamble =3D htonl(0);	/*unknown */
-		avs->encoding =3D htonl(0);	/*unknown */
+	=09
+		avs->version =3D cpu_to_be32(P80211CAPTURE_VERSION);
+		avs->length =3D cpu_to_be32(sizeof (struct avs_80211_1_header));
+		avs->mactime =3D cpu_to_be64(le64_to_cpu(clock));
+		avs->hosttime =3D cpu_to_be64(jiffies);
+		avs->phytype =3D cpu_to_be32(6);	/*OFDM: 6 for (g), 8 for (a) */
+		avs->channel =3D cpu_to_be32(channel_of_freq(freq));
+		avs->datarate =3D cpu_to_be32(rate * 5);
+		avs->antenna =3D cpu_to_be32(0);	/*unknown */
+		avs->priority =3D cpu_to_be32(0);	/*unknown */
+		avs->ssi_type =3D cpu_to_be32(3);	/*2: dBm, 3: raw RSSI */
+		avs->ssi_signal =3D cpu_to_be32(rssi & 0x7f);
+		avs->ssi_noise =3D cpu_to_be32(priv->local_iwstatistics.qual.noise);	/*b=
etter than 'undefined', I assume */
+		avs->preamble =3D cpu_to_be32(0);	/*unknown */
+		avs->encoding =3D cpu_to_be32(0);	/*unknown */
 	} else
 		skb_pull(*skb, sizeof (struct rfmon_header));
=20
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_hotplug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_hotplug.c,v
retrieving revision 1.58
retrieving revision 1.59
diff -u -r1.58 -r1.59
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_hotplug.c	18 Mar 20=
04 05:25:24 -0000	1.58
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_hotplug.c	20 Mar 20=
04 16:58:36 -0000	1.59
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_hotplug.c,v 1.56 2004/02/=
26 23:33:02 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_hotplug.c,v 1.59 2004/03/=
20 16:58:36 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/init.h> /* For __init, __exit */
=20
+#include "prismcompat.h"
 #include "islpci_dev.h"
 #include "islpci_mgt.h"		/* for pc_debug */
 #include "isl_oid.h"
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v
retrieving revision 1.42
retrieving revision 1.43
diff -u -r1.42 -r1.43
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	18 Mar 2004 0=
5:25:24 -0000	1.42
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	20 Mar 2004 1=
6:58:37 -0000	1.43
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.40 2004/02/01 1=
0:57:23 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.43 2004/03/20 1=
6:58:37 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright 2004 Jens Maurer <Jens.Maurer@gmx.net>
@@ -22,12 +22,12 @@
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/moduleparam.h>
=20
 #include <asm/io.h>
 #include <asm/system.h>
 #include <linux/if_arp.h>
=20
+#include "prismcompat.h"
 #include "isl_38xx.h"
 #include "islpci_mgt.h"
 #include "isl_oid.h"		/* additional types and defs for isl38xx fw */
@@ -456,21 +456,11 @@
 	const long wait_cycle_jiffies =3D (ISL38XX_WAIT_CYCLE * 10 * HZ) / 1000;
 	long timeout_left =3D ISL38XX_MAX_WAIT_CYCLES * wait_cycle_jiffies;
 	int err;
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
-	DEFINE_WAIT(wait);
-#else
-	DECLARE_WAITQUEUE(wait, current);
-#endif
=20
 	if (down_interruptible(&priv->mgmt_sem))
 		return -ERESTARTSYS;
=20
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
-	prepare_to_wait(&priv->mgmt_wqueue, &wait, TASK_UNINTERRUPTIBLE);
-#else
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&priv->mgmt_wqueue, &wait);
-#endif
+	PRISM_DEFWAITQ(priv->mgmt_wqueue, wait);
 	err =3D islpci_mgt_transmit(ndev, operation, oid, senddata, sendlen);
 	if(err)
 		goto out;
@@ -499,12 +489,7 @@
=20
 	/* TODO: we should reset the device here */    =20
  out:
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
-	finish_wait(&priv->mgmt_wqueue, &wait);
-#else
-	remove_wait_queue(&priv->mgmt_wqueue, &wait);
-	set_current_state(TASK_RUNNING);
-#endif
+	PRISM_ENDWAITQ(priv->mgmt_wqueue, wait);
 	up(&priv->mgmt_sem);
 	return err;
 }
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.h,v
retrieving revision 1.24
retrieving revision 1.25
diff -u -r1.24 -r1.25
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.h	18 Mar 2004 0=
5:25:24 -0000	1.24
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.h	20 Mar 2004 1=
6:58:37 -0000	1.25
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.h,v 1.22 2004/01/30 1=
6:24:00 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.h,v 1.25 2004/03/20 1=
6:58:37 mcgrof Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
@@ -24,15 +24,6 @@
 #include <linux/wireless.h>
 #include <linux/skbuff.h>
=20
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,41)
-# include <linux/workqueue.h>
-#else
-# include <linux/tqueue.h>
-# define work_struct tq_struct
-# define INIT_WORK INIT_TQUEUE
-# define schedule_work schedule_task
-#endif
-
 /*
  *  Function definitions
  */
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.c,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -r1.11 -r1.12
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	19 Mar 2004 23:0=
3:58 -0000	1.11
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	20 Mar 2004 16:5=
8:37 -0000	1.12
@@ -16,6 +16,7 @@
  *
  */
=20
+#include "prismcompat.h"
 #include "islpci_dev.h"
 #include "islpci_mgt.h"
 #include "isl_oid.h"
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: ksrc/prismcompat.h
diff -N ksrc/prismcompat.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	20 Mar 2004 =
18:23:28 -0000	1.1
@@ -0,0 +1,47 @@
+/* =20
+ *  (C) 2004 Margit Schubert-While <margitsw@t-online.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
+ *
+ */
+
+/* =20
+ *	Compatibility header file to aid support of different kernel versions
+ */
+
+#ifndef _PRISM_COMPAT_H
+#define _PRISM_COMPAT_H
+
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/config.h>
+#include <linux/moduleparam.h>
+#include <linux/workqueue.h>
+
+#if !defined(CONFIG_FW_LOADER) && !defined(CONFIG_FW_LOADER_MODULE)
+#error Firmware Loading is not configured in the kernel !
+#endif
+
+#define prism54_synchronize_irq(irq) synchronize_irq(irq)
+
+#define PRISM_DEFWAITQ(x, y)	DEFINE_WAIT(y); \
+	prepare_to_wait(&(x), &(y), TASK_UNINTERRUPTIBLE)
+
+#define PRISM_ENDWAITQ(x, y)	finish_wait(&(x), &(y))
+
+#define _REQ_FW_DEV_T		struct device *
+
+#define PRISM_FW_PDEV		&priv->pdev->dev
+
+#endif				/* _PRISM_COMPAT_H */
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: ksrc/prismcompat24.h
diff -N ksrc/prismcompat24.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	20 Mar 200=
4 18:23:28 -0000	1.1
@@ -0,0 +1,64 @@
+/* =20
+ *  (C) 2004 Margit Schubert-While <margitsw@t-online.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
+ *
+ */
+
+/* =20
+ *	Compatibility header file to aid support of different kernel versions
+ */
+
+#ifndef _PRISM_COMPAT_H
+#define _PRISM_COMPAT_H
+
+#include <linux/firmware.h>
+#include <linux/config.h>
+#include <linux/tqueue.h>
+
+#define work_struct		tq_struct
+#define INIT_WORK		INIT_TQUEUE
+#define schedule_work		schedule_task
+
+#define irqreturn_t		void
+#define IRQ_HANDLED
+#define IRQ_NONE
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
+#define free_netdev(x)		kfree(x)
+#define pci_name(x)		x->slot_name
+#endif
+
+#define module_param(x, y, z)	MODULE_PARM(x, "i")
+
+#define netdev_priv(x)		x->priv
+
+#if !defined(CONFIG_FW_LOADER) && !defined(CONFIG_FW_LOADER_MODULE)
+#error Firmware Loading is not configured in the kernel !
+#endif
+
+#define prism54_synchronize_irq(irq) synchronize_irq()
+
+#define PRISM_DEFWAITQ(x, y)	DECLARE_WAITQUEUE(y, current); \
+	set_current_state(TASK_UNINTERRUPTIBLE); \
+	add_wait_queue(&(x), &(y))
+
+#define PRISM_ENDWAITQ(x, y)	remove_wait_queue(&(x), &(y)); \
+	set_current_state(TASK_RUNNING)
+
+#define _REQ_FW_DEV_T		char *
+
+#define PRISM_FW_PDEV		pci_name(priv->pdev)
+
+#endif				/* _PRISM_COMPAT_H */

--SqJDPA0lBYgnDFWV--

--jmkJtp15SxLq1SbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbMUat1JN+IKUl4RAvGmAKClHLqpxB2DXcCeY9Q5dW28ng1a1QCgpjhY
nh+uyKNVEFI8KHxLR7W3mnk=
=NEcy
-----END PGP SIGNATURE-----

--jmkJtp15SxLq1SbD--
