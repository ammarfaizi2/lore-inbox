Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbTBEHhe>; Wed, 5 Feb 2003 02:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267845AbTBEHhe>; Wed, 5 Feb 2003 02:37:34 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:32011 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267844AbTBEHhd>; Wed, 5 Feb 2003 02:37:33 -0500
Message-Id: <200302050738.h157c5s16708@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: [PATCH] 2.4.20 still can't detect my SCSI disk
Date: Wed, 5 Feb 2003 09:36:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I had to find out why 2.4.19 did not work with one old EISA SCSI disk.
As it turned out, it's an identification problem only. I made a patch
which works for me, machine is a mail server and now
I have no problems with disks.

I sent the patch to Justin T. Gibbs, he said he will test it
and push to you.

As I see it is still not insluded in 2.4.20 (and visual inspection
of 2.4.21-pre3 patch shows it's not there either).

So I mail the patch to you and to Justin T. Gibbs.

Please include.
--
vda

--- linux-2.4.20/drivers/scsi/aic7xxx/aic7770.c	Fri Aug  2 22:39:44 2002
+++ linux-2.4.20.new/drivers/scsi/aic7xxx/aic7770.c	Thu Oct 24 11:56:23 2002
@@ -56,6 +56,7 @@
 #define ID_AHA_274x	0x04907771
 #define ID_AHA_284xB	0x04907756 /* BIOS enabled */
 #define ID_AHA_284x	0x04907757 /* BIOS disabled*/
+#define ID_AHA_7782	0x04907782

 static int aha2840_load_seeprom(struct ahc_softc *ahc);
 static ahc_device_setup_t ahc_aic7770_VL_setup;
@@ -83,7 +84,14 @@
 		0xFFFFFFFF,
 		"Adaptec aic7770 SCSI adapter",
 		ahc_aic7770_EISA_setup
-	}
+	},
+	/* vda@port.imtp.ilyichevsk.odessa.ua met this: */
+	{
+		ID_AHA_7782,
+		0xFFFFFFFF,
+		"Adaptec aic7782 SCSI adapter", /* Olivetti 2 channel EISA */
+		ahc_aic7770_EISA_setup
+	},
 };
 const int ahc_num_aic7770_devs = NUM_ELEMENTS(aic7770_ident_table);

