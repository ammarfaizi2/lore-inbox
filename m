Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWCaUhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWCaUhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCaUfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:35:45 -0500
Received: from isilmar.linta.de ([213.239.214.66]:28887 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932149AbWCaUfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:18 -0500
Date: Fri, 31 Mar 2006 22:22:11 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux@dominikbrodowski.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/33] pcmcia: remove unneeded Vcc pseudo setting
Message-ID: <20060331202211.GA28159@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060331195852.GB27888@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331195852.GB27888@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we do not allow setting Vcc in the pcmcia core, and Vpp1 and
Vpp2 can only be set to the same value, a lot of code can be
streamlined.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/bluetooth/bluecard_cs.c         |    4 ----
 drivers/bluetooth/bt3c_cs.c             |    6 +-----
 drivers/bluetooth/btuart_cs.c           |    6 +-----
 drivers/bluetooth/dtl1_cs.c             |    4 ----
 drivers/char/pcmcia/cm4000_cs.c         |    7 -------
 drivers/char/pcmcia/cm4040_cs.c         |    7 -------
 drivers/char/pcmcia/synclink_cs.c       |    7 -------
 drivers/ide/legacy/ide-cs.c             |   11 ++++-------
 drivers/isdn/hardware/avm/avm_cs.c      |    1 -
 drivers/isdn/hisax/avma1_cs.c           |    1 -
 drivers/isdn/hisax/elsa_cs.c            |    8 ++------
 drivers/isdn/hisax/sedlbauer_cs.c       |   16 ++++++----------
 drivers/isdn/hisax/teles_cs.c           |    8 ++------
 drivers/mtd/maps/pcmciamtd.c            |    7 ++-----
 drivers/net/pcmcia/3c574_cs.c           |    1 -
 drivers/net/pcmcia/3c589_cs.c           |    1 -
 drivers/net/pcmcia/axnet_cs.c           |    5 -----
 drivers/net/pcmcia/com20020_cs.c        |    1 -
 drivers/net/pcmcia/fmvj18x_cs.c         |    8 +-------
 drivers/net/pcmcia/ibmtr_cs.c           |    1 -
 drivers/net/pcmcia/nmclan_cs.c          |    1 -
 drivers/net/pcmcia/pcnet_cs.c           |    5 -----
 drivers/net/pcmcia/smc91c92_cs.c        |    1 -
 drivers/net/pcmcia/xirc2ps_cs.c         |    1 -
 drivers/net/wireless/airo_cs.c          |   19 ++++++-------------
 drivers/net/wireless/atmel_cs.c         |   10 ++--------
 drivers/net/wireless/hostap/hostap_cs.c |   19 +++++++------------
 drivers/net/wireless/netwave_cs.c       |    1 -
 drivers/net/wireless/orinoco_cs.c       |   18 ++++++++----------
 drivers/net/wireless/ray_cs.c           |    1 -
 drivers/net/wireless/spectrum_cs.c      |   16 +++++++---------
 drivers/net/wireless/wavelan_cs.c       |    1 -
 drivers/net/wireless/wl3501_cs.c        |    1 -
 drivers/parport/parport_cs.c            |    5 -----
 drivers/pcmcia/pcmcia_resource.c        |    6 +-----
 drivers/scsi/pcmcia/aha152x_stub.c      |    1 -
 drivers/scsi/pcmcia/fdomain_stub.c      |    1 -
 drivers/scsi/pcmcia/nsp_cs.c            |   15 ++++++---------
 drivers/scsi/pcmcia/qlogic_stub.c       |    1 -
 drivers/scsi/pcmcia/sym53c500_cs.c      |    1 -
 drivers/serial/serial_cs.c              |   12 +-----------
 drivers/telephony/ixj_pcmcia.c          |    3 ---
 drivers/usb/host/sl811_cs.c             |   15 ++++++---------
 include/pcmcia/cs.h                     |    2 +-
 sound/pcmcia/pdaudiocf/pdaudiocf.c      |    4 ----
 sound/pcmcia/vx/vxpocket.c              |    1 -
 46 files changed, 64 insertions(+), 207 deletions(-)

