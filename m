Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262427AbTCMQb1>; Thu, 13 Mar 2003 11:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTCMQb1>; Thu, 13 Mar 2003 11:31:27 -0500
Received: from adsl-35-224.38-151.net24.it ([151.38.224.35]:53768 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id <S262427AbTCMQbS>; Thu, 13 Mar 2003 11:31:18 -0500
Date: Thu, 13 Mar 2003 17:41:57 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] add prink KERN_* suffixes
Message-ID: <20030313164157.GB6435@renditai.milesteg.arr>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.20
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looking at the Kernel Janitor TODO list I saw this:
------------------------------------------------------------------------
=46rom: Andrey Panin <pazke at orbita dot don dot sitek dot net>

- check printk() calls (should include appropriate KERN_* constant).

------------------------------------------------------------------------

The following three patches add KERN_* prefixes to all printk() in
3c509.c 8390.c hp.c and slhc.c

I don't know if I got the priorities right, so some feedback is
appreciated...=20

The patches are against 2.5.64 and are also available at:
http://digilander.libero.it/webvenza/kernel_patches.html

--=20
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3c509_printk.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /home/venza/kernel/dontdiff linux-2.5.64/drivers/net/3c509.c l=
inux-2.5.64-work/drivers/net/3c509.c
--- linux-2.5.64/drivers/net/3c509.c	2003-03-06 11:41:18.000000000 +0100
+++ linux-2.5.64-work/drivers/net/3c509.c	2003-03-13 12:28:39.000000000 +01=
00
@@ -316,14 +316,14 @@
=20
 	{
 		const char *if_names[] =3D {"10baseT", "AUI", "undefined", "BNC"};
-		printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
+		printk(KERN_INFO "%s: 3c5x9 at %#3.3lx, %s port, address ",
 			dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
 	}
=20
 	/* Read in the station address. */
 	for (i =3D 0; i < 6; i++)
-		printk(" %2.2x", dev->dev_addr[i]);
-	printk(", IRQ %d.\n", dev->irq);
+		printk(KERN_INFO " %2.2x", dev->dev_addr[i]);
+	printk(KERN_INFO ", IRQ %d.\n", dev->irq);
=20
 	if (el3_debug > 0)
 		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
@@ -399,7 +399,7 @@
 			}
 			irq =3D pnp_irq(idev, 0);
 			if (el3_debug > 3)
-				printk ("ISAPnP reports %s at i/o 0x%x, irq %d\n",
+				printk (KERN_DEBUG "ISAPnP reports %s at i/o 0x%x, irq %d\n",
 					(char*) el3_isapnp_adapters[i].driver_data, ioaddr, irq);
 			EL3WINDOW(0);
 			for (j =3D 0; j < 3; j++)
@@ -432,7 +432,7 @@
 	}
 	if (id_port >=3D 0x200) {
 		/* Rare -- do we really need a warning? */
-		printk(" WARNING: No I/O port available for 3c509 activation.\n");
+		printk(KERN_WARNING " No I/O port available for 3c509 activation.\n");
 		return -ENODEV;
 	}
 	/* Next check for all ISA bus boards by sending the ID sequence to the
@@ -475,7 +475,7 @@
 			    phys_addr[2] =3D=3D el3_isapnp_phys_addr[i][2])
 			{
 				if (el3_debug > 3)
-					printk("3c509 with address %02x %02x %02x %02x %02x %02x was found by=
 ISAPnP\n",
+					printk(KERN_DEBUG "3c509 with address %02x %02x %02x %02x %02x %02x w=
as found by ISAPnP\n",
 						phys_addr[0] & 0xff, phys_addr[0] >> 8,
 						phys_addr[1] & 0xff, phys_addr[1] >> 8,
 						phys_addr[2] & 0xff, phys_addr[2] >> 8);
@@ -586,7 +586,7 @@
 		irq =3D pos5 & 0x0f;
=20
=20
-		printk("3c529: found %s at slot %d\n",
+		printk(KERN_INFO "3c529: found %s at slot %d\n",
 			   el3_mca_adapter_names[mdev->index], slot + 1);
=20
 		/* claim the slot */
