Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVIDXky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVIDXky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVIDXjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:39:53 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:50817 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932108AbVIDXa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:56 -0400
Message-Id: <20050904232329.281740000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:33 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Johnson <dj@david-web.co.uk>
Content-Disposition: inline; filename=dvb-bt8xx-formatting-cleanup.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 34/54] bt8xx: cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Johnson <dj@david-web.co.uk>

Indentation fixes and remove unnecessary braces.

Signed-off-by: David Johnson <dj@david-web.co.uk>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |  229 ++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 113 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-09-04 22:28:28.000000000 +0200
@@ -32,9 +32,7 @@
 #include "dvbdev.h"
 #include "dvb_demux.h"
 #include "dvb_frontend.h"
-
 #include "dvb-bt8xx.h"
-
 #include "bt878.h"
 
 static int debug;
@@ -43,9 +41,9 @@ module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
 
 #define dprintk( args... ) \
-	do { \
+	do \
 		if (debug) printk(KERN_DEBUG args); \
-	} while (0)
+	while (0)
 
 static void dvb_bt8xx_task(unsigned long data)
 {
@@ -119,14 +117,12 @@ static struct bt878 __init *dvb_bt8xx_87
 	unsigned int card_nr;
 
 	/* Hmm, n squared. Hope n is small */
-	for (card_nr = 0; card_nr < bt878_num; card_nr++) {
+	for (card_nr = 0; card_nr < bt878_num; card_nr++)
 		if (is_pci_slot_eq(bt878[card_nr].dev, bttv_pci_dev))
 			return &bt878[card_nr];
-	}
 	return NULL;
 }
 
-
 static int thomson_dtt7579_demod_init(struct dvb_frontend* fe)
 {
 	static u8 mt352_clock_config [] = { 0x89, 0x38, 0x38 };
@@ -157,13 +153,19 @@ static int thomson_dtt7579_pll_set(struc
 	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
 	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
 
-	if (params->frequency < 542000000) cp = 0xb4;
-	else if (params->frequency < 771000000) cp = 0xbc;
-	else cp = 0xf4;
-
-	if (params->frequency == 0) bs = 0x03;
-	else if (params->frequency < 443250000) bs = 0x02;
-	else bs = 0x08;
+	if (params->frequency < 542000000)
+		cp = 0xb4;
+	else if (params->frequency < 771000000)
+		cp = 0xbc;
+	else
+		cp = 0xf4;
+
+	if (params->frequency == 0)
+		bs = 0x03;
+	else if (params->frequency < 443250000)
+		bs = 0x02;
+	else
+		bs = 0x08;
 
 	pllbuf[0] = 0xc0; // Note: non-linux standard PLL i2c address
 	pllbuf[1] = div >> 8;
@@ -175,7 +177,6 @@ static int thomson_dtt7579_pll_set(struc
 }
 
 static struct mt352_config thomson_dtt7579_config = {
-
 	.demod_address = 0x0f,
 	.demod_init = thomson_dtt7579_demod_init,
 	.pll_set = thomson_dtt7579_pll_set,
@@ -183,25 +184,26 @@ static struct mt352_config thomson_dtt75
 
 static int cx24108_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
-   u32 freq = params->frequency;
-
-   int i, a, n, pump;
-   u32 band, pll;
+	u32 freq = params->frequency;
 
+	int i, a, n, pump;
+	u32 band, pll;
 
-   u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
-	       1576000,1718000,1856000,2036000,2150000};
-   u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
-	       0x00102000,0x00104000,0x00108000,0x00110000,
-	       0x00120000,0x00140000};
+	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
+		1576000,1718000,1856000,2036000,2150000};
+	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
+		0x00102000,0x00104000,0x00108000,0x00110000,
+		0x00120000,0x00140000};
 
-#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
+	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
 	printk("cx24108 debug: entering SetTunerFreq, freq=%d\n",freq);
 
 	/* This is really the bit driving the tuner chip cx24108 */
 
