Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbTCPQY2>; Sun, 16 Mar 2003 11:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbTCPQY2>; Sun, 16 Mar 2003 11:24:28 -0500
Received: from adsl-35-224.38-151.net24.it ([151.38.224.35]:53778 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id <S262686AbTCPQYS>; Sun, 16 Mar 2003 11:24:18 -0500
Date: Sun, 16 Mar 2003 17:34:56 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Philip.Blundell@pobox.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add printk KERN_* prefixes in 3c505.c
Message-ID: <20030316163456.GC2530@renditai.milesteg.arr>
Mail-Followup-To: Philip.Blundell@pobox.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.20
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds KERN_* prefixes to almost all printk of 3c505.c 
in the 2.5.64 kernel tree.

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3c505_c_printk.diff"

diff -urN -X /home/venza/kernel/dontdiff linux-2.5.64/drivers/net/3c505.c linux-2.5.64-work/drivers/net/3c505.c
--- linux-2.5.64/drivers/net/3c505.c	2003-03-14 17:35:22.000000000 +0100
+++ linux-2.5.64-work/drivers/net/3c505.c	2003-03-16 17:19:50.000000000 +0100
@@ -313,7 +313,7 @@
 
 	outb_control(orig_hcr, dev);
 	if (!start_receive(dev, &adapter->tx_pcb))
-		printk("%s: start receive command failed \n", dev->name);
+		printk(KERN_ERR "%s: start receive command failed \n", dev->name);
 }
 
 /* Check to make sure that a DMA transfer hasn't timed out.  This should
@@ -325,7 +325,7 @@
 	elp_device *adapter = dev->priv;
 	if (adapter->dmaing && time_after(jiffies, adapter->current_dma.start_time + 10)) {
 		unsigned long flags, f;
-		printk("%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
+		printk(KERN_ERR "%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
 		spin_lock_irqsave(&adapter->lock, flags);
 		adapter->dmaing = 0;
 		adapter->busy = 0;
@@ -350,7 +350,7 @@
 		if (inb_status(base_addr) & HCRE)
 			return FALSE;
 	}
-	printk("3c505: send_pcb_slow timed out\n");
+	printk(KERN_WARNING "3c505: send_pcb_slow timed out\n");
 	return TRUE;
 }
 
@@ -362,7 +362,7 @@
 		if (inb_status(base_addr) & HCRE)
 			return FALSE;
 	}
-	printk("3c505: send_pcb_fast timed out\n");
+	printk(KERN_WARNING "3c505: send_pcb_fast timed out\n");
 	return TRUE;
 }
 
@@ -415,7 +415,7 @@
 	/* Avoid contention */
 	if (test_and_set_bit(1, &adapter->send_pcb_semaphore)) {
 		if (elp_debug >= 3) {
-			printk("%s: send_pcb entered while threaded\n", dev->name);
+			printk(KERN_DEBUG "%s: send_pcb entered while threaded\n", dev->name);
 		}
 		return FALSE;
 	}
@@ -461,7 +461,7 @@
 	}
 
 	if (elp_debug >= 1)
