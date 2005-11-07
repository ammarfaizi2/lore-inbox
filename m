Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVKGDQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVKGDQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVKGDQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:09 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:28808 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932422AbVKGDQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:07 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Hartmut Hackmann <hartmut.hackmann@t.online.de>
Subject: [Patch 08/20] V4L(908) Added dvb t support for asus p7134 dual
Date: Mon, 07 Nov 2005 00:58:08 -0200
Message-Id: <1131333341.25215.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t.online.de>

- Added dvb-t support for Asus P7134 Dual
- added pci id for ADS Tech Instant TV cardbus variant

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t.online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-cards.c |    9 ++++++++-
 drivers/media/video/saa7134/saa7134-dvb.c   |    4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

--- hg.orig/drivers/media/video/saa7134/saa7134-cards.c
+++ hg/drivers/media/video/saa7134/saa7134-cards.c
@@ -2431,6 +2431,7 @@ struct saa7134_board saa7134_boards[] = 
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
 		.gpiomask	= 1 << 21,
+		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -2864,13 +2865,18 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subvendor    = 0x1421,
 		.subdevice    = 0x0350,		/* PCI version */
 		.driver_data  = SAA7134_BOARD_ADS_INSTANT_TV,
-
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
 		.subvendor    = 0x1421,
 		.subdevice    = 0x0370,		/* cardbus version */
 		.driver_data  = SAA7134_BOARD_ADS_INSTANT_TV,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1421,
+		.subdevice    = 0x1370,        /* cardbus version */
+		.driver_data  = SAA7134_BOARD_ADS_INSTANT_TV,
 
 	},{     /* Typhoon DVB-T Duo Digital/Analog Cardbus */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -3222,6 +3228,7 @@ int saa7134_board_init2(struct saa7134_d
 		}
 		break;
 	case SAA7134_BOARD_PHILIPS_TIGER:
+	case SAA7134_BOARD_ASUSTeK_P7131_DUAL:
 		/* this is a hybrid board, initialize to analog mode */
 		{
 		u8 data[] = { 0x3c, 0x33, 0x68};
--- hg.orig/drivers/media/video/saa7134/saa7134-dvb.c
+++ hg/drivers/media/video/saa7134/saa7134-dvb.c
@@ -880,6 +880,10 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = tda10046_attach(&philips_tiger_config,
 						    &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_ASUSTeK_P7131_DUAL:
+		dev->dvb.frontend = tda10046_attach(&philips_tiger_config,
+						    &dev->i2c_adap);
+		break;
 #endif
 #ifdef HAVE_NXT200X
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