70294b468302fd7a0a99dad935c7ba5322989345
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index bb833b2..8e23f9a 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -878,7 +878,6 @@ static int bluecard_attach(struct pcmcia
 	link->irq.Instance = info;
 
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->handle = p_dev;
@@ -925,7 +924,6 @@ static void bluecard_config(dev_link_t *
 	tuple_t tuple;
 	u_short buf[256];
 	cisparse_t parse;
-	config_info_t config;
 	int i, n, last_ret, last_fn;
 
 	tuple.TupleData = (cisdata_t *)buf;
@@ -945,8 +943,6 @@ static void bluecard_config(dev_link_t *
 
 	/* Configure card */
 	link->state |= DEV_CONFIG;
-	i = pcmcia_get_configuration_info(handle, &config);
-	link->conf.Vcc = config.Vcc;
 
 	link->conf.ConfigIndex = 0x20;
 	link->io.NumPorts1 = 64;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 7b0f4f0..0b84805 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -670,7 +670,6 @@ static int bt3c_attach(struct pcmcia_dev
 	link->irq.Instance = info;
 
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->handle = p_dev;
@@ -728,7 +727,6 @@ static void bt3c_config(dev_link_t *link
 	u_short buf[256];
 	cisparse_t parse;
 	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
-	config_info_t config;
 	int i, j, try, last_ret, last_fn;
 
 	tuple.TupleData = (cisdata_t *)buf;
@@ -748,8 +746,6 @@ static void bt3c_config(dev_link_t *link
 
 	/* Configure card */
 	link->state |= DEV_CONFIG;
-	i = pcmcia_get_configuration_info(handle, &config);
-	link->conf.Vcc = config.Vcc;
 
 	/* First pass: look for a config entry that looks normal. */
 	tuple.TupleData = (cisdata_t *)buf;
@@ -764,7 +760,7 @@ static void bt3c_config(dev_link_t *link
 			if (i != CS_SUCCESS)
 				goto next_entry;
 			if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-				link->conf.Vpp1 = link->conf.Vpp2 = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+				link->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 			if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) && (cf->io.win[0].base != 0)) {
 				link->conf.ConfigIndex = cf->index;
 				link->io.BasePort1 = cf->io.win[0].base;
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 9a507bd..ec19a57 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -598,7 +598,6 @@ static int btuart_attach(struct pcmcia_d
 	link->irq.Instance = info;
 
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->handle = p_dev;
@@ -656,7 +655,6 @@ static void btuart_config(dev_link_t *li
 	u_short buf[256];
 	cisparse_t parse;
 	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
-	config_info_t config;
 	int i, j, try, last_ret, last_fn;
 
 	tuple.TupleData = (cisdata_t *)buf;
@@ -676,8 +674,6 @@ static void btuart_config(dev_link_t *li
 
 	/* Configure card */
 	link->state |= DEV_CONFIG;
-	i = pcmcia_get_configuration_info(handle, &config);
-	link->conf.Vcc = config.Vcc;
 
 	/* First pass: look for a config entry that looks normal. */
 	tuple.TupleData = (cisdata_t *) buf;
@@ -692,7 +688,7 @@ static void btuart_config(dev_link_t *li
 			if (i != CS_SUCCESS)
 				goto next_entry;
 			if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-				link->conf.Vpp1 = link->conf.Vpp2 = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+				link->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 			if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) && (cf->io.win[0].base != 0)) {
 				link->conf.ConfigIndex = cf->index;
 				link->io.BasePort1 = cf->io.win[0].base;
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 39dbe73..86617ee 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -577,7 +577,6 @@ static int dtl1_attach(struct pcmcia_dev
 	link->irq.Instance = info;
 
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->handle = p_dev;
@@ -634,7 +633,6 @@ static void dtl1_config(dev_link_t *link
 	u_short buf[256];
 	cisparse_t parse;
 	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
-	config_info_t config;
 	int i, last_ret, last_fn;
 
 	tuple.TupleData = (cisdata_t *)buf;
@@ -654,8 +652,6 @@ static void dtl1_config(dev_link_t *link
 
 	/* Configure card */
 	link->state |= DEV_CONFIG;
-	i = pcmcia_get_configuration_info(handle, &config);
-	link->conf.Vcc = config.Vcc;
 
 	tuple.TupleData = (cisdata_t *)buf;
 	tuple.TupleOffset = 0;
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 870decb..c996ae1 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1765,7 +1765,6 @@ static void cm4000_config(dev_link_t * l
 	struct cm4000_dev *dev;
 	tuple_t tuple;
 	cisparse_t parse;
-	config_info_t conf;
 	u_char buf[64];
 	int fail_fn, fail_rc;
 	int rc;
@@ -1790,16 +1789,10 @@ static void cm4000_config(dev_link_t * l
 		fail_fn = ParseTuple;
 		goto cs_failed;
 	}
-	if ((fail_rc =
-	     pcmcia_get_configuration_info(handle, &conf)) != CS_SUCCESS) {
-		fail_fn = GetConfigurationInfo;
-		goto cs_failed;
-	}
 
 	link->state |= DEV_CONFIG;
 	link->conf.ConfigBase = parse.config.base;
 	link->conf.Present = parse.config.rmask[0];
-	link->conf.Vcc = conf.Vcc;
 
 	link->io.BasePort2 = 0;
 	link->io.NumPorts2 = 0;
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 47f10c8..94ecd03 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -520,7 +520,6 @@ static void reader_config(dev_link_t *li
 	struct reader_dev *dev;
 	tuple_t tuple;
 	cisparse_t parse;
-	config_info_t conf;
 	u_char buf[64];
 	int fail_fn, fail_rc;
 	int rc;
@@ -546,16 +545,10 @@ static void reader_config(dev_link_t *li
 		fail_fn = ParseTuple;
 		goto cs_failed;
 	}
-	if ((fail_rc = pcmcia_get_configuration_info(handle, &conf))
-							!= CS_SUCCESS) {
-		fail_fn = GetConfigurationInfo;
-		goto cs_failed;
-	}
 
 	link->state |= DEV_CONFIG;
 	link->conf.ConfigBase = parse.config.base;
 	link->conf.Present = parse.config.rmask[0];
-	link->conf.Vcc = conf.Vcc;
 
 	link->io.BasePort2 = 0;
 	link->io.NumPorts2 = 0;
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index d3ea53a..a6cbd32 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -576,7 +576,6 @@ static int mgslpc_attach(struct pcmcia_d
     link->irq.Handler = NULL;
     
     link->conf.Attributes = 0;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->handle = p_dev;
@@ -604,7 +603,6 @@ static void mgslpc_config(dev_link_t *li
     cisparse_t parse;
     int last_fn, last_ret;
     u_char buf[64];
-    config_info_t conf;
     cistpl_cftable_entry_t dflt = { 0 };
     cistpl_cftable_entry_t *cfg;
     
@@ -626,10 +624,6 @@ static void mgslpc_config(dev_link_t *li
     /* Configure card */
     link->state |= DEV_CONFIG;
 
-    /* Look up the current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    link->conf.Vcc = conf.Vcc;
-
     /* get CIS configuration entry */
 
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
@@ -662,7 +656,6 @@ static void mgslpc_config(dev_link_t *li
     }
 
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 8;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 7ad8a95..3b5b55f 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -122,7 +122,6 @@ static int ide_attach(struct pcmcia_devi
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->handle = p_dev;
@@ -222,7 +221,6 @@ static void ide_config(dev_link_t *link)
 
     /* Not sure if this is right... look up the current Vcc */
     CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &stk->conf));
-    link->conf.Vcc = stk->conf.Vcc;
 
     pass = io_base = ctl_base = 0;
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
@@ -244,10 +242,10 @@ static void ide_config(dev_link_t *link)
 	}
 
 	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-	    link->conf.Vpp1 = link->conf.Vpp2 =
+	    link->conf.Vpp =
 		cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 	else if (stk->dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
-	    link->conf.Vpp1 = link->conf.Vpp2 =
+	    link->conf.Vpp =
 		stk->dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 
 	if ((cfg->io.nwin > 0) || (stk->dflt.io.nwin > 0)) {
@@ -329,9 +327,8 @@ static void ide_config(dev_link_t *link)
     info->node.minor = 0;
     info->hd = hd;
     link->dev = &info->node;
-    printk(KERN_INFO "ide-cs: %s: Vcc = %d.%d, Vpp = %d.%d\n",
-	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
-	   link->conf.Vpp1 / 10, link->conf.Vpp1 % 10);
+    printk(KERN_INFO "ide-cs: %s: Vpp = %d.%d\n",
+	   info->node.dev_name, link->conf.Vpp / 10, link->conf.Vpp % 10);
 
     link->state &= ~DEV_CONFIG_PENDING;
     kfree(stk);
diff --git a/drivers/isdn/hardware/avm/avm_cs.c b/drivers/isdn/hardware/avm/avm_cs.c
index ae70247..0c504dc 100644
--- a/drivers/isdn/hardware/avm/avm_cs.c
+++ b/drivers/isdn/hardware/avm/avm_cs.c
@@ -123,7 +123,6 @@ static int avmcs_attach(struct pcmcia_de
     
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/isdn/hisax/avma1_cs.c b/drivers/isdn/hisax/avma1_cs.c
index 5e847cf..8d23e5a 100644
--- a/drivers/isdn/hisax/avma1_cs.c
+++ b/drivers/isdn/hisax/avma1_cs.c
@@ -153,7 +153,6 @@ static int avma1cs_attach(struct pcmcia_
 
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/isdn/hisax/elsa_cs.c b/drivers/isdn/hisax/elsa_cs.c
index b76b303..00835d5 100644
--- a/drivers/isdn/hisax/elsa_cs.c
+++ b/drivers/isdn/hisax/elsa_cs.c
@@ -170,7 +170,6 @@ static int elsa_cs_attach(struct pcmcia_
     link->io.IOAddrLines = 3;
 
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->handle = p_dev;
@@ -324,11 +323,8 @@ static void elsa_cs_config(dev_link_t *l
     link->dev = &dev->node;
 
     /* Finally, report what we've done */
-    printk(KERN_INFO "%s: index 0x%02x: Vcc %d.%d",
-           dev->node.dev_name, link->conf.ConfigIndex,
-           link->conf.Vcc/10, link->conf.Vcc%10);
-    if (link->conf.Vpp1)
-        printk(", Vpp %d.%d", link->conf.Vpp1/10, link->conf.Vpp1%10);
+    printk(KERN_INFO "%s: index 0x%02x: ",
+           dev->node.dev_name, link->conf.ConfigIndex);
     if (link->conf.Attributes & CONF_ENABLE_IRQ)
         printk(", irq %d", link->irq.AssignedIRQ);
     if (link->io.NumPorts1)
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index 5745eb1..a3cd1c5 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -184,7 +184,6 @@ static int sedlbauer_attach(struct pcmci
 
 
     link->conf.Attributes = 0;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->handle = p_dev;
@@ -263,9 +262,7 @@ static void sedlbauer_config(dev_link_t 
     /* Configure card */
     link->state |= DEV_CONFIG;
 
-    /* Look up the current Vcc */
     CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    link->conf.Vcc = conf.Vcc;
 
     /*
       In this loop, we scan the CIS for configuration table entries,
@@ -309,10 +306,10 @@ static void sedlbauer_config(dev_link_t 
 	}
 	    
 	if (cfg->vpp1.present & (1<<CISTPL_POWER_VNOM))
-	    link->conf.Vpp1 = link->conf.Vpp2 =
+	    link->conf.Vpp =
 		cfg->vpp1.param[CISTPL_POWER_VNOM]/10000;
 	else if (dflt.vpp1.present & (1<<CISTPL_POWER_VNOM))
-	    link->conf.Vpp1 = link->conf.Vpp2 =
+	    link->conf.Vpp =
 		dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
 	
 	/* Do we need to allocate an interrupt? */
@@ -403,11 +400,10 @@ static void sedlbauer_config(dev_link_t 
     link->dev = &dev->node;
 
     /* Finally, report what we've done */
-    printk(KERN_INFO "%s: index 0x%02x: Vcc %d.%d",
-	   dev->node.dev_name, link->conf.ConfigIndex,
-	   link->conf.Vcc/10, link->conf.Vcc%10);
-    if (link->conf.Vpp1)
-	printk(", Vpp %d.%d", link->conf.Vpp1/10, link->conf.Vpp1%10);
+    printk(KERN_INFO "%s: index 0x%02x:",
+	   dev->node.dev_name, link->conf.ConfigIndex);
+    if (link->conf.Vpp)
+	printk(", Vpp %d.%d", link->conf.Vpp/10, link->conf.Vpp%10);
     if (link->conf.Attributes & CONF_ENABLE_IRQ)
 	printk(", irq %d", link->irq.AssignedIRQ);
     if (link->io.NumPorts1)
diff --git a/drivers/isdn/hisax/teles_cs.c b/drivers/isdn/hisax/teles_cs.c
index 929507e..040f098 100644
--- a/drivers/isdn/hisax/teles_cs.c
+++ b/drivers/isdn/hisax/teles_cs.c
@@ -161,7 +161,6 @@ static int teles_attach(struct pcmcia_de
     link->io.IOAddrLines = 5;
 
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->handle = p_dev;
@@ -315,11 +314,8 @@ static void teles_cs_config(dev_link_t *
     link->dev = &dev->node;
 
     /* Finally, report what we've done */
-    printk(KERN_INFO "%s: index 0x%02x: Vcc %d.%d",
-           dev->node.dev_name, link->conf.ConfigIndex,
-           link->conf.Vcc/10, link->conf.Vcc%10);
-    if (link->conf.Vpp1)
-        printk(", Vpp %d.%d", link->conf.Vpp1/10, link->conf.Vpp1%10);
+    printk(KERN_INFO "%s: index 0x%02x:",
+           dev->node.dev_name, link->conf.ConfigIndex);
     if (link->conf.Attributes & CONF_ENABLE_IRQ)
         printk(", irq %d", link->irq.AssignedIRQ);
     if (link->io.NumPorts1)
diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
index f45ff25..0026460 100644
--- a/drivers/mtd/maps/pcmciamtd.c
+++ b/drivers/mtd/maps/pcmciamtd.c
@@ -587,13 +587,10 @@ static void pcmciamtd_config(dev_link_t 
 	DEBUG(2, "Vcc = %d Vpp1 = %d Vpp2 = %d", t.Vcc, t.Vpp1, t.Vpp2);
 	dev->vpp = (vpp) ? vpp : t.Vpp1;
 	link->conf.Attributes = 0;
-	link->conf.Vcc = t.Vcc;
 	if(setvpp == 2) {
-		link->conf.Vpp1 = dev->vpp;
-		link->conf.Vpp2 = dev->vpp;
+		link->conf.Vpp = dev->vpp;
 	} else {
-		link->conf.Vpp1 = 0;
-		link->conf.Vpp2 = 0;
+		link->conf.Vpp = 0;
 	}
 
 	link->conf.IntType = INT_MEMORY;
diff --git a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
index 8dfa30b..179c9b7 100644
--- a/drivers/net/pcmcia/3c574_cs.c
+++ b/drivers/net/pcmcia/3c574_cs.c
@@ -280,7 +280,6 @@ static int tc574_attach(struct pcmcia_de
 	link->irq.Handler = &el3_interrupt;
 	link->irq.Instance = dev;
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->conf.ConfigIndex = 1;
 	link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
index b15066b..7e8036f 100644
--- a/drivers/net/pcmcia/3c589_cs.c
+++ b/drivers/net/pcmcia/3c589_cs.c
@@ -194,7 +194,6 @@ static int tc589_attach(struct pcmcia_de
     link->irq.Handler = &el3_interrupt;
     link->irq.Instance = dev;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index c34547c..5ca0d57 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -302,7 +302,6 @@ static void axnet_config(dev_link_t *lin
     cisparse_t parse;
     int i, j, last_ret, last_fn;
     u_short buf[64];
-    config_info_t conf;
 
     DEBUG(0, "axnet_config(0x%p)\n", link);
 
@@ -321,10 +320,6 @@ static void axnet_config(dev_link_t *lin
     /* Configure card */
     link->state |= DEV_CONFIG;
 
-    /* Look up current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    link->conf.Vcc = conf.Vcc;
-
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
diff --git a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
index 0748c3d..e14d3d1 100644
--- a/drivers/net/pcmcia/com20020_cs.c
+++ b/drivers/net/pcmcia/com20020_cs.c
@@ -178,7 +178,6 @@ static int com20020_attach(struct pcmcia
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.Present = PRESENT_OPTION;
 
diff --git a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
index 62efbc7..34bf963 100644
--- a/drivers/net/pcmcia/fmvj18x_cs.c
+++ b/drivers/net/pcmcia/fmvj18x_cs.c
@@ -257,7 +257,6 @@ static int fmvj18x_attach(struct pcmcia_
 
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     /* The FMVJ18x specific entries in the device structure. */
@@ -396,12 +395,7 @@ static void fmvj18x_config(dev_link_t *l
 	switch (le16_to_cpu(buf[0])) {
 	case MANFID_TDK:
 	    cardtype = TDK;
-	    if (le16_to_cpu(buf[1]) == PRODID_TDK_CF010) {
-		cs_status_t status;
-		pcmcia_get_status(handle, &status);
-		if (status.CardState & CS_EVENT_3VCARD)
-		    link->conf.Vcc = 33; /* inserted in 3.3V slot */
-	    } else if (le16_to_cpu(buf[1]) == PRODID_TDK_GN3410
+	    if (le16_to_cpu(buf[1]) == PRODID_TDK_GN3410
 			|| le16_to_cpu(buf[1]) == PRODID_TDK_NP9610
 			|| le16_to_cpu(buf[1]) == PRODID_TDK_MN3200) {
 		/* MultiFunction Card */
diff --git a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
index 6d7f8f5..904c5cb 100644
--- a/drivers/net/pcmcia/ibmtr_cs.c
+++ b/drivers/net/pcmcia/ibmtr_cs.c
@@ -167,7 +167,6 @@ static int ibmtr_attach(struct pcmcia_de
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->irq.Handler = &tok_interrupt;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.Present = PRESENT_OPTION;
 
diff --git a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
index cf2a50c..c25d945 100644
--- a/drivers/net/pcmcia/nmclan_cs.c
+++ b/drivers/net/pcmcia/nmclan_cs.c
@@ -469,7 +469,6 @@ static int nmclan_attach(struct pcmcia_d
     link->irq.Handler = &mace_interrupt;
     link->irq.Instance = dev;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
index 3a2b731..5a7e58a 100644
--- a/drivers/net/pcmcia/pcnet_cs.c
+++ b/drivers/net/pcmcia/pcnet_cs.c
@@ -531,7 +531,6 @@ static void pcnet_config(dev_link_t *lin
     int i, last_ret, last_fn, start_pg, stop_pg, cm_offset;
     int manfid = 0, prodid = 0, has_shmem = 0;
     u_short buf[64];
-    config_info_t conf;
     hw_info_t *hw_info;
 
     DEBUG(0, "pcnet_config(0x%p)\n", link);
@@ -550,10 +549,6 @@ static void pcnet_config(dev_link_t *lin
     /* Configure card */
     link->state |= DEV_CONFIG;
 
-    /* Look up current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    link->conf.Vcc = conf.Vcc;
-
     tuple.DesiredTuple = CISTPL_MANFID;
     tuple.Attributes = TUPLE_RETURN_COMMON;
     if ((pcmcia_get_first_tuple(handle, &tuple) == CS_SUCCESS) &&
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
index 86942c0..b46b7e1 100644
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -334,7 +334,6 @@ static int smc91c92_attach(struct pcmcia
     link->irq.Handler = &smc_interrupt;
     link->irq.Instance = dev;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     /* The SMC91c92-specific entries in the device structure. */
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index 19347bc..f5fa86d 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -571,7 +571,6 @@ xirc2ps_attach(struct pcmcia_device *p_d
 
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
index adb90b6..2216c04 100644
--- a/drivers/net/wireless/airo_cs.c
+++ b/drivers/net/wireless/airo_cs.c
@@ -168,7 +168,6 @@ static int airo_attach(struct pcmcia_dev
 	  device, and can be hard-wired here.
 	*/
 	link->conf.Attributes = 0;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	
 	/* Allocate space for private device-specific data */
@@ -294,16 +293,11 @@ static void airo_config(dev_link_t *link
 		
 		/* Use power settings for Vcc and Vpp if present */
 		/*  Note that the CIS values need to be rescaled */
-		if (cfg->vcc.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vcc = cfg->vcc.param[CISTPL_POWER_VNOM]/10000;
-		else if (dflt.vcc.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vcc = dflt.vcc.param[CISTPL_POWER_VNOM]/10000;
-		
 		if (cfg->vpp1.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				cfg->vpp1.param[CISTPL_POWER_VNOM]/10000;
 		else if (dflt.vpp1.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
 		
 		/* Do we need to allocate an interrupt? */
@@ -391,11 +385,10 @@ static void airo_config(dev_link_t *link
 	link->dev = &dev->node;
 	
 	/* Finally, report what we've done */
-	printk(KERN_INFO "%s: index 0x%02x: Vcc %d.%d",
-	       dev->node.dev_name, link->conf.ConfigIndex,
-	       link->conf.Vcc/10, link->conf.Vcc%10);
-	if (link->conf.Vpp1)
-		printk(", Vpp %d.%d", link->conf.Vpp1/10, link->conf.Vpp1%10);
+	printk(KERN_INFO "%s: index 0x%02x: ",
+	       dev->node.dev_name, link->conf.ConfigIndex);
+	if (link->conf.Vpp)
+		printk(", Vpp %d.%d", link->conf.Vpp/10, link->conf.Vpp%10);
 	if (link->conf.Attributes & CONF_ENABLE_IRQ)
 		printk(", irq %d", link->irq.AssignedIRQ);
 	if (link->io.NumPorts1)
diff --git a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
index 89dbc78..53fdaa2 100644
--- a/drivers/net/wireless/atmel_cs.c
+++ b/drivers/net/wireless/atmel_cs.c
@@ -179,7 +179,6 @@ static int atmel_attach(struct pcmcia_de
 	  device, and can be hard-wired here.
 	*/
 	link->conf.Attributes = 0;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	/* Allocate space for private device-specific data */
@@ -314,16 +313,11 @@ static void atmel_config(dev_link_t *lin
 		
 		/* Use power settings for Vcc and Vpp if present */
 		/*  Note that the CIS values need to be rescaled */
-		if (cfg->vcc.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vcc = cfg->vcc.param[CISTPL_POWER_VNOM]/10000;
-		else if (dflt.vcc.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vcc = dflt.vcc.param[CISTPL_POWER_VNOM]/10000;
-		
 		if (cfg->vpp1.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				cfg->vpp1.param[CISTPL_POWER_VNOM]/10000;
 		else if (dflt.vpp1.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
 		
 		/* Do we need to allocate an interrupt? */
diff --git a/drivers/net/wireless/hostap/hostap_cs.c b/drivers/net/wireless/hostap/hostap_cs.c
index 0fb6251..69024bf 100644
--- a/drivers/net/wireless/hostap/hostap_cs.c
+++ b/drivers/net/wireless/hostap/hostap_cs.c
@@ -512,7 +512,6 @@ static int prism2_attach(struct pcmcia_d
 	memset(link, 0, sizeof(dev_link_t));
 
 	PDEBUG(DEBUG_HW, "%s: setting Vcc=33 (constant)\n", dev_info);
-	link->conf.Vcc = 33;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->handle = p_dev;
@@ -603,9 +602,6 @@ static int prism2_config(dev_link_t *lin
 
 	CS_CHECK(GetConfigurationInfo,
 		 pcmcia_get_configuration_info(link->handle, &conf));
-	PDEBUG(DEBUG_HW, "%s: %s Vcc=%d (from config)\n", dev_info,
-	       ignore_cis_vcc ? "ignoring" : "setting", conf.Vcc);
-	link->conf.Vcc = conf.Vcc;
 
 	/* Look for an appropriate configuration table entry in the CIS */
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
@@ -650,10 +646,10 @@ static int prism2_config(dev_link_t *lin
 		}
 
 		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		else if (dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 
 		/* Do we need to allocate an interrupt? */
@@ -745,12 +741,11 @@ static int prism2_config(dev_link_t *lin
 	dev->base_addr = link->io.BasePort1;
 
 	/* Finally, report what we've done */
-	printk(KERN_INFO "%s: index 0x%02x: Vcc %d.%d",
-	       dev_info, link->conf.ConfigIndex,
-	       link->conf.Vcc / 10, link->conf.Vcc % 10);
-	if (link->conf.Vpp1)
-		printk(", Vpp %d.%d", link->conf.Vpp1 / 10,
-		       link->conf.Vpp1 % 10);
+	printk(KERN_INFO "%s: index 0x%02x: ",
+	       dev_info, link->conf.ConfigIndex);
+	if (link->conf.Vpp)
+		printk(", Vpp %d.%d", link->conf.Vpp / 10,
+		       link->conf.Vpp % 10);
 	if (link->conf.Attributes & CONF_ENABLE_IRQ)
 		printk(", irq %d", link->irq.AssignedIRQ);
 	if (link->io.NumPorts1)
diff --git a/drivers/net/wireless/netwave_cs.c b/drivers/net/wireless/netwave_cs.c
index 545717b..23d6b33 100644
--- a/drivers/net/wireless/netwave_cs.c
+++ b/drivers/net/wireless/netwave_cs.c
@@ -406,7 +406,6 @@ static int netwave_attach(struct pcmcia_
     
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
index 89e16cd..75981d8 100644
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -218,8 +218,7 @@ orinoco_cs_config(dev_link_t *link)
 
 	/* Look up the current Vcc */
 	CS_CHECK(GetConfigurationInfo,
-		 pcmcia_get_configuration_info(handle, &conf));
-	link->conf.Vcc = conf.Vcc;
+		 pcmcia_get_configuration_info(link->handle, &conf));
 
 	/*
 	 * In this loop, we scan the CIS for configuration table
@@ -274,10 +273,10 @@ orinoco_cs_config(dev_link_t *link)
 		}
 
 		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 			    cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		else if (dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 			    dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		
 		/* Do we need to allocate an interrupt? */
@@ -373,12 +372,11 @@ orinoco_cs_config(dev_link_t *link)
 	link->state &= ~DEV_CONFIG_PENDING;
 
 	/* Finally, report what we've done */
-	printk(KERN_DEBUG "%s: index 0x%02x: Vcc %d.%d",
-	       dev->name, link->conf.ConfigIndex,
-	       link->conf.Vcc / 10, link->conf.Vcc % 10);
-	if (link->conf.Vpp1)
-		printk(", Vpp %d.%d", link->conf.Vpp1 / 10,
-		       link->conf.Vpp1 % 10);
+	printk(KERN_DEBUG "%s: index 0x%02x: ",
+	       dev->name, link->conf.ConfigIndex);
+	if (link->conf.Vpp)
+		printk(", Vpp %d.%d", link->conf.Vpp / 10,
+		       link->conf.Vpp % 10);
 	printk(", irq %d", link->irq.AssignedIRQ);
 	if (link->io.NumPorts1)
 		printk(", io 0x%04x-0x%04x", link->io.BasePort1,
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index ed4bf50..7d95587 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -342,7 +342,6 @@ static int ray_attach(struct pcmcia_devi
 
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.ConfigIndex = 1;
     link->conf.Present = PRESENT_OPTION;
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index 0429f1d..7a4a80b 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -692,7 +692,6 @@ spectrum_cs_config(dev_link_t *link)
 	/* Look up the current Vcc */
 	CS_CHECK(GetConfigurationInfo,
 		 pcmcia_get_configuration_info(handle, &conf));
-	link->conf.Vcc = conf.Vcc;
 
 	/*
 	 * In this loop, we scan the CIS for configuration table
@@ -747,10 +746,10 @@ spectrum_cs_config(dev_link_t *link)
 		}
 
 		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 			    cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		else if (dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 			    dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		
 		/* Do we need to allocate an interrupt? */
@@ -851,12 +850,11 @@ spectrum_cs_config(dev_link_t *link)
 	link->state &= ~DEV_CONFIG_PENDING;
 
 	/* Finally, report what we've done */
-	printk(KERN_DEBUG "%s: index 0x%02x: Vcc %d.%d",
-	       dev->name, link->conf.ConfigIndex,
-	       link->conf.Vcc / 10, link->conf.Vcc % 10);
-	if (link->conf.Vpp1)
-		printk(", Vpp %d.%d", link->conf.Vpp1 / 10,
-		       link->conf.Vpp1 % 10);
+	printk(KERN_DEBUG "%s: index 0x%02x: ",
+	       dev->name, link->conf.ConfigIndex);
+	if (link->conf.Vpp)
+		printk(", Vpp %d.%d", link->conf.Vpp / 10,
+		       link->conf.Vpp % 10);
 	printk(", irq %d", link->irq.AssignedIRQ);
 	if (link->io.NumPorts1)
 		printk(", io 0x%04x-0x%04x", link->io.BasePort1,
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index 8cabcfe..daa17dc 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -4607,7 +4607,6 @@ wavelan_attach(struct pcmcia_device *p_d
 
   /* General socket configuration */
   link->conf.Attributes = CONF_ENABLE_IRQ;
-  link->conf.Vcc = 50;
   link->conf.IntType = INT_MEMORY_AND_IO;
 
   /* Chain drivers */
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 3a93a8b..393b5cb 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1976,7 +1976,6 @@ static int wl3501_attach(struct pcmcia_d
 
 	/* General socket configuration */
 	link->conf.Attributes	= CONF_ENABLE_IRQ;
-	link->conf.Vcc		= 50;
 	link->conf.IntType	= INT_MEMORY_AND_IO;
 	link->conf.ConfigIndex	= 1;
 	link->conf.Present	= PRESENT_OPTION;
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 5e12ed2..8d60146 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -117,7 +117,6 @@ static int parport_attach(struct pcmcia_
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
     link->handle = p_dev;
@@ -168,7 +167,6 @@ void parport_config(dev_link_t *link)
     tuple_t tuple;
     u_short buf[128];
     cisparse_t parse;
-    config_info_t conf;
     cistpl_cftable_entry_t *cfg = &parse.cftable_entry;
     cistpl_cftable_entry_t dflt = { 0 };
     struct parport *p;
@@ -189,9 +187,6 @@ void parport_config(dev_link_t *link)
     /* Configure card */
     link->state |= DEV_CONFIG;
 
-    /* Not sure if this is right... look up the current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 16504f8..17e2fbf 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -618,11 +618,7 @@ int pcmcia_request_configuration(struct 
 		return CS_CONFIGURATION_LOCKED;
 
 	/* Do power control.  We don't allow changes in Vcc. */
-	if (s->socket.Vcc != req->Vcc)
-		return CS_BAD_VCC;
-	if (req->Vpp1 != req->Vpp2)
-		return CS_BAD_VPP;
-	s->socket.Vpp = req->Vpp1;
+	s->socket.Vpp = req->Vpp;
 	if (s->ops->set_socket(s, &s->socket))
 		return CS_BAD_VPP;
 
diff --git a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha152x_stub.c
index 7fbef1e..12ec94d 100644
--- a/drivers/scsi/pcmcia/aha152x_stub.c
+++ b/drivers/scsi/pcmcia/aha152x_stub.c
@@ -119,7 +119,6 @@ static int aha152x_attach(struct pcmcia_
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.Present = PRESENT_OPTION;
 
diff --git a/drivers/scsi/pcmcia/fdomain_stub.c b/drivers/scsi/pcmcia/fdomain_stub.c
index 20b9b27..b3cd206 100644
--- a/drivers/scsi/pcmcia/fdomain_stub.c
+++ b/drivers/scsi/pcmcia/fdomain_stub.c
@@ -101,7 +101,6 @@ static int fdomain_attach(struct pcmcia_
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
-    link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
     link->conf.Present = PRESENT_OPTION;
 
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index e313b40..e41e1fe 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1627,7 +1627,6 @@ static int nsp_cs_attach(struct pcmcia_d
 
 	/* General socket configuration */
 	link->conf.Attributes	 = CONF_ENABLE_IRQ;
-	link->conf.Vcc		 = 50;
 	link->conf.IntType	 = INT_MEMORY_AND_IO;
 	link->conf.Present	 = PRESENT_OPTION;
 
@@ -1709,7 +1708,6 @@ static void nsp_cs_config(dev_link_t *li
 
 	/* Look up the current Vcc */
 	CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-	link->conf.Vcc = conf.Vcc;
 
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
@@ -1743,10 +1741,10 @@ static void nsp_cs_config(dev_link_t *li
 		}
 
 		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM)) {
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		} else if (dflt.vpp1.present & (1 << CISTPL_POWER_VNOM)) {
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
 		}
 
@@ -1905,11 +1903,10 @@ static void nsp_cs_config(dev_link_t *li
 #endif
 
 	/* Finally, report what we've done */
-	printk(KERN_INFO "nsp_cs: index 0x%02x: Vcc %d.%d",
-	       link->conf.ConfigIndex,
-	       link->conf.Vcc/10, link->conf.Vcc%10);
-	if (link->conf.Vpp1) {
-		printk(", Vpp %d.%d", link->conf.Vpp1/10, link->conf.Vpp1%10);
+	printk(KERN_INFO "nsp_cs: index 0x%02x: ",
+	       link->conf.ConfigIndex);
+	if (link->conf.Vpp) {
+		printk(", Vpp %d.%d", link->conf.Vpp/10, link->conf.Vpp%10);
 	}
 	if (link->conf.Attributes & CONF_ENABLE_IRQ) {
 		printk(", irq %d", link->irq.AssignedIRQ);
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 5a8da51..4f28589 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -176,7 +176,6 @@ static int qlogic_attach(struct pcmcia_d
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
 	link->irq.IRQInfo1 = IRQ_LEVEL_ID;
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->conf.Present = PRESENT_OPTION;
 
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 4a69885..2bce7b0 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -916,7 +916,6 @@ SYM53C500_attach(struct pcmcia_device *p
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
 	link->irq.IRQInfo1 = IRQ_LEVEL_ID;
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->conf.Present = PRESENT_OPTION;
 
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index b6b460f..1e6889f 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -358,7 +358,6 @@ static int simple_config(dev_link_t *lin
 			return setup_serial(handle, info, port, config.AssignedIRQ);
 		}
 	}
-	link->conf.Vcc = config.Vcc;
 
 	/* First pass: look for a config entry that looks normal. */
 	tuple->TupleData = (cisdata_t *) buf;
@@ -374,7 +373,7 @@ static int simple_config(dev_link_t *lin
 				if (i != CS_SUCCESS)
 					goto next_entry;
 				if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-					link->conf.Vpp1 = link->conf.Vpp2 =
+					link->conf.Vpp =
 					    cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
 				if ((cf->io.nwin > 0) && (cf->io.win[0].len == size_table[s]) &&
 					    (cf->io.win[0].base != 0)) {
@@ -445,7 +444,6 @@ static int multi_config(dev_link_t * lin
 	u_char *buf;
 	cisparse_t *parse;
 	cistpl_cftable_entry_t *cf;
-	config_info_t config;
 	int i, rc, base2 = 0;
 
 	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
@@ -456,14 +454,6 @@ static int multi_config(dev_link_t * lin
 	cf = &parse->cftable_entry;
 	buf = cfg_mem->buf;
 
-	i = pcmcia_get_configuration_info(handle, &config);
-	if (i != CS_SUCCESS) {
-		cs_error(handle, GetConfigurationInfo, i);
-		rc = -1;
-		goto free_cfg_mem;
-	}
-	link->conf.Vcc = config.Vcc;
-
 	tuple->TupleData = (cisdata_t *) buf;
 	tuple->TupleOffset = 0;
 	tuple->TupleDataMax = 255;
diff --git a/drivers/telephony/ixj_pcmcia.c b/drivers/telephony/ixj_pcmcia.c
index 5094655..de794b2 100644
--- a/drivers/telephony/ixj_pcmcia.c
+++ b/drivers/telephony/ixj_pcmcia.c
@@ -51,7 +51,6 @@ static int ixj_attach(struct pcmcia_devi
 	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
 	link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
 	link->io.IOAddrLines = 3;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->priv = kmalloc(sizeof(struct ixj_info_t), GFP_KERNEL);
 	if (!link->priv) {
@@ -157,7 +156,6 @@ static void ixj_config(dev_link_t * link
 	tuple_t tuple;
 	u_short buf[128];
 	cisparse_t parse;
-	config_info_t conf;
 	cistpl_cftable_entry_t *cfg = &parse.cftable_entry;
 	cistpl_cftable_entry_t dflt =
 	{
@@ -178,7 +176,6 @@ static void ixj_config(dev_link_t * link
 	link->conf.ConfigBase = parse.config.base;
 	link->conf.Present = parse.config.rmask[0];
 	link->state |= DEV_CONFIG;
-	CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	tuple.Attributes = 0;
 	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index ca3fc33..c6f1baf 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -191,7 +191,6 @@ static void sl811_cs_config(dev_link_t *
 	/* Look up the current Vcc */
 	CS_CHECK(GetConfigurationInfo,
 			pcmcia_get_configuration_info(handle, &conf));
-	link->conf.Vcc = conf.Vcc;
 
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
@@ -225,10 +224,10 @@ static void sl811_cs_config(dev_link_t *
 		}
 
 		if (cfg->vpp1.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				cfg->vpp1.param[CISTPL_POWER_VNOM]/10000;
 		else if (dflt.vpp1.present & (1<<CISTPL_POWER_VNOM))
-			link->conf.Vpp1 = link->conf.Vpp2 =
+			link->conf.Vpp =
 				dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
 
 		/* we need an interrupt */
@@ -271,11 +270,10 @@ next_entry:
 	dev->node.major = dev->node.minor = 0;
 	link->dev = &dev->node;
 
-	printk(KERN_INFO "%s: index 0x%02x: Vcc %d.%d",
-	       dev->node.dev_name, link->conf.ConfigIndex,
-	       link->conf.Vcc/10, link->conf.Vcc%10);
-	if (link->conf.Vpp1)
-		printk(", Vpp %d.%d", link->conf.Vpp1/10, link->conf.Vpp1%10);
+	printk(KERN_INFO "%s: index 0x%02x: ",
+	       dev->node.dev_name, link->conf.ConfigIndex);
+	if (link->conf.Vpp)
+		printk(", Vpp %d.%d", link->conf.Vpp/10, link->conf.Vpp%10);
 	printk(", irq %d", link->irq.AssignedIRQ);
 	printk(", io 0x%04x-0x%04x", link->io.BasePort1,
 	       link->io.BasePort1+link->io.NumPorts1-1);
@@ -311,7 +309,6 @@ static int sl811_cs_attach(struct pcmcia
 	link->irq.Handler = NULL;
 
 	link->conf.Attributes = 0;
-	link->conf.Vcc = 33;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 
 	link->handle = p_dev;
diff --git a/include/pcmcia/cs.h b/include/pcmcia/cs.h
index 087b3bc..e0835d6 100644
--- a/include/pcmcia/cs.h
+++ b/include/pcmcia/cs.h
@@ -125,7 +125,7 @@ typedef struct modconf_t {
 /* For RequestConfiguration */
 typedef struct config_req_t {
     u_int	Attributes;
-    u_int	Vcc, Vpp1, Vpp2;
+    u_int	Vpp; /* both Vpp1 and Vpp2 */
     u_int	IntType;
     u_int	ConfigBase;
     u_char	Status, Pin, Copy, ExtStatus;
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 31f4bdc..7c4091a 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -230,7 +230,6 @@ static void pdacf_config(dev_link_t *lin
 	struct snd_pdacf *pdacf = link->priv;
 	tuple_t tuple;
 	cisparse_t *parse = NULL;
-	config_info_t conf;
 	u_short buf[32];
 	int last_fn, last_ret;
 
@@ -253,9 +252,6 @@ static void pdacf_config(dev_link_t *lin
 	link->conf.ConfigIndex = 0x5;
 	kfree(parse);
 
-	CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-	link->conf.Vcc = conf.Vcc;
-
 	/* Configure card */
 	link->state |= DEV_CONFIG;
 
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index e101e05..ff2f927 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -161,7 +161,6 @@ static struct snd_vxpocket *snd_vxpocket
 	link->irq.Instance = chip;
 
 	link->conf.Attributes = CONF_ENABLE_IRQ;
-	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->conf.ConfigIndex = 1;
 	link->conf.Present = PRESENT_OPTION;
-- 
1.2.4