-		printk("%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
+		printk(KERN_DEBUG "%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
 
       sti_abort:
 	spin_unlock_irqrestore(&adapter->lock, flags);
@@ -510,7 +510,7 @@
 	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 && time_before(jiffies, timeout));
 	if (time_after_eq(jiffies, timeout)) {
 		TIMEOUT_MSG(__LINE__);
-		printk("%s: status %02x\n", dev->name, stat);
+		printk(KERN_INFO "%s: status %02x\n", dev->name, stat);
 		return FALSE;
 	}
 	pcb->length = inb_command(dev->base_addr);
@@ -541,7 +541,7 @@
 	/* safety check total length vs data length */
 	if (total_length != (pcb->length + 2)) {
 		if (elp_debug >= 2)
-			printk("%s: mangled PCB received\n", dev->name);
+			printk(KERN_NOTICE "%s: mangled PCB received\n", dev->name);
 		set_hsf(dev, HSF_PCB_NAK);
 		return FALSE;
 	}
@@ -550,7 +550,7 @@
 		if (test_and_set_bit(0, (void *) &adapter->busy)) {
 			if (backlog_next(adapter->rx_backlog.in) == adapter->rx_backlog.out) {
 				set_hsf(dev, HSF_PCB_NAK);
-				printk("%s: PCB rejected, transfer in progress and backlog full\n", dev->name);
+				printk(KERN_WARNING "%s: PCB rejected, transfer in progress and backlog full\n", dev->name);
 				pcb->command = 0;
 				return TRUE;
 			} else {
@@ -575,7 +575,7 @@
 	elp_device *adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: restarting receiver\n", dev->name);
+		printk(KERN_DEBUG "%s: restarting receiver\n", dev->name);
 	tx_pcb->command = CMD_RECEIVE_PACKET;
 	tx_pcb->length = sizeof(struct Rcv_pkt);
 	tx_pcb->data.rcv_pkt.buf_seg
@@ -609,7 +609,7 @@
 	skb = dev_alloc_skb(rlen + 2);
 
 	if (!skb) {
-		printk("%s: memory squeeze, dropping packet\n", dev->name);
+		printk(KERN_WARNING "%s: memory squeeze, dropping packet\n", dev->name);
 		target = adapter->dma_buffer;
 		adapter->current_dma.target = NULL;
 		return;
@@ -626,7 +626,7 @@
 
 	/* if this happens, we die */
 	if (test_and_set_bit(0, (void *) &adapter->dmaing))
-		printk("%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);
+		printk(KERN_ERR "%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);
 
 	skb->dev = dev;
 	adapter->current_dma.direction = 0;
@@ -646,14 +646,14 @@
 	release_dma_lock(flags);
 
 	if (elp_debug >= 3) {
-		printk("%s: rx DMA transfer started\n", dev->name);
+		printk(KERN_DEBUG "%s: rx DMA transfer started\n", dev->name);
 	}
 
 	if (adapter->rx_active)
 		adapter->rx_active--;
 
 	if (!adapter->busy)
-		printk("%s: receive_packet called, busy not set.\n", dev->name);
+		printk(KERN_WARNING "%s: receive_packet called, busy not set.\n", dev->name);
 }
 
 /******************************************************
@@ -682,10 +682,10 @@
 		 */
 		if (inb_status(dev->base_addr) & DONE) {
 			if (!adapter->dmaing) {
-				printk("%s: phantom DMA completed\n", dev->name);
+				printk(KERN_WARNING "%s: phantom DMA completed\n", dev->name);
 			}
 			if (elp_debug >= 3) {
-				printk("%s: %s DMA complete, status %02x\n", dev->name, adapter->current_dma.direction ? "tx" : "rx", inb_status(dev->base_addr));
+				printk(KERN_DEBUG "%s: %s DMA complete, status %02x\n", dev->name, adapter->current_dma.direction ? "tx" : "rx", inb_status(dev->base_addr));
 			}
 
 			outb_control(adapter->hcr_val & ~(DMAE | TCEN | DIR), dev);
@@ -709,7 +709,7 @@
 				int t = adapter->rx_backlog.length[adapter->rx_backlog.out];
 				adapter->rx_backlog.out = backlog_next(adapter->rx_backlog.out);
 				if (elp_debug >= 2)
-					printk("%s: receiving backlogged packet (%d)\n", dev->name, t);
+					printk(KERN_INFO "%s: receiving backlogged packet (%d)\n", dev->name, t);
 				receive_packet(dev, t);
 			} else {
 				adapter->busy = 0;
@@ -743,18 +743,18 @@
 						printk(KERN_ERR "%s: interrupt - packet not received correctly\n", dev->name);
 					} else {
 						if (elp_debug >= 3) {
-							printk("%s: interrupt - packet received of length %i (%i)\n", dev->name, len, dlen);
+							printk(KERN_DEBUG "%s: interrupt - packet received of length %i (%i)\n", dev->name, len, dlen);
 						}
 						if (adapter->irx_pcb.command == 0xff) {
 							if (elp_debug >= 2)
-								printk("%s: adding packet to backlog (len = %d)\n", dev->name, dlen);
+								printk(KERN_DEBUG "%s: adding packet to backlog (len = %d)\n", dev->name, dlen);
 							adapter->rx_backlog.length[adapter->rx_backlog.in] = dlen;
 							adapter->rx_backlog.in = backlog_next(adapter->rx_backlog.in);
 						} else {
 							receive_packet(dev, dlen);
 						}
 						if (elp_debug >= 3)
-							printk("%s: packet received\n", dev->name);
+							printk(KERN_DEBUG "%s: packet received\n", dev->name);
 					}
 					break;
 
@@ -764,7 +764,7 @@
 				case CMD_CONFIGURE_82586_RESPONSE:
 					adapter->got[CMD_CONFIGURE_82586] = 1;
 					if (elp_debug >= 3)
-						printk("%s: interrupt - configure response received\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - configure response received\n", dev->name);
 					break;
 
 					/*
@@ -773,7 +773,7 @@
 				case CMD_CONFIGURE_ADAPTER_RESPONSE:
 					adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Adapter memory configuration %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Adapter memory configuration %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -783,7 +783,7 @@
 				case CMD_LOAD_MULTICAST_RESPONSE:
 					adapter->got[CMD_LOAD_MULTICAST_LIST] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Multicast address list loading %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Multicast address list loading %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -793,7 +793,7 @@
 				case CMD_SET_ADDRESS_RESPONSE:
 					adapter->got[CMD_SET_STATION_ADDRESS] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Ethernet address setting %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Ethernet address setting %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -810,7 +810,7 @@
 					adapter->stats.rx_over_errors += adapter->irx_pcb.data.netstat.err_res;
 					adapter->got[CMD_NETWORK_STATISTICS] = 1;
 					if (elp_debug >= 3)
-						printk("%s: interrupt - statistics response received\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - statistics response received\n", dev->name);
 					break;
 
 					/*
@@ -818,7 +818,7 @@
 					 */
 				case CMD_TRANSMIT_PACKET_COMPLETE:
 					if (elp_debug >= 3)
-						printk("%s: interrupt - packet sent\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - packet sent\n", dev->name);
 					if (!netif_running(dev))
 						break;
 					switch (adapter->irx_pcb.data.xmit_resp.c_stat) {
@@ -842,7 +842,7 @@
 					break;
 				}
 			} else {
-				printk("%s: failed to read PCB on interrupt\n", dev->name);
+				printk(KERN_WARNING "%s: failed to read PCB on interrupt\n", dev->name);
 				adapter_reset(dev);
 			}
 		}
@@ -872,13 +872,13 @@
 	adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request to open device\n", dev->name);
+		printk(KERN_DEBUG "%s: request to open device\n", dev->name);
 
 	/*
 	 * make sure we actually found the device
 	 */
 	if (adapter == NULL) {
-		printk("%s: Opening a non-existent physical device\n", dev->name);
+		printk(KERN_WARNING "%s: Opening a non-existent physical device\n", dev->name);
 		return -EAGAIN;
 	}
 	/*
@@ -945,7 +945,7 @@
 	adapter->tx_pcb.length = sizeof(struct Memconf);
 	adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send memory configuration command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send memory configuration command\n", dev->name);
 	else {
 		int timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] == 0 && time_before(jiffies, timeout));
@@ -958,13 +958,13 @@
 	 * configure adapter to receive broadcast messages and wait for response
 	 */
 	if (elp_debug >= 3)
-		printk("%s: sending 82586 configure command\n", dev->name);
+		printk(KERN_DEBUG "%s: sending 82586 configure command\n", dev->name);
 	adapter->tx_pcb.command = CMD_CONFIGURE_82586;
 	adapter->tx_pcb.data.configure = NO_LOOPBACK | RECV_BROAD;
 	adapter->tx_pcb.length = 2;
 	adapter->got[CMD_CONFIGURE_82586] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send 82586 configure command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send 82586 configure command\n", dev->name);
 	else {
 		int timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_CONFIGURE_82586] == 0 && time_before(jiffies, timeout));
@@ -980,7 +980,7 @@
 	 */
 	prime_rx(dev);
 	if (elp_debug >= 3)
-		printk("%s: %d receive PCBs active\n", dev->name, adapter->rx_active);
+		printk(KERN_DEBUG "%s: %d receive PCBs active\n", dev->name, adapter->rx_active);
 
 	/*
 	 * device is now officially open!
@@ -1010,7 +1010,7 @@
 
 	if (test_and_set_bit(0, (void *) &adapter->busy)) {
 		if (elp_debug >= 2)
-			printk("%s: transmit blocked\n", dev->name);
+			printk(KERN_DEBUG "%s: transmit blocked\n", dev->name);
 		return FALSE;
 	}
 
@@ -1032,7 +1032,7 @@
 	}
 	/* if this happens, we die */
 	if (test_and_set_bit(0, (void *) &adapter->dmaing))
-		printk("%s: tx: DMA %d in progress\n", dev->name, adapter->current_dma.direction);
+		printk(KERN_ERR "%s: tx: DMA %d in progress\n", dev->name, adapter->current_dma.direction);
 
 	adapter->current_dma.direction = 1;
 	adapter->current_dma.start_time = jiffies;
@@ -1058,7 +1058,7 @@
 	release_dma_lock(flags);
 	
 	if (elp_debug >= 3)
-		printk("%s: DMA transfer started\n", dev->name);
+		printk(KERN_DEBUG "%s: DMA transfer started\n", dev->name);
 
 	return TRUE;
 }
@@ -1075,7 +1075,7 @@
 	stat = inb_status(dev->base_addr);
 	printk(KERN_WARNING "%s: transmit timed out, lost %s?\n", dev->name, (stat & ACRF) ? "interrupt" : "command");
 	if (elp_debug >= 1)
-		printk("%s: status %#02x\n", dev->name, stat);
+		printk(KERN_DEBUG "%s: status %#02x\n", dev->name, stat);
 	dev->trans_start = jiffies;
 	adapter->stats.tx_dropped++;
 	netif_wake_queue(dev);
@@ -1097,7 +1097,7 @@
 	check_3c505_dma(dev);
 
 	if (elp_debug >= 3)
-		printk("%s: request to send packet of length %d\n", dev->name, (int) skb->len);
+		printk(KERN_DEBUG "%s: request to send packet of length %d\n", dev->name, (int) skb->len);
 
 	netif_stop_queue(dev);
 	
@@ -1106,13 +1106,13 @@
 	 */
 	if (!send_packet(dev, skb)) {
 		if (elp_debug >= 2) {
-			printk("%s: failed to transmit packet\n", dev->name);
+			printk(KERN_DEBUG "%s: failed to transmit packet\n", dev->name);
 		}
 		spin_unlock_irqrestore(&adapter->lock, flags);
 		return 1;
 	}
 	if (elp_debug >= 3)
-		printk("%s: packet of length %d sent\n", dev->name, (int) skb->len);
+		printk(KERN_DEBUG "%s: packet of length %d sent\n", dev->name, (int) skb->len);
 
 	/*
 	 * start the transmit timeout
@@ -1136,7 +1136,7 @@
 	elp_device *adapter = (elp_device *) dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request for stats\n", dev->name);
+		printk(KERN_DEBUG "%s: request for stats\n", dev->name);
 
 	/* If the device is closed, just return the latest stats we have,
 	   - we cannot ask from the adapter without interrupts */
@@ -1148,7 +1148,7 @@
 	adapter->tx_pcb.length = 0;
 	adapter->got[CMD_NETWORK_STATISTICS] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send get statistics command\n", dev->name);
+		printk(KERN_DEBUG "%s: couldn't send get statistics command\n", dev->name);
 	else {
 		int timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_NETWORK_STATISTICS] == 0 && time_before(jiffies, timeout));
