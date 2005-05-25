Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVEYGr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVEYGr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVEYGr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:47:27 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:4441 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262283AbVEYGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:34 -0400
Message-Id: <20050525064005.712717000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 2/9] smsc-ircc2: formatting fixes
Content-Disposition: inline; filename=ircc2-formatting.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - some formatting changes for better readability.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |  637 +++++++++++++++++++++++++++++------------------------------
 1 files changed, 315 insertions(+), 322 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -68,6 +68,36 @@
 #include "smsc-ircc2.h"
 #include "smsc-sio.h"
 
+
+MODULE_AUTHOR("Daniele Peri <peri@csai.unipa.it>");
+MODULE_DESCRIPTION("SMC IrCC SIR/FIR controller driver");
+MODULE_LICENSE("GPL");
+
+
+static int ircc_dma = 255;
+module_param(ircc_dma, int, 0);
+MODULE_PARM_DESC(ircc_dma, "DMA channel");
+
+static int ircc_irq = 255;
+module_param(ircc_irq, int, 0);
+MODULE_PARM_DESC(ircc_irq, "IRQ line");
+
+static int ircc_fir;
+module_param(ircc_fir, int, 0);
+MODULE_PARM_DESC(ircc_fir, "FIR Base Address");
+
+static int ircc_sir;
+module_param(ircc_sir, int, 0);
+MODULE_PARM_DESC(ircc_sir, "SIR Base Address");
+
+static int ircc_cfg;
+module_param(ircc_cfg, int, 0);
+MODULE_PARM_DESC(ircc_cfg, "Configuration register base address");
+
+static int ircc_transceiver;
+module_param(ircc_transceiver, int, 0);
+MODULE_PARM_DESC(ircc_transceiver, "Transceiver type");
+
 /* Types */
 
 struct smsc_transceiver {
@@ -136,7 +166,7 @@ static const char *driver_name = "smsc-i
 #define	DIM(x)	(sizeof(x)/(sizeof(*(x))))
 #define SMSC_IRCC2_C_IRDA_FALLBACK_SPEED	9600
 #define SMSC_IRCC2_C_DEFAULT_TRANSCEIVER	1
-#define SMSC_IRCC2_C_NET_TIMEOUT			0
+#define SMSC_IRCC2_C_NET_TIMEOUT		0
 #define SMSC_IRCC2_C_SIR_STOP			0
 
 /* Prototypes */
@@ -179,7 +209,7 @@ static void smsc_ircc_sir_wait_hw_transm
 
 /* Probing */
 static int __init smsc_ircc_look_for_chips(void);
-static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base,u8 reg,const smsc_chip_t *chip,char *type);
+static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base, u8 reg, const smsc_chip_t *chip, char *type);
 static int __init smsc_superio_flat(const smsc_chip_t *chips, unsigned short cfg_base, char *type);
 static int __init smsc_superio_paged(const smsc_chip_t *chips, unsigned short cfg_base, char *type);
 static int __init smsc_superio_fdc(unsigned short cfg_base);
@@ -203,12 +233,12 @@ static int smsc_ircc_pmproc(struct pm_de
 
 /* Transceivers for SMSC-ircc */
 
-static smsc_transceiver_t smsc_transceivers[]=
+static smsc_transceiver_t smsc_transceivers[] =
 {
-	{ "Toshiba Satellite 1800 (GP data pin select)", smsc_ircc_set_transceiver_toshiba_sat1800, smsc_ircc_probe_transceiver_toshiba_sat1800},
-	{ "Fast pin select", smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select, smsc_ircc_probe_transceiver_smsc_ircc_fast_pin_select},
-	{ "ATC IRMode", smsc_ircc_set_transceiver_smsc_ircc_atc, smsc_ircc_probe_transceiver_smsc_ircc_atc},
-	{ NULL, NULL}
+	{ "Toshiba Satellite 1800 (GP data pin select)", smsc_ircc_set_transceiver_toshiba_sat1800, smsc_ircc_probe_transceiver_toshiba_sat1800 },
+	{ "Fast pin select", smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select, smsc_ircc_probe_transceiver_smsc_ircc_fast_pin_select },
+	{ "ATC IRMode", smsc_ircc_set_transceiver_smsc_ircc_atc, smsc_ircc_probe_transceiver_smsc_ircc_atc },
+	{ NULL, NULL }
 };
 #define SMSC_IRCC2_C_NUMBER_OF_TRANSCEIVERS (DIM(smsc_transceivers)-1)
 
@@ -221,7 +251,7 @@ static smsc_transceiver_t smsc_transceiv
 #define	FIR	4	/* SuperIO Chip has fast IRDA */
 #define	SERx4	8	/* SuperIO Chip supports 115,2 KBaud * 4=460,8 KBaud */
 
-static smsc_chip_t __initdata fdc_chips_flat[]=
+static smsc_chip_t __initdata fdc_chips_flat[] =
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37C44",	KEY55_1|NoIRDA,		0x00, 0x00 }, /* This chip cannot be detected */
@@ -235,7 +265,7 @@ static smsc_chip_t __initdata fdc_chips_
 	{ NULL }
 };
 
-static smsc_chip_t __initdata fdc_chips_paged[]=
+static smsc_chip_t __initdata fdc_chips_paged[] =
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37B72X",	KEY55_1|SIR|SERx4,	0x4c, 0x00 },
@@ -254,7 +284,7 @@ static smsc_chip_t __initdata fdc_chips_
 	{ NULL }
 };
 
-static smsc_chip_t __initdata lpc_chips_flat[]=
+static smsc_chip_t __initdata lpc_chips_flat[] =
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47N227",	KEY55_1|FIR|SERx4,	0x5a, 0x00 },
@@ -262,7 +292,7 @@ static smsc_chip_t __initdata lpc_chips_
 	{ NULL }
 };
 
-static smsc_chip_t __initdata lpc_chips_paged[]=
+static smsc_chip_t __initdata lpc_chips_paged[] =
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47B27X",	KEY55_1|SIR|SERx4,	0x51, 0x00 },
@@ -281,33 +311,25 @@ static smsc_chip_t __initdata lpc_chips_
 #define SMSCSIO_TYPE_FLAT	4
 #define SMSCSIO_TYPE_PAGED	8
 
