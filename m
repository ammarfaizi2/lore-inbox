Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVDSCru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDSCru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 22:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVDSCru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 22:47:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61709 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261285AbVDSCpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 22:45:04 -0400
Date: Tue, 19 Apr 2005 04:45:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mikep@linuxtr.net
Cc: linux-tr@linuxtr.net, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/tokenring/: cleanups
Message-ID: <20050419024502.GX5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the follwing cleanups:
- make needlessly global code static
- remove obsolete Emacs settings

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/pcmcia/ibmtr_cs.c           |    3 --
 drivers/net/tokenring/3c359.c           |    3 +-
 drivers/net/tokenring/3c359_microcode.h |    2 -
 drivers/net/tokenring/abyss.c           |   11 ---------
 drivers/net/tokenring/ibmtr.c           |   28 ++++++++++++------------
 drivers/net/tokenring/madgemc.c         |   14 ------------
 drivers/net/tokenring/proteon.c         |   11 ---------
 drivers/net/tokenring/skisa.c           |   11 ---------
 drivers/net/tokenring/smctr.c           |    2 -
 drivers/net/tokenring/smctr_firmware.h  |    2 -
 drivers/net/tokenring/tms380tr.c        |   13 -----------
 drivers/net/tokenring/tmspci.c          |   11 ---------
 12 files changed, 21 insertions(+), 90 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/ibmtr.c.old	2005-04-19 03:11:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/ibmtr.c	2005-04-19 03:41:47.000000000 +0200
@@ -151,7 +151,7 @@
 
 /* this allows displaying full adapter information */
 
-char *channel_def[] __devinitdata = { "ISA", "MCA", "ISA P&P" };
+static char *channel_def[] __devinitdata = { "ISA", "MCA", "ISA P&P" };
 
 static char pcchannelid[] __devinitdata = {
 	0x05, 0x00, 0x04, 0x09,
@@ -171,7 +171,7 @@
 	0x03, 0x08, 0x02, 0x00
 };
 