@@ -1256,7 +1256,7 @@
 	adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request to close device\n", dev->name);
+		printk(KERN_DEBUG "%s: request to close device\n", dev->name);
 
 	netif_stop_queue(dev);
 
@@ -1300,7 +1300,7 @@
 	unsigned long flags;
 
 	if (elp_debug >= 3)
-		printk("%s: request to set multicast list\n", dev->name);
+		printk(KERN_DEBUG "%s: request to set multicast list\n", dev->name);
 
 	spin_lock_irqsave(&adapter->lock, flags);
 	
@@ -1315,7 +1315,7 @@
 		}
 		adapter->got[CMD_LOAD_MULTICAST_LIST] = 0;
 		if (!send_pcb(dev, &adapter->tx_pcb))
-			printk("%s: couldn't send set_multicast command\n", dev->name);
+			printk(KERN_WARNING "%s: couldn't send set_multicast command\n", dev->name);
 		else {
 			int timeout = jiffies + TIMEOUT;
 			while (adapter->got[CMD_LOAD_MULTICAST_LIST] == 0 && time_before(jiffies, timeout));
@@ -1334,14 +1334,14 @@
 	 * and wait for response
 	 */
 	if (elp_debug >= 3)
-		printk("%s: sending 82586 configure command\n", dev->name);
+		printk(KERN_DEBUG "%s: sending 82586 configure command\n", dev->name);
 	adapter->tx_pcb.command = CMD_CONFIGURE_82586;
 	adapter->tx_pcb.length = 2;
 	adapter->got[CMD_CONFIGURE_82586] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
 	{
 		spin_unlock_irqrestore(&adapter->lock, flags);
-		printk("%s: couldn't send 82586 configure command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send 82586 configure command\n", dev->name);
 	}
 	else {
 		int timeout = jiffies + TIMEOUT;
@@ -1408,11 +1408,11 @@
 	orig_HSR = inb_status(addr);
 
 	if (elp_debug > 0)
-		printk(search_msg, name, addr);
+		printk(KERN_DEBUG search_msg, name, addr);
 
 	if (orig_HSR == 0xff) {
 		if (elp_debug > 0)
-			printk(notfound_msg, 1);
+			printk(KERN_DEBUG notfound_msg, 1);
 		goto out;
 	}
 	/* Enable interrupts - we need timers! */
@@ -1421,7 +1421,7 @@
 
 	/* Wait for a while; the adapter may still be booting up */
 	if (elp_debug > 0)
-		printk(stilllooking_msg);
+		printk(KERN_INFO stilllooking_msg);
 
 	if (orig_HSR & DIR) {
 		/* If HCR.DIR is up, we pull it down. HSR.DIR should follow. */
@@ -1431,7 +1431,7 @@
 		restore_flags(flags);
 		if (inb_status(addr) & DIR) {
 			if (elp_debug > 0)
-				printk(notfound_msg, 2);
+				printk(KERN_INFO notfound_msg, 2);
 			goto out;
 		}
 	} else {
@@ -1442,7 +1442,7 @@
 		restore_flags(flags);
 		if (!(inb_status(addr) & DIR)) {
 			if (elp_debug > 0)
-				printk(notfound_msg, 3);
+				printk(KERN_INFO notfound_msg, 3);
 			goto out;
 		}
 	}
@@ -1450,7 +1450,7 @@
 	 * It certainly looks like a 3c505.
 	 */
 	if (elp_debug > 0)
-		printk(found_msg);
+		printk(KERN_INFO found_msg);
 
 	return 0;
 out:
@@ -1481,7 +1481,7 @@
 
 	/* could not find an adapter */
 	if (elp_debug > 0)
-		printk(couldnot_msg, dev->name);
+		printk(KERN_INFO couldnot_msg, dev->name);
 
 	return 0;		/* Because of this, the layer above will return -ENODEV */
 }
@@ -1529,7 +1529,7 @@
 	 */
 	adapter = (elp_device *) (dev->priv = kmalloc(sizeof(elp_device), GFP_KERNEL));
 	if (adapter == NULL) {
-		printk("%s: out of memory\n", dev->name);
+		printk(KERN_ERR "%s: out of memory\n", dev->name);
 		return -ENODEV;
         }
 
@@ -1554,7 +1554,7 @@
 			/* Nope, it's ignoring the command register.  This means that
 			 * either it's still booting up, or it's died.
 			 */
-			printk("%s: command register wouldn't drain, ", dev->name);
+			printk(KERN_WARNING "%s: command register wouldn't drain, ", dev->name);
 			if ((inb_status(dev->base_addr) & 7) == 3) {
 				/* If the adapter status is 3, it *could* still be booting.
 				 * Give it the benefit of the doubt for 10 seconds.
@@ -1563,7 +1563,7 @@
 				timeout = jiffies + 10*HZ;
 				while (time_before(jiffies, timeout) && (inb_status(dev->base_addr) & 7));
 				if (inb_status(dev->base_addr) & 7) {
-					printk("%s: 3c505 failed to start\n", dev->name);
+					printk(KERN_ERR "%s: 3c505 failed to start\n", dev->name);
 				} else {
 					okay = 1;  /* It started */
 				}
@@ -1584,18 +1584,18 @@
 			adapter->tx_pcb.length = 0;
 			cookie = probe_irq_on();
 			if (!send_pcb(dev, &adapter->tx_pcb)) {
-				printk("%s: could not send first PCB\n", dev->name);
+				printk(KERN_ERR "%s: could not send first PCB\n", dev->name);
 				probe_irq_off(cookie);
 				continue;
 			}
 			if (!receive_pcb(dev, &adapter->rx_pcb)) {
-				printk("%s: could not read first PCB\n", dev->name);
+				printk(KERN_ERR "%s: could not read first PCB\n", dev->name);
 				probe_irq_off(cookie);
 				continue;
 			}
 			if ((adapter->rx_pcb.command != CMD_ADDRESS_RESPONSE) ||
 			    (adapter->rx_pcb.length != 6)) {
-				printk("%s: first PCB wrong (%d, %d)\n", dev->name, adapter->rx_pcb.command, adapter->rx_pcb.length);
+				printk(KERN_ERR "%s: first PCB wrong (%d, %d)\n", dev->name, adapter->rx_pcb.command, adapter->rx_pcb.length);
 				probe_irq_off(cookie);
 				continue;
 			}
@@ -1608,29 +1608,29 @@
 		outb_control(adapter->hcr_val | FLSH | ATTN, dev);
 		outb_control(adapter->hcr_val & ~(FLSH | ATTN), dev);
 	}
