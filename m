Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422898AbWJFTer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWJFTer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWJFTeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:34:46 -0400
Received: from havoc.gtf.org ([69.61.125.42]:19436 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422898AbWJFTek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:34:40 -0400
Date: Fri, 6 Oct 2006 15:34:38 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [git-or-PATCH] IRQ handler cleanups
Message-ID: <20061006193438.GA10730@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the pure-cleanup stuff I pulled out of this morning's
remove-irq-arg work.  No behavior changes, just killing dead code,
killing unused 'irq' arguments in sub-functions, and killing void*
casts.

Please pull from 'irqclean-submit1' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git irqclean-submit1

to receive the following updates:

 arch/i386/kernel/time.c            |    4 ++--
 drivers/atm/ambassador.c           |    7 +------
 drivers/atm/horizon.c              |    9 ---------
 drivers/atm/lanai.c                |    4 +---
 drivers/block/DAC960.c             |   14 +++++++-------
 drivers/cdrom/mcdx.c               |    4 ----
 drivers/char/rio/func.h            |    2 +-
 drivers/char/rio/rio_linux.c       |    4 ++--
 drivers/char/rio/riointr.c         |    2 +-
 drivers/char/riscom8.c             |    7 +++----
 drivers/char/specialix.c           |    2 +-
 drivers/isdn/act2000/act2000_isa.c |   22 ++++++----------------
 drivers/media/video/zoran_device.c |    2 +-
 drivers/net/3c509.c                |    7 +------
 drivers/net/3c523.c                |    7 ++-----
 drivers/net/3c527.c                |    5 -----
 drivers/net/8390.c                 |    8 +-------
 drivers/net/atp.c                  |    6 +-----
 drivers/net/de600.c                |    6 ------
 drivers/net/declance.c             |    4 ++--
 drivers/net/dgrs.c                 |    4 ++--
 drivers/net/eepro.c                |   22 +---------------------
 drivers/net/eexpress.c             |    7 -------
 drivers/net/irda/ali-ircc.c        |   10 ++--------
 drivers/net/irda/donauboe.c        |   11 +----------
 drivers/net/irda/irport.c          |    8 ++------
 drivers/net/irda/irport.h          |    2 +-
 drivers/net/irda/nsc-ircc.c        |    9 ++-------
 drivers/net/irda/w83977af_ir.c     |    9 ++-------
 drivers/net/lance.c                |    5 -----
 drivers/net/pcmcia/axnet_cs.c      |    8 +-------
 drivers/net/pcnet32.c              |    7 -------
 drivers/net/plip.c                 |    5 -----
 drivers/net/saa9730.c              |    2 +-
 drivers/net/sb1000.c               |    8 +-------
 drivers/net/skfp/skfddi.c          |    7 +------
 drivers/net/sonic.c                |    7 +------
 drivers/net/sunhme.c               |    4 ++--
 drivers/net/sunlance.c             |    2 +-
 drivers/net/sunqe.c                |    2 +-
 drivers/net/tokenring/smctr.c      |    7 -------
 drivers/net/tokenring/tms380tr.c   |    5 -----
 drivers/net/tulip/de4x5.c          |    6 +-----
 drivers/net/wan/cycx_main.c        |    4 ++--
 drivers/net/wan/sdla.c             |    8 +-------
 drivers/net/wireless/orinoco.c     |    2 +-
 drivers/net/wireless/wavelan_cs.c  |   11 +----------
 drivers/net/wireless/wl3501_cs.c   |   15 ++++-----------
 drivers/net/yellowfin.c            |    7 -------
 drivers/net/znet.c                 |    5 -----
 drivers/pcmcia/at91_cf.c           |    2 +-
 drivers/pcmcia/hd64465_ss.c        |    7 +++----
 drivers/scsi/NCR53c406a.c          |    8 ++++----
 drivers/scsi/aha152x.c             |    7 +------
 drivers/scsi/aic7xxx_old.c         |   12 ++++++------
 drivers/scsi/dc395x.c              |    2 +-
 drivers/scsi/qlogicfas408.c        |    6 +++---
 drivers/scsi/tmscsim.c             |    8 ++++----
 drivers/scsi/ultrastor.c           |    8 ++++----
 drivers/serial/68360serial.c       |    2 +-
 drivers/serial/jsm/jsm_neo.c       |    2 +-
 drivers/serial/mpc52xx_uart.c      |   10 +---------
 drivers/serial/netx-serial.c       |    2 +-
 drivers/serial/pxa.c               |    2 +-
 drivers/sn/ioc3.c                  |    2 +-
 drivers/spi/pxa2xx_spi.c           |    2 +-
 sound/isa/gus/gusmax.c             |    2 +-
 sound/isa/gus/interwave.c          |    2 +-
 sound/oss/es1371.c                 |    2 +-
 sound/oss/hal2.c                   |    2 +-
 sound/oss/i810_audio.c             |    2 +-
 sound/oss/mpu401.c                 |    2 +-
 sound/oss/vwsnd.c                  |    2 +-
 sound/pci/korg1212/korg1212.c      |    4 ----
 74 files changed, 106 insertions(+), 329 deletions(-)

Jeff Garzik:
      arch/i386/kernel/time: don't shadow 'irq' function arg
      drivers/net: eliminate irq handler impossible checks, needless casts
      Various drivers' irq handlers: kill dead code, needless casts
      drivers/net/eepro: kill dead code
      drivers/isdn/act2000: kill irq2card_map

diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 3f221f5..78af572 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -201,8 +201,8 @@ #endif
 		high bit of the PPI port B (0x61).  Note that some PS/2s,
 		notably the 55SX, work fine if this is removed.  */
 
-		irq = inb_p( 0x61 );	/* read the current state */
-		outb_p( irq|0x80, 0x61 );	/* reset the IRQ */
+		u8 irq_v = inb_p( 0x61 );	/* read the current state */
+		outb_p( irq_v|0x80, 0x61 );	/* reset the IRQ */
 	}
 
 	write_sequnlock(&xtime_lock);