-char __devinit *adapter_def(char type)
+static char __devinit *adapter_def(char type)
 {
 	switch (type) {
 	case 0xF: return "PC Adapter | PC Adapter II | Adapter/A";
@@ -184,7 +184,7 @@
 
 #define TRC_INIT 0x01		/*  Trace initialization & PROBEs */
 #define TRC_INITV 0x02		/*  verbose init trace points     */
-unsigned char ibmtr_debug_trace = 0;
+static unsigned char ibmtr_debug_trace = 0;
 
 static int 	ibmtr_probe(struct net_device *dev);
 static int	ibmtr_probe1(struct net_device *dev, int ioaddr);
@@ -192,20 +192,20 @@
 static int 	trdev_init(struct net_device *dev);
 static int 	tok_open(struct net_device *dev);
 static int 	tok_init_card(struct net_device *dev);
-void 		tok_open_adapter(unsigned long dev_addr);
+static void	tok_open_adapter(unsigned long dev_addr);
 static void 	open_sap(unsigned char type, struct net_device *dev);
 static void 	tok_set_multicast_list(struct net_device *dev);
 static int 	tok_send_packet(struct sk_buff *skb, struct net_device *dev);
 static int 	tok_close(struct net_device *dev);
-irqreturn_t tok_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t tok_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void 	initial_tok_int(struct net_device *dev);
 static void 	tr_tx(struct net_device *dev);
 static void 	tr_rx(struct net_device *dev);
-void 		ibmtr_reset_timer(struct timer_list*tmr,struct net_device *dev);
+static void	ibmtr_reset_timer(struct timer_list*tmr,struct net_device *dev);
 static void	tok_rerun(unsigned long dev_addr);
-void 		ibmtr_readlog(struct net_device *dev);
+static void	ibmtr_readlog(struct net_device *dev);
 static struct 	net_device_stats *tok_get_stats(struct net_device *dev);
-int 		ibmtr_change_mtu(struct net_device *dev, int mtu);
+static int	ibmtr_change_mtu(struct net_device *dev, int mtu);
 static void	find_turbo_adapters(int *iolist);
 
 static int ibmtr_portlist[IBMTR_MAX_ADAPTERS+1] __devinitdata = {
@@ -928,7 +928,7 @@
 #define DLC_MAX_SAP_OFST        32
 #define DLC_MAX_STA_OFST        33
 
-void tok_open_adapter(unsigned long dev_addr)
+static void tok_open_adapter(unsigned long dev_addr)
 {
 	struct net_device *dev = (struct net_device *) dev_addr;
 	struct tok_info *ti;
@@ -1099,7 +1099,7 @@
 	return ti->sram_virt + index;
 }
 
-void dir_open_adapter (struct net_device *dev)
+static void dir_open_adapter (struct net_device *dev)
 {
         struct tok_info *ti = (struct tok_info *) dev->priv;
         unsigned char ret_code;
@@ -1172,7 +1172,7 @@
 
 /******************************************************************************/
 
-irqreturn_t tok_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t tok_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned char status;
 	/*  unsigned char status_even ; */
@@ -1840,7 +1840,7 @@
 
 /*****************************************************************************/
 
-void ibmtr_reset_timer(struct timer_list *tmr, struct net_device *dev)
+static void ibmtr_reset_timer(struct timer_list *tmr, struct net_device *dev)
 {
 	tmr->expires = jiffies + TR_RETRY_INTERVAL;
 	tmr->data = (unsigned long) dev;
@@ -1872,7 +1872,7 @@
 
 /*****************************************************************************/
 
-void ibmtr_readlog(struct net_device *dev)
+static void ibmtr_readlog(struct net_device *dev)
 {
 	struct tok_info *ti;
 
@@ -1905,7 +1905,7 @@
 
 /*****************************************************************************/
 
-int ibmtr_change_mtu(struct net_device *dev, int mtu)
+static int ibmtr_change_mtu(struct net_device *dev, int mtu)
 {
 	struct tok_info *ti = (struct tok_info *) dev->priv;
 
--- linux-2.6.12-rc2-mm3-full/drivers/net/pcmcia/ibmtr_cs.c.old	2005-04-19 03:42:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/pcmcia/ibmtr_cs.c	2005-04-19 03:42:10.000000000 +0200
@@ -119,9 +119,6 @@
 
 static dev_link_t *dev_list;
 
-extern int ibmtr_probe_card(struct net_device *dev);
-extern irqreturn_t tok_interrupt (int irq, void *dev_id, struct pt_regs *regs);
-
 /*====================================================================*/
 
 typedef struct ibmtr_dev_t {
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/3c359_microcode.h.old	2005-04-19 03:43:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/3c359_microcode.h	2005-04-19 03:43:16.000000000 +0200
@@ -22,7 +22,7 @@
 
 static int mc_size = 24880 ; 
 
-u8 microcode[] = { 
+static const u8 microcode[] = { 
  0xfe,0x3a,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
 ,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
 ,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/3c359.c.old	2005-04-19 03:43:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/3c359.c	2005-04-19 03:43:48.000000000 +0200
@@ -276,7 +276,8 @@
 	return ; 
 }
  
-int __devinit xl_probe(struct pci_dev *pdev, const struct pci_device_id *ent) 
+static int __devinit xl_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent) 
 {
 	struct net_device *dev ; 
 	struct xl_private *xl_priv ; 
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/madgemc.c.old	2005-04-19 03:44:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/madgemc.c	2005-04-19 03:47:40.000000000 +0200
@@ -625,7 +625,7 @@
 /*
  * Disable the board, and put back into power-up state.
  */
-void madgemc_chipset_close(struct net_device *dev)
+static void madgemc_chipset_close(struct net_device *dev)
 {
 	/* disable interrupts */
 	madgemc_setint(dev, 0);
@@ -786,15 +786,3 @@
 
 MODULE_LICENSE("GPL");
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c madgemc.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c madgemc.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
-
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/smctr_firmware.h.old	2005-04-19 03:44:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/smctr_firmware.h	2005-04-19 03:45:00.000000000 +0200
@@ -21,7 +21,7 @@
 
 #if defined(CONFIG_SMCTR) || defined(CONFIG_SMCTR_MODULE)
 
-unsigned char smctr_code[] = {
+static const unsigned char smctr_code[] = {
 	0x0BC, 0x01D, 0x012, 0x03B, 0x063, 0x0B4, 0x0E9, 0x000,
 	0x000, 0x01F, 0x000, 0x001, 0x001, 0x000, 0x002, 0x005,
 	0x001, 0x000, 0x006, 0x003, 0x001, 0x000, 0x004, 0x009,
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/smctr.c.old	2005-04-19 03:45:13.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/smctr.c	2005-04-19 03:45:20.000000000 +0200
@@ -77,7 +77,7 @@
 
 /* SMC Name of the Adapter. */
 static char smctr_name[] = "SMC TokenCard";
-char *smctr_model = "Unknown";
+static char *smctr_model = "Unknown";
 
 /* Use 0 for production, 1 for verification, 2 for debug, and
  * 3 for very verbose debug.
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/tms380tr.c.old	2005-04-19 03:45:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/tms380tr.c	2005-04-19 03:46:24.000000000 +0200
@@ -2379,7 +2379,7 @@
 EXPORT_SYMBOL(tmsdev_term);
 EXPORT_SYMBOL(tms380tr_wait);
 
-struct module *TMS380_module = NULL;
+static struct module *TMS380_module = NULL;
 
 int init_module(void)
 {
@@ -2397,14 +2397,3 @@
 
 MODULE_LICENSE("GPL");
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tms380tr.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tms380tr.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/tmspci.c.old	2005-04-19 03:46:38.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/tmspci.c	2005-04-19 03:46:48.000000000 +0200
@@ -254,14 +254,3 @@
 module_init(tms_pci_init);
 module_exit(tms_pci_rmmod);
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmspci.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmspci.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/skisa.c.old	2005-04-19 03:46:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/skisa.c	2005-04-19 03:47:06.000000000 +0200
@@ -429,14 +429,3 @@
 }
 #endif /* MODULE */
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c skisa.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c skisa.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/proteon.c.old	2005-04-19 03:47:15.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/proteon.c	2005-04-19 03:47:27.000000000 +0200
@@ -419,14 +419,3 @@
 }
 #endif /* MODULE */
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c proteon.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c proteon.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
--- linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/abyss.c.old	2005-04-19 03:47:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/tokenring/abyss.c	2005-04-19 03:47:53.000000000 +0200
@@ -468,14 +468,3 @@
 module_init(abyss_init);
 module_exit(abyss_rmmod);
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c abyss.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c abyss.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */

