Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTDDFaP (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbTDDE77 (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:59:59 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19589 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261530AbTDDEyY (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:54:24 -0500
Date: Fri, 4 Apr 2003 00:09:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404000938.GE11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030404000731.GB11574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404000731.GB11574@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c	Thu Apr  3 23:41:06 2003
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c	Thu Apr  3 23:41:06 2003
@@ -909,7 +909,7 @@
 #ifdef CONFIG_PNP_CARD

 static int __devinit fcpnp_probe(struct pnp_card *card,
-				 const struct pnp_card_id *card_id)
+				 const struct pnp_card_device_id *card_id)
 {
 	struct fritz_adapter *adapter;
 	struct pnp_dev *pnp_dev;
@@ -955,7 +955,7 @@
 	delete_adapter(adapter);
 }

-static struct pnp_card_id fcpnp_ids[] __devinitdata = {
+static struct pnp_card_device_id fcpnp_ids[] __devinitdata = {
 	{ .id          = "AVM0900",
 	  .driver_data = (unsigned long) "Fritz!Card PnP",
 	  .devs        = { { "AVM0900" } },
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Thu Apr  3 23:41:06 2003
+++ b/drivers/pnp/card.c	Thu Apr  3 23:41:06 2003
@@ -22,9 +22,9 @@
 LIST_HEAD(pnp_card_drivers);


-static const struct pnp_card_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
+static const struct pnp_card_device_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
 {
-	const struct pnp_card_id * drv_id = drv->id_table;
+	const struct pnp_card_device_id * drv_id = drv->id_table;
 	while (*drv_id->id){
 		if (compare_pnp_id(card->id,drv_id->id))
 			return drv_id;
@@ -52,7 +52,7 @@

 static int card_probe(struct pnp_card * card, struct pnp_card_driver * drv)
 {
-	const struct pnp_card_id *id = match_card(drv,card);
+	const struct pnp_card_device_id *id = match_card(drv,card);
 	if (id) {
 		struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
 		if (!clink)
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Thu Apr  3 23:41:06 2003
+++ b/include/linux/pnp.h	Thu Apr  3 23:41:06 2003
@@ -295,7 +295,7 @@
 	unsigned long driver_data;	/* data private to the driver */
 };
 
-struct pnp_card_id {
+struct pnp_card_device_id {
 	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 	struct {
@@ -317,9 +317,9 @@
 struct pnp_card_driver {
 	struct list_head global_list;
 	char * name;
-	const struct pnp_card_id *id_table;
+	const struct pnp_card_device_id *id_table;
 	unsigned int flags;
-	int  (*probe)  (struct pnp_card_link *card, const struct pnp_card_id *card_id);
+	int  (*probe)  (struct pnp_card_link *card, const struct pnp_card_device_id *card_id);
 	void (*remove) (struct pnp_card_link *card);
 	struct pnp_driver link;
 };
diff -Nru a/sound/isa/als100.c b/sound/isa/als100.c
--- a/sound/isa/als100.c	Thu Apr  3 23:41:06 2003
+++ b/sound/isa/als100.c	Thu Apr  3 23:41:06 2003
@@ -98,7 +98,7 @@
 	struct pnp_dev *devopl;
 };
 
-static struct pnp_card_id snd_als100_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_als100_pnpids[] __devinitdata = {
 	/* ALS100 - PRO16PNP */
 	{ .id = "ALS0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
 	/* ALS110 - MF1000 - Digimate 3D Sound */
@@ -118,7 +118,7 @@
 
 static int __devinit snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard,
 					    struct pnp_card_link *card,
-					    const struct pnp_card_id *id)
+					    const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
 	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
@@ -210,7 +210,7 @@
 
 static int __init snd_card_als100_probe(int dev,
 					struct pnp_card_link *pcard,
-					const struct pnp_card_id *pid)
+					const struct pnp_card_device_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -288,7 +288,7 @@
 }
 
 static int __devinit snd_als100_pnp_detect(struct pnp_card_link *card,
-					   const struct pnp_card_id *id)
+					   const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
diff -Nru a/sound/isa/sb/es968.c b/sound/isa/sb/es968.c
--- a/sound/isa/sb/es968.c	Thu Apr  3 23:41:06 2003
+++ b/sound/isa/sb/es968.c	Thu Apr  3 23:41:06 2003
@@ -69,7 +69,7 @@
 	struct pnp_dev *dev;
 };
 
-static struct pnp_card_id snd_es968_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_es968_pnpids[] __devinitdata = {
 	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
 	{ .id = "", } /* end */
 };
@@ -92,7 +92,7 @@
 
 static int __devinit snd_card_es968_isapnp(int dev, struct snd_card_es968 *acard,
 					struct pnp_card_link *card,
-					const struct pnp_card_id *id)
+					const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
 	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
@@ -133,7 +133,7 @@
 
 static int __init snd_card_es968_probe(int dev,
 					struct pnp_card_link *pcard,
-					const struct pnp_card_id *pid)
+					const struct pnp_card_device_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -188,7 +188,7 @@
 }
 
 static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
-                                          const struct pnp_card_id *id)
+                                          const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
diff -Nru a/sound/oss/sb_card.c b/sound/oss/sb_card.c
--- a/sound/oss/sb_card.c	Thu Apr  3 23:41:06 2003
+++ b/sound/oss/sb_card.c	Thu Apr  3 23:41:06 2003
@@ -224,7 +224,7 @@
 }
 
 /* Probe callback function for the PnP API */
-static int sb_pnp_probe(struct pnp_card_link *card, const struct pnp_card_id *card_id)
+static int sb_pnp_probe(struct pnp_card_link *card, const struct pnp_card_device_id *card_id)
 {
 	struct sb_card_config *scc;
 	struct sb_module_options sbmo = {0}; /* Default to 0 for PnP */
diff -Nru a/sound/oss/sb_card.h b/sound/oss/sb_card.h
--- a/sound/oss/sb_card.h	Thu Apr  3 23:41:06 2003
+++ b/sound/oss/sb_card.h	Thu Apr  3 23:41:06 2003
@@ -23,7 +23,7 @@
  */
 
 /* Card PnP ID Table */
-static struct pnp_card_id sb_pnp_card_table[] = {
+static struct pnp_card_device_id sb_pnp_card_table[] = {
 	/* Sound Blaster 16 */
 	{.id = "CTL0024", .driver_data = 0, devs : { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
