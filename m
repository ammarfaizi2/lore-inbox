Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTBLNSM>; Wed, 12 Feb 2003 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbTBLNSM>; Wed, 12 Feb 2003 08:18:12 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:8585 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267107AbTBLNRK>; Wed, 12 Feb 2003 08:17:10 -0500
Date: Wed, 12 Feb 2003 14:23:14 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James McKenzie <james@fishsoup.dhs.org>
Cc: Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>,
       Paul Bristow <paul.bristow@technologist.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] rename all symbols in drivers/net/irda/donauboe.c
Message-ID: <20030212132313.GB22472@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(It is not clear, who the maintainer if for drivers/net/irda/donauboe.c
 but I hope to reach someone this way.)

When compiling a kernel with both CONFIG_TOSHIBA_OLD and
CONFIG_TOSHIBA_FIR set to yes, the two drivers both define the same
symbols and the build breaks.

While this is an unusual configuration, it might make sense sometimes
to compile a kernel that will boot on several machines. So this
problem might bite someone doing real work, not just me. ;)

This patch just did an s/toshoboe/donauboe/g on the file, and will
break for sure, but it should be a hint in the correct direction.
Maybe someone will pick it up.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike

--- linux-2.4.21-pre3/drivers/net/irda/donauboe.c	Thu Jan 23 10:53:21 2003
+++ linux-2.4.21-pre3/drivers/net/irda/donauboe.new.c	Wed Feb 12 14:08:22 2003
@@ -43,7 +43,7 @@
  *
  ********************************************************************/
 
-/* Look at toshoboe.h (currently in include/net/irda) for details of */
+/* Look at donauboe.h (currently in include/net/irda) for details of */
 /* Where to get documentation on the chip         */
 
 
@@ -189,14 +189,14 @@
 #define CONFIG0H_DMA_ON_NORX CONFIG0H_DMA_OFF| OBOE_CONFIG0H_ENDMAC
 #define CONFIG0H_DMA_ON CONFIG0H_DMA_ON_NORX | OBOE_CONFIG0H_ENRX
 
-static struct pci_device_id toshoboe_pci_tbl[] __initdata = {
+static struct pci_device_id donauboe_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
 };
-MODULE_DEVICE_TABLE(pci, toshoboe_pci_tbl);
+MODULE_DEVICE_TABLE(pci, donauboe_pci_tbl);
 
-#define DRIVER_NAME "toshoboe"
+#define DRIVER_NAME "donauboe"
 static char *driver_name = DRIVER_NAME;
 
 static int max_baud = 4000000;
@@ -246,7 +246,7 @@
 #endif
 
 STATIC int