-static smsc_chip_address_t __initdata possible_addresses[]=
+static smsc_chip_address_t __initdata possible_addresses[] =
 {
-	{0x3f0, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED},
-	{0x370, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED},
-	{0xe0, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED},
-	{0x2e, SMSCSIO_TYPE_LPC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED},
-	{0x4e, SMSCSIO_TYPE_LPC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED},
-	{0,0}
+	{ 0x3f0, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
+	{ 0x370, SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
+	{ 0xe0,  SMSCSIO_TYPE_FDC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
+	{ 0x2e,  SMSCSIO_TYPE_LPC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
+	{ 0x4e,  SMSCSIO_TYPE_LPC|SMSCSIO_TYPE_FLAT|SMSCSIO_TYPE_PAGED },
+	{ 0, 0 }
 };
 
 /* Globals */
 
-static struct smsc_ircc_cb *dev_self[] = { NULL, NULL};
-
-static int ircc_irq=255;
-static int ircc_dma=255;
-static int ircc_fir=0;
-static int ircc_sir=0;
-static int ircc_cfg=0;
-static int ircc_transceiver=0;
-
-static unsigned short	dev_count=0;
+static struct smsc_ircc_cb *dev_self[] = { NULL, NULL };
+static unsigned short dev_count;
 
 static inline void register_bank(int iobase, int bank)
 {
-        outb(((inb(iobase+IRCC_MASTER) & 0xf0) | (bank & 0x07)),
-               iobase+IRCC_MASTER);
+        outb(((inb(iobase + IRCC_MASTER) & 0xf0) | (bank & 0x07)),
+               iobase + IRCC_MASTER);
 }
 
 
@@ -327,13 +349,13 @@ static inline void register_bank(int iob
  */
 static int __init smsc_ircc_init(void)
 {
-	int ret=-ENODEV;
+	int ret = -ENODEV;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
-	dev_count=0;
+	dev_count = 0;
 
-	if ((ircc_fir>0)&&(ircc_sir>0)) {
+	if (ircc_fir > 0 && ircc_sir > 0) {
 		IRDA_MESSAGE(" Overriding FIR address 0x%04x\n", ircc_fir);
 		IRDA_MESSAGE(" Overriding SIR address 0x%04x\n", ircc_sir);
 
@@ -344,7 +366,7 @@ static int __init smsc_ircc_init(void)
 	}
 
 	/* try user provided configuration register base address */
-	if (ircc_cfg>0) {
+	if (ircc_cfg > 0) {
 	        IRDA_MESSAGE(" Overriding configuration address 0x%04x\n",
 			     ircc_cfg);
 		if (!smsc_superio_fdc(ircc_cfg))
@@ -353,7 +375,8 @@ static int __init smsc_ircc_init(void)
 			ret = 0;
 	}
 
-	if(smsc_ircc_look_for_chips()>0) ret = 0;
+	if (smsc_ircc_look_for_chips() > 0)
+		ret = 0;
 
 	return ret;
 }
@@ -373,7 +396,7 @@ static int __init smsc_ircc_open(unsigne
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	err = smsc_ircc_present(fir_base, sir_base);
-	if(err)
+	if (err)
 		goto err_out;
 
 	err = -ENOMEM;
@@ -396,7 +419,7 @@ static int __init smsc_ircc_open(unsigne
 	dev->hard_start_xmit = smsc_ircc_hard_xmit_sir;
 #if SMSC_IRCC2_C_NET_TIMEOUT
 	dev->tx_timeout	     = smsc_ircc_timeout;
-	dev->watchdog_timeo  = HZ*2;  /* Allow enough time for speed change */
+	dev->watchdog_timeo  = HZ * 2;  /* Allow enough time for speed change */
 #endif
 	dev->open            = smsc_ircc_net_open;
 	dev->stop            = smsc_ircc_net_close;
@@ -444,19 +467,17 @@ static int __init smsc_ircc_open(unsigne
 	self->rx_buff.data = self->rx_buff.head;
 
 	smsc_ircc_setup_io(self, fir_base, sir_base, dma, irq);
-
 	smsc_ircc_setup_qos(self);
-
 	smsc_ircc_init_chip(self);
 
-	if(ircc_transceiver > 0  &&
-	   ircc_transceiver < SMSC_IRCC2_C_NUMBER_OF_TRANSCEIVERS)
+	if (ircc_transceiver > 0  &&
+	    ircc_transceiver < SMSC_IRCC2_C_NUMBER_OF_TRANSCEIVERS)
 		self->transceiver = ircc_transceiver;
 	else
 		smsc_ircc_probe_transceiver(self);
 
 	err = register_netdev(self->netdev);
-	if(err) {
+	if (err) {
 		IRDA_ERROR("%s, Network device registration failed!\n",
 			   driver_name);
 		goto err_out4;
@@ -469,6 +490,7 @@ static int __init smsc_ircc_open(unsigne
 	IRDA_MESSAGE("IrDA: Registered device %s\n", dev->name);
 
 	return 0;
+
  err_out4:
 	dma_free_coherent(NULL, self->tx_buff.truesize,
 			  self->tx_buff.head, self->tx_buff_dma);
@@ -511,16 +533,16 @@ static int smsc_ircc_present(unsigned in
 
 	register_bank(fir_base, 3);
 
-	high    = inb(fir_base+IRCC_ID_HIGH);
-	low     = inb(fir_base+IRCC_ID_LOW);
-	chip    = inb(fir_base+IRCC_CHIP_ID);
-	version = inb(fir_base+IRCC_VERSION);
-	config  = inb(fir_base+IRCC_INTERFACE);
+	high    = inb(fir_base + IRCC_ID_HIGH);
+	low     = inb(fir_base + IRCC_ID_LOW);
+	chip    = inb(fir_base + IRCC_CHIP_ID);
+	version = inb(fir_base + IRCC_VERSION);
+	config  = inb(fir_base + IRCC_INTERFACE);
 	dma     = config & IRCC_INTERFACE_DMA_MASK;
 	irq     = (config & IRCC_INTERFACE_IRQ_MASK) >> 4;
 
 	if (high != 0x10 || low != 0xb8 || (chip != 0xf1 && chip != 0xf2)) {
-	        IRDA_WARNING("%s(), addr 0x%04x - no device found!\n",
+		IRDA_WARNING("%s(), addr 0x%04x - no device found!\n",
 			     __FUNCTION__, fir_base);
 		goto out3;
 	}
@@ -529,6 +551,7 @@ static int smsc_ircc_present(unsigned in
 		     chip & 0x0f, version, fir_base, sir_base, dma, irq);
 
 	return 0;
+
  out3:
 	release_region(sir_base, SMSC_IRCC2_SIR_CHIP_IO_EXTENT);
  out2:
@@ -550,9 +573,9 @@ static void smsc_ircc_setup_io(struct sm
 	unsigned char config, chip_dma, chip_irq;
 
 	register_bank(fir_base, 3);
-	config  = inb(fir_base+IRCC_INTERFACE);
-	chip_dma     = config & IRCC_INTERFACE_DMA_MASK;
-	chip_irq     = (config & IRCC_INTERFACE_IRQ_MASK) >> 4;
+	config = inb(fir_base + IRCC_INTERFACE);
+	chip_dma = config & IRCC_INTERFACE_DMA_MASK;
+	chip_irq = (config & IRCC_INTERFACE_IRQ_MASK) >> 4;
 
 	self->io.fir_base  = fir_base;
 	self->io.sir_base  = sir_base;
@@ -610,41 +633,41 @@ static void smsc_ircc_init_chip(struct s
 {
 	int iobase, ir_mode, ctrl, fast;
 
-	IRDA_ASSERT( self != NULL, return; );
-	iobase = self->io.fir_base;
+	IRDA_ASSERT(self != NULL, return;);
 
+	iobase = self->io.fir_base;
 	ir_mode = IRCC_CFGA_IRDA_SIR_A;
 	ctrl = 0;
 	fast = 0;
 
 	register_bank(iobase, 0);
-	outb(IRCC_MASTER_RESET, iobase+IRCC_MASTER);
-	outb(0x00, iobase+IRCC_MASTER);
+	outb(IRCC_MASTER_RESET, iobase + IRCC_MASTER);
+	outb(0x00, iobase + IRCC_MASTER);
 
 	register_bank(iobase, 1);
-	outb(((inb(iobase+IRCC_SCE_CFGA) & 0x87) | ir_mode),
-	     iobase+IRCC_SCE_CFGA);
+	outb(((inb(iobase + IRCC_SCE_CFGA) & 0x87) | ir_mode),
+	     iobase + IRCC_SCE_CFGA);
 
 #ifdef smsc_669 /* Uses pin 88/89 for Rx/Tx */
-	outb(((inb(iobase+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM),
-	     iobase+IRCC_SCE_CFGB);
+	outb(((inb(iobase + IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM),
+	     iobase + IRCC_SCE_CFGB);
 #else
-	outb(((inb(iobase+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_IR),
-	     iobase+IRCC_SCE_CFGB);
+	outb(((inb(iobase + IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_IR),
+	     iobase + IRCC_SCE_CFGB);
 #endif
-	(void) inb(iobase+IRCC_FIFO_THRESHOLD);
-	outb(SMSC_IRCC2_FIFO_THRESHOLD, iobase+IRCC_FIFO_THRESHOLD);
+	(void) inb(iobase + IRCC_FIFO_THRESHOLD);
+	outb(SMSC_IRCC2_FIFO_THRESHOLD, iobase + IRCC_FIFO_THRESHOLD);
 
 	register_bank(iobase, 4);
-	outb((inb(iobase+IRCC_CONTROL) & 0x30) | ctrl, iobase+IRCC_CONTROL);
+	outb((inb(iobase + IRCC_CONTROL) & 0x30) | ctrl, iobase + IRCC_CONTROL);
 
 	register_bank(iobase, 0);
-	outb(fast, iobase+IRCC_LCR_A);
+	outb(fast, iobase + IRCC_LCR_A);
 
 	smsc_ircc_set_sir_speed(self, SMSC_IRCC2_C_IRDA_FALLBACK_SPEED);
 
 	/* Power on device */
-	outb(0x00, iobase+IRCC_MASTER);
+	outb(0x00, iobase + IRCC_MASTER);
 }
 
 /*
@@ -770,7 +793,7 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
-	if ((speed != self->io.speed) && (speed != -1)) {
+	if (speed != self->io.speed && speed != -1) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			/*
@@ -787,9 +810,8 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
-		} else {
-			self->new_speed = speed;
 		}
+		self->new_speed = speed;
 	}
 
 	/* Init tx buffer */
@@ -802,7 +824,7 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 	self->stats.tx_bytes += self->tx_buff.len;
 
 	/* Turn on transmit finished interrupt. Will fire immediately!  */
-	outb(UART_IER_THRI, iobase+UART_IER);
+	outb(UART_IER_THRI, iobase + UART_IER);
 
 	spin_unlock_irqrestore(&self->lock, flags);
 
@@ -826,7 +848,7 @@ static void smsc_ircc_set_fir_speed(stru
 
 	self->io.speed = speed;
 
-	switch(speed) {
+	switch (speed) {
 	default:
 	case 576000:
 		ir_mode = IRCC_CFGA_IRDA_HDLC;
@@ -853,14 +875,14 @@ static void smsc_ircc_set_fir_speed(stru
 	Now in tranceiver!
 	/* This causes an interrupt */
 	register_bank(fir_base, 0);
-	outb((inb(fir_base+IRCC_LCR_A) &  0xbf) | fast, fir_base+IRCC_LCR_A);
+	outb((inb(fir_base + IRCC_LCR_A) &  0xbf) | fast, fir_base + IRCC_LCR_A);
 	#endif
 
 	register_bank(fir_base, 1);
-	outb(((inb(fir_base+IRCC_SCE_CFGA) & IRCC_SCE_CFGA_BLOCK_CTRL_BITS_MASK) | ir_mode), fir_base+IRCC_SCE_CFGA);
+	outb(((inb(fir_base + IRCC_SCE_CFGA) & IRCC_SCE_CFGA_BLOCK_CTRL_BITS_MASK) | ir_mode), fir_base + IRCC_SCE_CFGA);
 
 	register_bank(fir_base, 4);
-	outb((inb(fir_base+IRCC_CONTROL) & 0x30) | ctrl, fir_base+IRCC_CONTROL);
+	outb((inb(fir_base + IRCC_CONTROL) & 0x30) | ctrl, fir_base + IRCC_CONTROL);
 }
 
 /*
@@ -888,28 +910,28 @@ static void smsc_ircc_fir_start(struct s
 	dev->hard_start_xmit = smsc_ircc_hard_xmit_fir;
 
 	/* Clear FIFO */
-	outb(inb(fir_base+IRCC_LCR_A)|IRCC_LCR_A_FIFO_RESET, fir_base+IRCC_LCR_A);
+	outb(inb(fir_base + IRCC_LCR_A) | IRCC_LCR_A_FIFO_RESET, fir_base + IRCC_LCR_A);
 
 	/* Enable interrupt */
-	/*outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, fir_base+IRCC_IER);*/
+	/*outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, fir_base + IRCC_IER);*/
 
 	register_bank(fir_base, 1);
 
 	/* Select the TX/RX interface */
 #ifdef SMSC_669 /* Uses pin 88/89 for Rx/Tx */
-	outb(((inb(fir_base+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM),
-	     fir_base+IRCC_SCE_CFGB);
+	outb(((inb(fir_base + IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_COM),
+	     fir_base + IRCC_SCE_CFGB);
 #else
-	outb(((inb(fir_base+IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_IR),
-	     fir_base+IRCC_SCE_CFGB);
+	outb(((inb(fir_base + IRCC_SCE_CFGB) & 0x3f) | IRCC_CFGB_MUX_IR),
+	     fir_base + IRCC_SCE_CFGB);
 #endif
-	(void) inb(fir_base+IRCC_FIFO_THRESHOLD);
+	(void) inb(fir_base + IRCC_FIFO_THRESHOLD);
 
 	/* Enable SCE interrupts */
-	outb(0, fir_base+IRCC_MASTER);
+	outb(0, fir_base + IRCC_MASTER);
 	register_bank(fir_base, 0);
-	outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, fir_base+IRCC_IER);
-	outb(IRCC_MASTER_INT_EN, fir_base+IRCC_MASTER);
+	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, fir_base + IRCC_IER);
+	outb(IRCC_MASTER_INT_EN, fir_base + IRCC_MASTER);
 }
 
 /*
@@ -928,8 +950,8 @@ static void smsc_ircc_fir_stop(struct sm
 
 	fir_base = self->io.fir_base;
 	register_bank(fir_base, 0);
-	/*outb(IRCC_MASTER_RESET, fir_base+IRCC_MASTER);*/
-	outb(inb(fir_base+IRCC_LCR_B) & IRCC_LCR_B_SIP_ENABLE, fir_base+IRCC_LCR_B);
+	/*outb(IRCC_MASTER_RESET, fir_base + IRCC_MASTER);*/
+	outb(inb(fir_base + IRCC_LCR_B) & IRCC_LCR_B_SIP_ENABLE, fir_base + IRCC_LCR_B);
 }
 
 
@@ -964,26 +986,26 @@ static void smsc_ircc_change_speed(void 
 	smsc_ircc_fir_start(self);
 	#endif
 
-	if(self->io.speed == 0)
+	if (self->io.speed == 0)
 		smsc_ircc_sir_start(self);
 
 	#if 0
-	if(!last_speed_was_sir) speed = self->io.speed;
+	if (!last_speed_was_sir) speed = self->io.speed;
 	#endif
 
-	if(self->io.speed != speed) smsc_ircc_set_transceiver_for_speed(self, speed);
+	if (self->io.speed != speed)
+		smsc_ircc_set_transceiver_for_speed(self, speed);
 
 	self->io.speed = speed;
 
-	if(speed <= SMSC_IRCC2_MAX_SIR_SPEED) {
-		if(!last_speed_was_sir) {
+	if (speed <= SMSC_IRCC2_MAX_SIR_SPEED) {
+		if (!last_speed_was_sir) {
 			smsc_ircc_fir_stop(self);
 			smsc_ircc_sir_start(self);
 		}
 		smsc_ircc_set_sir_speed(self, speed);
-	}
-	else {
-		if(last_speed_was_sir) {
+	} else {
+		if (last_speed_was_sir) {
 			#if SMSC_IRCC2_C_SIR_STOP
 			smsc_ircc_sir_stop(self);
 			#endif
@@ -1027,9 +1049,9 @@ void smsc_ircc_set_sir_speed(void *priv,
 	self->io.speed = speed;
 
 	/* Turn off interrupts */
-	outb(0, iobase+UART_IER);
+	outb(0, iobase + UART_IER);
 
-	divisor = SMSC_IRCC2_MAX_SIR_SPEED/speed;
+	divisor = SMSC_IRCC2_MAX_SIR_SPEED / speed;
 
 	fcr = UART_FCR_ENABLE_FIFO;
 
@@ -1038,22 +1060,20 @@ void smsc_ircc_set_sir_speed(void *priv,
 	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
 	 * about this timeout since it will always be fast enough.
 	 */
-	if (self->io.speed < 38400)
-		fcr |= UART_FCR_TRIGGER_1;
-	else
-		fcr |= UART_FCR_TRIGGER_14;
+	fcr |= self->io.speed < 38400 ?
+		UART_FCR_TRIGGER_1 : UART_FCR_TRIGGER_14;
 
 	/* IrDA ports use 8N1 */
 	lcr = UART_LCR_WLEN8;
 
-	outb(UART_LCR_DLAB | lcr, iobase+UART_LCR); /* Set DLAB */
-	outb(divisor & 0xff,      iobase+UART_DLL); /* Set speed */
-	outb(divisor >> 8,	  iobase+UART_DLM);
-	outb(lcr,		  iobase+UART_LCR); /* Set 8N1	*/
-	outb(fcr,		  iobase+UART_FCR); /* Enable FIFO's */
+	outb(UART_LCR_DLAB | lcr, iobase + UART_LCR); /* Set DLAB */
+	outb(divisor & 0xff,      iobase + UART_DLL); /* Set speed */
+	outb(divisor >> 8,	  iobase + UART_DLM);
+	outb(lcr,		  iobase + UART_LCR); /* Set 8N1 */
+	outb(fcr,		  iobase + UART_FCR); /* Enable FIFO's */
 
 	/* Turn on interrups */
-	outb(UART_IER_RLSI|UART_IER_RDI|UART_IER_THRI, iobase+UART_IER);
+	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
 
 	IRDA_DEBUG(2, "%s() speed changed to: %d\n", __FUNCTION__, speed);
 }
@@ -1086,7 +1106,7 @@ static int smsc_ircc_hard_xmit_fir(struc
 
 	/* Check if we need to change the speed after this frame */
 	speed = irda_get_next_speed(skb);
-	if ((speed != self->io.speed) && (speed != -1)) {
+	if (speed != self->io.speed && speed != -1) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			/* Note : you should make sure that speed changes
@@ -1096,8 +1116,9 @@ static int smsc_ircc_hard_xmit_fir(struc
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
-		} else
-			self->new_speed = speed;
+		}
+
+		self->new_speed = speed;
 	}
 
 	memcpy(self->tx_buff.head, skb->data, skb->len);
@@ -1122,6 +1143,7 @@ static int smsc_ircc_hard_xmit_fir(struc
 		/* Transmit frame */
 		smsc_ircc_dma_xmit(self, iobase, 0);
 	}
+
 	spin_unlock_irqrestore(&self->lock, flags);
 	dev_kfree_skb(skb);
 
@@ -1142,30 +1164,30 @@ static void smsc_ircc_dma_xmit(struct sm
 #if 1
 	/* Disable Rx */
 	register_bank(iobase, 0);
-	outb(0x00, iobase+IRCC_LCR_B);
+	outb(0x00, iobase + IRCC_LCR_B);
 #endif
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
-	     iobase+IRCC_SCE_CFGB);
+	outb(inb(iobase + IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
+	     iobase + IRCC_SCE_CFGB);
 
 	self->io.direction = IO_XMIT;
 
 	/* Set BOF additional count for generating the min turn time */
 	register_bank(iobase, 4);
-	outb(bofs & 0xff, iobase+IRCC_BOF_COUNT_LO);
-	ctrl = inb(iobase+IRCC_CONTROL) & 0xf0;
-	outb(ctrl | ((bofs >> 8) & 0x0f), iobase+IRCC_BOF_COUNT_HI);
+	outb(bofs & 0xff, iobase + IRCC_BOF_COUNT_LO);
+	ctrl = inb(iobase + IRCC_CONTROL) & 0xf0;
+	outb(ctrl | ((bofs >> 8) & 0x0f), iobase + IRCC_BOF_COUNT_HI);
 
 	/* Set max Tx frame size */
-	outb(self->tx_buff.len >> 8, iobase+IRCC_TX_SIZE_HI);
-	outb(self->tx_buff.len & 0xff, iobase+IRCC_TX_SIZE_LO);
+	outb(self->tx_buff.len >> 8, iobase + IRCC_TX_SIZE_HI);
+	outb(self->tx_buff.len & 0xff, iobase + IRCC_TX_SIZE_LO);
 
 	/*outb(UART_MCR_OUT2, self->io.sir_base + UART_MCR);*/
 
 	/* Enable burst mode chip Tx DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE |
-	     IRCC_CFGB_DMA_BURST, iobase+IRCC_SCE_CFGB);
+	outb(inb(iobase + IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE |
+	     IRCC_CFGB_DMA_BURST, iobase + IRCC_SCE_CFGB);
 
 	/* Setup DMA controller (must be done after enabling chip DMA) */
 	irda_setup_dma(self->io.dma, self->tx_buff_dma, self->tx_buff.len,
@@ -1174,11 +1196,11 @@ static void smsc_ircc_dma_xmit(struct sm
 	/* Enable interrupt */
 
 	register_bank(iobase, 0);
-	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, iobase+IRCC_IER);
-	outb(IRCC_MASTER_INT_EN, iobase+IRCC_MASTER);
+	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, iobase + IRCC_IER);
+	outb(IRCC_MASTER_INT_EN, iobase + IRCC_MASTER);
 
 	/* Enable transmit */
-	outb(IRCC_LCR_B_SCE_TRANSMIT | IRCC_LCR_B_SIP_ENABLE, iobase+IRCC_LCR_B);
+	outb(IRCC_LCR_B_SCE_TRANSMIT | IRCC_LCR_B_SIP_ENABLE, iobase + IRCC_LCR_B);
 }
 
 /*
@@ -1194,25 +1216,25 @@ static void smsc_ircc_dma_xmit_complete(
 #if 0
 	/* Disable Tx */
 	register_bank(iobase, 0);
-	outb(0x00, iobase+IRCC_LCR_B);
+	outb(0x00, iobase + IRCC_LCR_B);
 #endif
 	register_bank(self->io.fir_base, 1);
-	outb(inb(self->io.fir_base+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
-	     self->io.fir_base+IRCC_SCE_CFGB);
+	outb(inb(self->io.fir_base + IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
+	     self->io.fir_base + IRCC_SCE_CFGB);
 
 	/* Check for underrun! */
 	register_bank(iobase, 0);
-	if (inb(iobase+IRCC_LSR) & IRCC_LSR_UNDERRUN) {
+	if (inb(iobase + IRCC_LSR) & IRCC_LSR_UNDERRUN) {
 		self->stats.tx_errors++;
 		self->stats.tx_fifo_errors++;
 
 		/* Reset error condition */
 		register_bank(iobase, 0);
-		outb(IRCC_MASTER_ERROR_RESET, iobase+IRCC_MASTER);
-		outb(0x00, iobase+IRCC_MASTER);
+		outb(IRCC_MASTER_ERROR_RESET, iobase + IRCC_MASTER);
+		outb(0x00, iobase + IRCC_MASTER);
 	} else {
 		self->stats.tx_packets++;
-		self->stats.tx_bytes +=  self->tx_buff.len;
+		self->stats.tx_bytes += self->tx_buff.len;
 	}
 
 	/* Check if it's time to change the speed */
@@ -1236,26 +1258,26 @@ static int smsc_ircc_dma_receive(struct 
 #if 0
 	/* Turn off chip DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
-	     iobase+IRCC_SCE_CFGB);
+	outb(inb(iobase + IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
+	     iobase + IRCC_SCE_CFGB);
 #endif
 
 	/* Disable Tx */
 	register_bank(iobase, 0);
-	outb(0x00, iobase+IRCC_LCR_B);
+	outb(0x00, iobase + IRCC_LCR_B);
 
 	/* Turn off chip DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
-	     iobase+IRCC_SCE_CFGB);
+	outb(inb(iobase + IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
+	     iobase + IRCC_SCE_CFGB);
 
 	self->io.direction = IO_RECV;
 	self->rx_buff.data = self->rx_buff.head;
 
 	/* Set max Rx frame size */
 	register_bank(iobase, 4);
-	outb((2050 >> 8) & 0x0f, iobase+IRCC_RX_SIZE_HI);
-	outb(2050 & 0xff, iobase+IRCC_RX_SIZE_LO);
+	outb((2050 >> 8) & 0x0f, iobase + IRCC_RX_SIZE_HI);
+	outb(2050 & 0xff, iobase + IRCC_RX_SIZE_LO);
 
 	/* Setup DMA controller */
 	irda_setup_dma(self->io.dma, self->rx_buff_dma, self->rx_buff.truesize,
@@ -1263,19 +1285,18 @@ static int smsc_ircc_dma_receive(struct 
 
 	/* Enable burst mode chip Rx DMA */
 	register_bank(iobase, 1);
-	outb(inb(iobase+IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE |
-	     IRCC_CFGB_DMA_BURST, iobase+IRCC_SCE_CFGB);
+	outb(inb(iobase + IRCC_SCE_CFGB) | IRCC_CFGB_DMA_ENABLE |
+	     IRCC_CFGB_DMA_BURST, iobase + IRCC_SCE_CFGB);
 
 	/* Enable interrupt */
 	register_bank(iobase, 0);
-	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, iobase+IRCC_IER);
-	outb(IRCC_MASTER_INT_EN, iobase+IRCC_MASTER);
-
+	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, iobase + IRCC_IER);
+	outb(IRCC_MASTER_INT_EN, iobase + IRCC_MASTER);
 
 	/* Enable receiver */
 	register_bank(iobase, 0);
 	outb(IRCC_LCR_B_SCE_RECEIVE | IRCC_LCR_B_SIP_ENABLE,
-	     iobase+IRCC_LCR_B);
+	     iobase + IRCC_LCR_B);
 
 	return 0;
 }
@@ -1297,43 +1318,43 @@ static void smsc_ircc_dma_receive_comple
 #if 0
 	/* Disable Rx */
 	register_bank(iobase, 0);
-	outb(0x00, iobase+IRCC_LCR_B);
+	outb(0x00, iobase + IRCC_LCR_B);
 #endif
 	register_bank(iobase, 0);
-	outb(inb(iobase+IRCC_LSAR) & ~IRCC_LSAR_ADDRESS_MASK, iobase+IRCC_LSAR);
-	lsr= inb(iobase+IRCC_LSR);
-	msgcnt = inb(iobase+IRCC_LCR_B) & 0x08;
+	outb(inb(iobase + IRCC_LSAR) & ~IRCC_LSAR_ADDRESS_MASK, iobase + IRCC_LSAR);
+	lsr= inb(iobase + IRCC_LSR);
+	msgcnt = inb(iobase + IRCC_LCR_B) & 0x08;
 
 	IRDA_DEBUG(2, "%s: dma count = %d\n", __FUNCTION__,
 		   get_dma_residue(self->io.dma));
 
 	len = self->rx_buff.truesize - get_dma_residue(self->io.dma);
 
-	/* Look for errors
-	 */
-
-	if(lsr & (IRCC_LSR_FRAME_ERROR | IRCC_LSR_CRC_ERROR | IRCC_LSR_SIZE_ERROR)) {
+	/* Look for errors */
+	if (lsr & (IRCC_LSR_FRAME_ERROR | IRCC_LSR_CRC_ERROR | IRCC_LSR_SIZE_ERROR)) {
 		self->stats.rx_errors++;
-		if(lsr & IRCC_LSR_FRAME_ERROR) self->stats.rx_frame_errors++;
-		if(lsr & IRCC_LSR_CRC_ERROR) self->stats.rx_crc_errors++;
-		if(lsr & IRCC_LSR_SIZE_ERROR) self->stats.rx_length_errors++;
-		if(lsr & (IRCC_LSR_UNDERRUN | IRCC_LSR_OVERRUN)) self->stats.rx_length_errors++;
+		if (lsr & IRCC_LSR_FRAME_ERROR)
+			self->stats.rx_frame_errors++;
+		if (lsr & IRCC_LSR_CRC_ERROR)
+			self->stats.rx_crc_errors++;
+		if (lsr & IRCC_LSR_SIZE_ERROR)
+			self->stats.rx_length_errors++;
+		if (lsr & (IRCC_LSR_UNDERRUN | IRCC_LSR_OVERRUN))
+			self->stats.rx_length_errors++;
 		return;
 	}
+
 	/* Remove CRC */
-	if (self->io.speed < 4000000)
-		len -= 2;
-	else
-		len -= 4;
+	len -= self->io.speed < 4000000 ? 2 : 4;
 
-	if ((len < 2) || (len > 2050)) {
+	if (len < 2 || len > 2050) {
 		IRDA_WARNING("%s(), bogus len=%d\n", __FUNCTION__, len);
 		return;
 	}
 	IRDA_DEBUG(2, "%s: msgcnt = %d, len=%d\n", __FUNCTION__, msgcnt, len);
 
-	skb = dev_alloc_skb(len+1);
-	if (!skb)  {
+	skb = dev_alloc_skb(len + 1);
+	if (!skb) {
 		IRDA_WARNING("%s(), memory squeeze, dropping frame.\n",
 			     __FUNCTION__);
 		return;
@@ -1372,14 +1393,14 @@ static void smsc_ircc_sir_receive(struct
 	 */
 	do {
 		async_unwrap_char(self->netdev, &self->stats, &self->rx_buff,
-				  inb(iobase+UART_RX));
+				  inb(iobase + UART_RX));
 
 		/* Make sure we don't stay here to long */
 		if (boguscount++ > 32) {
 			IRDA_DEBUG(2, "%s(), breaking!\n", __FUNCTION__);
 			break;
 		}
-	} while (inb(iobase+UART_LSR) & UART_LSR_DR);
+	} while (inb(iobase + UART_LSR) & UART_LSR_DR);
 }
 
 
@@ -1408,7 +1429,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 	spin_lock(&self->lock);
 
 	/* Check if we should use the SIR interrupt handler */
-	if (self->io.speed <=  SMSC_IRCC2_MAX_SIR_SPEED) {
+	if (self->io.speed <= SMSC_IRCC2_MAX_SIR_SPEED) {
 		ret = smsc_ircc_interrupt_sir(dev);
 		goto irq_ret_unlock;
 	}
@@ -1416,15 +1437,15 @@ static irqreturn_t smsc_ircc_interrupt(i
 	iobase = self->io.fir_base;
 
 	register_bank(iobase, 0);
-	iir = inb(iobase+IRCC_IIR);
+	iir = inb(iobase + IRCC_IIR);
 	if (iir == 0)
 		goto irq_ret_unlock;
 	ret = IRQ_HANDLED;
 
 	/* Disable interrupts */
-	outb(0, iobase+IRCC_IER);
-	lcra = inb(iobase+IRCC_LCR_A);
-	lsr = inb(iobase+IRCC_LSR);
+	outb(0, iobase + IRCC_IER);
+	lcra = inb(iobase + IRCC_LCR_A);
+	lsr = inb(iobase + IRCC_LSR);
 
 	IRDA_DEBUG(2, "%s(), iir = 0x%02x\n", __FUNCTION__, iir);
 
@@ -1444,7 +1465,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 	/* Enable interrupts again */
 
 	register_bank(iobase, 0);
-	outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, iobase+IRCC_IER);
+	outb(IRCC_IER_ACTIVE_FRAME | IRCC_IER_EOM, iobase + IRCC_IER);
 
  irq_ret_unlock:
 	spin_unlock(&self->lock);
@@ -1469,12 +1490,12 @@ static irqreturn_t smsc_ircc_interrupt_s
 
 	iobase = self->io.sir_base;
 
-	iir = inb(iobase+UART_IIR) & UART_IIR_ID;
+	iir = inb(iobase + UART_IIR) & UART_IIR_ID;
 	if (iir == 0)
 		return IRQ_NONE;
 	while (iir) {
 		/* Clear interrupt */
-		lsr = inb(iobase+UART_LSR);
+		lsr = inb(iobase + UART_LSR);
 
 		IRDA_DEBUG(4, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n",
 			    __FUNCTION__, iir, lsr, iobase);
@@ -1624,9 +1645,7 @@ static int smsc_ircc_net_close(struct ne
 	self->irlap = NULL;
 
 	free_irq(self->io.irq, dev);
-
 	disable_dma(self->io.dma);
-
 	free_dma(self->io.dma);
 
 	return 0;
@@ -1637,12 +1656,10 @@ static void smsc_ircc_suspend(struct sms
 {
 	IRDA_MESSAGE("%s, Suspending\n", driver_name);
 
-	if (self->io.suspended)
-		return;
-
-	smsc_ircc_net_close(self->netdev);
-
-	self->io.suspended = 1;
+	if (!self->io.suspended) {
+		smsc_ircc_net_close(self->netdev);
+		self->io.suspended = 1;
+	}
 }
 
 static void smsc_ircc_wakeup(struct smsc_ircc_cb *self)
@@ -1703,14 +1720,14 @@ static int __exit smsc_ircc_close(struct
 
 	/* Stop interrupts */
 	register_bank(iobase, 0);
-	outb(0, iobase+IRCC_IER);
-	outb(IRCC_MASTER_RESET, iobase+IRCC_MASTER);
-	outb(0x00, iobase+IRCC_MASTER);
+	outb(0, iobase + IRCC_IER);
+	outb(IRCC_MASTER_RESET, iobase + IRCC_MASTER);
+	outb(0x00, iobase + IRCC_MASTER);
 #if 0
 	/* Reset to SIR mode */
 	register_bank(iobase, 1);
-        outb(IRCC_CFGA_IRDA_SIR_A|IRCC_CFGA_TX_POLARITY, iobase+IRCC_SCE_CFGA);
-        outb(IRCC_CFGB_IR, iobase+IRCC_SCE_CFGB);
+        outb(IRCC_CFGA_IRDA_SIR_A|IRCC_CFGA_TX_POLARITY, iobase + IRCC_SCE_CFGA);
+        outb(IRCC_CFGB_IR, iobase + IRCC_SCE_CFGB);
 #endif
 	spin_unlock_irqrestore(&self->lock, flags);
 
@@ -1744,7 +1761,7 @@ static void __exit smsc_ircc_cleanup(voi
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
-	for (i=0; i < 2; i++) {
+	for (i = 0; i < 2; i++) {
 		if (dev_self[i])
 			smsc_ircc_close(dev_self[i]);
 	}
@@ -1764,7 +1781,7 @@ void smsc_ircc_sir_start(struct smsc_irc
 	IRDA_DEBUG(3, "%s\n", __FUNCTION__);
 
 	IRDA_ASSERT(self != NULL, return;);
-	dev= self->netdev;
+	dev = self->netdev;
 	IRDA_ASSERT(dev != NULL, return;);
 	dev->hard_start_xmit = &smsc_ircc_hard_xmit_sir;
 
@@ -1772,25 +1789,25 @@ void smsc_ircc_sir_start(struct smsc_irc
 	sir_base = self->io.sir_base;
 
 	/* Reset everything */
-	outb(IRCC_MASTER_RESET, fir_base+IRCC_MASTER);
+	outb(IRCC_MASTER_RESET, fir_base + IRCC_MASTER);
 
 	#if SMSC_IRCC2_C_SIR_STOP
 	/*smsc_ircc_sir_stop(self);*/
 	#endif
 
 	register_bank(fir_base, 1);
-	outb(((inb(fir_base+IRCC_SCE_CFGA) & IRCC_SCE_CFGA_BLOCK_CTRL_BITS_MASK) | IRCC_CFGA_IRDA_SIR_A), fir_base+IRCC_SCE_CFGA);
+	outb(((inb(fir_base + IRCC_SCE_CFGA) & IRCC_SCE_CFGA_BLOCK_CTRL_BITS_MASK) | IRCC_CFGA_IRDA_SIR_A), fir_base + IRCC_SCE_CFGA);
 
 	/* Initialize UART */
-	outb(UART_LCR_WLEN8, sir_base+UART_LCR);  /* Reset DLAB */
-	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), sir_base+UART_MCR);
+	outb(UART_LCR_WLEN8, sir_base + UART_LCR);  /* Reset DLAB */
+	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), sir_base + UART_MCR);
 
 	/* Turn on interrups */
-	outb(UART_IER_RLSI | UART_IER_RDI |UART_IER_THRI, sir_base+UART_IER);
+	outb(UART_IER_RLSI | UART_IER_RDI |UART_IER_THRI, sir_base + UART_IER);
 
 	IRDA_DEBUG(3, "%s() - exit\n", __FUNCTION__);
 
-	outb(0x00, fir_base+IRCC_MASTER);
+	outb(0x00, fir_base + IRCC_MASTER);
 }
 
 #if SMSC_IRCC2_C_SIR_STOP
@@ -1802,10 +1819,10 @@ void smsc_ircc_sir_stop(struct smsc_ircc
 	iobase = self->io.sir_base;
 
 	/* Reset UART */
-	outb(0, iobase+UART_MCR);
+	outb(0, iobase + UART_MCR);
 
 	/* Turn off interrupts */
-	outb(0, iobase+UART_IER);
+	outb(0, iobase + UART_IER);
 }
 #endif
 
@@ -1856,21 +1873,19 @@ static void smsc_ircc_sir_write_wakeup(s
 		}
 		self->stats.tx_packets++;
 
-		if(self->io.speed <= 115200) {
-		/*
-		 * Reset Rx FIFO to make sure that all reflected transmit data
-		 * is discarded. This is needed for half duplex operation
-		 */
-		fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR;
-		if (self->io.speed < 38400)
-			fcr |= UART_FCR_TRIGGER_1;
-		else
-			fcr |= UART_FCR_TRIGGER_14;
+		if (self->io.speed <= 115200) {
+			/*
+			 * Reset Rx FIFO to make sure that all reflected transmit data
+			 * is discarded. This is needed for half duplex operation
+			 */
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR;
+			fcr |= self->io.speed < 38400 ?
+					UART_FCR_TRIGGER_1 : UART_FCR_TRIGGER_14;
 
-		outb(fcr, iobase+UART_FCR);
+			outb(fcr, iobase + UART_FCR);
 
-		/* Turn on receive interrupts */
-		outb(UART_IER_RDI, iobase+UART_IER);
+			/* Turn on receive interrupts */
+			outb(UART_IER_RDI, iobase + UART_IER);
 		}
 	}
 }
@@ -1886,15 +1901,15 @@ static int smsc_ircc_sir_write(int iobas
 	int actual = 0;
 
 	/* Tx FIFO should be empty! */
-	if (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
+	if (!(inb(iobase + UART_LSR) & UART_LSR_THRE)) {
 		IRDA_WARNING("%s(), failed, fifo not empty!\n", __FUNCTION__);
 		return 0;
 	}
 
 	/* Fill FIFO with current frame */
-	while ((fifo_size-- > 0) && (actual < len)) {
+	while (fifo_size-- > 0 && actual < len) {
 		/* Transmit next byte */
-		outb(buf[actual], iobase+UART_TX);
+		outb(buf[actual], iobase + UART_TX);
 		actual++;
 	}
 	return actual;
@@ -1924,17 +1939,18 @@ static void smsc_ircc_probe_transceiver(
 
 	IRDA_ASSERT(self != NULL, return;);
 
-	for(i=0; smsc_transceivers[i].name!=NULL; i++)
-		if((*smsc_transceivers[i].probe)(self->io.fir_base)) {
+	for (i = 0; smsc_transceivers[i].name != NULL; i++)
+		if (smsc_transceivers[i].probe(self->io.fir_base)) {
 			IRDA_MESSAGE(" %s transceiver found\n",
 				     smsc_transceivers[i].name);
-			self->transceiver= i+1;
+			self->transceiver= i + 1;
 			return;
 		}
+
 	IRDA_MESSAGE("No transceiver found. Defaulting to %s\n",
 		     smsc_transceivers[SMSC_IRCC2_C_DEFAULT_TRANSCEIVER].name);
 
-	self->transceiver= SMSC_IRCC2_C_DEFAULT_TRANSCEIVER;
+	self->transceiver = SMSC_IRCC2_C_DEFAULT_TRANSCEIVER;
 }
 
 
@@ -1949,7 +1965,8 @@ static void smsc_ircc_set_transceiver_fo
 	unsigned int trx;
 
 	trx = self->transceiver;
-	if(trx>0) (*smsc_transceivers[trx-1].set_for_speed)(self->io.fir_base, speed);
+	if (trx > 0)
+		smsc_transceivers[trx - 1].set_for_speed(self->io.fir_base, speed);
 }
 
 /*
@@ -1977,16 +1994,14 @@ static void smsc_ircc_set_transceiver_fo
 
 static void smsc_ircc_sir_wait_hw_transmitter_finish(struct smsc_ircc_cb *self)
 {
-	int iobase;
+	int iobase = self->io.sir_base;
 	int count = SMSC_IRCC2_HW_TRANSMITTER_TIMEOUT_US;
 
-	iobase = self->io.sir_base;
-
 	/* Calibrated busy loop */
-	while((count-- > 0) && !(inb(iobase+UART_LSR) & UART_LSR_TEMT))
+	while (count-- > 0 && !(inb(iobase + UART_LSR) & UART_LSR_TEMT))
 		udelay(1);
 
-	if(count == 0)
+	if (count == 0)
 		IRDA_DEBUG(0, "%s(): stuck transmitter\n", __FUNCTION__);
 }
 
@@ -1999,34 +2014,36 @@ static void smsc_ircc_sir_wait_hw_transm
 static int __init smsc_ircc_look_for_chips(void)
 {
 	smsc_chip_address_t *address;
-	char	*type;
+	char *type;
 	unsigned int cfg_base, found;
 
 	found = 0;
 	address = possible_addresses;
 
-	while(address->cfg_base){
+	while (address->cfg_base) {
 		cfg_base = address->cfg_base;
 
 		/*printk(KERN_WARNING "%s(): probing: 0x%02x for: 0x%02x\n", __FUNCTION__, cfg_base, address->type);*/
 
-		if( address->type & SMSCSIO_TYPE_FDC){
+		if (address->type & SMSCSIO_TYPE_FDC) {
 			type = "FDC";
-			if((address->type) & SMSCSIO_TYPE_FLAT) {
-				if(!smsc_superio_flat(fdc_chips_flat,cfg_base, type)) found++;
-			}
-			if((address->type) & SMSCSIO_TYPE_PAGED) {
-				if(!smsc_superio_paged(fdc_chips_paged,cfg_base, type)) found++;
-			}
+			if (address->type & SMSCSIO_TYPE_FLAT)
+				if (!smsc_superio_flat(fdc_chips_flat, cfg_base, type))
+					found++;
+
+			if (address->type & SMSCSIO_TYPE_PAGED)
+				if (!smsc_superio_paged(fdc_chips_paged, cfg_base, type))
+					found++;
 		}
-		if( address->type & SMSCSIO_TYPE_LPC){
+		if (address->type & SMSCSIO_TYPE_LPC) {
 			type = "LPC";
-			if((address->type) & SMSCSIO_TYPE_FLAT) {
-				if(!smsc_superio_flat(lpc_chips_flat,cfg_base,type)) found++;
-			}
-			if((address->type) & SMSCSIO_TYPE_PAGED) {
-				if(!smsc_superio_paged(lpc_chips_paged,cfg_base,"LPC")) found++;
-			}
+			if (address->type & SMSCSIO_TYPE_FLAT)
+				if (!smsc_superio_flat(lpc_chips_flat, cfg_base, type))
+					found++;
+
+			if (address->type & SMSCSIO_TYPE_PAGED)
+				if (!smsc_superio_paged(lpc_chips_paged, cfg_base, type))
+					found++;
 		}
 		address++;
 	}
@@ -2047,38 +2064,36 @@ static int __init smsc_superio_flat(cons
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
-	if (smsc_ircc_probe(cfgbase, SMSCSIOFLAT_DEVICEID_REG, chips, type)==NULL)
+	if (smsc_ircc_probe(cfgbase, SMSCSIOFLAT_DEVICEID_REG, chips, type) == NULL)
 		return ret;
 
 	outb(SMSCSIOFLAT_UARTMODE0C_REG, cfgbase);
-	mode = inb(cfgbase+1);
+	mode = inb(cfgbase + 1);
 
 	/*printk(KERN_WARNING "%s(): mode: 0x%02x\n", __FUNCTION__, mode);*/
 
-	if(!(mode & SMSCSIOFLAT_UART2MODE_VAL_IRDA))
+	if (!(mode & SMSCSIOFLAT_UART2MODE_VAL_IRDA))
 		IRDA_WARNING("%s(): IrDA not enabled\n", __FUNCTION__);
 
 	outb(SMSCSIOFLAT_UART2BASEADDR_REG, cfgbase);
-	sirbase = inb(cfgbase+1) << 2;
+	sirbase = inb(cfgbase + 1) << 2;
 
 	/* FIR iobase */
 	outb(SMSCSIOFLAT_FIRBASEADDR_REG, cfgbase);
-	firbase = inb(cfgbase+1) << 3;
+	firbase = inb(cfgbase + 1) << 3;
 
 	/* DMA */
 	outb(SMSCSIOFLAT_FIRDMASELECT_REG, cfgbase);
-	dma = inb(cfgbase+1) & SMSCSIOFLAT_FIRDMASELECT_MASK;
+	dma = inb(cfgbase + 1) & SMSCSIOFLAT_FIRDMASELECT_MASK;
 
 	/* IRQ */
 	outb(SMSCSIOFLAT_UARTIRQSELECT_REG, cfgbase);
-	irq = inb(cfgbase+1) & SMSCSIOFLAT_UART2IRQSELECT_MASK;
+	irq = inb(cfgbase + 1) & SMSCSIOFLAT_UART2IRQSELECT_MASK;
 
 	IRDA_MESSAGE("%s(): fir: 0x%02x, sir: 0x%02x, dma: %02d, irq: %d, mode: 0x%02x\n", __FUNCTION__, firbase, sirbase, dma, irq, mode);
 
-	if (firbase) {
-		if (smsc_ircc_open(firbase, sirbase, dma, irq) == 0)
-			ret=0;
-	}
+	if (firbase && smsc_ircc_open(firbase, sirbase, dma, irq) == 0)
+		ret = 0;
 
 	/* Exit configuration */
 	outb(SMSCSIO_CFGEXITKEY, cfgbase);
@@ -2099,7 +2114,7 @@ static int __init smsc_superio_paged(con
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
-	if (smsc_ircc_probe(cfg_base,0x20,chips,type)==NULL)
+	if (smsc_ircc_probe(cfg_base, 0x20, chips, type) == NULL)
 		return ret;
 
 	/* Select logical device (UART2) */
@@ -2108,7 +2123,7 @@ static int __init smsc_superio_paged(con
 
 	/* SIR iobase */
 	outb(0x60, cfg_base);
-	sir_io  = inb(cfg_base + 1) << 8;
+	sir_io = inb(cfg_base + 1) << 8;
 	outb(0x61, cfg_base);
 	sir_io |= inb(cfg_base + 1);
 
@@ -2119,10 +2134,8 @@ static int __init smsc_superio_paged(con
 	fir_io |= inb(cfg_base + 1);
 	outb(0x2b, cfg_base); /* ??? */
 
-	if (fir_io) {
-		if (smsc_ircc_open(fir_io, sir_io, ircc_dma, ircc_irq) == 0)
-			ret=0;
-	}
+	if (fir_io && smsc_ircc_open(fir_io, sir_io, ircc_dma, ircc_irq) == 0)
+		ret = 0;
 
 	/* Exit configuration */
 	outb(SMSCSIO_CFGEXITKEY, cfg_base);
@@ -2131,21 +2144,17 @@ static int __init smsc_superio_paged(con
 }
 
 
-static int __init smsc_access(unsigned short cfg_base,unsigned char reg)
+static int __init smsc_access(unsigned short cfg_base, unsigned char reg)
 {
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
 	outb(reg, cfg_base);
-
-	if (inb(cfg_base)!=reg)
-		return -1;
-
-	return 0;
+	return inb(cfg_base) != reg ? -1 : 0;
 }
 
-static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base,u8 reg,const smsc_chip_t *chip,char *type)
+static const smsc_chip_t * __init smsc_ircc_probe(unsigned short cfg_base, u8 reg, const smsc_chip_t *chip, char *type)
 {
-	u8 devid,xdevid,rev;
+	u8 devid, xdevid, rev;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
@@ -2158,7 +2167,7 @@ static const smsc_chip_t * __init smsc_i
 
 	outb(reg, cfg_base);
 
-	xdevid=inb(cfg_base+1);
+	xdevid = inb(cfg_base + 1);
 
 	/* Enter configuration */
 
@@ -2171,48 +2180,46 @@ static const smsc_chip_t * __init smsc_i
 
 	/* probe device ID */
 
-	if (smsc_access(cfg_base,reg))
+	if (smsc_access(cfg_base, reg))
 		return NULL;
 
-	devid=inb(cfg_base+1);
-
-	if (devid==0)			/* typical value for unused port */
-		return NULL;
+	devid = inb(cfg_base + 1);
 
-	if (devid==0xff)		/* typical value for unused port */
+	if (devid == 0 || devid == 0xff)	/* typical values for unused port */
 		return NULL;
 
 	/* probe revision ID */
 
-	if (smsc_access(cfg_base,reg+1))
+	if (smsc_access(cfg_base, reg + 1))
 		return NULL;
 
-	rev=inb(cfg_base+1);
+	rev = inb(cfg_base + 1);
 
-	if (rev>=128)			/* i think this will make no sense */
+	if (rev >= 128)			/* i think this will make no sense */
 		return NULL;
 
-	if (devid==xdevid)		/* protection against false positives */
+	if (devid == xdevid)		/* protection against false positives */
 		return NULL;
 
 	/* Check for expected device ID; are there others? */
 
-	while(chip->devid!=devid) {
+	while (chip->devid != devid) {
 
 		chip++;
 
-		if (chip->name==NULL)
+		if (chip->name == NULL)
 			return NULL;
 	}
 
-	IRDA_MESSAGE("found SMC SuperIO Chip (devid=0x%02x rev=%02X base=0x%04x): %s%s\n",devid,rev,cfg_base,type,chip->name);
+	IRDA_MESSAGE("found SMC SuperIO Chip (devid=0x%02x rev=%02X base=0x%04x): %s%s\n",
+		     devid, rev, cfg_base, type, chip->name);
 
-	if (chip->rev>rev){
+	if (chip->rev > rev) {
 		IRDA_MESSAGE("Revision higher than expected\n");
 		return NULL;
 	}
 
-	if (chip->flags&NoIRDA)
+	if (chip->flags & NoIRDA)
 		IRDA_MESSAGE("chipset does not support IRDA\n");
 
 	return chip;
@@ -2226,8 +2233,8 @@ static int __init smsc_superio_fdc(unsig
 		IRDA_WARNING("%s: can't get cfg_base of 0x%03x\n",
 			     __FUNCTION__, cfg_base);
 	} else {
-		if (!smsc_superio_flat(fdc_chips_flat,cfg_base,"FDC")
-		    ||!smsc_superio_paged(fdc_chips_paged,cfg_base,"FDC"))
+		if (!smsc_superio_flat(fdc_chips_flat, cfg_base, "FDC") ||
+		    !smsc_superio_paged(fdc_chips_paged, cfg_base, "FDC"))
 			ret =  0;
 
 		release_region(cfg_base, 2);
@@ -2244,9 +2251,10 @@ static int __init smsc_superio_lpc(unsig
 		IRDA_WARNING("%s: can't get cfg_base of 0x%03x\n",
 			     __FUNCTION__, cfg_base);
 	} else {
-		if (!smsc_superio_flat(lpc_chips_flat,cfg_base,"LPC")
-		    ||!smsc_superio_paged(lpc_chips_paged,cfg_base,"LPC"))
+		if (!smsc_superio_flat(lpc_chips_flat, cfg_base, "LPC") ||
+		    !smsc_superio_paged(lpc_chips_paged, cfg_base, "LPC"))
 			ret = 0;
+
 		release_region(cfg_base, 2);
 	}
 	return ret;
@@ -2269,18 +2277,23 @@ static int __init smsc_superio_lpc(unsig
 static void smsc_ircc_set_transceiver_smsc_ircc_atc(int fir_base, u32 speed)
 {
 	unsigned long jiffies_now, jiffies_timeout;
-	u8	val;
+	u8 val;
 
-	jiffies_now= jiffies;
-	jiffies_timeout= jiffies+SMSC_IRCC2_ATC_PROGRAMMING_TIMEOUT_JIFFIES;
+	jiffies_now = jiffies;
+	jiffies_timeout = jiffies + SMSC_IRCC2_ATC_PROGRAMMING_TIMEOUT_JIFFIES;
 
 	/* ATC */
 	register_bank(fir_base, 4);
-	outb((inb(fir_base+IRCC_ATC) & IRCC_ATC_MASK) |IRCC_ATC_nPROGREADY|IRCC_ATC_ENABLE, fir_base+IRCC_ATC);
-	while((val=(inb(fir_base+IRCC_ATC) & IRCC_ATC_nPROGREADY)) && !time_after(jiffies, jiffies_timeout));
-	if(val)
+	outb((inb(fir_base + IRCC_ATC) & IRCC_ATC_MASK) | IRCC_ATC_nPROGREADY|IRCC_ATC_ENABLE,
+	     fir_base + IRCC_ATC);
+
+	while ((val = (inb(fir_base + IRCC_ATC) & IRCC_ATC_nPROGREADY)) &&
+		!time_after(jiffies, jiffies_timeout))
+		/* empty */;
+
+	if (val)
 		IRDA_WARNING("%s(): ATC: 0x%02x\n", __FUNCTION__,
-			     inb(fir_base+IRCC_ATC));
+			     inb(fir_base + IRCC_ATC));
 }
 
 /*
@@ -2304,22 +2317,20 @@ static int smsc_ircc_probe_transceiver_s
 
 static void smsc_ircc_set_transceiver_smsc_ircc_fast_pin_select(int fir_base, u32 speed)
 {
-	u8	fast_mode;
+	u8 fast_mode;
 
-	switch(speed)
-	{
-		default:
-		case 576000 :
+	switch (speed) {
+	default:
+	case 576000 :
 		fast_mode = 0;
 		break;
-		case 1152000 :
-		case 4000000 :
+	case 1152000 :
+	case 4000000 :
 		fast_mode = IRCC_LCR_A_FAST;
 		break;
-
 	}
 	register_bank(fir_base, 0);
-	outb((inb(fir_base+IRCC_LCR_A) &  0xbf) | fast_mode, fir_base+IRCC_LCR_A);
+	outb((inb(fir_base + IRCC_LCR_A) & 0xbf) | fast_mode, fir_base + IRCC_LCR_A);
 }
 
 /*
@@ -2343,23 +2354,22 @@ static int smsc_ircc_probe_transceiver_s
 
 static void smsc_ircc_set_transceiver_toshiba_sat1800(int fir_base, u32 speed)
 {
-	u8	fast_mode;
+	u8 fast_mode;
 
-	switch(speed)
-	{
-		default:
-		case 576000 :
+	switch (speed) {
+	default:
+	case 576000 :
 		fast_mode = 0;
 		break;
-		case 1152000 :
-		case 4000000 :
+	case 1152000 :
+	case 4000000 :
 		fast_mode = /*IRCC_LCR_A_FAST |*/ IRCC_LCR_A_GP_DATA;
 		break;
 
 	}
 	/* This causes an interrupt */
 	register_bank(fir_base, 0);
-	outb((inb(fir_base+IRCC_LCR_A) &  0xbf) | fast_mode, fir_base+IRCC_LCR_A);
+	outb((inb(fir_base + IRCC_LCR_A) &  0xbf) | fast_mode, fir_base + IRCC_LCR_A);
 }
 
 /*
@@ -2377,20 +2387,3 @@ static int smsc_ircc_probe_transceiver_t
 
 module_init(smsc_ircc_init);
 module_exit(smsc_ircc_cleanup);
-
-MODULE_AUTHOR("Daniele Peri <peri@csai.unipa.it>");
-MODULE_DESCRIPTION("SMC IrCC SIR/FIR controller driver");
-MODULE_LICENSE("GPL");
-
-module_param(ircc_dma, int, 0);
-MODULE_PARM_DESC(ircc_dma, "DMA channel");
-module_param(ircc_irq, int, 0);
-MODULE_PARM_DESC(ircc_irq, "IRQ line");
-module_param(ircc_fir, int, 0);
-MODULE_PARM_DESC(ircc_fir, "FIR Base Address");
-module_param(ircc_sir, int, 0);
-MODULE_PARM_DESC(ircc_sir, "SIR Base Address");
-module_param(ircc_cfg, int, 0);
-MODULE_PARM_DESC(ircc_cfg, "Configuration register base address");
-module_param(ircc_transceiver, int, 0);
-MODULE_PARM_DESC(ircc_transceiver, "Transceiver type");

