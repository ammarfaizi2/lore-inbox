Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267681AbSLSX5y>; Thu, 19 Dec 2002 18:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267689AbSLSX5y>; Thu, 19 Dec 2002 18:57:54 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:38920
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267681AbSLSX5w>; Thu, 19 Dec 2002 18:57:52 -0500
Date: Thu, 19 Dec 2002 19:08:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Burton Windle <bwindle@fint.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch][2.5][cft] OSS cs4232.c fix compilation
Message-ID: <Pine.LNX.4.50.0212191905320.22130-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Burton,
	You'll need the ad1848 patches i posted earlier too.

Regards,
	Zwane

Index: linux-2.5.52/sound/oss/cs4232.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.52/sound/oss/cs4232.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cs4232.c
--- linux-2.5.52/sound/oss/cs4232.c	16 Dec 2002 05:17:07 -0000	1.1.1.1
+++ linux-2.5.52/sound/oss/cs4232.c	19 Dec 2002 22:44:52 -0000
@@ -357,7 +357,7 @@

 /* All cs4232 based cards have the main ad1848 card either as CSC0000 or
  * CSC0100. */
-static const struct pnp_id cs4232_pnp_table[] = {
+static const struct pnp_device_id cs4232_pnp_table[] = {
 	{ .id = "CSC0100", .driver_data = 0 },
 	{ .id = "CSC0000", .driver_data = 0 },
 	/* Guillemot Turtlebeach something appears to be cs4232 compatible
@@ -368,7 +368,7 @@

 /*MODULE_DEVICE_TABLE(isapnp, isapnp_cs4232_list);*/

-static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
+static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct address_info *isapnpcfg;

@@ -386,20 +386,19 @@
 		return -ENODEV;
 	}
 	attach_cs4232(isapnpcfg);
-	pci_set_drvdata(dev,isapnpcfg);
+	pnp_set_drvdata(dev,isapnpcfg);
 	return 0;
 }

 static void cs4232_pnp_remove(struct pnp_dev *dev)
 {
-	struct address_info *cfg = (struct address_info*) dev->driver_data;
+	struct address_info *cfg = pnp_get_drvdata(dev);
 	if (cfg)
 		unload_cs4232(cfg);
 }

 static struct pnp_driver cs4232_driver = {
 	.name		= "cs4232",
-	.card_id_table	= NULL,
 	.id_table	= cs4232_pnp_table,
 	.probe		= cs4232_pnp_probe,
 	.remove		= cs4232_pnp_remove,

-- 
function.linuxpower.ca