-	printk("%s: failed to initialise 3c505\n", dev->name);
+	printk(KERN_ERR "%s: failed to initialise 3c505\n", dev->name);
 	release_region(dev->base_addr, ELP_IO_EXTENT);
 	return -ENODEV;
 
-      okay:
+okay:
 	if (dev->irq) {		/* Is there a preset IRQ? */
 		int rpt = probe_irq_off(cookie);
 		if (dev->irq != rpt) {
-			printk("%s: warning, irq %d configured but %d detected\n", dev->name, dev->irq, rpt);
+			printk(KERN_WARNING "%s: warning, irq %d configured but %d detected\n", dev->name, dev->irq, rpt);
 		}
 		/* if dev->irq == probe_irq_off(cookie), all is well */
 	} else		       /* No preset IRQ; just use what we can detect */
 		dev->irq = probe_irq_off(cookie);
 	switch (dev->irq) {    /* Legal, sane? */
 	case 0:
-		printk("%s: IRQ probe failed: check 3c505 jumpers.\n",
+		printk(KERN_ERR "%s: IRQ probe failed: check 3c505 jumpers.\n",
 		       dev->name);
 		return -ENODEV;
 	case 1:
 	case 6:
 	case 8:
 	case 13:
-		printk("%s: Impossible IRQ %d reported by probe_irq_off().\n",
+		printk(KERN_ERR "%s: Impossible IRQ %d reported by probe_irq_off().\n",
 		       dev->name, dev->irq);
 		return -ENODEV;
 	}
@@ -1660,7 +1660,7 @@
 	/*
 	 * print remainder of startup message
 	 */
-	printk("%s: 3c505 at %#lx, irq %d, dma %d, ",
+	printk("KERN_INFO %s: 3c505 at %#lx, irq %d, dma %d, ",
 	       dev->name, dev->base_addr, dev->irq, dev->dma);
 	printk("addr %02x:%02x:%02x:%02x:%02x:%02x, ",
 	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
@@ -1676,7 +1676,7 @@
 	    !receive_pcb(dev, &adapter->rx_pcb) ||
 	    (adapter->rx_pcb.command != CMD_ADAPTER_INFO_RESPONSE) ||
 	    (adapter->rx_pcb.length != 10)) {
-		printk("not responding to second PCB\n");
+		printk(KERN_WARNING "not responding to second PCB\n");
 	}
 	printk("rev %d.%d, %dk\n", adapter->rx_pcb.data.info.major_vers, adapter->rx_pcb.data.info.minor_vers, adapter->rx_pcb.data.info.RAM_sz);
 
@@ -1695,10 +1695,10 @@
 	    !receive_pcb(dev, &adapter->rx_pcb) ||
 	    (adapter->rx_pcb.command != CMD_CONFIGURE_ADAPTER_RESPONSE) ||
 	    (adapter->rx_pcb.length != 2)) {
-		printk("%s: could not configure adapter memory\n", dev->name);
+		printk(KERN_WARNING "%s: could not configure adapter memory\n", dev->name);
 	}
 	if (adapter->rx_pcb.data.configure) {
-		printk("%s: adapter configuration failed\n", dev->name);
+		printk(KERN_ERR "%s: adapter configuration failed\n", dev->name);
 	}
 
 	/*
--qMm9M+Fa2AknHoGS--