-	if(freq<950000) freq=950000; /* kHz */
-	if(freq>2150000) freq=2150000; /* satellite IF is 950..2150MHz */
+	if (freq<950000)
+		freq = 950000; /* kHz */
+	else if (freq>2150000)
+		freq = 2150000; /* satellite IF is 950..2150MHz */
 
 	/* decide which VCO to use for the input frequency */
 	for(i=1;(i<sizeof(osci)/sizeof(osci[0]))&&(osci[i]<freq);i++);
@@ -228,25 +230,22 @@ static int cx24108_pll_set(struct dvb_fr
 	cx24110_pll_write(fe,0x500c0000);
 	cx24110_pll_write(fe,0x83f1f800);
 	cx24110_pll_write(fe,pll);
-/*        writereg(client,0x56,0x7f);*/
+	//writereg(client,0x56,0x7f);
 
 	return 0;
 }
 
 static int pinnsat_pll_init(struct dvb_frontend* fe)
 {
-   return 0;
+	return 0;
 }
 
-
 static struct cx24110_config pctvsat_config = {
-
 	.demod_address = 0x55,
 	.pll_init = pinnsat_pll_init,
 	.pll_set = cx24108_pll_set,
 };
 
-
 static int microtune_mt7202dtf_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *) fe->dvb->priv;
@@ -258,15 +257,23 @@ static int microtune_mt7202dtf_pll_set(s
 	div = (36000000 + params->frequency + 83333) / 166666;
 	cfg = 0x88;
 
-	if (params->frequency < 175000000) cpump = 2;
-	else if (params->frequency < 390000000) cpump = 1;
-	else if (params->frequency < 470000000) cpump = 2;
-	else if (params->frequency < 750000000) cpump = 2;
-	else cpump = 3;
-
-	if (params->frequency < 175000000) band_select = 0x0e;
-	else if (params->frequency < 470000000) band_select = 0x05;
-	else band_select = 0x03;
+	if (params->frequency < 175000000)
+		cpump = 2;
+	else if (params->frequency < 390000000)
+		cpump = 1;
+	else if (params->frequency < 470000000)
+		cpump = 2;
+	else if (params->frequency < 750000000)
+		cpump = 2;
+	else
+		cpump = 3;
+
+	if (params->frequency < 175000000)
+		band_select = 0x0e;
+	else if (params->frequency < 470000000)
+		band_select = 0x05;
+	else
+		band_select = 0x03;
 
 	data[0] = (div >> 8) & 0x7f;
 	data[1] = div & 0xff;
@@ -285,14 +292,11 @@ static int microtune_mt7202dtf_request_f
 }
 
 static struct sp887x_config microtune_mt7202dtf_config = {
-
 	.demod_address = 0x70,
 	.pll_set = microtune_mt7202dtf_pll_set,
 	.request_firmware = microtune_mt7202dtf_request_firmware,
 };
 
-
-
 static int advbt771_samsung_tdtc9251dh0_demod_init(struct dvb_frontend* fe)
 {
 	static u8 mt352_clock_config [] = { 0x89, 0x38, 0x2d };
@@ -303,7 +307,6 @@ static int advbt771_samsung_tdtc9251dh0_
 	static u8 mt352_av771_extra[] = { 0xB5, 0x7A };
 	static u8 mt352_capt_range_cfg[] = { 0x75, 0x32 };
 
-
 	mt352_write(fe, mt352_clock_config, sizeof(mt352_clock_config));
 	udelay(2000);
 	mt352_write(fe, mt352_reset, sizeof(mt352_reset));
@@ -326,25 +329,43 @@ static int advbt771_samsung_tdtc9251dh0_
 	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
 	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
 
-	if (params->frequency < 150000000) cp = 0xB4;
-	else if (params->frequency < 173000000) cp = 0xBC;
-	else if (params->frequency < 250000000) cp = 0xB4;
-	else if (params->frequency < 400000000) cp = 0xBC;
-	else if (params->frequency < 420000000) cp = 0xF4;
-	else if (params->frequency < 470000000) cp = 0xFC;
-	else if (params->frequency < 600000000) cp = 0xBC;
-	else if (params->frequency < 730000000) cp = 0xF4;
-	else cp = 0xFC;
-
-	if (params->frequency < 150000000) bs = 0x01;
-	else if (params->frequency < 173000000) bs = 0x01;
-	else if (params->frequency < 250000000) bs = 0x02;
-	else if (params->frequency < 400000000) bs = 0x02;
-	else if (params->frequency < 420000000) bs = 0x02;
-	else if (params->frequency < 470000000) bs = 0x02;
-	else if (params->frequency < 600000000) bs = 0x08;
-	else if (params->frequency < 730000000) bs = 0x08;
-	else bs = 0x08;
+	if (params->frequency < 150000000)
+		cp = 0xB4;
+	else if (params->frequency < 173000000)
+		cp = 0xBC;
+	else if (params->frequency < 250000000)
+		cp = 0xB4;
+	else if (params->frequency < 400000000)
+		cp = 0xBC;
+	else if (params->frequency < 420000000)
+		cp = 0xF4;
+	else if (params->frequency < 470000000)
+		cp = 0xFC;
+	else if (params->frequency < 600000000)
+		cp = 0xBC;
+	else if (params->frequency < 730000000)
+		cp = 0xF4;
+	else
+		cp = 0xFC;
+
+	if (params->frequency < 150000000)
+		bs = 0x01;
+	else if (params->frequency < 173000000)
+		bs = 0x01;
+	else if (params->frequency < 250000000)
+		bs = 0x02;
+	else if (params->frequency < 400000000)
+		bs = 0x02;
+	else if (params->frequency < 420000000)
+		bs = 0x02;
+	else if (params->frequency < 470000000)
+		bs = 0x02;
+	else if (params->frequency < 600000000)
+		bs = 0x08;
+	else if (params->frequency < 730000000)
+		bs = 0x08;
+	else
+		bs = 0x08;
 
 	pllbuf[0] = 0xc2; // Note: non-linux standard PLL i2c address
 	pllbuf[1] = div >> 8;
@@ -356,19 +377,15 @@ static int advbt771_samsung_tdtc9251dh0_
 }
 
 static struct mt352_config advbt771_samsung_tdtc9251dh0_config = {
-
 	.demod_address = 0x0f,
 	.demod_init = advbt771_samsung_tdtc9251dh0_demod_init,
 	.pll_set = advbt771_samsung_tdtc9251dh0_pll_set,
 };
 
-
 static struct dst_config dst_config = {
-
 	.demod_address = 0x55,
 };
 
-
 static int or51211_request_firmware(struct dvb_frontend* fe, const struct firmware **fw, char* name)
 {
 	struct dvb_bt8xx_card* bt = (struct dvb_bt8xx_card*) fe->dvb->priv;
@@ -398,10 +415,9 @@ static void or51211_reset(struct dvb_fro
 	 */
 	/* reset & PRM1,2&4 are outputs */
 	int ret = bttv_gpio_enable(bt->bttv_nr, 0x001F, 0x001F);
-	if (ret != 0) {
+	if (ret != 0)
 		printk(KERN_WARNING "or51211: Init Error - Can't Reset DVR "
 		       "(%i)\n", ret);
-	}
 	bttv_write_gpio(bt->bttv_nr, 0x001F, 0x0000);   /* Reset */
 	msleep(20);
 	/* Now set for normal operation */
@@ -417,7 +433,6 @@ static void or51211_sleep(struct dvb_fro
 }
 
 static struct or51211_config or51211_config = {
-
 	.demod_address = 0x15,
 	.request_firmware = or51211_request_firmware,
 	.setmode = or51211_setmode,
@@ -425,7 +440,6 @@ static struct or51211_config or51211_con
 	.sleep = or51211_sleep,
 };
 
-
 static int vp3021_alps_tded4_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *) fe->dvb->priv;
@@ -454,13 +468,11 @@ static int vp3021_alps_tded4_pll_set(str
 }
 
 static struct nxt6000_config vp3021_alps_tded4_config = {
-
 	.demod_address = 0x0a,
 	.clock_inversion = 1,
 	.pll_set = vp3021_alps_tded4_pll_set,
 };
 
-
 static void frontend_init(struct dvb_bt8xx_card *card, u32 type)
 {
 	int ret;
@@ -468,7 +480,7 @@ static void frontend_init(struct dvb_bt8
 
 	switch(type) {
 #ifdef BTTV_DVICO_DVBT_LITE
-	case BTTV_DVICO_DVBT_LITE:
+		case BTTV_DVICO_DVBT_LITE:
 		card->fe = mt352_attach(&thomson_dtt7579_config, card->i2c_adapter);
 		if (card->fe != NULL) {
 			card->fe->ops->info.frequency_min = 174000000;
@@ -479,24 +491,22 @@ static void frontend_init(struct dvb_bt8
 #endif
 
 #ifdef BTTV_TWINHAN_VP3021
-	case BTTV_TWINHAN_VP3021:
+		case BTTV_TWINHAN_VP3021:
 #else
-	case BTTV_NEBULA_DIGITV:
+		case BTTV_NEBULA_DIGITV:
 #endif
 		card->fe = nxt6000_attach(&vp3021_alps_tded4_config, card->i2c_adapter);
-		if (card->fe != NULL) {
+		if (card->fe != NULL)
 			break;
-		}
 		break;
 
-	case BTTV_AVDVBT_761:
+		case BTTV_AVDVBT_761:
 		card->fe = sp887x_attach(&microtune_mt7202dtf_config, card->i2c_adapter);
-		if (card->fe != NULL) {
+		if (card->fe != NULL)
 			break;
-		}
 		break;
 
-	case BTTV_AVDVBT_771:
+		case BTTV_AVDVBT_771:
 		card->fe = mt352_attach(&advbt771_samsung_tdtc9251dh0_config, card->i2c_adapter);
 		if (card->fe != NULL) {
 			card->fe->ops->info.frequency_min = 174000000;
@@ -505,7 +515,7 @@ static void frontend_init(struct dvb_bt8
 		}
 		break;
 
-	case BTTV_TWINHAN_DST:
+		case BTTV_TWINHAN_DST:
 		/*	DST is not a frontend driver !!!		*/
 		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
 		/*	Setup the Card					*/
@@ -522,54 +532,48 @@ static void frontend_init(struct dvb_bt8
 
 		/*	Attach other DST peripherals if any		*/
 		/*	Conditional Access device			*/
-		if (state->dst_hw_cap & DST_TYPE_HAS_CA) {
+		if (state->dst_hw_cap & DST_TYPE_HAS_CA)
 			ret = dst_ca_attach(state, &card->dvb_adapter);
-		}
-		if (card->fe != NULL) {
+
+		if (card->fe != NULL)
 			break;
-		}
 		break;
 
-	case BTTV_PINNACLESAT:
+		case BTTV_PINNACLESAT:
 		card->fe = cx24110_attach(&pctvsat_config, card->i2c_adapter);
-		if (card->fe != NULL) {
+		if (card->fe != NULL)
 			break;
-		}
 		break;
 
-	case BTTV_PC_HDTV:
+		case BTTV_PC_HDTV:
 		card->fe = or51211_attach(&or51211_config, card->i2c_adapter);
-		if (card->fe != NULL) {
+		if (card->fe != NULL)
 			break;
-		}
 		break;
 	}
 
-	if (card->fe == NULL) {
+	if (card->fe == NULL)
 		printk("dvb-bt8xx: A frontend driver was not found for device %04x/%04x subsystem %04x/%04x\n",
 		       card->bt->dev->vendor,
 		       card->bt->dev->device,
 		       card->bt->dev->subsystem_vendor,
 		       card->bt->dev->subsystem_device);
-	} else {
+	else
 		if (dvb_register_frontend(&card->dvb_adapter, card->fe)) {
 			printk("dvb-bt8xx: Frontend registration failed!\n");
 			if (card->fe->ops->release)
 				card->fe->ops->release(card->fe);
 			card->fe = NULL;
 		}
-	}
 }
 
 static int __init dvb_bt8xx_load_card(struct dvb_bt8xx_card *card, u32 type)
 {
 	int result;
 
-	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name,
-					   THIS_MODULE)) < 0) {
+	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name, THIS_MODULE)) < 0) {
 		printk("dvb_bt8xx: dvb_register_adapter failed (errno = %d)\n", result);
 		return result;
-
 	}
 	card->dvb_adapter.priv = card;
 
@@ -664,9 +668,8 @@ static int dvb_bt8xx_probe(struct device
 	strncpy(card->card_name, sub->core->name, sizeof(sub->core->name));
 	card->i2c_adapter = &sub->core->i2c_adap;
 
-	switch(sub->core->type)
-	{
-	case BTTV_PINNACLESAT:
+	switch(sub->core->type) {
+		case BTTV_PINNACLESAT:
 		card->gpio_mode = 0x0400c060;
 		/* should be: BT878_A_GAIN=0,BT878_A_PWRDN,BT878_DA_DPM,BT878_DA_SBR,
 			      BT878_DA_IOM=1,BT878_DA_APP to enable serial highspeed mode. */
@@ -675,7 +678,7 @@ static int dvb_bt8xx_probe(struct device
 		break;
 
 #ifdef BTTV_DVICO_DVBT_LITE
-	case BTTV_DVICO_DVBT_LITE:
+		case BTTV_DVICO_DVBT_LITE:
 #endif
 		card->gpio_mode = 0x0400C060;
 		card->op_sync_orin = 0;
@@ -686,25 +689,25 @@ static int dvb_bt8xx_probe(struct device
 		break;
 
 #ifdef BTTV_TWINHAN_VP3021
-	case BTTV_TWINHAN_VP3021:
+		case BTTV_TWINHAN_VP3021:
 #else
-	case BTTV_NEBULA_DIGITV:
+		case BTTV_NEBULA_DIGITV:
 #endif
-	case BTTV_AVDVBT_761:
+		case BTTV_AVDVBT_761:
 		card->gpio_mode = (1 << 26) | (1 << 14) | (1 << 5);
 		card->op_sync_orin = 0;
 		card->irq_err_ignore = 0;
 		/* A_PWRDN DA_SBR DA_APP (high speed serial) */
 		break;
 
-	case BTTV_AVDVBT_771: //case 0x07711461:
+		case BTTV_AVDVBT_771: //case 0x07711461:
 		card->gpio_mode = 0x0400402B;
 		card->op_sync_orin = BT878_RISC_SYNC_MASK;
 		card->irq_err_ignore = 0;
 		/* A_PWRDN DA_SBR  DA_APP[0] PKTP=10 RISC_ENABLE FIFO_ENABLE*/
 		break;
 
-	case BTTV_TWINHAN_DST:
+		case BTTV_TWINHAN_DST:
 		card->gpio_mode = 0x2204f2c;
 		card->op_sync_orin = BT878_RISC_SYNC_MASK;
 		card->irq_err_ignore = BT878_APABORT | BT878_ARIPERR |
@@ -722,13 +725,13 @@ static int dvb_bt8xx_probe(struct device
 		 * RISC+FIFO ENABLE */
 		break;
 
-	case BTTV_PC_HDTV:
+		case BTTV_PC_HDTV:
 		card->gpio_mode = 0x0100EC7B;
 		card->op_sync_orin = 0;
 		card->irq_err_ignore = 0;
 		break;
 
-	default:
+		default:
 		printk(KERN_WARNING "dvb_bt8xx: Unknown bttv card type: %d.\n",
 				sub->core->type);
 		kfree(card);
@@ -751,7 +754,6 @@ static int dvb_bt8xx_probe(struct device
 
 		kfree(card);
 		return -EFAULT;
-
 	}
 
 	init_MUTEX(&card->bt->gpio_lock);
@@ -779,7 +781,8 @@ static int dvb_bt8xx_remove(struct devic
 	card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
 	dvb_dmxdev_release(&card->dmxdev);
 	dvb_dmx_release(&card->demux);
-	if (card->fe) dvb_unregister_frontend(card->fe);
+	if (card->fe)
+		dvb_unregister_frontend(card->fe);
 	dvb_unregister_adapter(&card->dvb_adapter);
 
 	kfree(card);

--