@@ -599,7 +599,7 @@
 		irq =3D mca_device_transform_irq(mdev, irq);
 		ioaddr =3D mca_device_transform_ioport(mdev, ioaddr);=20
 		if (el3_debug > 2) {
-				printk("3c529: irq %d  ioaddr 0x%x  ifport %d\n", irq, ioaddr, if_port=
);
+				printk(KERN_DEBUG "3c529: irq %d  ioaddr 0x%x  ifport %d\n", irq, ioad=
dr, if_port);
 		}
 		EL3WINDOW(0);
 		for (i =3D 0; i < 3; i++) {
@@ -721,7 +721,7 @@
 		word =3D (word << 1) + (inb(id_port) & 0x01);
=20
 	if (el3_debug > 3)
-		printk("  3c509 EEPROM word %d %#4.4x.\n", index, word);
+		printk(KERN_DEBUG "  3c509 EEPROM word %d %#4.4x.\n", index, word);
=20
 	return word;
 }
@@ -742,13 +742,13 @@
=20
 	EL3WINDOW(0);
 	if (el3_debug > 3)
-		printk("%s: Opening, IRQ %d	 status@%x %4.4x.\n", dev->name,
+		printk(KERN_DEBUG "%s: Opening, IRQ %d	 status@%x %4.4x.\n", dev->name,
 			   dev->irq, ioaddr + EL3_STATUS, inw(ioaddr + EL3_STATUS));
=20
 	el3_up(dev);
=20
 	if (el3_debug > 3)
-		printk("%s: Opened 3c509  IRQ %d  status %4.4x.\n",
+		printk(KERN_DEBUG "%s: Opened 3c509  IRQ %d  status %4.4x.\n",
 			   dev->name, dev->irq, inw(ioaddr + EL3_STATUS));
=20
 	return 0;
@@ -761,7 +761,7 @@
 	int ioaddr =3D dev->base_addr;
=20
 	/* Transmitter timeout, serious problems. */
-	printk("%s: transmit timed out, Tx_status %2.2x status %4.4x "
+	printk(KERN_ERR "%s: transmit timed out, Tx_status %2.2x status %4.4x "
 		   "Tx FIFO room %d.\n",
 		   dev->name, inb(ioaddr + TX_STATUS), inw(ioaddr + EL3_STATUS),
 		   inw(ioaddr + TX_FREE));
@@ -786,7 +786,7 @@
 	lp->stats.tx_bytes +=3D skb->len;
 =09
 	if (el3_debug > 4) {
-		printk("%s: el3_start_xmit(length =3D %u) called, status %4.4x.\n",
+		printk(KERN_DEBUG "%s: el3_start_xmit(length =3D %u) called, status %4.4=
x.\n",
 			   dev->name, skb->len, inw(ioaddr + EL3_STATUS));
 	}
 #if 0
@@ -867,7 +867,7 @@
 	int i =3D max_interrupt_work;
=20
 	if (dev =3D=3D NULL) {
-		printk ("el3_interrupt(): irq %d for unknown device.\n", irq);
+		printk (KERN_INFO "el3_interrupt(): irq %d for unknown device.\n", irq);
 		return;
 	}
=20
@@ -878,7 +878,7 @@
=20
 	if (el3_debug > 4) {
 		status =3D inw(ioaddr + EL3_STATUS);
-		printk("%s: interrupt, status %4.4x.\n", dev->name, status);
+		printk(KERN_DEBUG "%s: interrupt, status %4.4x.\n", dev->name, status);
 	}
=20
 	while ((status =3D inw(ioaddr + EL3_STATUS)) &
@@ -889,7 +889,7 @@
=20
 		if (status & TxAvailable) {
 			if (el3_debug > 5)
-				printk("	TX room bit was handled.\n");
+				printk(KERN_DEBUG "	TX room bit was handled.\n");
 			/* There's room in the FIFO for a full-sized packet. */
 			outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
 			netif_wake_queue (dev);
@@ -928,7 +928,7 @@
 		}
=20
 		if (--i < 0) {
-			printk("%s: Infinite loop in interrupt, status %4.4x.\n",
+			printk(KERN_ERR "%s: Infinite loop in interrupt, status %4.4x.\n",
 				   dev->name, status);
 			/* Clear all interrupts. */
 			outw(AckIntr | 0xFF, ioaddr + EL3_CMD);
@@ -939,7 +939,7 @@
 	}
=20
 	if (el3_debug > 4) {
-		printk("%s: exiting interrupt, status %4.4x.\n", dev->name,
+		printk(KERN_DEBUG "%s: exiting interrupt, status %4.4x.\n", dev->name,
 			   inw(ioaddr + EL3_STATUS));
 	}
 	spin_unlock(&lp->lock);
@@ -975,7 +975,7 @@
 	int ioaddr =3D dev->base_addr;
=20
 	if (el3_debug > 5)
-		printk("   Updating the statistics.\n");
+		printk(KERN_DEBUG "   Updating the statistics.\n");
 	/* Turn off statistics updates while reading. */
 	outw(StatsDisable, ioaddr + EL3_CMD);
 	/* Switch to the stats window, and read everything. */
@@ -1006,7 +1006,7 @@
 	short rx_status;
=20
 	if (el3_debug > 5)
-		printk("   In rx_packet(), status %4.4x, rx_status %4.4x.\n",
+		printk(KERN_DEBUG "   In rx_packet(), status %4.4x, rx_status %4.4x.\n",
 			   inw(ioaddr+EL3_STATUS), inw(ioaddr+RX_STATUS));
 	while ((rx_status =3D inw(ioaddr + RX_STATUS)) > 0) {
 		if (rx_status & 0x4000) { /* Error, update stats. */
@@ -1029,7 +1029,7 @@
 			skb =3D dev_alloc_skb(pkt_len+5);
 			lp->stats.rx_bytes +=3D pkt_len;
 			if (el3_debug > 4)
-				printk("Receiving packet size %d status %4.4x.\n",
+				printk(KERN_DEBUG "Receiving packet size %d status %4.4x.\n",
 					   pkt_len, rx_status);
 			if (skb !=3D NULL) {
 				skb->dev =3D dev;
@@ -1054,7 +1054,7 @@
 			outw(RxDiscard, ioaddr + EL3_CMD);
 			lp->stats.rx_dropped++;
 			if (el3_debug)
-				printk("%s: Couldn't allocate a sk_buff of size %d.\n",
+				printk(KERN_DEBUG "%s: Couldn't allocate a sk_buff of size %d.\n",
 					   dev->name, pkt_len);
 		}
 		inw(ioaddr + EL3_STATUS); 				/* Delay. */
@@ -1080,7 +1080,7 @@
 		static int old;
 		if (old !=3D dev->mc_count) {
 			old =3D dev->mc_count;
-			printk("%s: Setting Rx mode to %d addresses.\n", dev->name, dev->mc_cou=
nt);
+			printk(KERN_INFO "%s: Setting Rx mode to %d addresses.\n", dev->name, d=
ev->mc_count);
 		}
 	}
 	spin_lock_irqsave(&lp->lock, flags);
@@ -1103,7 +1103,7 @@
 	struct el3_private *lp =3D (struct el3_private *)dev->priv;
 =09
 	if (el3_debug > 2)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
=20
 	el3_down(dev);
=20
@@ -1409,30 +1409,30 @@
 		EL3WINDOW(4);
 		net_diag =3D inw(ioaddr + WN4_NETDIAG);
 		net_diag =3D (net_diag | FD_ENABLE); /* temporarily assume full-duplex w=
ill be set */
-		printk("%s: ", dev->name);
+		printk(KERN_INFO "%s: ", dev->name);
 		switch (dev->if_port & 0x0c) {
 			case 12:
 				/* force full-duplex mode if 3c5x9b */
 				if (sw_info & 0x000f) {
-					printk("Forcing 3c5x9b full-duplex mode");
+					printk(KERN_INFO "Forcing 3c5x9b full-duplex mode");
 					break;
 				}
 			case 8:
 				/* set full-duplex mode based on eeprom config setting */
 				if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
-					printk("Setting 3c5x9b full-duplex mode (from EEPROM configuration bi=
t)");
+					printk(KERN_INFO "Setting 3c5x9b full-duplex mode (from EEPROM config=
uration bit)");
 					break;
 				}
 			default:
 				/* xcvr=3D(0 || 4) OR user has an old 3c5x9 non "B" model */
-				printk("Setting 3c5x9/3c5x9B half-duplex mode");
+				printk(KERN_INFO "Setting 3c5x9/3c5x9B half-duplex mode");
 				net_diag =3D (net_diag & ~FD_ENABLE); /* disable full duplex */
 		}
=20
 		outw(net_diag, ioaddr + WN4_NETDIAG);
-		printk(" if_port: %d, sw_info: %4.4x\n", dev->if_port, sw_info);
+		printk(KERN_INFO " if_port: %d, sw_info: %4.4x\n", dev->if_port, sw_info=
);
 		if (el3_debug > 3)
-			printk("%s: 3c5x9 net diag word is now: %4.4x.\n", dev->name, net_diag);
+			printk(KERN_DEBUG "%s: 3c5x9 net diag word is now: %4.4x.\n", dev->name=
, net_diag);
 		/* Enable link beat and jabber check. */
 		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
 	}

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8390_printk.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /home/venza/kernel/dontdiff linux-2.5.64/drivers/net/8390.c li=
nux-2.5.64-work/drivers/net/8390.c
--- linux-2.5.64/drivers/net/8390.c	2003-03-06 11:41:18.000000000 +0100
+++ linux-2.5.64-work/drivers/net/8390.c	2003-03-13 12:43:54.000000000 +0100
@@ -430,7 +430,7 @@
    =20
 	if (dev =3D=3D NULL)=20
 	{
-		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
+		printk (KERN_INFO "net_interrupt(): irq %d for unknown device.\n", irq);
 		return;
 	}
    =20
@@ -448,8 +448,8 @@
 #if 1 /* This might just be an interrupt for a PCI device sharing this lin=
e */
 		/* The "irqlock" check is only for testing. */
 		printk(ei_local->irqlock
-			   ? "%s: Interrupted while interrupts are masked! isr=3D%#2x imr=3D%#2=
x.\n"
-			   : "%s: Reentering the interrupt handler! isr=3D%#2x imr=3D%#2x.\n",
+			   ? KERN_DEBUG "%s: Interrupted while interrupts are masked! isr=3D%#2=
x imr=3D%#2x.\n"
+			   : KERN_DEBUG "%s: Reentering the interrupt handler! isr=3D%#2x imr=
=3D%#2x.\n",
 			   dev->name, inb_p(e8390_base + EN0_ISR),
 			   inb_p(e8390_base + EN0_IMR));
 #endif
@@ -547,15 +547,15 @@
 #ifdef VERBOSE_ERROR_DUMP
 	printk(KERN_DEBUG "%s: transmitter error (%#2x): ", dev->name, txsr);
 	if (txsr & ENTSR_ABT)
-		printk("excess-collisions ");
+		printk(KERN_DEBUG "excess-collisions ");
 	if (txsr & ENTSR_ND)
-		printk("non-deferral ");
+		printk(KERN_DEBUG "non-deferral ");
 	if (txsr & ENTSR_CRS)
-		printk("lost-carrier ");
+		printk(KERN_DEBUG "lost-carrier ");
 	if (txsr & ENTSR_FU)
-		printk("FIFO-underrun ");
+		printk(KERN_DEBUG "FIFO-underrun ");
 	if (txsr & ENTSR_CDH)
-		printk("lost-heartbeat ");
+		printk(KERN_DEBUG "lost-heartbeat ");
 	printk("\n");
 #endif
=20
@@ -615,7 +615,7 @@
 	else if (ei_local->tx2 < 0)=20
 	{
 		if (ei_local->lasttx !=3D 2  &&  ei_local->lasttx !=3D -2)
-			printk("%s: bogus last_tx_buffer %d, tx2=3D%d.\n",
+			printk(KERN_ERR "%s: bogus last_tx_buffer %d, tx2=3D%d.\n",
 				ei_local->name, ei_local->lasttx, ei_local->tx2);
 		ei_local->tx2 =3D 0;
 		if (ei_local->tx1 > 0)=20
@@ -782,7 +782,7 @@
 	=09
 		/* This _should_ never happen: it's here for avoiding bad clones. */
 		if (next_frame >=3D ei_local->stop_page) {
-			printk("%s: next frame inconsistency, %#2x\n", dev->name,
+			printk(KERN_ERR "%s: next frame inconsistency, %#2x\n", dev->name,
 				   next_frame);
 			next_frame =3D ei_local->rx_start_page;
 		}
@@ -1008,7 +1008,7 @@
 int ethdev_init(struct net_device *dev)
 {
 	if (ei_debug > 1)
-		printk(version);
+		printk(KERN_DEBUG version);
    =20
 	if (dev->priv =3D=3D NULL)=20
 	{

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="slhc_hp_printk.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /home/venza/kernel/dontdiff linux-2.5.64/drivers/net/hp.c linu=
x-2.5.64-work/drivers/net/hp.c
--- linux-2.5.64/drivers/net/hp.c	2002-11-30 15:07:12.000000000 +0100
+++ linux-2.5.64-work/drivers/net/hp.c	2003-03-13 12:52:11.000000000 +0100
@@ -129,19 +129,19 @@
 	}
=20
 	if (ei_debug  &&  version_printed++ =3D=3D 0)
-		printk(version);
+		printk(KERN_INFO version);
=20
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
-		printk (" unable to get memory for dev->priv.\n");
+		printk (KERN_ERR " unable to get memory for dev->priv.\n");
 		retval =3D -ENOMEM;
 		goto out;
 	}
=20
-	printk("%s: %s (ID %02x) at %#3x,", dev->name, name, board_id, ioaddr);
+	printk(KERN_INFO "%s: %s (ID %02x) at %#3x,", dev->name, name, board_id, =
ioaddr);
=20
 	for(i =3D 0; i < ETHER_ADDR_LEN; i++)
-		printk(" %2.2x", dev->dev_addr[i] =3D inb(ioaddr + i));
+		printk(KERN_INFO " %2.2x", dev->dev_addr[i] =3D inb(ioaddr + i));
=20
 	/* Snarf the interrupt now.  Someday this could be moved to open(). */
 	if (dev->irq < 2) {
@@ -157,14 +157,14 @@
 				outb_p( 0x00 | HP_RUN, ioaddr + HP_CONFIGURE);
 				if (irq =3D=3D probe_irq_off(cookie)		 /* It's a good IRQ line! */
 					&& request_irq (irq, ei_interrupt, 0, dev->name, dev) =3D=3D 0) {
-					printk(" selecting IRQ %d.\n", irq);
+					printk(KERN_INFO " selecting IRQ %d.\n", irq);
 					dev->irq =3D *irqp;
 					break;
 				}
 			}
 		} while (*++irqp);
 		if (*irqp =3D=3D 0) {
-			printk(" no free IRQ lines.\n");
+			printk(KERN_ERR " no free IRQ lines.\n");
 			retval =3D -EBUSY;
 			goto out1;
 		}
@@ -172,7 +172,7 @@
 		if (dev->irq =3D=3D 2)
 			dev->irq =3D 9;
 		if ((retval =3D request_irq(dev->irq, ei_interrupt, 0, dev->name, dev)))=
 {
-			printk (" unable to get IRQ %d.\n", dev->irq);
+			printk (KERN_ERR " unable to get IRQ %d.\n", dev->irq);
 			goto out1;
 		}
 	}
@@ -223,7 +223,7 @@
 	int hp_base =3D dev->base_addr - NIC_OFFSET;
 	int saved_config =3D inb_p(hp_base + HP_CONFIGURE);
=20
-	if (ei_debug > 1) printk("resetting the 8390 time=3D%ld...", jiffies);
+	if (ei_debug > 1) printk(KERN_DEBUG "resetting the 8390 time=3D%ld...", j=
iffies);
 	outb_p(0x00, hp_base + HP_CONFIGURE);
 	ei_status.txing =3D 0;
 	/* Pause just a few cycles for the hardware reset to take place. */
@@ -233,9 +233,9 @@
 	udelay(5);
=20
 	if ((inb_p(hp_base+NIC_OFFSET+EN0_ISR) & ENISR_RESET) =3D=3D 0)
-		printk("%s: hp_reset_8390() did not complete.\n", dev->name);
+		printk(KERN_WARNING "%s: hp_reset_8390() did not complete.\n", dev->name=
);
=20
-	if (ei_debug > 1) printk("8390 reset done (%ld).", jiffies);
+	if (ei_debug > 1) printk(KERN_DEBUG "8390 reset done (%ld).", jiffies);
 	return;
 }
=20
@@ -295,7 +295,7 @@
 	  int addr =3D (high << 8) + low;
 	  /* Check only the lower 8 bits so we can ignore ring wrap. */
 	  if (((ring_offset + xfer_count) & 0xff) !=3D (addr & 0xff))
-		printk("%s: RX transfer address mismatch, %#4.4x vs. %#4.4x (actual).\n",
+		printk(KERN_WARNING "%s: RX transfer address mismatch, %#4.4x vs. %#4.4x=
 (actual).\n",
 			   dev->name, ring_offset + xfer_count, addr);
 	}
 	outb_p(saved_config & (~HP_DATAON), nic_base - NIC_OFFSET + HP_CONFIGURE);
@@ -352,7 +352,7 @@
 	  int low  =3D inb_p(nic_base + EN0_RSARLO);
 	  int addr =3D (high << 8) + low;
 	  if ((start_page << 8) + count !=3D addr)
-		printk("%s: TX Transfer address mismatch, %#4.4x vs. %#4.4x.\n",
+		printk(KERN_WARNING "%s: TX Transfer address mismatch, %#4.4x vs. %#4.4x=
=2E\n",
 			   dev->name, (start_page << 8) + count, addr);
 	}
 	outb_p(saved_config & (~HP_DATAON), nic_base - NIC_OFFSET + HP_CONFIGURE);
diff -urN -X /home/venza/kernel/dontdiff linux-2.5.64/drivers/net/slhc.c li=
nux-2.5.64-work/drivers/net/slhc.c
--- linux-2.5.64/drivers/net/slhc.c	2003-03-06 11:41:21.000000000 +0100
+++ linux-2.5.64-work/drivers/net/slhc.c	2003-03-13 12:47:40.000000000 +0100
@@ -696,7 +696,7 @@
 void slhc_i_status(struct slcompress *comp)
 {
 	if (comp !=3D NULLSLCOMPR) {
-		printk("\t%d Cmp, %d Uncmp, %d Bad, %d Tossed\n",
+		printk(KERN_INFO "\t%d Cmp, %d Uncmp, %d Bad, %d Tossed\n",
 			comp->sls_i_compressed,
 			comp->sls_i_uncompressed,
 			comp->sls_i_error,
@@ -708,12 +708,12 @@
 void slhc_o_status(struct slcompress *comp)
 {
 	if (comp !=3D NULLSLCOMPR) {
-		printk("\t%d Cmp, %d Uncmp, %d AsIs, %d NotTCP\n",
+		printk(KERN_INFO "\t%d Cmp, %d Uncmp, %d AsIs, %d NotTCP\n",
 			comp->sls_o_compressed,
 			comp->sls_o_uncompressed,
 			comp->sls_o_tcp,
 			comp->sls_o_nontcp);
-		printk("\t%10d Searches, %10d Misses\n",
+		printk(KERN_INFO "\t%10d Searches, %10d Misses\n",
 			comp->sls_o_searches,
 			comp->sls_o_misses);
 	}

--zYM0uCDKw75PZbzx--

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+cLTV2rmHZCWzV+0RAgeLAJwLsJAYJxv/oyUVrfVHFUs+1x1qAgCgstoH
YoTuvnpFpHQjgzvqJ5zJN8k=
=ZGQE
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
