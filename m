Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbRE3Aj2>; Tue, 29 May 2001 20:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbRE3AjV>; Tue, 29 May 2001 20:39:21 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:62734 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262164AbRE3AjG>; Tue, 29 May 2001 20:39:06 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300040.CAA04496@green.mif.pg.gda.pl>
Subject: [PATCH] net #1
To: linux-kernel@vger.kernel.org (kernel list)
Date: Wed, 30 May 2001 02:40:16 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From kufel!ankry  Wed May 30 02:29:36 2001
Return-Path: <kufel!ankry>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id CAA04405
	for green.mif.pg.gda.pl!ankry; Wed, 30 May 2001 02:29:35 +0200
Received: (from ankry@localhost)
	by kufel.dom (8.9.3/8.9.3) id CAA02200
	for green!ankry; Wed, 30 May 2001 02:07:43 +0200
Date: Wed, 30 May 2001 02:07:43 +0200
From: Andrzej Krzysztofowicz <kufel!ankry>
Message-Id: <200105300007.CAA02200@kufel.dom>
To: kufel!green.mif.pg.gda.pl!ankry
Subject: alan.1

cox, jg, linux-net@vger.kernel.org, andrewm@uow.edu.au

Hi,
  This patch adds MODULE_PARM_DESC to all drivers located directly in
drivers/net. Some existing descriptions are fixed; some undefined
parameters are disabled.
  Also a dependency of 3c509 parameters on CONFIG_ISAPNP is removed. It is
better to have a non-working parameter (many drivers have such parameters)
than having a driver that sometimes supports a parameter and sometimes it
does not...

This is the first of my series of network patches, that are generated
incrementally against 2.4.5-ac4. However, they are so separated, that
can be applied independently (eventually with some minor shifts)

Andrzej

*********************** PATCH 1 *********************************
diff -uNr linux-2.4.5-ac4/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.4.5-ac4/drivers/net/3c501.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c501.c	Wed May 30 01:07:41 2001
@@ -925,6 +925,8 @@
 static int irq=5;
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "EtherLink I/O base address");
+MODULE_PARM_DESC(irq, "EtherLink IRQ number");
 
 /**
  * init_module:
diff -uNr linux-2.4.5-ac4/drivers/net/3c503.c linux/drivers/net/3c503.c
--- linux-2.4.5-ac4/drivers/net/3c503.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c503.c	Wed May 30 01:07:41 2001
@@ -615,6 +615,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM(xcvr, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink II I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink II IRQ number(s) (assigned)");
+MODULE_PARM_DESC(xcvr, "EtherLink II tranceiver(s) (0=internal, 1=external)");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
diff -uNr linux-2.4.5-ac4/drivers/net/3c505.c linux/drivers/net/3c505.c
--- linux-2.4.5-ac4/drivers/net/3c505.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c505.c	Wed May 30 01:07:41 2001
@@ -1621,6 +1621,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
 MODULE_PARM(dma, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink Plus I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink Plus IRQ number(s) (assigned)");
+MODULE_PARM_DESC(dma, "EtherLink Plus DMA channel(s)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/3c507.c linux/drivers/net/3c507.c
--- linux-2.4.5-ac4/drivers/net/3c507.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c507.c	Wed May 30 01:07:41 2001
@@ -861,6 +861,8 @@
 static int irq;
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "EtherLink16 I/O base address");
+MODULE_PARM_DESC(irq, "(ignored)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/3c509.c linux/drivers/net/3c509.c
--- linux-2.4.5-ac4/drivers/net/3c509.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c509.c	Wed May 30 01:07:41 2001
@@ -1007,9 +1007,12 @@
 MODULE_PARM(irq,"1-8i");
 MODULE_PARM(xcvr,"1-8i");
 MODULE_PARM(max_interrupt_work, "i");
-#ifdef CONFIG_ISAPNP
+MODULE_PARM_DESC(debug, "EtherLink III debug level (0-6)");
+MODULE_PARM_DESC(irq, "EtherLink III IRQ number(s) (assigned)");
+MODULE_PARM_DESC(xcvr,"EtherLink III tranceiver(s) (0=internal, 1=external)");
+MODULE_PARM_DESC(max_interrupt_work, "EtherLink III maximum events handled per interrupt");
 MODULE_PARM(nopnp, "i");
-#endif
+MODULE_PARM_DESC(nopnp, "EtherLink III disable ISA PnP support (0-1)");
 
 int
 init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/3c515.c linux/drivers/net/3c515.c
--- linux-2.4.5-ac4/drivers/net/3c515.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c515.c	Wed May 30 01:07:41 2001
@@ -85,6 +85,11 @@
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
+MODULE_PARM_DESC(debug, "3c515 debug level (0-6)");
+MODULE_PARM_DESC(options, "3c515: Bits 0-2: media type, bit 3: full duplex, bit 4: bus mastering");
+MODULE_PARM_DESC(full_duplex, "(ignored)");
+MODULE_PARM_DESC(rx_copybreak, "3c515 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(max_interrupt_work, "3c515 maximum events handled per interrupt");
 
 /* "Knobs" for adjusting internal parameters. */
 /* Put out somewhat more debugging messages. (0 - no msg, 1 minimal msgs). */
diff -uNr linux-2.4.5-ac4/drivers/net/3c523.c linux/drivers/net/3c523.c
--- linux-2.4.5-ac4/drivers/net/3c523.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/3c523.c	Wed May 30 01:07:41 2001
@@ -1226,6 +1226,8 @@
 static int io[MAX_3C523_CARDS];
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_3C523_CARDS) "i");
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_3C523_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink/MC I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink/MC IRQ number(s)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/3c59x.c linux/drivers/net/3c59x.c
--- linux-2.4.5-ac4/drivers/net/3c59x.c	Mon May 28 01:34:53 2001
+++ linux/drivers/net/3c59x.c	Wed May 30 01:07:41 2001
@@ -236,6 +236,18 @@
 MODULE_PARM(compaq_irq, "i");
 MODULE_PARM(compaq_device_id, "i");
 MODULE_PARM(watchdog, "i");
+MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
+MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
+MODULE_PARM_DESC(full_duplex, "3c59x full duplex setting(s) (1)");
+MODULE_PARM_DESC(hw_checksums, "3c59x Hardware checksum checking by adapter(s) (0-1)");
+MODULE_PARM_DESC(flow_ctrl, "3c59x 802.3x flow control usage (PAUSE only) (0-1)");
+MODULE_PARM_DESC(enable_wol, "3c59x: Turn on Wake-on-LAN for adapter(s) (0-1)");
+MODULE_PARM_DESC(rx_copybreak, "3c59x copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(max_interrupt_work, "3c59x maximum events handled per interrupt");
+MODULE_PARM_DESC(compaq_ioaddr, "3c59x PCI I/O base address (Compaq BIOS problem workaround)");
+MODULE_PARM_DESC(compaq_irq, "3c59x PCI IRQ number (Compaq BIOS problem workaround)");
+MODULE_PARM_DESC(compaq_device_id, "3c59x PCI device ID (Compaq BIOS problem workaround)");
+MODULE_PARM_DESC(watchdog, "3c59x transmit timeout in milliseconds");
 
 /* Operational parameter that usually are not changed. */
 
diff -uNr linux-2.4.5-ac4/drivers/net/8139too.c linux/drivers/net/8139too.c
--- linux-2.4.5-ac4/drivers/net/8139too.c	Tue May 29 20:46:16 2001
+++ linux/drivers/net/8139too.c	Wed May 30 01:07:41 2001
@@ -580,6 +580,10 @@
 MODULE_PARM (max_interrupt_work, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM (full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC (multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
+MODULE_PARM_DESC (max_interrupt_work, "8139too maximum events handled per interrupt");
+MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
+MODULE_PARM_DESC (full_duplex, "8139too: Force full duplex for board(s) (1)");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);
 static int rtl8139_open (struct net_device *dev);
diff -uNr linux-2.4.5-ac4/drivers/net/82596.c linux/drivers/net/82596.c
--- linux-2.4.5-ac4/drivers/net/82596.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/82596.c	Wed May 30 01:07:42 2001
@@ -151,6 +151,7 @@
 MODULE_AUTHOR("Richard Hirst");
 MODULE_DESCRIPTION("i82596 driver");
 MODULE_PARM(i596_debug, "i");
+MODULE_PARM_DESC(i596_debug, "i82596 debug mask");
 
 
 /* Copy frames shorter than rx_copybreak, otherwise pass on up in
@@ -1493,9 +1494,11 @@
 static int io = 0x300;
 static int irq = 10;
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(irq, "Apricot IRQ number");
 #endif
 
 MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "i82596 debug mask");
 static int debug = -1;
 
 int init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/ac3200.c linux/drivers/net/ac3200.c
--- linux-2.4.5-ac4/drivers/net/ac3200.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/ac3200.c	Wed May 30 01:07:42 2001
@@ -344,6 +344,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
+MODULE_PARM_DESC(io, "ac3200 I/O base adress(es)");
+MODULE_PARM_DESC(irq, "ac3200 IRQ number(s)");
+MODULE_PARM_DESC(mem, "ac3200 Memory base address(es)");
 
 int
 init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/acenic.c linux/drivers/net/acenic.c
--- linux-2.4.5-ac4/drivers/net/acenic.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/acenic.c	Wed May 30 01:07:42 2001
@@ -748,7 +748,6 @@
 }
 
 
-#ifdef MODULE
 MODULE_AUTHOR("Jes Sorensen <jes@linuxcare.com>");
 MODULE_DESCRIPTION("AceNIC/3C985/GA620 Gigabit Ethernet driver");
 MODULE_PARM(link, "1-" __MODULE_STRING(8) "i");
@@ -757,7 +756,12 @@
 MODULE_PARM(max_tx_desc, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_coal_tick, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(max_rx_desc, "1-" __MODULE_STRING(8) "i");
-#endif
+MODULE_PARM_DESC(link, "Acenic/3C985/NetGear link state");
+MODULE_PARM_DESC(trace, "Acenic/3C985/NetGear firmware trace level");
+MODULE_PARM_DESC(tx_coal_tick, "Acenic/3C985/NetGear maximum clock ticks to wait for packets");
+MODULE_PARM_DESC(max_tx_desc, "Acenic/3C985/NetGear maximum number of transmit descriptors");
+MODULE_PARM_DESC(rx_coal_tick, "Acenic/3C985/NetGear maximum clock ticks to wait for packets");
+MODULE_PARM_DESC(max_rx_desc, "Acenic/3C985/NetGear maximum number of receive descriptors");
 
 
 static void __exit ace_module_cleanup(void)
diff -uNr linux-2.4.5-ac4/drivers/net/aironet4500_core.c linux/drivers/net/aironet4500_core.c
--- linux-2.4.5-ac4/drivers/net/aironet4500_core.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/aironet4500_core.c	Wed May 30 01:07:42 2001
@@ -2566,7 +2566,7 @@
 MODULE_PARM(awc_debug,"i");
 MODULE_PARM(tx_rate,"i");
 MODULE_PARM(channel,"i");
-MODULE_PARM(tx_full_rate,"i");
+//MODULE_PARM(tx_full_rate,"i");
 MODULE_PARM(adhoc,"i");
 MODULE_PARM(master,"i");
 MODULE_PARM(slave,"i");
@@ -2575,6 +2575,12 @@
 MODULE_PARM(large_buff_mem,"i");
 MODULE_PARM(small_buff_no,"i");
 MODULE_PARM(SSID,"c33");
+MODULE_PARM_DESC(awc_debug,"Aironet debug mask");
+MODULE_PARM_DESC(channel,"Aironet ");
+MODULE_PARM_DESC(adhoc,"Aironet Access Points not available (0-1)");
+MODULE_PARM_DESC(master,"Aironet is Adhoc master (creates network sync) (0-1)");
+MODULE_PARM_DESC(slave,"Aironet is Adhoc slave (0-1)");
+MODULE_PARM_DESC(max_mtu,"Aironet MTU limit (256-2312)");
 #endif
 
 /*EXPORT_SYMBOL(tx_queue_len);
diff -uNr linux-2.4.5-ac4/drivers/net/arlan.c linux/drivers/net/arlan.c
--- linux-2.4.5-ac4/drivers/net/arlan.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/arlan.c	Wed May 30 01:07:42 2001
@@ -68,6 +68,23 @@
 MODULE_PARM(arlan_exit_debug, "i");
 MODULE_PARM(arlan_entry_and_exit_debug, "i");
 MODULE_PARM(arlan_EEPROM_bad, "i");
+MODULE_PARM_DESC(irq, "(unused)");
+MODULE_PARM_DESC(mem, "Arlan memory address for single device probing");
+MODULE_PARM_DESC(probe, "Arlan probe at initialization (0-1)");
+MODULE_PARM_DESC(arlan_debug, "Arlan debug enable (0-1)");
+MODULE_PARM_DESC(numDevices, "Number of Arlan devices; ignored if >1");
+MODULE_PARM_DESC(testMemory, "(unused)");
+MODULE_PARM_DESC(mdebug, "Arlan multicast debugging (0-1)");
+MODULE_PARM_DESC(retries, "Arlan maximum packet retransmisions");
+#ifdef ARLAN_ENTRY_EXIT_DEBUGGING
+MODULE_PARM_DESC(arlan_entry_debug, "Arlan driver function entry debugging");
+MODULE_PARM_DESC(arlan_exit_debug, "Arlan driver function exit debugging");
+MODULE_PARM_DESC(arlan_entry_and_exit_debug, "Arlan driver function entry and exit debugging");
+#else
+MODULE_PARM_DESC(arlan_entry_debug, "(ignored)");
+MODULE_PARM_DESC(arlan_exit_debug, "(ignored)");
+MODULE_PARM_DESC(arlan_entry_and_exit_debug, "(ignored)");
+#endif
 
 EXPORT_SYMBOL(arlan_device);
 EXPORT_SYMBOL(arlan_conf);
diff -uNr linux-2.4.5-ac4/drivers/net/at1700.c linux/drivers/net/at1700.c
--- linux-2.4.5-ac4/drivers/net/at1700.c	Sat May 19 18:33:43 2001
+++ linux/drivers/net/at1700.c	Wed May 30 01:07:42 2001
@@ -880,6 +880,9 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(net_debug, "i");
+MODULE_PARM_DESC(io, "AT1700/FMV18X I/O base address");
+MODULE_PARM_DESC(irq, "AT1700/FMV18X IRQ number");
+MODULE_PARM_DESC(net_debug, "AT1700/FMV18X debug level (0-6)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/atari_bionet.c linux/drivers/net/atari_bionet.c
--- linux-2.4.5-ac4/drivers/net/atari_bionet.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/atari_bionet.c	Wed May 30 01:07:42 2001
@@ -127,6 +127,7 @@
  */
 unsigned int bionet_debug = NET_DEBUG;
 MODULE_PARM(bionet_debug, "i");
+MODULE_PARM_DESC(bionet_debug, "bionet debug level (0-2)");
 
 static unsigned int bionet_min_poll_time = 2;
 
diff -uNr linux-2.4.5-ac4/drivers/net/atari_pamsnet.c linux/drivers/net/atari_pamsnet.c
--- linux-2.4.5-ac4/drivers/net/atari_pamsnet.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/atari_pamsnet.c	Wed May 30 01:07:42 2001
@@ -123,6 +123,7 @@
  */
 unsigned int pamsnet_debug = NET_DEBUG;
 MODULE_PARM(pamsnet_debug, "i");
+MODULE_PARM_DESC(pamsnet_debug, "pamsnet debug enable (0-1)");
 
 static unsigned int pamsnet_min_poll_time = 2;
 
diff -uNr linux-2.4.5-ac4/drivers/net/atarilance.c linux/drivers/net/atarilance.c
--- linux-2.4.5-ac4/drivers/net/atarilance.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/atarilance.c	Wed May 30 01:07:42 2001
@@ -83,6 +83,7 @@
 static int lance_debug = 1;
 #endif
 MODULE_PARM(lance_debug, "i");
+MODULE_PARM_DESC(lance_debug, "atarilance debug level (0-3)");
 
 /* Print debug messages on probing? */
 #undef LANCE_DEBUG_PROBE
diff -uNr linux-2.4.5-ac4/drivers/net/atp.c linux/drivers/net/atp.c
--- linux-2.4.5-ac4/drivers/net/atp.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/atp.c	Wed May 30 01:07:42 2001
@@ -153,9 +153,14 @@
 MODULE_DESCRIPTION("RealTek RTL8002/8012 parallel port Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
-MODULE_PARM(io, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM(xcvr, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM(io, "1-" __MODULE_STRING(NUM_UNITS) "i");
+MODULE_PARM(irq, "1-" __MODULE_STRING(NUM_UNITS) "i");
+MODULE_PARM(xcvr, "1-" __MODULE_STRING(NUM_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "ATP maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "ATP debug level (0-7)");
+MODULE_PARM_DESC(io, "ATP I/O base address(es)");
+MODULE_PARM_DESC(irq, "ATP IRQ number(s)");
+MODULE_PARM_DESC(xcvr, "ATP tranceiver(s) (0=internal, 1=external)");
 
 #define RUN_AT(x) (jiffies + (x))
 
diff -uNr linux-2.4.5-ac4/drivers/net/bagetlance.c linux/drivers/net/bagetlance.c
--- linux-2.4.5-ac4/drivers/net/bagetlance.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/bagetlance.c	Wed May 30 01:07:42 2001
@@ -59,6 +59,7 @@
 static int lance_debug = 1;
 #endif
 MODULE_PARM(lance_debug, "i");
+MODULE_PARM_DESC(lance_debug, "Lance debug level (0-3)");
 
 /* Print debug messages on probing? */
 #undef LANCE_DEBUG_PROBE
diff -uNr linux-2.4.5-ac4/drivers/net/cs89x0.c linux/drivers/net/cs89x0.c
--- linux-2.4.5-ac4/drivers/net/cs89x0.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/cs89x0.c	Wed May 30 01:07:42 2001
@@ -1607,6 +1607,25 @@
 MODULE_PARM(dma , "i");
 MODULE_PARM(dmasize , "i");
 MODULE_PARM(use_dma , "i");
+MODULE_PARM_DESC(io, "cs89x0 I/O base address");
+MODULE_PARM_DESC(irq, "cs89x0 IRQ number");
+#if DEBUGGING
+MODULE_PARM_DESC(debug, "cs89x0 debug level (0-6)");
+#else
+MODULE_PARM_DESC(debug, "(ignored)");
+#endif
+MODULE_PARM_DESC(media, "Set cs89x0 adapter(s) media type(s) (rj45,bnc,aui)");
+/* No other value than -1 for duplex seems to be currently interpreted */
+MODULE_PARM_DESC(duplex, "(ignored)");
+#if ALLOW_DMA
+MODULE_PARM_DESC(dma , "cs89x0 ISA DMA channel; ignored if use_dma=0");
+MODULE_PARM_DESC(dmasize , "cs89x0 DMA size in kB (16,64); ignored if use_dma=0");
+MODULE_PARM_DESC(use_dma , "cs89x0 using DMA (0-1)");
+#else
+MODULE_PARM_DESC(dma , "(ignored)");
+MODULE_PARM_DESC(dmasize , "(ignored)");
+MODULE_PARM_DESC(use_dma , "(ignored)");
+#endif
 
 MODULE_AUTHOR("Mike Cruse, Russwll Nelson <nelson@crynwr.com>, Andrew Morton <andrewm@uow.edu.au>");
 
diff -uNr linux-2.4.5-ac4/drivers/net/de4x5.c linux/drivers/net/de4x5.c
--- linux-2.4.5-ac4/drivers/net/de4x5.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/de4x5.c	Wed May 30 01:07:42 2001
@@ -1044,6 +1044,9 @@
 MODULE_PARM(de4x5_debug, "i");
 MODULE_PARM(dec_only, "i");
 MODULE_PARM(args, "s");
+MODULE_PARM_DESC(de4x5_debug, "de4x5 debug mask");
+MODULE_PARM_DESC(dec_only, "de4x5 probe only for Digital boards (0-1)");
+MODULE_PARM_DESC(args, "de4x5 full duplex and media type settings; see de4x5.c for details");
 # else
 static int loading_module;
 #endif /* MODULE */
@@ -5784,6 +5787,7 @@
 static struct net_device *mdev = NULL;
 static int io=0x0;/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
 MODULE_PARM(io, "i");
+MODULE_PARM_DESC(io, "de4x5 I/O base address");
 
 int
 init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/de600.c linux/drivers/net/de600.c
--- linux-2.4.5-ac4/drivers/net/de600.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/de600.c	Wed May 30 01:07:42 2001
@@ -113,9 +113,11 @@
 
 static unsigned int de600_debug = DE600_DEBUG;
 MODULE_PARM(de600_debug, "i");
+MODULE_PARM_DESC(de600_debug, "DE-600 debug level (0-2)");
 
 static unsigned int delay_time = 10;
 MODULE_PARM(delay_time, "i");
+MODULE_PARM_DESC(delay_time, "DE-600 deley on I/O in microseconds");
 
 #ifdef FAKE_SMALL_MAX
 static unsigned long de600_rspace(struct sock *sk);
diff -uNr linux-2.4.5-ac4/drivers/net/de620.c linux/drivers/net/de620.c
--- linux-2.4.5-ac4/drivers/net/de620.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/de620.c	Wed May 30 01:07:42 2001
@@ -197,6 +197,12 @@
 MODULE_PARM(irq, "i");
 MODULE_PARM(clone, "i");
 MODULE_PARM(de620_debug, "i");
+MODULE_PARM_DESC(bnc, "DE-620 set BNC medium (0-1)");
+MODULE_PARM_DESC(utp, "DE-620 set UTP medium (0-1)");
+MODULE_PARM_DESC(io, "DE-620 I/O base address,required");
+MODULE_PARM_DESC(irq, "DE-620 IRQ number,required");
+MODULE_PARM_DESC(clone, "Check also for non-D-Link DE-620 clones (0-1)");
+MODULE_PARM_DESC(de620_debug, "DE-620 debug level (0-2)");
 
 /***********************************************
  *                                             *
diff -uNr linux-2.4.5-ac4/drivers/net/depca.c linux/drivers/net/depca.c
--- linux-2.4.5-ac4/drivers/net/depca.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/depca.c	Wed May 30 01:07:42 2001
@@ -2039,6 +2039,8 @@
 static int io=0x200;    /* Or use the irq= io= options to insmod */
 MODULE_PARM(irq, "i");
 MODULE_PARM(io, "i");
+MODULE_PARM_DESC(irq, "DEPCA IRQ number");
+MODULE_PARM_DESC(io, "DEPCA I/O base address");
 
 /* See depca_probe() for autoprobe messages when a module */	
 int
diff -uNr linux-2.4.5-ac4/drivers/net/dgrs.c linux/drivers/net/dgrs.c
--- linux-2.4.5-ac4/drivers/net/dgrs.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/dgrs.c	Wed May 30 01:07:42 2001
@@ -1441,6 +1441,9 @@
 MODULE_PARM(iptrap, "1-4i");
 MODULE_PARM(ipxnet, "i");
 MODULE_PARM(nicmode, "i");
+MODULE_PARM_DESC(debug, "Digi RightSwitch enable debugging (0-1)");
+MODULE_PARM_DESC(dma, "Digi RightSwitch enable BM DMA (0-1)");
+MODULE_PARM_DESC(nicmode, "Digi RightSwitch operating mode (1: switch, 2: multi-NIC)");
 
 static int __init dgrs_init_module (void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/dmfe.c linux/drivers/net/dmfe.c
--- linux-2.4.5-ac4/drivers/net/dmfe.c	Mon May 28 01:33:58 2001
+++ linux/drivers/net/dmfe.c	Wed May 30 01:07:42 2001
@@ -2014,7 +2014,10 @@
 MODULE_PARM(HPNA_tx_cmd, "i");
 MODULE_PARM(HPNA_NoiseFloor, "i");
 MODULE_PARM(SF_mode, "i");
-
+MODULE_PARM_DESC(debug, "Davicom DM9xxx enable debugging (0-1)");
+MODULE_PARM_DESC(mode, "Davicom DM9xxx: Bit 0: 10/100Mbps, bit 2: duplex, bit 8: HomePNA");
+MODULE_PARM_DESC(SF_mode, "Davicom DM9xxx special function (bit 0: VLAN, bit 1 Flow Control, bit 2: TX pause packet)");
+                                                                                                                                
 /*	Description:
  *	when user used insmod to add module, system invoked init_module()
  *	to initilize and register.
diff -uNr linux-2.4.5-ac4/drivers/net/e2100.c linux/drivers/net/e2100.c
--- linux-2.4.5-ac4/drivers/net/e2100.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/e2100.c	Wed May 30 01:07:42 2001
@@ -386,6 +386,10 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_E21_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_E21_CARDS) "i");
 MODULE_PARM(xcvr, "1-" __MODULE_STRING(MAX_E21_CARDS) "i");
+MODULE_PARM_DESC(io, "E2100 I/O base address(es)");
+MODULE_PARM_DESC(irq, "E2100 IRQ number(s)");
+MODULE_PARM_DESC(mem, " E2100 memory base address(es)");
+MODULE_PARM_DESC(xcvr, "E2100 tranceiver(s) (0=internal, 1=external)");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
diff -uNr linux-2.4.5-ac4/drivers/net/eepro.c linux/drivers/net/eepro.c
--- linux-2.4.5-ac4/drivers/net/eepro.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/eepro.c	Wed May 30 01:07:42 2001
@@ -1771,6 +1771,10 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_EEPRO) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_EEPRO) "i");
 MODULE_PARM(autodetect, "1-" __MODULE_STRING(1) "i");
+MODULE_PARM_DESC(io, "EtherExpress Pro/10 I/O base addres(es)");
+MODULE_PARM_DESC(irq, "EtherExpress Pro/10 IRQ number(s)");
+MODULE_PARM_DESC(mem, "EtherExpress Pro/10 Rx buffer size(es) in kB (3-29)");
+MODULE_PARM_DESC(autodetect, "EtherExpress Pro/10 force board(s) detection (0-1)");
 
 int 
 init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/eepro100.c linux/drivers/net/eepro100.c
--- linux-2.4.5-ac4/drivers/net/eepro100.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/eepro100.c	Wed May 30 01:07:42 2001
@@ -124,6 +124,17 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(multicast_filter_limit, "i");
+MODULE_PARM_DESC(debug, "eepro100 debug level (0-6)");
+MODULE_PARM_DESC(options, "epro100: Bits 0-3: tranceiver type, bit 4: full duplex, bit 5: 100Mbps");
+MODULE_PARM_DESC(full_duplex, "epro100 full duplex setting(s) (1)");
+MODULE_PARM_DESC(congenb, "epro100  Enable congestion control (1)");
+MODULE_PARM_DESC(txfifo, "epro100 Tx FIFO threshold in 4 byte units, (0-15)");
+MODULE_PARM_DESC(rxfifo, "epro100 Rx FIFO threshold in 4 byte units, (0-15)");
+MODULE_PARM_DESC(txdmaccount, "epro100 Tx DMA burst length; 128 - disable (0-128)");
+MODULE_PARM_DESC(rxdmaccount, "epro100 Rx DMA burst length; 128 - disable (0-128)");
+MODULE_PARM_DESC(rx_copybreak, "epro100 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(max_interrupt_work, "epro100 maximum events handled per interrupt");
+MODULE_PARM_DESC(multicast_filter_limit, "epro100 maximum number of filtered multicast addresses");
 
 #define RUN_AT(x) (jiffies + (x))
 
diff -uNr linux-2.4.5-ac4/drivers/net/eexpress.c linux/drivers/net/eexpress.c
--- linux-2.4.5-ac4/drivers/net/eexpress.c	Sat May 19 18:34:42 2001
+++ linux/drivers/net/eexpress.c	Wed May 30 01:07:42 2001
@@ -1632,6 +1632,8 @@
 
 MODULE_PARM(io, "1-" __MODULE_STRING(EEXP_MAX_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(EEXP_MAX_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherExpress 16 I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherExpress 16 IRQ number(s)");
 
 /* Ideally the user would give us io=, irq= for every card.  If any parameters
  * are specified, we verify and then use them.  If no parameters are given, we
diff -uNr linux-2.4.5-ac4/drivers/net/epic100.c linux/drivers/net/epic100.c
--- linux-2.4.5-ac4/drivers/net/epic100.c	Mon May 28 01:33:58 2001
+++ linux/drivers/net/epic100.c	Wed May 30 01:07:42 2001
@@ -135,6 +135,11 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(debug, "EPIC/100 debug level (0-5)");
+MODULE_PARM_DESC(max_interrupt_work, "EPIC/100 maximum events handled per interrupt");
+MODULE_PARM_DESC(options, "EPIC/100: Bits 0-3: media type, bit 4: full duplex");
+MODULE_PARM_DESC(rx_copybreak, "EPIC/100 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(full_duplex, "EPIC/100 full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
diff -uNr linux-2.4.5-ac4/drivers/net/es3210.c linux/drivers/net/es3210.c
--- linux-2.4.5-ac4/drivers/net/es3210.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/es3210.c	Wed May 30 01:07:42 2001
@@ -383,6 +383,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_ES_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_ES_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_ES_CARDS) "i");
+MODULE_PARM_DESC(io, "ES3210 I/O base address(es)");
+MODULE_PARM_DESC(irq, "ES3210 IRQ number(s)");
+MODULE_PARM_DESC(mem, "ES3210 memory base address(es)");
 
 int
 init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/eth16i.c linux/drivers/net/eth16i.c
--- linux-2.4.5-ac4/drivers/net/eth16i.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/eth16i.c	Wed May 30 01:07:42 2001
@@ -1407,7 +1407,7 @@
 MODULE_DESCRIPTION("ICL EtherTeam 16i/32 driver");
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_ETH16I_CARDS) "i");
-MODULE_PARM_DESC(io, "eth16i io base address");
+MODULE_PARM_DESC(io, "eth16i I/O base address(es)");
 
 #if 0
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_ETH16I_CARDS) "i");
@@ -1415,10 +1415,10 @@
 #endif
 
 MODULE_PARM(mediatype, "1-" __MODULE_STRING(MAX_ETH16I_CARDS) "s");
-MODULE_PARM_DESC(mediatype, "eth16i interfaceport mediatype");
+MODULE_PARM_DESC(mediatype, "eth16i media type of interface(s) (bnc,tp,dix,auto,eprom)");
 
 MODULE_PARM(debug, "i");
-MODULE_PARM_DESC(debug, "eth16i debug level (0-4)");
+MODULE_PARM_DESC(debug, "eth16i debug level (0-6)");
 #endif
 
 int init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/ethertap.c linux/drivers/net/ethertap.c
--- linux-2.4.5-ac4/drivers/net/ethertap.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/ethertap.c	Wed May 30 01:07:42 2001
@@ -336,6 +336,7 @@
 
 static int unit;
 MODULE_PARM(unit,"i");
+MODULE_PARM_DESC(unit,"Ethertap device number");
 
 static struct net_device dev_ethertap =
 {
diff -uNr linux-2.4.5-ac4/drivers/net/ewrk3.c linux/drivers/net/ewrk3.c
--- linux-2.4.5-ac4/drivers/net/ewrk3.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/ewrk3.c	Wed May 30 01:07:42 2001
@@ -1849,6 +1849,8 @@
 
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "EtherWORKS 3 I/O base address");
+MODULE_PARM_DESC(irq, "EtherWORKS 3 IRQ number");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/fealnx.c linux/drivers/net/fealnx.c
--- linux-2.4.5-ac4/drivers/net/fealnx.c	Mon May 28 01:33:58 2001
+++ linux/drivers/net/fealnx.c	Wed May 30 01:07:42 2001
@@ -107,12 +107,18 @@
 MODULE_AUTHOR("Myson or whoever");
 MODULE_DESCRIPTION("Myson MTD-8xx 100/10M Ethernet PCI Adapter Driver");
 MODULE_PARM(max_interrupt_work, "i");
-MODULE_PARM(min_pci_latency, "i");
+//MODULE_PARM(min_pci_latency, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(multicast_filter_limit, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "fealnx maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "fealnx enable debugging (0-1)");
+MODULE_PARM_DESC(rx_copybreak, "fealnx copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(multicast_filter_limit, "fealnx maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(options, "fealnx: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "fealnx full duplex setting(s) (1)");
 
 #define MIN_REGION_SIZE 136
 
diff -uNr linux-2.4.5-ac4/drivers/net/fmv18x.c linux/drivers/net/fmv18x.c
--- linux-2.4.5-ac4/drivers/net/fmv18x.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/fmv18x.c	Wed May 30 01:07:42 2001
@@ -628,6 +628,9 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(net_debug, "i");
+MODULE_PARM_DESC(io, "FMV-18X I/O address");
+MODULE_PARM_DESC(irq, "FMV-18X IRQ number");
+MODULE_PARM_DESC(net_debug, "FMV-18X debug level (0-1,5-6)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/hamachi.c linux/drivers/net/hamachi.c
--- linux-2.4.5-ac4/drivers/net/hamachi.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/hamachi.c	Wed May 30 01:07:42 2001
@@ -535,7 +535,22 @@
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(force32, "i");
-
+MODULE_PARM_DESC(max_interrupt_work, "GNIC-II maximum events handled per interrupt");
+MODULE_PARM_DESC(mtu, "GNIC-II MTU (all boards)");
+MODULE_PARM_DESC(debug, "GNIC-II debug level (0-7)");
+MODULE_PARM_DESC(min_rx_pkt, "GNIC-II minimum Rx packets processed between interrupts");
+MODULE_PARM_DESC(max_rx_gap, "GNIC-II maximum Rx inter-packet gap in 8.192 microsecond units");
+MODULE_PARM_DESC(max_rx_latency, "GNIC-II time between Rx interrupts in 8.192 microsecond units");
+MODULE_PARM_DESC(min_tx_pkt, "GNIC-II minimum Tx packets processed between interrupts");
+MODULE_PARM_DESC(max_tx_gap, "GNIC-II maximum Tx inter-packet gap in 8.192 microsecond units");
+MODULE_PARM_DESC(max_tx_latency, "GNIC-II time between Tx interrupts in 8.192 microsecond units");
+MODULE_PARM_DESC(rx_copybreak, "GNIC-II copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(rx_params, "GNIC-II min_rx_pkt+max_rx_gap+max_rx_latency");
+MODULE_PARM_DESC(tx_params, "GNIC-II min_tx_pkt+max_tx_gap+max_tx_latency");
+MODULE_PARM_DESC(options, "GNIC-II Bits 0-3: media type, bits 4-6: as force32, bit 7: half duplex, bit 9 full duplex");
+MODULE_PARM_DESC(full_duplex, "GNIC-II full duplex setting(s) (1)");
+MODULE_PARM_DESC(force32, "GNIC-II: Bit 0: 32 bit PCI, bit 1: disable parity, bit 2: 64 bit PCI (all boards)");
+                                                                        
 static int read_eeprom(long ioaddr, int location);
 static int mdio_read(long ioaddr, int phy_id, int location);
 static void mdio_write(long ioaddr, int phy_id, int location, int value);
diff -uNr linux-2.4.5-ac4/drivers/net/hp-plus.c linux/drivers/net/hp-plus.c
--- linux-2.4.5-ac4/drivers/net/hp-plus.c	Sat May 19 18:35:46 2001
+++ linux/drivers/net/hp-plus.c	Wed May 30 01:07:42 2001
@@ -408,6 +408,8 @@
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_HPP_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_HPP_CARDS) "i");
+MODULE_PARM_DESC(io, "HP PC-LAN+ I/O port address(es)");
+MODULE_PARM_DESC(irq, "HP PC-LAN+ IRQ number(s); ignored if properly detected");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
diff -uNr linux-2.4.5-ac4/drivers/net/hp.c linux/drivers/net/hp.c
--- linux-2.4.5-ac4/drivers/net/hp.c	Sat May 19 18:35:46 2001
+++ linux/drivers/net/hp.c	Wed May 30 01:07:42 2001
@@ -379,6 +379,8 @@
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_HP_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_HP_CARDS) "i");
+MODULE_PARM_DESC(io, "HP PC-LAN I/O base address(es)");
+MODULE_PARM_DESC(irq, "HP PC-LAN IRQ number(s) (assigned)");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
diff -uNr linux-2.4.5-ac4/drivers/net/hp100.c linux/drivers/net/hp100.c
--- linux-2.4.5-ac4/drivers/net/hp100.c	Sat May 19 18:34:42 2001
+++ linux/drivers/net/hp100.c	Wed May 30 01:07:42 2001
@@ -296,6 +296,9 @@
 MODULE_PARM( hp100_rx_ratio, "1i" );
 MODULE_PARM( hp100_priority_tx, "1i" );
 MODULE_PARM( hp100_mode, "1i" );
+MODULE_PARM_DESC(hp100_rx_ratio, "%% of HP100 memory used for Rx packets (1-99)");
+MODULE_PARM_DESC(hp100_priority_tx, "HP100 enable transmit as priority (0-1)");
+MODULE_PARM_DESC(hp100_mode, "HP100 operation mode (1-4)");
 
 /*
  *  prototypes
@@ -3022,11 +3025,13 @@
 /* Parameters set by insmod */
 static int hp100_port[5] = { 0, -1, -1, -1, -1 };
 MODULE_PARM(hp100_port, "1-5i");
+MODULE_PARM_DESC(hp100_port, "HP100 I/O port number(s); 0 for autodetection");
 
 /* Allocate 5 string of length IFNAMSIZ, one string for each device */
 static char hp100_name[5][IFNAMSIZ] = { "", "", "", "", "" };
 /* Allow insmod to write those 5 strings individually */
 MODULE_PARM(hp100_name, "1-5c" __MODULE_STRING(IFNAMSIZ));
+MODULE_PARM_DESC(hp100_name, "HP100 interface name(s)");
 
 /* List of devices */
 static struct net_device *hp100_devlist[5];
diff -uNr linux-2.4.5-ac4/drivers/net/ibmlana.c linux/drivers/net/ibmlana.c
--- linux-2.4.5-ac4/drivers/net/ibmlana.c	Sat May 19 18:33:45 2001
+++ linux/drivers/net/ibmlana.c	Wed May 30 01:07:42 2001
@@ -1197,6 +1197,8 @@
 static int io;
 MODULE_PARM(irq, "i");
 MODULE_PARM(io, "i");
+MODULE_PARM_DESC(irq, "IBM LAN/A IRQ number");
+MODULE_PARM_DESC(io, "IBM LAN/A I/O base address");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/lance.c linux/drivers/net/lance.c
--- linux-2.4.5-ac4/drivers/net/lance.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/lance.c	Wed May 30 01:07:42 2001
@@ -299,6 +299,10 @@
 MODULE_PARM(dma, "1-" __MODULE_STRING(MAX_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_CARDS) "i");
 MODULE_PARM(lance_debug, "i");
+MODULE_PARM_DESC(io, "LANCE/PCnet I/O base address(es),required");
+MODULE_PARM_DESC(dma, "LANCE/PCnet ISA DMA channel (ignored for some devices)");
+MODULE_PARM_DESC(irq, "LANCE/PCnet IRQ number (ignored for some devices)");
+MODULE_PARM_DESC(lance_debug, "LANCE/PCnet debug level (0-7)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/lasi_82596.c linux/drivers/net/lasi_82596.c
--- linux-2.4.5-ac4/drivers/net/lasi_82596.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/lasi_82596.c	Wed May 30 01:07:42 2001
@@ -181,7 +181,7 @@
 MODULE_AUTHOR("Richard Hirst");
 MODULE_DESCRIPTION("i82596 driver");
 MODULE_PARM(i596_debug, "i");
-
+MODULE_PARM_DESC(i596_debug, "lasi_82596 debug mask");
 
 /* Copy frames shorter than rx_copybreak, otherwise pass on up in
  * a full sized sk_buff.  Value of 100 stolen from tulip.c (!alpha).
@@ -1512,13 +1512,13 @@
 {0,};
 static struct net_device dev_82596 =
 {
-	devicename,	/* device name inserted by drivers/net/net_init.c */
-	0, 0, 0, 0,
-	0, 0,		/* base, irq */
-	0, 0, 0, NULL, lasi_i82596_probe};
+	name: devicename,	/* device name inserted by drivers/net/net_init.c */
+	init: lasi_i82596_probe,
+};
 
 
 MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "lasi_82596 debug mask");
 static int debug = -1;
 
 int init_module(void)
diff -uNr linux-2.4.5-ac4/drivers/net/lne390.c linux/drivers/net/lne390.c
--- linux-2.4.5-ac4/drivers/net/lne390.c	Sat May 19 18:33:45 2001
+++ linux/drivers/net/lne390.c	Wed May 30 01:07:42 2001
@@ -381,6 +381,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
+MODULE_PARM_DESC(io, "LNE390 I/O base address(es)");
+MODULE_PARM_DESC(irq, "LNE390 IRQ number(s)");
+MODULE_PARM_DESC(mem, "LNE390 memory base address(es)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/lp486e.c linux/drivers/net/lp486e.c
--- linux-2.4.5-ac4/drivers/net/lp486e.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/lp486e.c	Wed May 30 01:07:42 2001
@@ -1328,6 +1328,9 @@
 //MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(debug, "lp486e debug leve (0-2) + print mask (bits: 30-32)");
+MODULE_PARM_DESC(options, "(unused)");
+MODULE_PARM_DESC(full_duplex, "(unused)");
 
 static struct net_device dev_lp486e;
 static int full_duplex;
diff -uNr linux-2.4.5-ac4/drivers/net/mac89x0.c linux/drivers/net/mac89x0.c
--- linux-2.4.5-ac4/drivers/net/mac89x0.c	Sat May 19 18:34:43 2001
+++ linux/drivers/net/mac89x0.c	Wed May 30 01:07:42 2001
@@ -626,6 +626,7 @@
 static int debug;
 
 MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "CS89[02]0 debug level (0-5)");
 
 EXPORT_NO_SYMBOLS;
 
diff -uNr linux-2.4.5-ac4/drivers/net/mace.c linux/drivers/net/mace.c
--- linux-2.4.5-ac4/drivers/net/mace.c	Mon May 28 01:33:58 2001
+++ linux/drivers/net/mace.c	Wed May 30 01:07:42 2001
@@ -25,6 +25,7 @@
 static int port_aaui = -1;
 
 MODULE_PARM(port_aaui, "i");
+MODULE_PARM_DESC(port_aaui, "MACE uses AAUI port (0-1)");
 
 #define N_RX_RING	8
 #define N_TX_RING	6
diff -uNr linux-2.4.5-ac4/drivers/net/macsonic.c linux/drivers/net/macsonic.c
--- linux-2.4.5-ac4/drivers/net/macsonic.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/macsonic.c	Wed May 30 01:07:42 2001
@@ -582,6 +582,7 @@
 static struct net_device dev_macsonic;
 
 MODULE_PARM(sonic_debug, "i");
+MODULE_PARM_DESC(sonic_debug, "macsonic debug level (1-4)");
 
 EXPORT_NO_SYMBOLS;
 
diff -uNr linux-2.4.5-ac4/drivers/net/natsemi.c linux/drivers/net/natsemi.c
--- linux-2.4.5-ac4/drivers/net/natsemi.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/natsemi.c	Wed May 30 01:07:42 2001
@@ -157,6 +157,12 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "DP8381x maximum events handled per interrupt");
+MODULE_PARM_DESC(mtu, "DP8381x MTU (all boards)");
+MODULE_PARM_DESC(debug, "DP8381x debug level (0-5)");
+MODULE_PARM_DESC(rx_copybreak, "DP8381x copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(options, "DP8381x: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "DP8381x full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
diff -uNr linux-2.4.5-ac4/drivers/net/ne.c linux/drivers/net/ne.c
--- linux-2.4.5-ac4/drivers/net/ne.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/ne.c	Wed May 30 01:07:42 2001
@@ -735,6 +735,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+MODULE_PARM_DESC(io, "NEx000 I/O base address(es),required");
+MODULE_PARM_DESC(irq, "NEx000 IRQ number(s)");
+MODULE_PARM_DESC(bad, "NEx000 accept bad clone(s)");
 
 /* This is set up so that no ISA autoprobe takes place. We can't guarantee
 that the ne2k probe is the last 8390 based probe to take place (as it
diff -uNr linux-2.4.5-ac4/drivers/net/ne2.c linux/drivers/net/ne2.c
--- linux-2.4.5-ac4/drivers/net/ne2.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/ne2.c	Wed May 30 01:07:42 2001
@@ -749,6 +749,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
+MODULE_PARM_DESC(io, "(ignored)");
+MODULE_PARM_DESC(irq, "(ignored)");
+MODULE_PARM_DESC(bad, "(ignored)");
 #endif
 
 /* Module code fixed by David Weinehall */
diff -uNr linux-2.4.5-ac4/drivers/net/ne2k-pci.c linux/drivers/net/ne2k-pci.c
--- linux-2.4.5-ac4/drivers/net/ne2k-pci.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/ne2k-pci.c	Wed May 30 01:07:42 2001
@@ -71,6 +71,9 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(debug, "PCI NE2000 debug level (1-2)");
+MODULE_PARM_DESC(options, "PCI NE2000: Bit 5: full duplex");
+MODULE_PARM_DESC(full_duplex, "PCI NE2000 full duplex setting(s) (1)");
 
 /* Some defines that people can play with if so inclined. */
 
diff -uNr linux-2.4.5-ac4/drivers/net/ne3210.c linux/drivers/net/ne3210.c
--- linux-2.4.5-ac4/drivers/net/ne3210.c	Sat May 19 18:33:46 2001
+++ linux/drivers/net/ne3210.c	Wed May 30 01:07:42 2001
@@ -370,6 +370,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE3210_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE3210_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_NE3210_CARDS) "i");
+MODULE_PARM_DESC(io, "NE3210 I/O base address(es)");
+MODULE_PARM_DESC(irq, "NE3210 IRQ number(s)");
+MODULE_PARM_DESC(mem, "NE3210 memory base address(es)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/ni5010.c linux/drivers/net/ni5010.c
--- linux-2.4.5-ac4/drivers/net/ni5010.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/ni5010.c	Wed May 30 01:07:42 2001
@@ -739,6 +739,8 @@
 
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "ni5010 I/O base address");
+MODULE_PARM_DESC(irq, "ni5010 IRQ number");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/ni52.c linux/drivers/net/ni52.c
--- linux-2.4.5-ac4/drivers/net/ni52.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/ni52.c	Wed May 30 01:07:42 2001
@@ -1296,6 +1296,10 @@
 MODULE_PARM(irq, "i");
 MODULE_PARM(memstart, "l");
 MODULE_PARM(memend, "l");
+MODULE_PARM_DESC(io, "NI5210 I/O base address,required");
+MODULE_PARM_DESC(irq, "NI5210 IRQ number,required");
+MODULE_PARM_DESC(memstart, "NI5210 memory base address,required");
+MODULE_PARM_DESC(memend, "NI5210 memory end address,required");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/ni65.c linux/drivers/net/ni65.c
--- linux-2.4.5-ac4/drivers/net/ni65.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/ni65.c	Wed May 30 01:07:42 2001
@@ -1184,6 +1184,9 @@
 MODULE_PARM(irq, "i");
 MODULE_PARM(io, "i");
 MODULE_PARM(dma, "i");
+MODULE_PARM_DESC(irq, "ni6510 IRQ number (ignored for some cards)");
+MODULE_PARM_DESC(io, "ni6510 I/O base address");
+MODULE_PARM_DESC(dma, "ni6510 ISA DMA channel (ignored for some cards)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/pci-skeleton.c linux/drivers/net/pci-skeleton.c
--- linux-2.4.5-ac4/drivers/net/pci-skeleton.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pci-skeleton.c	Wed May 30 01:07:42 2001
@@ -480,11 +480,15 @@
 };
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
-MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
+MODULE_DESCRIPTION ("Skeleton for a PCI Fast Ethernet driver");
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (max_interrupt_work, "i");
 MODULE_PARM (debug, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(8) "i");
+MODULE_PARM_DESC (multicast_filter_limit, "pci-skeleton maximum number of filtered multicast addresses");
+MODULE_PARM_DESC (max_interrupt_work, "pci-skeleton maximum events handled per interrupt");
+MODULE_PARM_DESC (media, "pci-skeleton: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC (debug, "(unused)");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);
 static int netdrv_open (struct net_device *dev);
diff -uNr linux-2.4.5-ac4/drivers/net/pcnet32.c linux/drivers/net/pcnet32.c
--- linux-2.4.5-ac4/drivers/net/pcnet32.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/pcnet32.c	Wed May 30 01:07:42 2001
@@ -1545,6 +1545,12 @@
 MODULE_PARM(tx_start_pt, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(debug, "PCnet32 debug level (1-6)");
+MODULE_PARM_DESC(max_interrupt_work, "PCnet32 maximum events handled per interrupt");
+MODULE_PARM_DESC(rx_copybreak, "PCnet32 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(tx_start_pt, "(unused)");
+MODULE_PARM_DESC(options, "PCnet32 media type(s) (0-2,4,9-14)");
+MODULE_PARM_DESC(full_duplex, "PCnet32 full duplex setting(s) (1)");
 MODULE_AUTHOR("Thomas Bogendoerfer");
 MODULE_DESCRIPTION("Driver for PCnet32 and PCnetPCI based ethercards");
 
diff -uNr linux-2.4.5-ac4/drivers/net/plip.c linux/drivers/net/plip.c
--- linux-2.4.5-ac4/drivers/net/plip.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/plip.c	Wed May 30 01:07:42 2001
@@ -1297,6 +1297,7 @@
 
 MODULE_PARM(parport, "1-" __MODULE_STRING(PLIP_MAX) "i");
 MODULE_PARM(timid, "1i");
+MODULE_PARM_DESC(parport, "List of parport device numbers to use by plip");
 
 static struct net_device *dev_plip[PLIP_MAX] = { NULL, };
 
diff -uNr linux-2.4.5-ac4/drivers/net/ppp_async.c linux/drivers/net/ppp_async.c
--- linux-2.4.5-ac4/drivers/net/ppp_async.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/ppp_async.c	Wed May 30 01:07:42 2001
@@ -80,6 +80,7 @@
 
 static int flag_time = HZ;
 MODULE_PARM(flag_time, "i");
+MODULE_PARM_DESC(flag_time, "ppp_async: interval between flagged packets (in clock ticks)");
 
 /*
  * Prototypes.
diff -uNr linux-2.4.5-ac4/drivers/net/sb1000.c linux/drivers/net/sb1000.c
--- linux-2.4.5-ac4/drivers/net/sb1000.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/sb1000.c	Wed May 30 01:07:42 2001
@@ -1211,6 +1211,8 @@
 MODULE_DESCRIPTION("General Instruments SB1000 driver");
 MODULE_PARM(io, "1-2i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "SB1000 I/O base addresses");
+MODULE_PARM_DESC(irq, "SB1000 IRQ number");
 
 static struct net_device dev_sb1000;
 static int io[2];
diff -uNr linux-2.4.5-ac4/drivers/net/seeq8005.c linux/drivers/net/seeq8005.c
--- linux-2.4.5-ac4/drivers/net/seeq8005.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/seeq8005.c	Wed May 30 01:07:42 2001
@@ -715,6 +715,8 @@
 static int irq = 10;
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "SEEQ 8005 I/O base address");
+MODULE_PARM_DESC(irq, "SEEQ 8005 IRQ number");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/shaper.c linux/drivers/net/shaper.c
--- linux-2.4.5-ac4/drivers/net/shaper.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/shaper.c	Wed May 30 01:07:42 2001
@@ -682,6 +682,7 @@
 #ifdef MODULE
 
 MODULE_PARM(shapers, "i");
+MODULE_PARM_DESC(shapers, "Traffic shaper: maximum nuber of shapers");
 
 #else /* MODULE */
 
diff -uNr linux-2.4.5-ac4/drivers/net/sis900.c linux/drivers/net/sis900.c
--- linux-2.4.5-ac4/drivers/net/sis900.c	Mon May 28 01:34:55 2001
+++ linux/drivers/net/sis900.c	Wed May 30 01:07:42 2001
@@ -158,6 +158,9 @@
 MODULE_PARM(multicast_filter_limit, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(multicast_filter_limit, "SiS 900/7016 maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(max_interrupt_work, "SiS 900/7016 maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "SiS 900/7016 debug level (2-4)");
 
 static int sis900_open(struct net_device *net_dev);
 static int sis900_mii_probe (struct net_device * net_dev);
diff -uNr linux-2.4.5-ac4/drivers/net/slip.c linux/drivers/net/slip.c
--- linux-2.4.5-ac4/drivers/net/slip.c	Sat May 19 18:35:49 2001
+++ linux/drivers/net/slip.c	Wed May 30 01:07:42 2001
@@ -96,6 +96,7 @@
 
 int slip_maxdev = SL_NRUNIT;		/* Can be overridden with insmod! */
 MODULE_PARM(slip_maxdev, "i");
+MODULE_PARM_DESC(slip_maxdev, "Maximum number of slip devices");
 
 static struct tty_ldisc	sl_ldisc;
 
diff -uNr linux-2.4.5-ac4/drivers/net/smc-mca.c linux/drivers/net/smc-mca.c
--- linux-2.4.5-ac4/drivers/net/smc-mca.c	Mon May 28 01:34:55 2001
+++ linux/drivers/net/smc-mca.c	Wed May 30 01:07:42 2001
@@ -440,6 +440,8 @@
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
+MODULE_PARM_DESC(io, "SMC Ultra/EtherEZ MCA I/O base address(es)");
+MODULE_PARM_DESC(irq, "SMC Ultra/EtherEZ MCA IRQ number(s)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/smc-ultra.c linux/drivers/net/smc-ultra.c
--- linux-2.4.5-ac4/drivers/net/smc-ultra.c	Sat May 19 18:35:49 2001
+++ linux/drivers/net/smc-ultra.c	Wed May 30 01:07:42 2001
@@ -500,6 +500,8 @@
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_ULTRA_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_ULTRA_CARDS) "i");
+MODULE_PARM_DESC(io, "SMC Ultra I/O base address(es)");
+MODULE_PARM_DESC(irq, "SMC Ultra IRQ number(s) (assigned)");
 
 EXPORT_NO_SYMBOLS;
 
diff -uNr linux-2.4.5-ac4/drivers/net/smc9194.c linux/drivers/net/smc9194.c
--- linux-2.4.5-ac4/drivers/net/smc9194.c	Sat May 19 18:35:49 2001
+++ linux/drivers/net/smc9194.c	Wed May 30 01:07:42 2001
@@ -1566,6 +1566,9 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(ifport, "i");
+MODULE_PARM_DESC(io, "SMC 99194 I/O base address");
+MODULE_PARM_DESC(irq, "SMC 99194 IRQ number");
+MODULE_PARM_DESC(ifport, "SMC 99194 interface port (0-default, 1-TP, 2-AUI)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.5-ac4/drivers/net/starfire.c linux/drivers/net/starfire.c
--- linux-2.4.5-ac4/drivers/net/starfire.c	Sat May 19 18:35:49 2001
+++ linux/drivers/net/starfire.c	Wed May 30 01:07:42 2001
@@ -128,6 +128,12 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "Starfire maximum events handled per interrupt");
+MODULE_PARM_DESC(mtu, "Starfire MTU (all boards)");
+MODULE_PARM_DESC(debug, "Starfire debug level (0-6)");
+MODULE_PARM_DESC(rx_copybreak, "Starfire copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(options, "Starfire: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "Starfire full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
diff -uNr linux-2.4.5-ac4/drivers/net/sun3lance.c linux/drivers/net/sun3lance.c
--- linux-2.4.5-ac4/drivers/net/sun3lance.c	Mon May 28 01:34:55 2001
+++ linux/drivers/net/sun3lance.c	Wed May 30 01:07:42 2001
@@ -70,6 +70,7 @@
 static int lance_debug = 1;
 #endif
 MODULE_PARM(lance_debug, "i");
+MODULE_PARM_DESC(lance_debug, "SUN3 Lance debug level (0-3)");
 
 #define	DPRINTK(n,a) \
 	do {  \
diff -uNr linux-2.4.5-ac4/drivers/net/sundance.c linux/drivers/net/sundance.c
--- linux-2.4.5-ac4/drivers/net/sundance.c	Sat May 19 18:35:49 2001
+++ linux/drivers/net/sundance.c	Wed May 30 01:07:42 2001
@@ -109,6 +109,12 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "Sundance Alta maximum events handled per interrupt");
+MODULE_PARM_DESC(mtu, "Sundance Alta MTU (all boards)");
+MODULE_PARM_DESC(debug, "Sundance Alta debug level (0-5)");
+MODULE_PARM_DESC(rx_copybreak, "Sundance Alta copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(options, "Sundance Alta: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "Sundance Alta full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
diff -uNr linux-2.4.5-ac4/drivers/net/sungem.c linux/drivers/net/sungem.c
--- linux-2.4.5-ac4/drivers/net/sungem.c	Sat May 19 18:35:49 2001
+++ linux/drivers/net/sungem.c	Wed May 30 01:07:42 2001
@@ -49,6 +49,7 @@
 MODULE_AUTHOR("David S. Miller (davem@redhat.com)");
 MODULE_DESCRIPTION("Sun GEM Gbit ethernet driver");
 MODULE_PARM(gem_debug, "i");
+MODULE_PARM_DESC(gem_debug, "(ignored)");
 
 #define GEM_MODULE_NAME	"gem"
 #define PFX GEM_MODULE_NAME ": "
diff -uNr linux-2.4.5-ac4/drivers/net/sunhme.c linux/drivers/net/sunhme.c
--- linux-2.4.5-ac4/drivers/net/sunhme.c	Mon May 28 01:33:58 2001
+++ linux/drivers/net/sunhme.c	Wed May 30 01:07:42 2001
@@ -72,6 +72,7 @@
 
 /* accept MAC address of the form macaddr=0x08,0x00,0x20,0x30,0x40,0x50 */
 MODULE_PARM(macaddr, "6i");
+MODULE_PARM_DESC(macaddr, "Happy Meal MAC address to set");
 
 static struct happy_meal *root_happy_dev;
 
diff -uNr linux-2.4.5-ac4/drivers/net/tlan.c linux/drivers/net/tlan.c
--- linux-2.4.5-ac4/drivers/net/tlan.c	Sat May 19 18:35:50 2001
+++ linux/drivers/net/tlan.c	Wed May 30 01:07:42 2001
@@ -194,6 +194,11 @@
 MODULE_PARM(speed, "1-" __MODULE_STRING(MAX_TLAN_BOARDS) "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(bbuf, "i");
+MODULE_PARM_DESC(aui, "ThunderLAN use AUI port(s) (0-1)");
+MODULE_PARM_DESC(duplex, "ThunderLAN duplex setting(s) (0-default, 1-half, 2-full)");
+MODULE_PARM_DESC(speed, "ThunderLAN port speen setting(s) (0,10,100)");
+MODULE_PARM_DESC(debug, "ThunderLAN debug mask");
+MODULE_PARM_DESC(bbuf, "ThunderLAN use big buffer (0-1)");
 EXPORT_NO_SYMBOLS;
 
 /* Define this to enable Link beat monitoring */
diff -uNr linux-2.4.5-ac4/drivers/net/via-rhine.c linux/drivers/net/via-rhine.c
--- linux-2.4.5-ac4/drivers/net/via-rhine.c	Sat May 19 18:35:50 2001
+++ linux/drivers/net/via-rhine.c	Wed May 30 01:07:42 2001
@@ -165,7 +165,11 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
-
+MODULE_PARM_DESC(max_interrupt_work, "VIA Rhine maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "VIA Rhine debug level (0-7)");
+MODULE_PARM_DESC(rx_copybreak, "VIA Rhine copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(options, "VIA Rhine: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "VIA Rhine full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
diff -uNr linux-2.4.5-ac4/drivers/net/wavelan.p.h linux/drivers/net/wavelan.p.h
--- linux-2.4.5-ac4/drivers/net/wavelan.p.h	Sat May 19 18:34:47 2001
+++ linux/drivers/net/wavelan.p.h	Wed May 30 01:07:42 2001
@@ -705,6 +705,9 @@
 MODULE_PARM(io, "1-4i");
 MODULE_PARM(irq, "1-4i");
 MODULE_PARM(name, "1-4c" __MODULE_STRING(IFNAMSIZ));
+MODULE_PARM(io, "WaveLAN I/O base address(es),required");
+MODULE_PARM(irq, "WaveLAN IRQ number(s)");
+MODULE_PARM(name, "WaveLAN interface neme(s)");
 #endif	/* MODULE */
 
 #endif	/* WAVELAN_P_H */
diff -uNr linux-2.4.5-ac4/drivers/net/wd.c linux/drivers/net/wd.c
--- linux-2.4.5-ac4/drivers/net/wd.c	Sat May 19 18:35:52 2001
+++ linux/drivers/net/wd.c	Wed May 30 01:07:42 2001
@@ -449,6 +449,10 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_WD_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_WD_CARDS) "i");
 MODULE_PARM(mem_end, "1-" __MODULE_STRING(MAX_WD_CARDS) "i");
+MODULE_PARM_DESC(io, "WD80x3 I/O base address(es)");
+MODULE_PARM_DESC(irq, "WD80x3 IRQ number(s) (ignored for PureData boards)");
+MODULE_PARM_DESC(mem, "WD80x3 memory base address(es)(ignored for PureData boards)");
+MODULE_PARM_DESC(mem_end, "WD80x3 memory end address(es)");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
diff -uNr linux-2.4.5-ac4/drivers/net/winbond-840.c linux/drivers/net/winbond-840.c
--- linux-2.4.5-ac4/drivers/net/winbond-840.c	Tue May 29 20:46:08 2001
+++ linux/drivers/net/winbond-840.c	Wed May 30 01:07:42 2001
@@ -155,6 +155,12 @@
 MODULE_PARM(multicast_filter_limit, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "winbond-840 maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "winbond-840 debug level (0-6)");
+MODULE_PARM_DESC(rx_copybreak, "winbond-840 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(multicast_filter_limit, "winbond-840 maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(options, "winbond-840: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "winbond-840 full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
diff -uNr linux-2.4.5-ac4/drivers/net/yellowfin.c linux/drivers/net/yellowfin.c
--- linux-2.4.5-ac4/drivers/net/yellowfin.c	Mon May 28 01:33:59 2001
+++ linux/drivers/net/yellowfin.c	Wed May 30 01:07:42 2001
@@ -146,6 +146,13 @@
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(gx_fix, "i");
+MODULE_PARM_DESC(max_interrupt_work, "G-NIC maximum events handled per interrupt");
+MODULE_PARM_DESC(mtu, "G-NIC MTU (all boards)");
+MODULE_PARM_DESC(debug, "G-NIC debug level (0-7)");
+MODULE_PARM_DESC(rx_copybreak, "G-NIC copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(options, "G-NIC: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "G-NIC full duplex setting(s) (1)");
+MODULE_PARM_DESC(gx_fix, "G-NIC: enable GX server chipset bug workaround (0-1)");
 
 /*
 				Theory of Operation


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
