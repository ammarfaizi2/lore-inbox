Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSJXJTH>; Thu, 24 Oct 2002 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265362AbSJXJTH>; Thu, 24 Oct 2002 05:19:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2821 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265361AbSJXJTG>; Thu, 24 Oct 2002 05:19:06 -0400
Message-Id: <200210240920.g9O9KDp08623@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: EISA AIC7XXX not detected
Date: Thu, 24 Oct 2002 12:12:49 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua> <365640000.1035385777@aslan.btc.adaptec.com> <200210240853.g9O8qwp08460@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200210240853.g9O8qwp08460@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I sticked some printks in the code, here is a new syslog output
> (diff with printks is an the end).
>
> ...
> seems my controller is not considered compatible ;)
> ...

With this patch it got detected. Seems to work fine.
Please inform me when (and whether) you plan to push it
to Marcelo.

(of course feel free to edit the patch, I don't insist on 'vda'
being there :)
--
vda


diff -u --recursive linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7770.c linux-2.4.19net3/drivers/scsi/aic7xxx/aic7770.c
--- linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7770.c	Fri Aug  2 22:39:44 2002
+++ linux-2.4.19net3/drivers/scsi/aic7xxx/aic7770.c	Thu Oct 24 11:56:23 2002
@@ -56,6 +56,7 @@
 #define ID_AHA_274x	0x04907771
 #define ID_AHA_284xB	0x04907756 /* BIOS enabled */
 #define ID_AHA_284x	0x04907757 /* BIOS disabled*/
+#define ID_AIC_vda	0x04907782

 static int aha2840_load_seeprom(struct ahc_softc *ahc);
 static ahc_device_setup_t ahc_aic7770_VL_setup;
@@ -83,7 +84,14 @@
 		0xFFFFFFFF,
 		"Adaptec aic7770 SCSI adapter",
 		ahc_aic7770_EISA_setup
-	}
+	},
+	/* vda */
+	{
+		ID_AIC_vda,
+		0xFFFFFFFF,
+		"Adaptec aic7782 SCSI adapter (seen: Olivetti 2 channel EISA)",
+		ahc_aic7770_EISA_setup
+	},
 };
 const int ahc_num_aic7770_devs = NUM_ELEMENTS(aic7770_ident_table);