-toshoboe_checkfcs (unsigned char *buf, int len)
+donauboe_checkfcs (unsigned char *buf, int len)
 {
   int i;
   union
@@ -284,7 +284,7 @@
 
 /* Dump the registers */
 STATIC void
-toshoboe_dumpregs (struct toshoboe_cb *self)
+donauboe_dumpregs (struct donauboe_cb *self)
 {
   __u32 ringbase;
 
@@ -332,7 +332,7 @@
 
 /*Don't let the chip look at memory */
 STATIC void
-toshoboe_disablebm (struct toshoboe_cb *self)
+donauboe_disablebm (struct donauboe_cb *self)
 {
   __u8 command;
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -345,7 +345,7 @@
 
 /* Shutdown the chip and point the taskfile reg somewhere else */
 STATIC void
-toshoboe_stopchip (struct toshoboe_cb *self)
+donauboe_stopchip (struct donauboe_cb *self)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
@@ -372,12 +372,12 @@
   /*switch it off */
   OUTB (OBOE_CONFIG1_OFF, OBOE_CONFIG1);
 
-  toshoboe_disablebm (self);
+  donauboe_disablebm (self);
 }
 
 /* Transmitter initialization */
 STATIC void
-toshoboe_start_DMA (struct toshoboe_cb *self, int opts)
+donauboe_start_DMA (struct donauboe_cb *self, int opts)
 {
   OUTB (0x0, OBOE_ENABLEH);
   OUTB (CONFIG0H_DMA_ON | opts,  OBOE_CONFIG0H);
@@ -387,7 +387,7 @@
 
 /*Set the baud rate */
 STATIC void
-toshoboe_setbaud (struct toshoboe_cb *self)
+donauboe_setbaud (struct donauboe_cb *self)
 {
   __u16 pconfig = 0;
   __u8 config0l = 0;
@@ -522,7 +522,7 @@
 
 /*Let the chip look at memory */
 STATIC void
-toshoboe_enablebm (struct toshoboe_cb *self)
+donauboe_enablebm (struct donauboe_cb *self)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
   pci_set_master (self->pdev);
@@ -530,7 +530,7 @@
 
 /*setup the ring */
 STATIC void
-toshoboe_initring (struct toshoboe_cb *self)
+donauboe_initring (struct donauboe_cb *self)
 {
   int i;
 
@@ -553,7 +553,7 @@
 }
 
 STATIC void
-toshoboe_resetptrs (struct toshoboe_cb *self)
+donauboe_resetptrs (struct donauboe_cb *self)
 {
   /* Can reset pointers by twidling DMA */
   OUTB (0x0, OBOE_ENABLEH);
@@ -566,14 +566,14 @@
 
 /* Called in locked state */
 STATIC void
-toshoboe_initptrs (struct toshoboe_cb *self)
+donauboe_initptrs (struct donauboe_cb *self)
 {
 
   /* spin_lock_irqsave(self->spinlock, flags); */
   /* save_flags (flags); */
 
   /* Can reset pointers by twidling DMA */
-  toshoboe_resetptrs (self);
+  donauboe_resetptrs (self);
 
   OUTB (0x0, OBOE_ENABLEH);
   OUTB (CONFIG0H_DMA_ON, OBOE_CONFIG0H);
@@ -588,14 +588,14 @@
 /* Wake the chip up and get it looking at the rings */
 /* Called in locked state */
 STATIC void
-toshoboe_startchip (struct toshoboe_cb *self)
+donauboe_startchip (struct donauboe_cb *self)
 {
   __u32 physaddr;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
-  toshoboe_initring (self);
-  toshoboe_enablebm (self);
+  donauboe_initring (self);
+  donauboe_enablebm (self);
   OUTBP (OBOE_CONFIG1_RESET, OBOE_CONFIG1);
   OUTBP (OBOE_CONFIG1_ON, OBOE_CONFIG1);
 
@@ -641,17 +641,17 @@
 
   /*set to sensible speed */
   self->speed = 9600;
-  toshoboe_setbaud (self);
-  toshoboe_initptrs (self);
+  donauboe_setbaud (self);
+  donauboe_initptrs (self);
 }
 
 STATIC void
-toshoboe_isntstuck (struct toshoboe_cb *self)
+donauboe_isntstuck (struct donauboe_cb *self)
 {
 }
 
 STATIC void
-toshoboe_checkstuck (struct toshoboe_cb *self)
+donauboe_checkstuck (struct donauboe_cb *self)
 {
   unsigned long flags;
 
@@ -662,15 +662,15 @@
       /* This will reset the chip completely */
       printk (KERN_ERR DRIVER_NAME ": Resetting chip\n");
 
-      toshoboe_stopchip (self);
-      toshoboe_startchip (self);
+      donauboe_stopchip (self);
+      donauboe_startchip (self);
       spin_unlock_irqrestore(&self->spinlock, flags);
     }
 }
 
 /*Generate packet of about mtt us long */
 STATIC int
-toshoboe_makemttpacket (struct toshoboe_cb *self, void *buf, int mtt)
+donauboe_makemttpacket (struct donauboe_cb *self, void *buf, int mtt)
 {
   int xbofs;
 
@@ -699,7 +699,7 @@
 /* Probe code */
 
 STATIC void
-toshoboe_dumptx (struct toshoboe_cb *self)
+donauboe_dumptx (struct donauboe_cb *self)
 {
   int i;
   PROBE_DEBUG(KERN_WARNING "TX:");
@@ -709,7 +709,7 @@
 }
 
 STATIC void
-toshoboe_dumprx (struct toshoboe_cb *self, int score)
+donauboe_dumprx (struct donauboe_cb *self, int score)
 {
   int i;
   PROBE_DEBUG(" %d\nRX:",score);
@@ -739,19 +739,19 @@
     }
 }
 
-STATIC int toshoboe_invalid_dev(int irq) 
+STATIC int donauboe_invalid_dev(int irq) 
 {
   printk (KERN_WARNING DRIVER_NAME ": irq %d for unknown device.\n", irq);
   return 1;
 }
 
 STATIC void
-toshoboe_probeinterrupt (int irq, void *dev_id, struct pt_regs *regs)
+donauboe_probeinterrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
-  struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
+  struct donauboe_cb *self = (struct donauboe_cb *) dev_id;
   __u8 irqstat;
 
-  if (self == NULL && toshoboe_invalid_dev(irq)) 
+  if (self == NULL && donauboe_invalid_dev(irq)) 
     return;
 
   irqstat = INB (OBOE_ISR);
@@ -775,7 +775,7 @@
         {
           self->int_tx+=100;
           PROBE_DEBUG("S");
-          toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+          donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
         }
     }
 
@@ -794,7 +794,7 @@
 }
 
 STATIC int
-toshoboe_maketestpacket (unsigned char *buf, int badcrc, int fir)
+donauboe_maketestpacket (unsigned char *buf, int badcrc, int fir)
 {
   int i;
   int len = 0;
@@ -831,17 +831,17 @@
 }
 
 STATIC int
-toshoboe_probefail (struct toshoboe_cb *self, char *msg)
+donauboe_probefail (struct donauboe_cb *self, char *msg)
 {
   printk (KERN_ERR DRIVER_NAME "probe(%d) failed %s\n",self-> speed, msg);
-  toshoboe_dumpregs (self);
-  toshoboe_stopchip (self);
+  donauboe_dumpregs (self);
+  donauboe_stopchip (self);
   free_irq (self->io.irq, (void *) self);
   return 0;
 }
 
 STATIC int
-toshoboe_numvalidrcvs (struct toshoboe_cb *self)
+donauboe_numvalidrcvs (struct donauboe_cb *self)
 {
   int i, ret = 0;
   for (i = 0; i < RX_SLOTS; ++i)
@@ -852,7 +852,7 @@
 }
 
 STATIC int
-toshoboe_numrcvs (struct toshoboe_cb *self)
+donauboe_numrcvs (struct donauboe_cb *self)
 {
   int i, ret = 0;
   for (i = 0; i < RX_SLOTS; ++i)
@@ -863,7 +863,7 @@
 }
 
 STATIC int
-toshoboe_probe (struct toshoboe_cb *self)
+donauboe_probe (struct donauboe_cb *self)
 {
   int i, j, n;
 #ifdef USE_MIR
@@ -875,8 +875,8 @@
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
-  if (request_irq (self->io.irq, toshoboe_probeinterrupt,
-                   self->io.irqflags, "toshoboe", (void *) self))
+  if (request_irq (self->io.irq, donauboe_probeinterrupt,
+                   self->io.irqflags, "donauboe", (void *) self))
     {
       printk (KERN_ERR DRIVER_NAME ": probe failed to allocate irq %d\n",
               self->io.irq);
@@ -888,16 +888,16 @@
   for (j = 0; j < (sizeof (bauds) / sizeof (int)); ++j)
     {
       int fir = (j > 1);
-      toshoboe_stopchip (self);
+      donauboe_stopchip (self);
 
 
       spin_lock_irqsave(&self->spinlock, flags);
       /*Address is already setup */
-      toshoboe_startchip (self);
+      donauboe_startchip (self);
       self->int_rx = self->int_tx = 0;
       self->speed = bauds[j];
-      toshoboe_setbaud (self);
-      toshoboe_initptrs (self);
+      donauboe_setbaud (self);
+      donauboe_initptrs (self);
       spin_unlock_irqrestore(&self->spinlock, flags); 
 
       self->ring->tx[self->txs].control =
@@ -906,7 +906,7 @@
         (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX
               : OBOE_CTL_TX_HW_OWNS ;
       self->ring->tx[self->txs].len =
-        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+        donauboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
       self->txs++;
       self->txs %= TX_SLOTS;
 
@@ -914,7 +914,7 @@
         (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_SIP
               : OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX ;
       self->ring->tx[self->txs].len =
-        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+        donauboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
       self->txs++;
       self->txs %= TX_SLOTS;
 
@@ -922,7 +922,7 @@
         (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX
               : OBOE_CTL_TX_HW_OWNS ;
       self->ring->tx[self->txs].len =
-        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+        donauboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
       self->txs++;
       self->txs %= TX_SLOTS;
 
@@ -931,48 +931,48 @@
               | OBOE_CTL_TX_SIP     | OBOE_CTL_TX_BAD_CRC
               : OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX ;
       self->ring->tx[self->txs].len =
-        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+        donauboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
       self->txs++;
       self->txs %= TX_SLOTS;
 
-      toshoboe_dumptx (self);
+      donauboe_dumptx (self);
       /* Turn on TX and RX and loopback */
-      toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+      donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
 
       i = 0;
       n = fir ? 1 : 4;
-      while (toshoboe_numvalidrcvs (self) != n)
+      while (donauboe_numvalidrcvs (self) != n)
         {
           if (i > 4800)
-              return toshoboe_probefail (self, "filter test");
+              return donauboe_probefail (self, "filter test");
           udelay ((9600*(TT_LEN+16))/self->speed);
           i++;
         }
 
       n = fir ? 203 : 102;
-      while ((toshoboe_numrcvs(self) != self->int_rx) || (self->int_tx != n))
+      while ((donauboe_numrcvs(self) != self->int_rx) || (self->int_tx != n))
         {
           if (i > 4800)
-              return toshoboe_probefail (self, "interrupt test");
+              return donauboe_probefail (self, "interrupt test");
           udelay ((9600*(TT_LEN+16))/self->speed);
           i++;
         }
-     toshoboe_dumprx (self,i);
+     donauboe_dumprx (self,i);
 
      }
 
   /* test 2: SIR in char at a time */
 
-  toshoboe_stopchip (self);
+  donauboe_stopchip (self);
   self->int_rx = self->int_tx = 0;
 
   spin_lock_irqsave(&self->spinlock, flags);
-  toshoboe_startchip (self);
+  donauboe_startchip (self);
   spin_unlock_irqrestore(&self->spinlock, flags);
 
   self->async = 1;
   self->speed = 115200;
-  toshoboe_setbaud (self);
+  donauboe_setbaud (self);
   self->ring->tx[self->txs].control =
     OBOE_CTL_TX_RTCENTX | OBOE_CTL_TX_HW_OWNS;
   self->ring->tx[self->txs].len = 4;
@@ -981,31 +981,31 @@
   ((unsigned char *) self->tx_bufs[self->txs])[1] = 'i';
   ((unsigned char *) self->tx_bufs[self->txs])[2] = 's';
   ((unsigned char *) self->tx_bufs[self->txs])[3] = 'h';
-  toshoboe_dumptx (self);
-  toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+  donauboe_dumptx (self);
+  donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
 
   i = 0;
-  while (toshoboe_numvalidrcvs (self) != 4)
+  while (donauboe_numvalidrcvs (self) != 4)
     {
       if (i > 100)
-          return toshoboe_probefail (self, "Async test");
+          return donauboe_probefail (self, "Async test");
       udelay (100);
       i++;
     }
 
-  while ((toshoboe_numrcvs (self) != self->int_rx) || (self->int_tx != 1))
+  while ((donauboe_numrcvs (self) != self->int_rx) || (self->int_tx != 1))
     {
       if (i > 100)
-          return toshoboe_probefail (self, "Async interrupt test");
+          return donauboe_probefail (self, "Async interrupt test");
       udelay (100);
       i++;
     }
-  toshoboe_dumprx (self,i);
+  donauboe_dumprx (self,i);
 
   self->async = 0;
   self->speed = 9600;
-  toshoboe_setbaud (self);
-  toshoboe_stopchip (self);
+  donauboe_setbaud (self);
+  donauboe_stopchip (self);
 
   free_irq (self->io.irq, (void *) self);
 
@@ -1019,15 +1019,15 @@
 
 /* Transmit something */
 STATIC int
-toshoboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
+donauboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
 {
-  struct toshoboe_cb *self;
+  struct donauboe_cb *self;
   __s32 speed;
   int mtt, len, ctl;
   unsigned long flags;
   struct irda_skb_cb *cb = (struct irda_skb_cb *) skb->cb;
 
-  self = (struct toshoboe_cb *) dev->priv;
+  self = (struct donauboe_cb *) dev->priv;
 
   ASSERT (self != NULL, return 0; );
 
@@ -1048,7 +1048,7 @@
   if (self->stopped)
       return -EBUSY;
 
-  toshoboe_checkstuck (self);
+  donauboe_checkstuck (self);
 
   /* Check if we need to change the speed */
   /* But not now. Wait after transmission if mtt not required */
@@ -1079,7 +1079,7 @@
         { 
           /* idle and no data, change speed now */
           self->speed = speed;
-          toshoboe_setbaud (self);
+          donauboe_setbaud (self);
 	  spin_unlock_irqrestore(&self->spinlock, flags);
           dev_kfree_skb (skb);
           return 0;
@@ -1102,7 +1102,7 @@
       /* In MIR and FIR we need to generate a string of data */
       /* which we will add a wrong checksum to */
 
-      mtt = toshoboe_makemttpacket (self, self->tx_bufs[self->txs], mtt);
+      mtt = donauboe_makemttpacket (self, self->tx_bufs[self->txs], mtt);
       IRDA_DEBUG (1, "%s.mtt:%x(%x)%d\n", __FUNCTION__ 
           ,skb->len,mtt,self->txpending);
       if (mtt)
@@ -1124,7 +1124,7 @@
 
           OUTB (0x0, OBOE_ENABLEH);
           /* It is only a timer. Do not send mtt packet outside! */
-          toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+          donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
 
           self->txpending++;
 
@@ -1149,7 +1149,7 @@
     {
       IRDA_DEBUG (0, "%s.ful:%x(%x)%x\n", __FUNCTION__
           ,skb->len, self->ring->tx[self->txs].control, self->txpending);
-      toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
+      donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
       spin_unlock_irqrestore(&self->spinlock, flags);
       return -EBUSY;
     }
@@ -1179,7 +1179,7 @@
   /* If transmitter is idle start in one-shot mode */
 
   if (!self->txpending)
-      toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
+      donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
 
   self->txpending++;
 
@@ -1194,13 +1194,13 @@
 
 /*interrupt handler */
 STATIC void
-toshoboe_interrupt (int irq, void *dev_id, struct pt_regs *regs)
+donauboe_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
-  struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
+  struct donauboe_cb *self = (struct donauboe_cb *) dev_id;
   __u8 irqstat;
   struct sk_buff *skb = NULL;
 
-  if (self == NULL && toshoboe_invalid_dev(irq)) 
+  if (self == NULL && donauboe_invalid_dev(irq)) 
     return;
 
   irqstat = INB (OBOE_ISR);
@@ -1212,7 +1212,7 @@
 /* Ack all the interrupts */
   OUTB (irqstat, OBOE_ISR);
 
-  toshoboe_isntstuck (self);
+  donauboe_isntstuck (self);
 
 /* Txdone */
   if (irqstat & OBOE_INT_TXDONE)
@@ -1251,7 +1251,7 @@
 #else
           self->stats.tx_packets++;
 #endif
-          toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
+          donauboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
         }
 
       if ((!self->txpending) && (self->new_speed))
@@ -1259,7 +1259,7 @@
           self->speed = self->new_speed;
           IRDA_DEBUG (1, "%s: Executed TxDone scheduled speed change %d\n",
 		      __FUNCTION__, self->speed);
-          toshoboe_setbaud (self);
+          donauboe_setbaud (self);
         }
 
       /* Tell network layer that we want more frames */
@@ -1288,7 +1288,7 @@
               /* hasn't been done by the hardware */
               if (enable & OBOE_ENABLEH_SIRON)
                 {
-                  if (!toshoboe_checkfcs (self->rx_bufs[self->rxs], len))
+                  if (!donauboe_checkfcs (self->rx_bufs[self->rxs], len))
                       len = 0;
                   /*Trim off the CRC */
                   if (len > 1)
@@ -1384,7 +1384,7 @@
 }
 
 STATIC int
-toshoboe_net_init (struct net_device *dev)
+donauboe_net_init (struct net_device *dev)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
@@ -1396,15 +1396,15 @@
 }
 
 STATIC int
-toshoboe_net_open (struct net_device *dev)
+donauboe_net_open (struct net_device *dev)
 {
-  struct toshoboe_cb *self;
+  struct donauboe_cb *self;
   unsigned long flags;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
   ASSERT (dev != NULL, return -1; );
-  self = (struct toshoboe_cb *) dev->priv;
+  self = (struct donauboe_cb *) dev->priv;
 
   ASSERT (self != NULL, return 0; );
 
@@ -1414,14 +1414,14 @@
   if (self->stopped)
     return 0;
 
-  if (request_irq (self->io.irq, toshoboe_interrupt,
+  if (request_irq (self->io.irq, donauboe_interrupt,
                    SA_SHIRQ | SA_INTERRUPT, dev->name, (void *) self))
     {
       return -EAGAIN;
     }
 
   spin_lock_irqsave(&self->spinlock, flags);
-  toshoboe_startchip (self);
+  donauboe_startchip (self);
   spin_unlock_irqrestore(&self->spinlock, flags);
 
   /* Ready to play! */
@@ -1441,14 +1441,14 @@
 }
 
 STATIC int
-toshoboe_net_close (struct net_device *dev)
+donauboe_net_close (struct net_device *dev)
 {
-  struct toshoboe_cb *self;
+  struct donauboe_cb *self;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
   ASSERT (dev != NULL, return -1; );
-  self = (struct toshoboe_cb *) dev->priv;
+  self = (struct donauboe_cb *) dev->priv;
 
   /* Stop device */
   netif_stop_queue(dev);
@@ -1464,7 +1464,7 @@
 
   if (!self->stopped)
     {
-      toshoboe_stopchip (self);
+      donauboe_stopchip (self);
     }
 
   MOD_DEC_USE_COUNT;
@@ -1473,16 +1473,16 @@
 }
 
 /*
- * Function toshoboe_net_ioctl (dev, rq, cmd)
+ * Function donauboe_net_ioctl (dev, rq, cmd)
  *
  *    Process IOCTL commands for this device
  *
  */
 STATIC int
-toshoboe_net_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
+donauboe_net_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
   struct if_irda_req *irq = (struct if_irda_req *) rq;
-  struct toshoboe_cb *self;
+  struct donauboe_cb *self;
   unsigned long flags;
   int ret = 0;
 
@@ -1510,7 +1510,7 @@
         return -EPERM;
 
       /* self->speed=irq->ifr_baudrate; */
-      /* toshoboe_setbaud(self); */
+      /* donauboe_setbaud(self); */
       /* Just change speed once - inserted by Paul Bristow */
       self->new_speed = irq->ifr_baudrate;
       break;
@@ -1547,10 +1547,10 @@
 MODULE_PARM_DESC(do_probe, "Enable/disable chip probing and self-test");
 
 STATIC void
-toshoboe_close (struct pci_dev *pci_dev)
+donauboe_close (struct pci_dev *pci_dev)
 {
   int i;
-  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
+  struct donauboe_cb *self = (struct donauboe_cb*)pci_get_drvdata(pci_dev);
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
@@ -1558,7 +1558,7 @@
 
   if (!self->stopped)
     {
-      toshoboe_stopchip (self);
+      donauboe_stopchip (self);
     }
 
   release_region (self->io.fir_base, self->io.fir_ext);
@@ -1591,9 +1591,9 @@
 }
 
 STATIC int
-toshoboe_open (struct pci_dev *pci_dev, const struct pci_device_id *pdid)
+donauboe_open (struct pci_dev *pci_dev, const struct pci_device_id *pdid)
 {
-  struct toshoboe_cb *self;
+  struct donauboe_cb *self;
   struct net_device *dev;
   int i = 0;
   int ok = 0;
@@ -1604,7 +1604,7 @@
   if ((err=pci_enable_device(pci_dev)))
     return err;
 
-  self = kmalloc (sizeof (struct toshoboe_cb), GFP_KERNEL);
+  self = kmalloc (sizeof (struct donauboe_cb), GFP_KERNEL);
 
   if (self == NULL)
     {
@@ -1613,7 +1613,7 @@
       return -ENOMEM;
     }
 
-  memset (self, 0, sizeof (struct toshoboe_cb));
+  memset (self, 0, sizeof (struct donauboe_cb));
 
   self->pdev = pci_dev;
   self->base = pci_resource_start(pci_dev,0);
@@ -1714,7 +1714,7 @@
     }
 
   if (do_probe)
-    if (!toshoboe_probe (self))
+    if (!donauboe_probe (self))
       {
         err = -ENODEV;
         goto freebufs;
@@ -1732,11 +1732,11 @@
 
   printk (KERN_INFO "IrDA: Registered device %s\n", dev->name);
 
-  dev->init = toshoboe_net_init;
-  dev->hard_start_xmit = toshoboe_hard_xmit;
-  dev->open = toshoboe_net_open;
-  dev->stop = toshoboe_net_close;
-  dev->do_ioctl = toshoboe_net_ioctl;
+  dev->init = donauboe_net_init;
+  dev->hard_start_xmit = donauboe_hard_xmit;
+  dev->open = donauboe_net_open;
+  dev->stop = donauboe_net_close;
+  dev->do_ioctl = donauboe_net_ioctl;
 
   rtnl_lock ();
   err = register_netdevice (dev);
@@ -1773,9 +1773,9 @@
 }
 
 STATIC int
-toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
+donauboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
 {
-  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
+  struct donauboe_cb *self = (struct donauboe_cb*)pci_get_drvdata(pci_dev);
   unsigned long flags;
   int i = 10;
 
@@ -1793,7 +1793,7 @@
 
   spin_lock_irqsave(&self->spinlock, flags);
 
-  toshoboe_stopchip (self);
+  donauboe_stopchip (self);
   self->stopped = 1;
   self->txpending = 0;
 
@@ -1802,9 +1802,9 @@
 }
 
 STATIC int
-toshoboe_wakeup (struct pci_dev *pci_dev)
+donauboe_wakeup (struct pci_dev *pci_dev)
 {
-  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
+  struct donauboe_cb *self = (struct donauboe_cb*)pci_get_drvdata(pci_dev);
   unsigned long flags;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -1817,7 +1817,7 @@
 
   spin_lock_irqsave(&self->spinlock, flags);
 
-  toshoboe_startchip (self);
+  donauboe_startchip (self);
   self->stopped = 0;
 
   netif_wake_queue(self->netdev);
@@ -1825,26 +1825,26 @@
   return 0;
 }
 
-static struct pci_driver toshoboe_pci_driver = {
-  name		: "toshoboe",
-  id_table	: toshoboe_pci_tbl,
-  probe		: toshoboe_open,
-  remove	: toshoboe_close,
-  suspend	: toshoboe_gotosleep,
-  resume	: toshoboe_wakeup 
+static struct pci_driver donauboe_pci_driver = {
+  name		: "donauboe",
+  id_table	: donauboe_pci_tbl,
+  probe		: donauboe_open,
+  remove	: donauboe_close,
+  suspend	: donauboe_gotosleep,
+  resume	: donauboe_wakeup 
 };
 
 int __init
-toshoboe_init (void)
+donauboe_init (void)
 {
-  return pci_module_init(&toshoboe_pci_driver);
+  return pci_module_init(&donauboe_pci_driver);
 }
 
 STATIC void __exit
-toshoboe_cleanup (void)
+donauboe_cleanup (void)
 {
-  pci_unregister_driver(&toshoboe_pci_driver);
+  pci_unregister_driver(&donauboe_pci_driver);
 }
 
-module_init(toshoboe_init);
-module_exit(toshoboe_cleanup);
+module_init(donauboe_init);
+module_exit(donauboe_cleanup);