diff --git a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
index 8ff5c4e..323592d 100644
--- a/drivers/atm/ambassador.c
+++ b/drivers/atm/ambassador.c
@@ -862,15 +862,10 @@ static inline void interrupts_off (amb_d
 /********** interrupt handling **********/
 
 static irqreturn_t interrupt_handler(int irq, void *dev_id) {
-  amb_dev * dev = (amb_dev *) dev_id;
+  amb_dev * dev = dev_id;
   
   PRINTD (DBG_IRQ|DBG_FLOW, "interrupt_handler: %p", dev_id);
   
-  if (!dev_id) {
-    PRINTD (DBG_IRQ|DBG_ERR, "irq with NULL dev_id: %d", irq);
-    return IRQ_NONE;
-  }
-  
   {
     u32 interrupt = rd_plain (dev, offsetof(amb_mem, interrupt));
   
diff --git a/drivers/atm/horizon.c b/drivers/atm/horizon.c
index 33e9ee4..f593492 100644
--- a/drivers/atm/horizon.c
+++ b/drivers/atm/horizon.c
@@ -1389,15 +1389,6 @@ static irqreturn_t interrupt_handler(int
   
   PRINTD (DBG_FLOW, "interrupt_handler: %p", dev_id);
   
-  if (!dev_id) {
-    PRINTD (DBG_IRQ|DBG_ERR, "irq with NULL dev_id: %d", irq);
-    return IRQ_NONE;
-  }
-  if (irq != dev->irq) {
-    PRINTD (DBG_IRQ|DBG_ERR, "irq mismatch: %d", irq);
-    return IRQ_NONE;
-  }
-  
   // definitely for us
   irq_ok = 0;
   while ((int_source = rd_regl (dev, INT_SOURCE_REG_OFF)
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 8895f02..2678255 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -1892,11 +1892,9 @@ #endif
 
 static irqreturn_t lanai_int(int irq, void *devid)
 {
-	struct lanai_dev *lanai = (struct lanai_dev *) devid;
+	struct lanai_dev *lanai = devid;
 	u32 reason;
 
-	(void) irq;	/* unused variables */
-
 #ifdef USE_POWERDOWN
 	/*
 	 * If we're powered down we shouldn't be generating any interrupts -
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 3e8ab84..742d074 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -5254,7 +5254,7 @@ #endif
 static irqreturn_t DAC960_GEM_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V2_StatusMailbox_T *NextStatusMailbox;
   unsigned long flags;
@@ -5295,7 +5295,7 @@ static irqreturn_t DAC960_GEM_InterruptH
 static irqreturn_t DAC960_BA_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V2_StatusMailbox_T *NextStatusMailbox;
   unsigned long flags;
@@ -5337,7 +5337,7 @@ static irqreturn_t DAC960_BA_InterruptHa
 static irqreturn_t DAC960_LP_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V2_StatusMailbox_T *NextStatusMailbox;
   unsigned long flags;
@@ -5379,7 +5379,7 @@ static irqreturn_t DAC960_LP_InterruptHa
 static irqreturn_t DAC960_LA_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V1_StatusMailbox_T *NextStatusMailbox;
   unsigned long flags;
@@ -5417,7 +5417,7 @@ static irqreturn_t DAC960_LA_InterruptHa
 static irqreturn_t DAC960_PG_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V1_StatusMailbox_T *NextStatusMailbox;
   unsigned long flags;
@@ -5455,7 +5455,7 @@ static irqreturn_t DAC960_PG_InterruptHa
 static irqreturn_t DAC960_PD_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   unsigned long flags;
 
@@ -5493,7 +5493,7 @@ static irqreturn_t DAC960_PD_InterruptHa
 static irqreturn_t DAC960_P_InterruptHandler(int IRQ_Channel,
 				      void *DeviceIdentifier)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  DAC960_Controller_T *Controller = DeviceIdentifier;
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
   unsigned long flags;
 
diff --git a/drivers/cdrom/mcdx.c b/drivers/cdrom/mcdx.c
index 60e1978..f574962 100644
--- a/drivers/cdrom/mcdx.c
+++ b/drivers/cdrom/mcdx.c
@@ -850,10 +850,6 @@ static irqreturn_t mcdx_intr(int irq, vo
 	struct s_drive_stuff *stuffp = dev_id;
 	unsigned char b;
 
-	if (stuffp == NULL) {
-		xwarn("mcdx: no device for intr %d\n", irq);
-		return IRQ_NONE;
-	}
 #ifdef AK2
 	if (!stuffp->busy && stuffp->pending)
 		stuffp->int_err = 1;
diff --git a/drivers/char/rio/func.h b/drivers/char/rio/func.h
index 6b03918..9e7283b 100644
--- a/drivers/char/rio/func.h
+++ b/drivers/char/rio/func.h
@@ -88,7 +88,7 @@ void RIOHostReset(unsigned int, struct D
 
 /* riointr.c */
 void RIOTxEnable(char *);
-void RIOServiceHost(struct rio_info *, struct Host *, int);
+void RIOServiceHost(struct rio_info *, struct Host *);
 int riotproc(struct rio_info *, struct ttystatics *, int, int);
 
 /* rioparam.c */
diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
index 3bea594..c382df0 100644
--- a/drivers/char/rio/rio_linux.c
+++ b/drivers/char/rio/rio_linux.c
@@ -368,7 +368,7 @@ static irqreturn_t rio_interrupt(int irq
 	struct Host *HostP;
 	func_enter();
 
-	HostP = (struct Host *) ptr;	/* &p->RIOHosts[(long)ptr]; */
+	HostP = ptr;			/* &p->RIOHosts[(long)ptr]; */
 	rio_dprintk(RIO_DEBUG_IFLOW, "rio: enter rio_interrupt (%d/%d)\n", irq, HostP->Ivec);
 
 	/* AAargh! The order in which to do these things is essential and
@@ -402,7 +402,7 @@ static irqreturn_t rio_interrupt(int irq
 		return IRQ_HANDLED;
 	}
 
-	RIOServiceHost(p, HostP, irq);
+	RIOServiceHost(p, HostP);
 
 	rio_dprintk(RIO_DEBUG_IFLOW, "riointr() doing host %p type %d\n", ptr, HostP->Type);
 
diff --git a/drivers/char/rio/riointr.c b/drivers/char/rio/riointr.c
index 0bd0904..eeda40c 100644
--- a/drivers/char/rio/riointr.c
+++ b/drivers/char/rio/riointr.c
@@ -181,7 +181,7 @@ static int RupIntr;
 static int RxIntr;
 static int TxIntr;
 
-void RIOServiceHost(struct rio_info *p, struct Host *HostP, int From)
+void RIOServiceHost(struct rio_info *p, struct Host *HostP)
 {
 	rio_spin_lock(&HostP->HostLock);
 	if ((HostP->Flags & RUN_STATE) != RC_RUNNING) {
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index be68cfb..5ab32b3 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -559,11 +559,10 @@ static irqreturn_t rc_interrupt(int irq,
 	int handled = 0;
 
 	bp = IRQ_to_board[irq];
-	
-	if (!bp || !(bp->flags & RC_BOARD_ACTIVE))  {
+
+	if (!(bp->flags & RC_BOARD_ACTIVE))
 		return IRQ_NONE;
-	}
-	
+
 	while ((++loop < 16) && ((status = ~(rc_in(bp, RC_BSR))) &
 				 (RC_BSR_TOUT | RC_BSR_TINT |
 				  RC_BSR_MINT | RC_BSR_RINT))) {
diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
index 6022495..d0b88d0 100644
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -912,7 +912,7 @@ static irqreturn_t sx_interrupt(int irq,
 	spin_lock_irqsave(&bp->lock, flags);
 
 	dprintk (SX_DEBUG_FLOW, "enter %s port %d room: %ld\n", __FUNCTION__, port_No(sx_get_port(bp, "INT")), SERIAL_XMIT_SIZE - sx_get_port(bp, "ITN")->xmit_cnt - 1);
-	if (!bp || !(bp->flags & SX_BOARD_ACTIVE)) {
+	if (!(bp->flags & SX_BOARD_ACTIVE)) {
 		dprintk (SX_DEBUG_IRQ, "sx: False interrupt. irq %d.\n", irq);
 		spin_unlock_irqrestore(&bp->lock, flags);
 		func_exit();
diff --git a/drivers/isdn/act2000/act2000_isa.c b/drivers/isdn/act2000/act2000_isa.c
index 3014495..3cac237 100644
--- a/drivers/isdn/act2000/act2000_isa.c
+++ b/drivers/isdn/act2000/act2000_isa.c
@@ -16,8 +16,6 @@ #include "act2000.h"
 #include "act2000_isa.h"
 #include "capi.h"
 
-static act2000_card *irq2card_map[16];
-
 /*
  * Reset Controller, then try to read the Card's signature.
  + Return:
@@ -65,14 +63,9 @@ act2000_isa_detect(unsigned short portba
 static irqreturn_t
 act2000_isa_interrupt(int irq, void *dev_id)
 {
-        act2000_card *card = irq2card_map[irq];
+        act2000_card *card = dev_id;
         u_char istatus;
 
-        if (!card) {
-                printk(KERN_WARNING
-                       "act2000: Spurious interrupt!\n");
-                return IRQ_NONE;
-        }
         istatus = (inb(ISA_PORT_ISR) & 0x07);
         if (istatus & ISA_ISR_OUT) {
                 /* RX fifo has data */
@@ -139,17 +132,15 @@ int
 act2000_isa_config_irq(act2000_card * card, short irq)
 {
         if (card->flags & ACT2000_FLAGS_IVALID) {
-                free_irq(card->irq, NULL);
-                irq2card_map[card->irq] = NULL;
+                free_irq(card->irq, card);
         }
         card->flags &= ~ACT2000_FLAGS_IVALID;
         outb(ISA_COR_IRQOFF, ISA_PORT_COR);
         if (!irq)
                 return 0;
 
-	if (!request_irq(irq, &act2000_isa_interrupt, 0, card->regname, NULL)) {
+	if (!request_irq(irq, &act2000_isa_interrupt, 0, card->regname, card)) {
 		card->irq = irq;
-		irq2card_map[card->irq] = card;
 		card->flags |= ACT2000_FLAGS_IVALID;
                 printk(KERN_WARNING
                        "act2000: Could not request irq %d\n",irq);
@@ -188,10 +179,9 @@ act2000_isa_release(act2000_card * card)
         unsigned long flags;
 
         spin_lock_irqsave(&card->lock, flags);
-        if (card->flags & ACT2000_FLAGS_IVALID) {
-                free_irq(card->irq, NULL);
-                irq2card_map[card->irq] = NULL;
-        }
+        if (card->flags & ACT2000_FLAGS_IVALID)
+                free_irq(card->irq, card);
+
         card->flags &= ~ACT2000_FLAGS_IVALID;
         if (card->flags & ACT2000_FLAGS_PVALID)
                 release_region(card->port, ISA_REGION);
diff --git a/drivers/media/video/zoran_device.c b/drivers/media/video/zoran_device.c
index d9d5020..168e431 100644
--- a/drivers/media/video/zoran_device.c
+++ b/drivers/media/video/zoran_device.c
@@ -1415,7 +1415,7 @@ zoran_irq (int             irq,
 	struct zoran *zr;
 	unsigned long flags;
 
-	zr = (struct zoran *) dev_id;
+	zr = dev_id;
 	count = 0;
 
 	if (zr->testing) {
diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
index 7ad0a54..f791bf0 100644
--- a/drivers/net/3c509.c
+++ b/drivers/net/3c509.c
@@ -912,16 +912,11 @@ #endif
 static irqreturn_t
 el3_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
+	struct net_device *dev = dev_id;
 	struct el3_private *lp;
 	int ioaddr, status;
 	int i = max_interrupt_work;
 
-	if (dev == NULL) {
-		printk ("el3_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
 	lp = netdev_priv(dev);
 	spin_lock(&lp->lock);
 
diff --git a/drivers/net/3c523.c b/drivers/net/3c523.c
index 1c97271..9184946 100644
--- a/drivers/net/3c523.c
+++ b/drivers/net/3c523.c
@@ -902,14 +902,11 @@ static void *alloc_rfa(struct net_device
 static irqreturn_t
 elmc_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	unsigned short stat;
 	struct priv *p;
 
-	if (dev == NULL) {
-		printk(KERN_ERR "elmc-interrupt: irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	} else if (!netif_running(dev)) {
+	if (!netif_running(dev)) {
 		/* The 3c523 has this habit of generating interrupts during the
 		   reset.  I'm not sure if the ni52 has this same problem, but it's
 		   really annoying if we haven't finished initializing it.  I was
diff --git a/drivers/net/3c527.c b/drivers/net/3c527.c
index d516c32..f4aca53 100644
--- a/drivers/net/3c527.c
+++ b/drivers/net/3c527.c
@@ -1324,11 +1324,6 @@ static irqreturn_t mc32_interrupt(int ir
 	int rx_event = 0;
 	int tx_event = 0;
 
-	if (dev == NULL) {
-		printk(KERN_WARNING "%s: irq %d for unknown device.\n", cardname, irq);
-		return IRQ_NONE;
-	}
-
 	ioaddr = dev->base_addr;
 	lp = netdev_priv(dev);
 
diff --git a/drivers/net/8390.c b/drivers/net/8390.c
index fa3442c..3d1c599 100644
--- a/drivers/net/8390.c
+++ b/drivers/net/8390.c
@@ -406,14 +406,8 @@ irqreturn_t ei_interrupt(int irq, void *
 	int interrupts, nr_serviced = 0;
 	struct ei_device *ei_local;
 
-	if (dev == NULL)
-	{
-		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
 	e8390_base = dev->base_addr;
-	ei_local = (struct ei_device *) netdev_priv(dev);
+	ei_local = netdev_priv(dev);
 
 	/*
 	 *	Protect the irq test too.
diff --git a/drivers/net/atp.c b/drivers/net/atp.c
index 062f80e..2d306fc 100644
--- a/drivers/net/atp.c
+++ b/drivers/net/atp.c
@@ -598,17 +598,13 @@ static int atp_send_packet(struct sk_buf
    Handle the network interface interrupts. */
 static irqreturn_t atp_interrupt(int irq, void *dev_instance)
 {
-	struct net_device *dev = (struct net_device *)dev_instance;
+	struct net_device *dev = dev_instance;
 	struct net_local *lp;
 	long ioaddr;
 	static int num_tx_since_rx;
 	int boguscount = max_interrupt_work;
 	int handled = 0;
 
-	if (dev == NULL) {
-		printk(KERN_ERR "ATP_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
 	ioaddr = dev->base_addr;
 	lp = netdev_priv(dev);
 
diff --git a/drivers/net/de600.c b/drivers/net/de600.c
index d9b006c..690bb40 100644
--- a/drivers/net/de600.c
+++ b/drivers/net/de600.c
@@ -265,12 +265,6 @@ static irqreturn_t de600_interrupt(int i
 	int		retrig = 0;
 	int		boguscount = 0;
 
-	/* This might just as well be deleted now, no crummy drivers present :-) */
-	if ((dev == NULL) || (DE600_IRQ != irq)) {
-		printk(KERN_ERR "%s: bogus interrupt %d\n", dev?dev->name:"DE-600", irq);
-		return IRQ_NONE;
-	}
-
 	spin_lock(&de600_lock);
 
 	select_nic();
diff --git a/drivers/net/declance.c b/drivers/net/declance.c
index e179aa1..00e2a8a 100644
--- a/drivers/net/declance.c
+++ b/drivers/net/declance.c
@@ -696,7 +696,7 @@ out:
 
 static irqreturn_t lance_dma_merr_int(const int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 
 	printk("%s: DMA error\n", dev->name);
 	return IRQ_HANDLED;
@@ -704,7 +704,7 @@ static irqreturn_t lance_dma_merr_int(co
 
 static irqreturn_t lance_interrupt(const int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct lance_private *lp = netdev_priv(dev);
 	volatile struct lance_regs *ll = lp->ll;
 	int csr0;
diff --git a/drivers/net/dgrs.c b/drivers/net/dgrs.c
index 6b1234b..a795202 100644
--- a/drivers/net/dgrs.c
+++ b/drivers/net/dgrs.c
@@ -897,8 +897,8 @@ static int dgrs_ioctl(struct net_device 
 
 static irqreturn_t dgrs_intr(int irq, void *dev_id)
 {
-	struct net_device	*dev0 = (struct net_device *) dev_id;
-	DGRS_PRIV	*priv0 = (DGRS_PRIV *) dev0->priv;
+	struct net_device	*dev0 = dev_id;
+	DGRS_PRIV	*priv0 = dev0->priv;
 	I596_CB		*cbp;
 	int		cmd;
 	int		i;
diff --git a/drivers/net/eepro.c b/drivers/net/eepro.c
index aae454a..a4eb0dc 100644
--- a/drivers/net/eepro.c
+++ b/drivers/net/eepro.c
@@ -994,16 +994,6 @@ static int eepro_open(struct net_device 
 		return -EAGAIN;
 	}
 
-#ifdef irq2dev_map
-	if  (((irq2dev_map[dev->irq] != 0)
-		|| (irq2dev_map[dev->irq] = dev) == 0) &&
-		(irq2dev_map[dev->irq]!=dev)) {
-		/* printk("%s: IRQ map wrong\n", dev->name); */
-	        free_irq(dev->irq, dev);
-		return -EAGAIN;
-	}
-#endif
-
 	/* Initialize the 82595. */
 
 	eepro_sw2bank2(ioaddr); /* be CAREFUL, BANK 2 now */
@@ -1198,17 +1188,11 @@ static int eepro_send_packet(struct sk_b
 static irqreturn_t
 eepro_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev =  (struct net_device *)dev_id;
-	                      /* (struct net_device *)(irq2dev_map[irq]);*/
+	struct net_device *dev = dev_id;
 	struct eepro_local *lp;
 	int ioaddr, status, boguscount = 20;
 	int handled = 0;
 
-	if (dev == NULL) {
-                printk (KERN_ERR "eepro_interrupt(): irq %d for unknown device.\\n", irq);
-                return IRQ_NONE;
-        }
-
 	lp = netdev_priv(dev);
 
         spin_lock(&lp->lock);
@@ -1288,10 +1272,6 @@ static int eepro_close(struct net_device
 	/* release the interrupt */
 	free_irq(dev->irq, dev);
 
-#ifdef irq2dev_map
-	irq2dev_map[dev->irq] = 0;
-#endif
-
 	/* Update the statistics here. What statistics? */
 
 	return 0;
diff --git a/drivers/net/eexpress.c b/drivers/net/eexpress.c
index 05ca730..e14be02 100644
--- a/drivers/net/eexpress.c
+++ b/drivers/net/eexpress.c
@@ -796,13 +796,6 @@ static irqreturn_t eexp_irq(int irq, voi
 	unsigned short ioaddr,status,ack_cmd;
 	unsigned short old_read_ptr, old_write_ptr;
 
-	if (dev==NULL)
-	{
-		printk(KERN_WARNING "eexpress: irq %d for unknown device\n",
-		       irq);
-		return IRQ_NONE;
-	}
-
 	lp = netdev_priv(dev);
 	ioaddr = dev->base_addr;
 
diff --git a/drivers/net/irda/ali-ircc.c b/drivers/net/irda/ali-ircc.c
index 971e2de..cebf8c3 100644
--- a/drivers/net/irda/ali-ircc.c
+++ b/drivers/net/irda/ali-ircc.c
@@ -662,19 +662,13 @@ static int ali_ircc_read_dongle_id (int 
  */
 static irqreturn_t ali_ircc_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct ali_ircc_cb *self;
 	int ret;
 		
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
 		
- 	if (!dev) {
-		IRDA_WARNING("%s: irq %d for unknown device.\n",
-			     ALI_IRCC_DRIVER_NAME, irq);
-		return IRQ_NONE;
-	}	
-	
-	self = (struct ali_ircc_cb *) dev->priv;
+	self = dev->priv;
 	
 	spin_lock(&self->lock);
 	
diff --git a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
index 7a91281..636d063 100644
--- a/drivers/net/irda/donauboe.c
+++ b/drivers/net/irda/donauboe.c
@@ -657,12 +657,6 @@ toshoboe_makemttpacket (struct toshoboe_
   return xbofs;
 }
 
-static int toshoboe_invalid_dev(int irq)
-{
-  printk (KERN_WARNING DRIVER_NAME ": irq %d for unknown device.\n", irq);
-  return 1;
-}
-
 #ifdef USE_PROBE
 /***********************************************************************/
 /* Probe code */
@@ -711,12 +705,9 @@ stuff_byte (__u8 byte, __u8 * buf)
 static irqreturn_t
 toshoboe_probeinterrupt (int irq, void *dev_id)
 {
-  struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
+  struct toshoboe_cb *self = dev_id;
   __u8 irqstat;
 
-  if (self == NULL && toshoboe_invalid_dev(irq))
-    return IRQ_NONE;
-
   irqstat = INB (OBOE_ISR);
 
 /* was it us */
diff --git a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
index 6ea78ec..654a68b 100644
--- a/drivers/net/irda/irport.c
+++ b/drivers/net/irda/irport.c
@@ -766,18 +766,14 @@ static inline void irport_receive(struct
  */
 static irqreturn_t irport_interrupt(int irq, void *dev_id) 
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct irport_cb *self;
 	int boguscount = 0;
 	int iobase;
 	int iir, lsr;
 	int handled = 0;
 
-	if (!dev) {
-		IRDA_WARNING("%s() irq %d for unknown device.\n", __FUNCTION__, irq);
-		return IRQ_NONE;
-	}
-	self = (struct irport_cb *) dev->priv;
+	self = dev->priv;
 
 	spin_lock(&self->lock);
 
diff --git a/drivers/net/irda/irport.h b/drivers/net/irda/irport.h
index 4393168..3f46b84 100644
--- a/drivers/net/irda/irport.h
+++ b/drivers/net/irda/irport.h
@@ -74,7 +74,7 @@ struct irport_cb {
 	/* For piggyback drivers */
 	void *priv;                
 	void (*change_speed)(void *priv, __u32 speed);
-	int (*interrupt)(int irq, void *dev_id);
+	irqreturn_t (*interrupt)(int irq, void *dev_id);
 };
 
 #endif /* IRPORT_H */
diff --git a/drivers/net/irda/nsc-ircc.c b/drivers/net/irda/nsc-ircc.c
index ea12e99..29b5ccd 100644
--- a/drivers/net/irda/nsc-ircc.c
+++ b/drivers/net/irda/nsc-ircc.c
@@ -2068,17 +2068,12 @@ static void nsc_ircc_fir_interrupt(struc
  */
 static irqreturn_t nsc_ircc_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct nsc_ircc_cb *self;
 	__u8 bsr, eir;
 	int iobase;
 
-	if (!dev) {
-		IRDA_WARNING("%s: irq %d for unknown device.\n",
-			     driver_name, irq);
-		return IRQ_NONE;
-	}
-	self = (struct nsc_ircc_cb *) dev->priv;
+	self = dev->priv;
 
 	spin_lock(&self->lock);	
 
diff --git a/drivers/net/irda/w83977af_ir.c b/drivers/net/irda/w83977af_ir.c
index b4fb92a..4212657 100644
--- a/drivers/net/irda/w83977af_ir.c
+++ b/drivers/net/irda/w83977af_ir.c
@@ -1113,17 +1113,12 @@ static __u8 w83977af_fir_interrupt(struc
  */
 static irqreturn_t w83977af_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct w83977af_ir *self;
 	__u8 set, icr, isr;
 	int iobase;
 
-	if (!dev) {
-		printk(KERN_WARNING "%s: irq %d for unknown device.\n", 
-			driver_name, irq);
-		return IRQ_NONE;
-	}
-	self = (struct w83977af_ir *) dev->priv;
+	self = dev->priv;
 
 	iobase = self->io.fir_base;
 
diff --git a/drivers/net/lance.c b/drivers/net/lance.c
index 7afac47..6efbd49 100644
--- a/drivers/net/lance.c
+++ b/drivers/net/lance.c
@@ -1019,11 +1019,6 @@ static irqreturn_t lance_interrupt(int i
 	int csr0, ioaddr, boguscnt=10;
 	int must_restart;
 
-	if (dev == NULL) {
-		printk ("lance_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
 	ioaddr = dev->base_addr;
 	lp = dev->priv;
 
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index e5f3669..5ddd574 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -1201,14 +1201,8 @@ static irqreturn_t ax_interrupt(int irq,
 	struct ei_device *ei_local;
     	int handled = 0;
 
-	if (dev == NULL) 
-	{
-		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-    
 	e8390_base = dev->base_addr;
-	ei_local = (struct ei_device *) netdev_priv(dev);
+	ei_local = netdev_priv(dev);
 
 	/*
 	 *	Protect the irq test too.
diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
index c73e2f2..36f9d98 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -2569,13 +2569,6 @@ pcnet32_interrupt(int irq, void *dev_id)
 	u16 csr0;
 	int boguscnt = max_interrupt_work;
 
-	if (!dev) {
-		if (pcnet32_debug & NETIF_MSG_INTR)
-			printk(KERN_DEBUG "%s(): irq %d for unknown device\n",
-			       __FUNCTION__, irq);
-		return IRQ_NONE;
-	}
-
 	ioaddr = dev->base_addr;
 	lp = dev->priv;
 
diff --git a/drivers/net/plip.c b/drivers/net/plip.c
index c0b333d..71afb27 100644
--- a/drivers/net/plip.c
+++ b/drivers/net/plip.c
@@ -909,11 +909,6 @@ plip_interrupt(int irq, void *dev_id)
 	struct plip_local *rcv;
 	unsigned char c0;
 
-	if (dev == NULL) {
-		printk(KERN_DEBUG "plip_interrupt: irq %d for unknown device.\n", irq);
-		return;
-	}
-
 	nl = netdev_priv(dev);
 	rcv = &nl->rcv_data;
 
diff --git a/drivers/net/saa9730.c b/drivers/net/saa9730.c
index c9efad8..b269513 100644
--- a/drivers/net/saa9730.c
+++ b/drivers/net/saa9730.c
@@ -747,7 +747,7 @@ static int lan_saa9730_rx(struct net_dev
 
 static irqreturn_t lan_saa9730_interrupt(const int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct lan_saa9730_private *lp = netdev_priv(dev);
 
 	if (lan_saa9730_debug > 5)
diff --git a/drivers/net/sb1000.c b/drivers/net/sb1000.c
index dc30dee..b9fa4fb 100644
--- a/drivers/net/sb1000.c
+++ b/drivers/net/sb1000.c
@@ -1084,19 +1084,13 @@ static irqreturn_t sb1000_interrupt(int 
 	char *name;
 	unsigned char st;
 	int ioaddr[2];
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct sb1000_private *lp = netdev_priv(dev);
 
 	const unsigned char Command0[6] = {0x80, 0x2c, 0x00, 0x00, 0x00, 0x00};
 	const unsigned char Command1[6] = {0x80, 0x2e, 0x00, 0x00, 0x00, 0x00};
 	const int MaxRxErrorCount = 6;
 
-	if (dev == NULL) {
-		printk(KERN_ERR "sb1000_interrupt(): irq %d for unknown device.\n",
-			irq);
-		return IRQ_NONE;
-	}
-
 	ioaddr[0] = dev->base_addr;
 	/* mem_start holds the second I/O address */
 	ioaddr[1] = dev->mem_start;
diff --git a/drivers/net/skfp/skfddi.c b/drivers/net/skfp/skfddi.c
index 06ea262..9733a11 100644
--- a/drivers/net/skfp/skfddi.c
+++ b/drivers/net/skfp/skfddi.c
@@ -616,15 +616,10 @@ static int skfp_close(struct net_device 
 
 irqreturn_t skfp_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct s_smc *smc;	/* private board structure pointer */
 	skfddi_priv *bp;
 
-	if (dev == NULL) {
-		printk("%s: irq %d for unknown device\n", dev->name, irq);
-		return IRQ_NONE;
-	}
-
 	smc = netdev_priv(dev);
 	bp = &smc->os;
 
diff --git a/drivers/net/sonic.c b/drivers/net/sonic.c
index cfece96..ed7aa0a 100644
--- a/drivers/net/sonic.c
+++ b/drivers/net/sonic.c
@@ -295,15 +295,10 @@ static int sonic_send_packet(struct sk_b
  */
 static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
+	struct net_device *dev = dev_id;
 	struct sonic_local *lp = netdev_priv(dev);
 	int status;
 
-	if (dev == NULL) {
-		printk(KERN_ERR "sonic_interrupt: irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
 	if (!(status = SONIC_READ(SONIC_ISR) & SONIC_IMR_DEFAULT))
 		return IRQ_NONE;
 
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 45d07fa..9d7cd13 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -2095,8 +2095,8 @@ static void happy_meal_rx(struct happy_m
 
 static irqreturn_t happy_meal_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
-	struct happy_meal *hp  = dev->priv;
+	struct net_device *dev = dev_id;
+	struct happy_meal *hp  = netdev_priv(dev);
 	u32 happy_status       = hme_read32(hp, hp->gregs + GREG_STAT);
 
 	HMD(("happy_meal_interrupt: status=%08x ", happy_status));
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 9207e19..5b00d79 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -822,7 +822,7 @@ out:
 
 static irqreturn_t lance_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
+	struct net_device *dev = dev_id;
 	struct lance_private *lp = netdev_priv(dev);
 	int csr0;
 
diff --git a/drivers/net/sunqe.c b/drivers/net/sunqe.c
index 020e781..7874eb1 100644
--- a/drivers/net/sunqe.c
+++ b/drivers/net/sunqe.c
@@ -468,7 +468,7 @@ static void qe_tx_reclaim(struct sunqe *
  */
 static irqreturn_t qec_interrupt(int irq, void *dev_id)
 {
-	struct sunqec *qecp = (struct sunqec *) dev_id;
+	struct sunqec *qecp = dev_id;
 	u32 qec_status;
 	int channel = 0;
 
diff --git a/drivers/net/tokenring/smctr.c b/drivers/net/tokenring/smctr.c
index 9bd4cba..46dabdb 100644
--- a/drivers/net/tokenring/smctr.c
+++ b/drivers/net/tokenring/smctr.c
@@ -1990,15 +1990,8 @@ static irqreturn_t smctr_interrupt(int i
         __u8 isb_type, isb_subtype;
         __u16 isb_index;
 
-        if(dev == NULL)
-        {
-                printk(KERN_CRIT "%s: irq %d for unknown device.\n", dev->name, irq);
-                return IRQ_NONE;
-        }
-
         ioaddr = dev->base_addr;
         tp = netdev_priv(dev);
-        
 
         if(tp->status == NOT_INITIALIZED)
                 return IRQ_NONE;
diff --git a/drivers/net/tokenring/tms380tr.c b/drivers/net/tokenring/tms380tr.c
index c0ab6e4..ea797ca 100644
--- a/drivers/net/tokenring/tms380tr.c
+++ b/drivers/net/tokenring/tms380tr.c
@@ -751,11 +751,6 @@ irqreturn_t tms380tr_interrupt(int irq, 
 	unsigned short irq_type;
 	int handled = 0;
 
-	if(dev == NULL) {
-		printk(KERN_INFO "%s: irq %d for unknown device.\n", dev->name, irq);
-		return IRQ_NONE;
-	}
-
 	tp = netdev_priv(dev);
 
 	irq_type = SIFREADW(SIFSTS);
diff --git a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
index e17f977..3f4b640 100644
--- a/drivers/net/tulip/de4x5.c
+++ b/drivers/net/tulip/de4x5.c
@@ -1540,16 +1540,12 @@ de4x5_queue_pkt(struct sk_buff *skb, str
 static irqreturn_t
 de4x5_interrupt(int irq, void *dev_id)
 {
-    struct net_device *dev = (struct net_device *)dev_id;
+    struct net_device *dev = dev_id;
     struct de4x5_private *lp;
     s32 imr, omr, sts, limit;
     u_long iobase;
     unsigned int handled = 0;
 
-    if (dev == NULL) {
-	printk ("de4x5_interrupt(): irq %d for unknown device.\n", irq);
-	return IRQ_NONE;
-    }
     lp = netdev_priv(dev);
     spin_lock(&lp->lock);
     iobase = dev->base_addr;
diff --git a/drivers/net/wan/cycx_main.c b/drivers/net/wan/cycx_main.c
index 12363e0..6e5f1c8 100644
--- a/drivers/net/wan/cycx_main.c
+++ b/drivers/net/wan/cycx_main.c
@@ -303,9 +303,9 @@ out:	return ret;
  */
 static irqreturn_t cycx_isr(int irq, void *dev_id)
 {
-	struct cycx_device *card = (struct cycx_device *)dev_id;
+	struct cycx_device *card = dev_id;
 
-	if (!card || card->wandev.state == WAN_UNCONFIGURED)
+	if (card->wandev.state == WAN_UNCONFIGURED)
 		goto out;
 
 	if (card->in_isr) {
diff --git a/drivers/net/wan/sdla.c b/drivers/net/wan/sdla.c
index 5715d25..6a485f0 100644
--- a/drivers/net/wan/sdla.c
+++ b/drivers/net/wan/sdla.c
@@ -875,13 +875,7 @@ static irqreturn_t sdla_isr(int irq, voi
 
 	dev = dev_id;
 
-	if (dev == NULL)
-	{
-		printk(KERN_WARNING "sdla_isr(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
-	flp = dev->priv;
+	flp = netdev_priv(dev);
 
 	if (!flp->initialized)
 	{
diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
index 793da5f..b779c7d 100644
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -1954,7 +1954,7 @@ static void __orinoco_ev_wterr(struct ne
 
 irqreturn_t orinoco_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
+	struct net_device *dev = dev_id;
 	struct orinoco_private *priv = netdev_priv(dev);
 	hermes_t *hw = &priv->hw;
 	int count = MAX_IRQLOOPS_PER_IRQ;
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index cadfe13..aafb301 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -4119,21 +4119,12 @@ static irqreturn_t
 wavelan_interrupt(int		irq,
 		  void *	dev_id)
 {
-  struct net_device *	dev;
+  struct net_device *	dev = dev_id;
   net_local *	lp;
   kio_addr_t	base;
   int		status0;
   u_int		tx_status;
 
-  if ((dev = dev_id) == NULL)
-    {
-#ifdef DEBUG_INTERRUPT_ERROR
-      printk(KERN_WARNING "wavelan_interrupt(): irq %d for unknown device.\n",
-	     irq);
-#endif
-      return IRQ_NONE;
-    }
-
 #ifdef DEBUG_INTERRUPT_TRACE
   printk(KERN_DEBUG "%s: ->wavelan_interrupt()\n", dev->name);
 #endif
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index a143035..5b98a78 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1155,25 +1155,18 @@ static inline void wl3501_ack_interrupt(
  */
 static irqreturn_t wl3501_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
+	struct net_device *dev = dev_id;
 	struct wl3501_card *this;
-	int handled = 1;
 
-	if (!dev)
-		goto unknown;
-	this = dev->priv;
+	this = netdev_priv(dev);
 	spin_lock(&this->lock);
 	wl3501_ack_interrupt(this);
 	wl3501_block_interrupt(this);
 	wl3501_rx_interrupt(dev);
 	wl3501_unblock_interrupt(this);
 	spin_unlock(&this->lock);
-out:
-	return IRQ_RETVAL(handled);
-unknown:
-	handled = 0;
-	printk(KERN_ERR "%s: irq %d for unknown device.\n", __FUNCTION__, irq);
-	goto out;
+
+	return IRQ_HANDLED;
 }
 
 static int wl3501_reset_board(struct wl3501_card *this)
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index ac60021..2412ce4 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -896,13 +896,6 @@ static irqreturn_t yellowfin_interrupt(i
 	int boguscnt = max_interrupt_work;
 	unsigned int handled = 0;
 
-#ifndef final_version			/* Can never occur. */
-	if (dev == NULL) {
-		printk (KERN_ERR "yellowfin_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-#endif
-
 	yp = netdev_priv(dev);
 	ioaddr = yp->base;
 
diff --git a/drivers/net/znet.c b/drivers/net/znet.c
index 2068a10..b24b072 100644
--- a/drivers/net/znet.c
+++ b/drivers/net/znet.c
@@ -610,11 +610,6 @@ static irqreturn_t znet_interrupt(int ir
 	int boguscnt = 20;
 	int handled = 0;
 
-	if (dev == NULL) {
-		printk(KERN_WARNING "znet_interrupt(): IRQ %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
 	spin_lock (&znet->lock);
 
 	ioaddr = dev->base_addr;
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 991e084..7f5df9a 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -66,7 +66,7 @@ static int at91_cf_ss_init(struct pcmcia
 
 static irqreturn_t at91_cf_irq(int irq, void *_cf)
 {
-	struct at91_cf_socket	*cf = (struct at91_cf_socket *) _cf;
+	struct at91_cf_socket *cf = _cf;
 
 	if (irq == cf->board->det_pin) {
 		unsigned present = at91_cf_present(cf);
diff --git a/drivers/pcmcia/hd64465_ss.c b/drivers/pcmcia/hd64465_ss.c
index db3c26b..caca0dc 100644
--- a/drivers/pcmcia/hd64465_ss.c
+++ b/drivers/pcmcia/hd64465_ss.c
@@ -650,7 +650,7 @@ #endif
  */
 static int hs_irq_demux(int irq, void *dev)
 {
-    	hs_socket_t *sp = (hs_socket_t *)dev;
+    	hs_socket_t *sp = dev;
 	u_int cscr;
     	
     	DPRINTK("hs_irq_demux(irq=%d)\n", irq);
@@ -673,11 +673,10 @@ static int hs_irq_demux(int irq, void *d
  
 static irqreturn_t hs_interrupt(int irq, void *dev)
 {
-    	hs_socket_t *sp = (hs_socket_t *)dev;
+    	hs_socket_t *sp = dev;
 	u_int events = 0;
 	u_int cscr;
-	
-	
+
 	cscr = hs_in(sp, CSCR);
 	
 	DPRINTK("hs_interrupt, cscr=%04x\n", cscr);
diff --git a/drivers/scsi/NCR53c406a.c b/drivers/scsi/NCR53c406a.c
index 3896278..d461381 100644
--- a/drivers/scsi/NCR53c406a.c
+++ b/drivers/scsi/NCR53c406a.c
@@ -168,7 +168,7 @@ enum Phase {
 };
 
 /* Static function prototypes */
-static void NCR53c406a_intr(int, void *);
+static void NCR53c406a_intr(void *);
 static irqreturn_t do_NCR53c406a_intr(int, void *);
 static void chip_init(void);
 static void calc_port_addr(void);
@@ -685,7 +685,7 @@ static void wait_intr(void)
 		return;
 	}
 
-	NCR53c406a_intr(0, NULL, NULL);
+	NCR53c406a_intr(NULL);
 }
 #endif
 
@@ -767,12 +767,12 @@ static irqreturn_t do_NCR53c406a_intr(in
 	struct Scsi_Host *dev = dev_id;
 
 	spin_lock_irqsave(dev->host_lock, flags);
-	NCR53c406a_intr(0, dev_id);
+	NCR53c406a_intr(dev_id);
 	spin_unlock_irqrestore(dev->host_lock, flags);
 	return IRQ_HANDLED;
 }
 
-static void NCR53c406a_intr(int unused, void *dev_id)
+static void NCR53c406a_intr(void *dev_id)
 {
 	DEB(unsigned char fifo_size;
 	    )
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index e04c2bc..a0d1cee 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -759,12 +759,7 @@ static inline Scsi_Cmnd *remove_SC(Scsi_
 
 static irqreturn_t swintr(int irqno, void *dev_id)
 {
-	struct Scsi_Host *shpnt = (struct Scsi_Host *)dev_id;
-
-	if (!shpnt) {
-        	printk(KERN_ERR "aha152x: catched software interrupt %d for unknown controller.\n", irqno);
-		return IRQ_NONE;
-	}
+	struct Scsi_Host *shpnt = dev_id;
 
 	HOSTDATA(shpnt)->swint++;
 
diff --git a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
index 7f0adf9..bcd7fff 100644
--- a/drivers/scsi/aic7xxx_old.c
+++ b/drivers/scsi/aic7xxx_old.c
@@ -6345,12 +6345,12 @@ #endif
  *   SCSI controller interrupt handler.
  *-F*************************************************************************/
 static void
-aic7xxx_isr(int irq, void *dev_id)
+aic7xxx_isr(void *dev_id)
 {
   struct aic7xxx_host *p;
   unsigned char intstat;
 
-  p = (struct aic7xxx_host *)dev_id;
+  p = dev_id;
 
   /*
    * Just a few sanity checks.  Make sure that we have an int pending.
@@ -6489,7 +6489,7 @@ do_aic7xxx_isr(int irq, void *dev_id)
   p->flags |= AHC_IN_ISR;
   do
   {
-    aic7xxx_isr(irq, dev_id);
+    aic7xxx_isr(dev_id);
   } while ( (aic_inb(p, INTSTAT) & INT_PEND) );
   aic7xxx_done_cmds_complete(p);
   aic7xxx_run_waiting_queues(p);
@@ -10377,7 +10377,7 @@ static int __aic7xxx_bus_device_reset(st
 
   hscb = scb->hscb;
 
-  aic7xxx_isr(p->irq, (void *)p);
+  aic7xxx_isr(p);
   aic7xxx_done_cmds_complete(p);
   /* If the command was already complete or just completed, then we didn't
    * do a reset, return FAILED */
@@ -10608,7 +10608,7 @@ static int __aic7xxx_abort(struct scsi_c
   else
     return FAILED;
 
-  aic7xxx_isr(p->irq, (void *)p);
+  aic7xxx_isr(p);
   aic7xxx_done_cmds_complete(p);
   /* If the command was already complete or just completed, then we didn't
    * do a reset, return FAILED */
@@ -10863,7 +10863,7 @@ static int aic7xxx_reset(struct scsi_cmn
 
   while((aic_inb(p, INTSTAT) & INT_PEND) && !(p->flags & AHC_IN_ISR))
   {
-    aic7xxx_isr(p->irq, p);
+    aic7xxx_isr(p);
     pause_sequencer(p);
   }
   aic7xxx_done_cmds_complete(p);
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 81e3ee5..23f5e41 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1815,7 +1815,7 @@ static void dc395x_handle_interrupt(stru
 
 static irqreturn_t dc395x_interrupt(int irq, void *dev_id)
 {
-	struct AdapterCtlBlk *acb = (struct AdapterCtlBlk *)dev_id;
+	struct AdapterCtlBlk *acb = dev_id;
 	u16 scsi_status;
 	u8 dma_status;
 	irqreturn_t handled = IRQ_NONE;
diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 1a7de3b..e072535 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -405,10 +405,10 @@ static unsigned int ql_pcmd(Scsi_Cmnd * 
  *	Interrupt handler 
  */
 
-static void ql_ihandl(int irq, void *dev_id)
+static void ql_ihandl(void *dev_id)
 {
 	Scsi_Cmnd *icmd;
-	struct Scsi_Host *host = (struct Scsi_Host *)dev_id;
+	struct Scsi_Host *host = dev_id;
 	struct qlogicfas408_priv *priv = get_priv_by_host(host);
 	int qbase = priv->qbase;
 	REG0;
@@ -438,7 +438,7 @@ irqreturn_t qlogicfas408_ihandl(int irq,
 	struct Scsi_Host *host = dev_id;
 
 	spin_lock_irqsave(host->host_lock, flags);
-	ql_ihandl(irq, dev_id);
+	ql_ihandl(dev_id);
 	spin_unlock_irqrestore(host->host_lock, flags);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
index 0f0ac92..d03aa6c 100644
--- a/drivers/scsi/tmscsim.c
+++ b/drivers/scsi/tmscsim.c
@@ -700,9 +700,9 @@ dc390_InvalidCmd(struct dc390_acb* pACB)
 
 
 static irqreturn_t __inline__
-DC390_Interrupt(int irq, void *dev_id)
+DC390_Interrupt(void *dev_id)
 {
-    struct dc390_acb *pACB = (struct dc390_acb*)dev_id;
+    struct dc390_acb *pACB = dev_id;
     struct dc390_dcb *pDCB;
     struct dc390_srb *pSRB;
     u8  sstatus=0;
@@ -811,12 +811,12 @@ #endif
     return IRQ_HANDLED;
 }
 
-static irqreturn_t do_DC390_Interrupt( int irq, void *dev_id)
+static irqreturn_t do_DC390_Interrupt(int irq, void *dev_id)
 {
     irqreturn_t ret;
     DEBUG1(printk (KERN_INFO "DC390: Irq (%i) caught: ", irq));
     /* Locking is done in DC390_Interrupt */
-    ret = DC390_Interrupt(irq, dev_id);
+    ret = DC390_Interrupt(dev_id);
     DEBUG1(printk (".. IRQ returned\n"));
     return ret;
 }
diff --git a/drivers/scsi/ultrastor.c b/drivers/scsi/ultrastor.c
index 107f0fc..56906ab 100644
--- a/drivers/scsi/ultrastor.c
+++ b/drivers/scsi/ultrastor.c
@@ -287,7 +287,7 @@ static const unsigned short ultrastor_po
 };
 #endif
 
-static void ultrastor_interrupt(int, void *);
+static void ultrastor_interrupt(void *);
 static irqreturn_t do_ultrastor_interrupt(int, void *);
 static inline void build_sg_list(struct mscp *, struct scsi_cmnd *SCpnt);
 
@@ -893,7 +893,7 @@ #if ULTRASTOR_DEBUG & UD_ABORT
 	
 	spin_lock_irqsave(host->host_lock, flags);
 	/* FIXME: Ewww... need to think about passing host around properly */
-	ultrastor_interrupt(0, NULL);
+	ultrastor_interrupt(NULL);
 	spin_unlock_irqrestore(host->host_lock, flags);
 	return SUCCESS;
       }
@@ -1039,7 +1039,7 @@ #endif
     return 0;
 }
 
-static void ultrastor_interrupt(int irq, void *dev_id)
+static void ultrastor_interrupt(void *dev_id)
 {
     unsigned int status;
 #if ULTRASTOR_MAX_CMDS > 1
@@ -1177,7 +1177,7 @@ static irqreturn_t do_ultrastor_interrup
     struct Scsi_Host *dev = dev_id;
     
     spin_lock_irqsave(dev->host_lock, flags);
-    ultrastor_interrupt(irq, dev_id);
+    ultrastor_interrupt(dev_id);
     spin_unlock_irqrestore(dev->host_lock, flags);
     return IRQ_HANDLED;
 }
diff --git a/drivers/serial/68360serial.c b/drivers/serial/68360serial.c
index 4e56ec8..634ecca 100644
--- a/drivers/serial/68360serial.c
+++ b/drivers/serial/68360serial.c
@@ -620,7 +620,7 @@ static void rs_360_interrupt(int vec, vo
 	volatile struct smc_regs *smcp;
 	volatile struct scc_regs *sccp;
 	
-	info = (ser_info_t *)dev_id;
+	info = dev_id;
 
 	idx = PORT_NUM(info->state->smc_scc_num);
 	if (info->state->smc_scc_num & NUM_IS_SCC) {
diff --git a/drivers/serial/jsm/jsm_neo.c b/drivers/serial/jsm/jsm_neo.c
index 8fa31e6..8be8da3 100644
--- a/drivers/serial/jsm/jsm_neo.c
+++ b/drivers/serial/jsm/jsm_neo.c
@@ -1116,7 +1116,7 @@ #endif
  */
 static irqreturn_t neo_intr(int irq, void *voidbrd)
 {
-	struct jsm_board *brd = (struct jsm_board *) voidbrd;
+	struct jsm_board *brd = voidbrd;
 	struct jsm_channel *ch;
 	int port = 0;
 	int type = 0;
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 039c2fd..4f80c5b 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -512,19 +512,11 @@ mpc52xx_uart_int_tx_chars(struct uart_po
 static irqreturn_t 
 mpc52xx_uart_int(int irq, void *dev_id)
 {
-	struct uart_port *port = (struct uart_port *) dev_id;
+	struct uart_port *port = dev_id;
 	unsigned long pass = ISR_PASS_LIMIT;
 	unsigned int keepgoing;
 	unsigned short status;
 	
-	if ( irq != port->irq ) {
-		printk( KERN_WARNING
-		        "mpc52xx_uart_int : " \
-		        "Received wrong int %d. Waiting for %d\n",
-		       irq, port->irq);
-		return IRQ_NONE;
-	}
-	
 	spin_lock(&port->lock);
 	
 	/* While we have stuff to do, we continue */
diff --git a/drivers/serial/netx-serial.c b/drivers/serial/netx-serial.c
index e92d7e1..062bad4 100644
--- a/drivers/serial/netx-serial.c
+++ b/drivers/serial/netx-serial.c
@@ -247,7 +247,7 @@ static void netx_rxint(struct uart_port 
 
 static irqreturn_t netx_int(int irq, void *dev_id)
 {
-	struct uart_port *port = (struct uart_port *)dev_id;
+	struct uart_port *port = dev_id;
 	unsigned long flags;
 	unsigned char status;
 
diff --git a/drivers/serial/pxa.c b/drivers/serial/pxa.c
index 846089f..415fe96 100644
--- a/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -232,7 +232,7 @@ static inline void check_modem_status(st
  */
 static inline irqreturn_t serial_pxa_irq(int irq, void *dev_id)
 {
-	struct uart_pxa_port *up = (struct uart_pxa_port *)dev_id;
+	struct uart_pxa_port *up = dev_id;
 	unsigned int iir, lsr;
 
 	iir = serial_in(up, UART_IIR);
diff --git a/drivers/sn/ioc3.c b/drivers/sn/ioc3.c
index 3d91b6b..cd6b653 100644
--- a/drivers/sn/ioc3.c
+++ b/drivers/sn/ioc3.c
@@ -401,7 +401,7 @@ static inline uint32_t get_pending_intrs
 static irqreturn_t ioc3_intr_io(int irq, void *arg)
 {
 	unsigned long flags;
-	struct ioc3_driver_data *idd = (struct ioc3_driver_data *)arg;
+	struct ioc3_driver_data *idd = arg;
 	int handled = 1, id;
 	unsigned int pending;
 
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 77122ed..72025df 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -669,7 +669,7 @@ static irqreturn_t interrupt_transfer(st
 
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
-	struct driver_data *drv_data = (struct driver_data *)dev_id;
+	struct driver_data *drv_data = dev_id;
 	void *reg = drv_data->ioaddr;
 
 	if (!drv_data->cur_msg) {
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 52498c9..c1c69e3 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -107,7 +107,7 @@ static int __init snd_gusmax_detect(stru
 
 static irqreturn_t snd_gusmax_interrupt(int irq, void *dev_id)
 {
-	struct snd_gusmax *maxcard = (struct snd_gusmax *) dev_id;
+	struct snd_gusmax *maxcard = dev_id;
 	int loop, max = 5;
 	int handled = 0;
 
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 5c474b8..f12cd09 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -301,7 +301,7 @@ #endif
 
 static irqreturn_t snd_interwave_interrupt(int irq, void *dev_id)
 {
-	struct snd_interwave *iwcard = (struct snd_interwave *) dev_id;
+	struct snd_interwave *iwcard = dev_id;
 	int loop, max = 5;
 	int handled = 0;
 
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index 2562f47..ddf6b0a 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -1102,7 +1102,7 @@ static void es1371_handle_midi(struct es
 
 static irqreturn_t es1371_interrupt(int irq, void *dev_id)
 {
-        struct es1371_state *s = (struct es1371_state *)dev_id;
+        struct es1371_state *s = dev_id;
 	unsigned int intsrc, sctl;
 	
 	/* fastpath out, to ease interrupt sharing */
diff --git a/sound/oss/hal2.c b/sound/oss/hal2.c
index 7807aba..784bdd7 100644
--- a/sound/oss/hal2.c
+++ b/sound/oss/hal2.c
@@ -372,7 +372,7 @@ static void hal2_adc_interrupt(struct ha
 
 static irqreturn_t hal2_interrupt(int irq, void *dev_id)
 {
-	struct hal2_card *hal2 = (struct hal2_card*)dev_id;
+	struct hal2_card *hal2 = dev_id;
 	irqreturn_t ret = IRQ_NONE;
 
 	/* decide what caused this interrupt */
diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
index a48af87..240cc79 100644
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -1525,7 +1525,7 @@ #endif
 
 static irqreturn_t i810_interrupt(int irq, void *dev_id)
 {
-	struct i810_card *card = (struct i810_card *)dev_id;
+	struct i810_card *card = dev_id;
 	u32 status;
 
 	spin_lock(&card->lock);
diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 58d4a5d..e962205 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -435,7 +435,7 @@ static void mpu401_input_loop(struct mpu
 static irqreturn_t mpuintr(int irq, void *dev_id)
 {
 	struct mpu_config *devc;
-	int dev = (int) dev_id;
+	int dev = (int)(unsigned long) dev_id;
 	int handled = 0;
 
 	devc = &dev_conf[dev];
diff --git a/sound/oss/vwsnd.c b/sound/oss/vwsnd.c
index 0cd4d6e..6dfb9f4 100644
--- a/sound/oss/vwsnd.c
+++ b/sound/oss/vwsnd.c
@@ -2235,7 +2235,7 @@ static void vwsnd_audio_write_intr(vwsnd
 
 static irqreturn_t vwsnd_audio_intr(int irq, void *dev_id)
 {
-	vwsnd_dev_t *devc = (vwsnd_dev_t *) dev_id;
+	vwsnd_dev_t *devc = dev_id;
 	unsigned int status;
 
 	DBGEV("(irq=%d, dev_id=0x%p)\n", irq, dev_id);
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 398aa10..fa8cd8c 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1124,9 +1124,6 @@ static irqreturn_t snd_korg1212_interrup
         u32 doorbellValue;
         struct snd_korg1212 *korg1212 = dev_id;
 
-	if(irq != korg1212->irq)
-		return IRQ_NONE;
-
         doorbellValue = readl(korg1212->inDoorbellPtr);
 
         if (!doorbellValue)
@@ -1140,7 +1137,6 @@ static irqreturn_t snd_korg1212_interrup
 
 	korg1212->inIRQ++;
 
-
         switch (doorbellValue) {
                 case K1212_DB_DSPDownloadDone:
                         K1212_DEBUG_PRINTK("K1212_DEBUG: IRQ DNLD count - %ld, %x, [%s].\n",
