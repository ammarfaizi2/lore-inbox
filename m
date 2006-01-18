Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWAROTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWAROTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWAROTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:19:20 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28821 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030324AbWAROTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:19:19 -0500
Subject: PATCH: Next rio bits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 14:18:42 +0000
Message-Id: <1137593922.29045.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

INKERNEL is always defined
HOST is never defined
therefore RTA is also never defined

Strip the relevant garbage out of the headers on this basis.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/cirrus.h linux-2.6.16-rc1/drivers/char/rio/cirrus.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/cirrus.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/cirrus.h	2006-01-18 13:55:16.846219200 +0000
@@ -40,148 +40,6 @@
 #endif
 #define _cirrus_h 1
 
-#ifdef RTA
-#define	TO_UART	RX
-#define TO_DRIVER TX
-#endif
-
-#ifdef HOST
-#define	TO_UART	TX
-#define TO_DRIVER RX
-#endif
-#ifdef RTA
-/* Miscellaneous defines for CIRRUS addresses and related logic for
-   interrupts etc.
-*/
-#define	MAP(a)		((short *)(cirrus_base + (a)))
-#define outp(a,b)	(*MAP (a) =(b))
-#define inp(a)		((*MAP (a)) & 0xff)
-#define	CIRRUS_FIRST	(short*)0x7300
-#define	CIRRUS_SECOND	(short*)0x7200
-#define	CIRRUS_THIRD	(short*)0x7100
-#define	CIRRUS_FOURTH	(short*)0x7000
-#define	PORTS_ON_CIRRUS	4
-#define	CIRRUS_FIFO_SIZE	12
-#define	SPACE		0x20
-#define	TAB		0x09
-#define	LINE_FEED	0x0a
-#define	CARRIAGE_RETURN	0x0d
-#define	BACKSPACE	0x08
-#define	SPACES_IN_TABS	8
-#define	SEND_ESCAPE	0x00
-#define START_BREAK	0x81
-#define	TIMER_TICK	0x82
-#define STOP_BREAK	0x83
-#define BASE(a) ((a) < 4 ? (short*)CIRRUS_FIRST : ((a) < 8 ? (short *)CIRRUS_SECOND : ((a) < 12 ? (short*)CIRRUS_THIRD : (short *)CIRRUS_FOURTH)))
-#define txack1	((short *)0x7104)
-#define rxack1	((short *)0x7102)
-#define mdack1  ((short *)0x7106)
-#define txack2  ((short *)0x7006)
-#define rxack2	((short *)0x7004)
-#define mdack2  ((short *)0x7100)
-#define int_latch       ((short *) 0x7800)
-#define int_status      ((short *) 0x7c00)
-#define tx1_pending     0x20
-#define rx1_pending     0x10
-#define md1_pending     0x40
-#define tx2_pending     0x02
-#define rx2_pending     0x01
-#define md2_pending     0x40
-#define module1_bits	0x07
-#define module1_modern	0x08
-#define module2_bits	0x70
-#define module2_modern	0x80
-#define module_blank	0xf
-#define rs232_d25	0x0
-#define	rs232_rj45	0x1
-#define rs422_d25	0x3
-#define parallel	0x5
-
-#define	CLK0	0x00
-#define CLK1	0x01
-#define CLK2	0x02
-#define CLK3	0x03
-#define CLK4	0x04
-
-#define CIRRUS_REVC    0x42
-#define CIRRUS_REVE    0x44
-
-#define	TURNON	1
-#define TURNOFF 0
-
-/* The list of CIRRUS registers. 
-   NB. These registers are relative values on 8 bit boundaries whereas
-   on the RTA's the CIRRUS registers are on word boundaries. Use pointer
-   arithmetic (short *) to obtain the real addresses required */
-#define ccr	0x05		/* Channel Command Register     */
-#define ier	0x06		/* Interrupt Enable Register    */
-#define cor1	0x08		/* Channel Option Register 1    */
-#define cor2	0x09		/* Channel Option Register 2    */
-#define cor3	0x0a		/* Channel Option Register 3    */
-#define cor4	0x1e		/* Channel Option Register 4    */
-#define	cor5	0x1f		/* Channel Option Register 5    */
-
-#define ccsr	0x0b		/* Channel Control Status Register */
-#define rdcr	0x0e		/* Receive Data Count Register  */
-#define tdcr	0x12		/* Transmit Data Count Register */
-#define mcor1	0x15		/* Modem Change Option Register 1 */
-#define mcor2	0x16		/* Modem Change Option Regsiter 2 */
-
-#define livr	0x18		/* Local Interrupt Vector Register */
-#define schr1	0x1a		/* Special Character Register 1 */
-#define schr2	0x1b		/* Special Character Register 2 */
-#define schr3	0x1c		/* Special Character Register 3 */
-#define schr4	0x1d		/* Special Character Register 4 */
-
-#define rtr	0x20		/* Receive Timer Register */
-#define rtpr	0x21		/* Receive Timeout Period Register */
-#define lnc	0x24		/* Lnext character */
-
-#define rivr	0x43		/* Receive Interrupt Vector Register    */
-#define tivr	0x42		/* Transmit Interrupt Vector Register   */
-#define mivr	0x41		/* Modem Interrupt Vector Register      */
-#define gfrcr	0x40		/* Global Firmware Revision code Reg    */
-#define ricr	0x44		/* Receive Interrupting Channel Reg     */
-#define ticr	0x45		/* Transmit Interrupting Channel Reg    */
-#define micr	0x46		/* Modem Interrupting Channel Register  */
-
-#define gcr	0x4b		/* Global configuration register */
-#define misr    0x4c		/* Modem interrupt status register */
-
-#define rbusr	0x59
-#define tbusr	0x5a
-#define mbusr	0x5b
-
-#define eoir	0x60		/* End Of Interrupt Register */
-#define rdsr	0x62		/* Receive Data / Status Register */
-#define tdr	0x63		/* Transmit Data Register */
-#define svrr	0x67		/* Service Request Register */
-
-#define car	0x68		/* Channel Access Register */
-#define mir	0x69		/* Modem Interrupt Register */
-#define tir	0x6a		/* Transmit Interrupt Register */
-#define rir	0x6b		/* Receive Interrupt Register */
-#define msvr1	0x6c		/* Modem Signal Value Register 1 */
-#define msvr2	0x6d		/* Modem Signal Value Register 2 */
-#define psvr	0x6f		/* Printer Signal Value Register */
-
-#define tbpr	0x72		/* Transmit Baud Rate Period Register */
-#define tcor	0x76		/* Transmit Clock Option Register */
-
-#define rbpr	0x78		/* Receive Baud Rate Period Register */
-#define rber	0x7a		/* Receive Baud Rate Extension Register */
-#define rcor	0x7c		/* Receive Clock Option Register */
-#define ppr	0x7e		/* Prescalar Period Register    */
-
-/* Misc registers used for forcing the 1400 out of its reset woes */
-#define airl	0x6d
-#define airm	0x6e
-#define airh	0x6f
-#define btcr	0x66
-#define mtcr	0x6c
-#define tber	0x74
-
-#endif				/* #ifdef RTA */
 
 
 /* Bit fields for particular registers */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/defaults.h linux-2.6.16-rc1/drivers/char/rio/defaults.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/defaults.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/defaults.h	2006-01-18 13:55:23.718174504 +0000
@@ -45,13 +45,6 @@
 #define MILLISECOND           (int) (1000/64)	/* 15.625 low ticks */
 #define SECOND                (int) 15625	/* Low priority ticks */
 
-#ifdef RTA
-#define RX_LIMIT       (ushort) 3
-#endif
-#ifdef HOST
-#define RX_LIMIT       (ushort) 1
-#endif
-
 #define LINK_TIMEOUT          (int) (POLL_PERIOD / 2)
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/link.h linux-2.6.16-rc1/drivers/char/rio/link.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/link.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/link.h	2006-01-18 13:54:13.511847488 +0000
@@ -102,30 +102,14 @@
 /*
 ** LED stuff
 */
-#if defined(RTA)
-#define LED_OFF            ((ushort) 0)	/* LED off */
-#define LED_RED            ((ushort) 1)	/* LED Red */
-#define LED_GREEN          ((ushort) 2)	/* LED Green */
-#define LED_ORANGE         ((ushort) 4)	/* LED Orange */
-#define LED_1TO8_OPEN      ((ushort) 1)	/* Port 1->8 LED on */
-#define LED_9TO16_OPEN     ((ushort) 2)	/* Port 9->16 LED on */
-#define LED_SET_COLOUR(colour)	(link->led = (colour))
-#define LED_OR_COLOUR(colour)	(link->led |= (colour))
-#define LED_TIMEOUT(time)    (link->led_timeout = RioTimePlus(RioTime(),(time)))
-#else
 #define LED_SET_COLOUR(colour)
 #define LED_OR_COLOUR(colour)
 #define LED_TIMEOUT(time)
-#endif				/* RTA */
 
 struct LPB {
 	WORD link_number;	/* Link Number */
 	Channel_ptr in_ch;	/* Link In Channel */
 	Channel_ptr out_ch;	/* Link Out Channel */
-#ifdef RTA
-	uchar stat_led;		/* Port open leds */
-	uchar led;		/* True, light led! */
-#endif
 	BYTE attached_serial[4];	/* Attached serial number */
 	BYTE attached_host_serial[4];
 	/* Serial number of Host who
@@ -144,30 +128,12 @@
 	WORD WaitNoBoot;	/* Secs to hold off booting */
 	PKT_ptr add_packet_list;	/* Add packets to here */
 	PKT_ptr remove_packet_list;	/* Send packets from here */
-#ifdef RTA
-#ifdef DCIRRUS
-#define    QBUFS_PER_REDIRECT (4 / PKTS_PER_BUFFER + 1)
-#else
-#define    QBUFS_PER_REDIRECT (8 / PKTS_PER_BUFFER + 1)
-#endif
-	PKT_ptr_ptr rd_add;	/* Add a new Packet here */
-	Q_BUF_ptr rd_add_qb;	/* Pointer to the add Q buf */
-	PKT_ptr_ptr rd_add_st_qbb;	/* Pointer to start of the Q's buf */
-	PKT_ptr_ptr rd_add_end_qbb;	/* Pointer to the end of the Q's buf */
-	PKT_ptr_ptr rd_remove;	/* Remove a Packet here */
-	Q_BUF_ptr rd_remove_qb;	/* Pointer to the remove Q buf */
-	PKT_ptr_ptr rd_remove_st_qbb;	/* Pointer to the start of the Q buf */
-	PKT_ptr_ptr rd_remove_end_qbb;	/* Pointer to the end of the Q buf */
-	ushort pkts_in_q;	/* Packets in queue */
-#endif
 
 	Channel_ptr lrt_fail_chan;	/* Lrt's failure channel */
 	Channel_ptr ltt_fail_chan;	/* Ltt's failure channel */
 
-#if defined (HOST) || defined (INKERNEL)
 	/* RUP structure for HOST to driver communications */
 	struct RUP rup;
-#endif
 	struct RUP link_rup;	/* RUP for the link (POLL,
 				   topology etc.) */
 	WORD attached_link;	/* Number of attached link */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/list.h linux-2.6.16-rc1/drivers/char/rio/list.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/list.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/list.h	2006-01-18 13:51:36.737680784 +0000
@@ -44,8 +44,6 @@
 
 #define PKT_IN_USE    0x1
 
-#ifdef INKERNEL
-
 #define ZERO_PTR (ushort) 0x8000
 #define	CaD	PortP->Caddr
 
@@ -54,143 +52,5 @@
 ** to by the TxAdd pointer has PKT_IN_USE clear in its address.
 */
 
-#ifndef linux
-#if defined( MIPS ) && !defined( MIPSEISA )
-/* May the shoes of the Devil dance on your grave for creating this */
-#define   can_add_transmit(PacketP,PortP) \
-          (!((uint)(PacketP = (struct PKT *)RIO_PTR(CaD,RINDW(PortP->TxAdd))) \
-          & (PKT_IN_USE<<2)))
-
-#elif  defined(MIPSEISA) || defined(nx6000) || \
-       defined(drs6000)  || defined(UWsparc)
-
-#define   can_add_transmit(PacketP,PortP) \
-          (!((uint)(PacketP = (struct PKT *)RIO_PTR(CaD,RINDW(PortP->TxAdd))) \
-	  & PKT_IN_USE))
-
-#else
-#define   can_add_transmit(PacketP,PortP) \
-          (!((uint)(PacketP = (struct PKT *)RIO_PTR(CaD,*PortP->TxAdd)) \
-	  & PKT_IN_USE))
-#endif
-
-/*
-** To add a packet to the queue, you set the PKT_IN_USE bit in the address,
-** and then move the TxAdd pointer along one position to point to the next
-** packet pointer. You must wrap the pointer from the end back to the start.
-*/
-#if defined(MIPS) || defined(nx6000) || defined(drs6000) || defined(UWsparc)
-#   define add_transmit(PortP)  \
-	WINDW(PortP->TxAdd,RINDW(PortP->TxAdd) | PKT_IN_USE);\
-	if (PortP->TxAdd == PortP->TxEnd)\
-	    PortP->TxAdd = PortP->TxStart;\
-	else\
-	    PortP->TxAdd++;\
-	WWORD(PortP->PhbP->tx_add , RIO_OFF(CaD,PortP->TxAdd));
-#elif defined(AIX)
-#   define add_transmit(PortP)  \
-	{\
-	    register ushort *TxAddP = (ushort *)RIO_PTR(Cad,PortP->TxAddO);\
-	    WINDW( TxAddP, RINDW( TxAddP ) | PKT_IN_USE );\
-	    if (PortP->TxAddO == PortP->TxEndO )\
-		PortP->TxAddO = PortP->TxStartO;\
-	    else\
-		PortP->TxAddO += sizeof(ushort);\
-	    WWORD(((PHB *)RIO_PTR(Cad,PortP->PhbO))->tx_add , PortP->TxAddO );\
-	}
-#else
-#   define add_transmit(PortP)  \
-	*PortP->TxAdd |= PKT_IN_USE;\
-	if (PortP->TxAdd == PortP->TxEnd)\
-	    PortP->TxAdd = PortP->TxStart;\
-	else\
-	    PortP->TxAdd++;\
-	PortP->PhbP->tx_add = RIO_OFF(CaD,PortP->TxAdd);
-#endif
-
-/*
-** can_remove_receive( PacketP, PortP ) returns non-zero if PKT_IN_USE is set
-** for the next packet on the queue. It will also set PacketP to point to the
-** relevant packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
-** then can_remove_receive() returns 0.
-*/
-#if defined(MIPS) || defined(nx6000) || defined(drs6000) || defined(UWsparc)
-#   define can_remove_receive(PacketP,PortP) \
-	((RINDW(PortP->RxRemove) & PKT_IN_USE) ? \
-	(PacketP=(struct PKT *)RIO_PTR(CaD,(RINDW(PortP->RxRemove) & ~PKT_IN_USE))):0)
-#elif defined(AIX)
-#   define can_remove_receive(PacketP,PortP) \
-	((RINDW((ushort *)RIO_PTR(Cad,PortP->RxRemoveO)) & PKT_IN_USE) ? \
-	(PacketP=(struct PKT *)RIO_PTR(Cad,RINDW((ushort *)RIO_PTR(Cad,PortP->RxRemoveO)) & ~PKT_IN_USE)):0)
-#else
-#   define can_remove_receive(PacketP,PortP) \
-	((*PortP->RxRemove & PKT_IN_USE) ? \
-	(PacketP=(struct PKT *)RIO_PTR(CaD,(*PortP->RxRemove & ~PKT_IN_USE))):0)
-#endif
-
-
-/*
-** Will God see it within his heart to forgive us for this thing that
-** we have created? To remove a packet from the receive queue you clear
-** its PKT_IN_USE bit, and then bump the pointers. Once the pointers
-** get to the end, they must be wrapped back to the start.
-*/
-#if defined(MIPS) || defined(nx6000) || defined(drs6000) || defined(UWsparc)
-#   define remove_receive(PortP) \
-	WINDW(PortP->RxRemove, (RINDW(PortP->RxRemove) & ~PKT_IN_USE));\
-	if (PortP->RxRemove == PortP->RxEnd)\
-	    PortP->RxRemove = PortP->RxStart;\
-	else\
-	    PortP->RxRemove++;\
-	WWORD(PortP->PhbP->rx_remove , RIO_OFF(CaD,PortP->RxRemove));
-#elif defined(AIX)
-#   define remove_receive(PortP) \
-    {\
-        register ushort *RxRemoveP = (ushort *)RIO_PTR(Cad,PortP->RxRemoveO);\
-        WINDW( RxRemoveP, RINDW( RxRemoveP ) & ~PKT_IN_USE );\
-        if (PortP->RxRemoveO == PortP->RxEndO)\
-            PortP->RxRemoveO = PortP->RxStartO;\
-        else\
-            PortP->RxRemoveO += sizeof(ushort);\
-        WWORD(((PHB *)RIO_PTR(Cad,PortP->PhbO))->rx_remove, PortP->RxRemoveO );\
-    }
-#else
-#   define remove_receive(PortP) \
-	*PortP->RxRemove &= ~PKT_IN_USE;\
-	if (PortP->RxRemove == PortP->RxEnd)\
-	    PortP->RxRemove = PortP->RxStart;\
-	else\
-	    PortP->RxRemove++;\
-	PortP->PhbP->rx_remove = RIO_OFF(CaD,PortP->RxRemove);
-#endif
-#endif
-
-
-#else				/* !IN_KERNEL */
-
-#define ZERO_PTR NULL
-
-
-#ifdef HOST
-/* #define can_remove_transmit(pkt,phb) ((((char*)pkt = (*(char**)(phb->tx_remove))-1) || 1)) && (*phb->u3.s2.tx_remove_ptr & PKT_IN_USE))   */
-#define remove_transmit(phb) *phb->u3.s2.tx_remove_ptr &= ~(ushort)PKT_IN_USE;\
-                             if (phb->tx_remove == phb->tx_end)\
-                                phb->tx_remove = phb->tx_start;\
-                             else\
-                                phb->tx_remove++;
-#define can_add_receive(phb) !(*phb->u4.s2.rx_add_ptr & PKT_IN_USE)
-#define add_receive(pkt,phb) *phb->rx_add = pkt;\
-                             *phb->u4.s2.rx_add_ptr |= PKT_IN_USE;\
-                             if (phb->rx_add == phb->rx_end)\
-                                phb->rx_add = phb->rx_start;\
-                             else\
-                                phb->rx_add++;
-#endif
-#endif
-
-#ifdef RTA
-#define splx(oldspl)    if ((oldspl) == 0) spl0()
-#endif
-
 #endif				/* ifndef _list.h */
 /*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/parmmap.h linux-2.6.16-rc1/drivers/char/rio/parmmap.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/parmmap.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/parmmap.h	2006-01-18 13:54:33.638787728 +0000
@@ -78,14 +78,9 @@
 	WORD idle_count;	/* Idle time counter */
 	WORD busy_count;	/* Busy counter */
 	WORD idle_control;	/* Control Idle Process */
-#if defined(HOST) || defined(INKERNEL)
 	WORD tx_intr;		/* TX interrupt pending */
 	WORD rx_intr;		/* RX interrupt pending */
 	WORD rup_intr;		/* RUP interrupt pending */
-#endif
-#if defined(RTA)
-	WORD dying_count;	/* Count of processes dead */
-#endif
 };
 
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/pkt.h linux-2.6.16-rc1/drivers/char/rio/pkt.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/pkt.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/pkt.h	2006-01-18 13:52:47.529918728 +0000
@@ -70,39 +70,12 @@
 #define CONTROL_DATA_WNDW  (DATA_WNDW << 8)
 
 struct PKT {
-#ifdef INKERNEL
 	BYTE dest_unit;		/* Destination Unit Id */
 	BYTE dest_port;		/* Destination POrt */
 	BYTE src_unit;		/* Source Unit Id */
 	BYTE src_port;		/* Source POrt */
-#else
-	union {
-		ushort destination;	/* Complete destination */
-		struct {
-			unsigned char unit;	/* Destination unit */
-			unsigned char port;	/* Destination port */
-		} s1;
-	} u1;
-	union {
-		ushort source;	/* Complete source */
-		struct {
-			unsigned char unit;	/* Source unit */
-			unsigned char port;	/* Source port */
-		} s2;
-	} u2;
-#endif
-#ifdef INKERNEL
 	BYTE len;
 	BYTE control;
-#else
-	union {
-		ushort control;
-		struct {
-			unsigned char len;
-			unsigned char control;
-		} s3;
-	} u3;
-#endif
 	BYTE data[PKT_MAX_DATA_LEN];
 	/* Actual data :-) */
 	WORD csum;		/* C-SUM */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/phb.h linux-2.6.16-rc1/drivers/char/rio/phb.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/phb.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/phb.h	2006-01-18 13:55:50.524099384 +0000
@@ -44,17 +44,6 @@
 #endif
 
 
- /*************************************************
-  * Set the LIMIT values.
-  ************************************************/
-#ifdef RTA
-#define RX_LIMIT       (ushort) 3
-#endif
-#ifdef HOST
-#define RX_LIMIT       (ushort) 1
-#endif
-
-
 /*************************************************
  * Handshake asserted. Deasserted by the LTT(s)
  ************************************************/
@@ -69,11 +58,7 @@
 /*************************************************
  * Maximum number of PHB's
  ************************************************/
-#if defined (HOST) || defined (INKERNEL)
 #define MAX_PHB               ((ushort) 128)	/* range 0-127 */
-#else
-#define MAX_PHB               ((ushort) 8)	/* range 0-7 */
-#endif
 
 /*************************************************
  * Defines for the mode fields
@@ -139,141 +124,23 @@
  * the start. The pointer tx_add points to a SPACE to put a Packet.
  * The pointer tx_remove points to the next Packet to remove
  *************************************************************************/
-#ifndef INKERNEL
-#define src_unit     u2.s2.unit
-#define src_port     u2.s2.port
-#define dest_unit    u1.s1.unit
-#define dest_port    u1.s1.port
-#endif
-#ifdef HOST
-#define tx_start     u3.s1.tx_start_ptr_ptr
-#define tx_add       u3.s1.tx_add_ptr_ptr
-#define tx_end       u3.s1.tx_end_ptr_ptr
-#define tx_remove    u3.s1.tx_remove_ptr_ptr
-#define rx_start     u4.s1.rx_start_ptr_ptr
-#define rx_add       u4.s1.rx_add_ptr_ptr
-#define rx_end       u4.s1.rx_end_ptr_ptr
-#define rx_remove    u4.s1.rx_remove_ptr_ptr
-#endif
 typedef struct PHB PHB;
 struct PHB {
-#ifdef RTA
-	ushort port;
-#endif
-#ifdef INKERNEL
 	WORD source;
-#else
-	union {
-		ushort source;	/* Complete source */
-		struct {
-			unsigned char unit;	/* Source unit */
-			unsigned char port;	/* Source port */
-		} s2;
-	} u2;
-#endif
 	WORD handshake;
 	WORD status;
 	NUMBER timeout;		/* Maximum of 1.9 seconds */
 	WORD link;		/* Send down this link */
-#ifdef INKERNEL
 	WORD destination;
-#else
-	union {
-		ushort destination;	/* Complete destination */
-		struct {
-			unsigned char unit;	/* Destination unit */
-			unsigned char port;	/* Destination port */
-		} s1;
-	} u1;
-#endif
-#ifdef RTA
-	ushort tx_pkts_added;
-	ushort tx_pkts_removed;
-	Q_BUF_ptr tx_q_start;	/* Start of the Q list chain */
-	short num_tx_q_bufs;	/* Number of Q buffers in the chain */
-	PKT_ptr_ptr tx_add;	/* Add a new Packet here */
-	Q_BUF_ptr tx_add_qb;	/* Pointer to the add Q buf */
-	PKT_ptr_ptr tx_add_st_qbb;	/* Pointer to start of the Q's buf */
-	PKT_ptr_ptr tx_add_end_qbb;	/* Pointer to the end of the Q's buf */
-	PKT_ptr_ptr tx_remove;	/* Remove a Packet here */
-	Q_BUF_ptr tx_remove_qb;	/* Pointer to the remove Q buf */
-	PKT_ptr_ptr tx_remove_st_qbb;	/* Pointer to the start of the Q buf */
-	PKT_ptr_ptr tx_remove_end_qbb;	/* Pointer to the end of the Q buf */
-#endif
-#ifdef INKERNEL
 	PKT_ptr_ptr tx_start;
 	PKT_ptr_ptr tx_end;
 	PKT_ptr_ptr tx_add;
 	PKT_ptr_ptr tx_remove;
-#endif
-#ifdef HOST
-	union {
-		struct {
-			PKT_ptr_ptr tx_start_ptr_ptr;
-			PKT_ptr_ptr tx_end_ptr_ptr;
-			PKT_ptr_ptr tx_add_ptr_ptr;
-			PKT_ptr_ptr tx_remove_ptr_ptr;
-		} s1;
-		struct {
-			ushort *tx_start_ptr;
-			ushort *tx_end_ptr;
-			ushort *tx_add_ptr;
-			ushort *tx_remove_ptr;
-		} s2;
-	} u3;
-#endif
 
-#ifdef  RTA
-	ushort rx_pkts_added;
-	ushort rx_pkts_removed;
-	Q_BUF_ptr rx_q_start;	/* Start of the Q list chain */
-	short num_rx_q_bufs;	/* Number of Q buffers in the chain */
-	PKT_ptr_ptr rx_add;	/* Add a new Packet here */
-	Q_BUF_ptr rx_add_qb;	/* Pointer to the add Q buf */
-	PKT_ptr_ptr rx_add_st_qbb;	/* Pointer to start of the Q's buf */
-	PKT_ptr_ptr rx_add_end_qbb;	/* Pointer to the end of the Q's buf */
-	PKT_ptr_ptr rx_remove;	/* Remove a Packet here */
-	Q_BUF_ptr rx_remove_qb;	/* Pointer to the remove Q buf */
-	PKT_ptr_ptr rx_remove_st_qbb;	/* Pointer to the start of the Q buf */
-	PKT_ptr_ptr rx_remove_end_qbb;	/* Pointer to the end of the Q buf */
-#endif
-#ifdef INKERNEL
 	PKT_ptr_ptr rx_start;
 	PKT_ptr_ptr rx_end;
 	PKT_ptr_ptr rx_add;
 	PKT_ptr_ptr rx_remove;
-#endif
-#ifdef HOST
-	union {
-		struct {
-			PKT_ptr_ptr rx_start_ptr_ptr;
-			PKT_ptr_ptr rx_end_ptr_ptr;
-			PKT_ptr_ptr rx_add_ptr_ptr;
-			PKT_ptr_ptr rx_remove_ptr_ptr;
-		} s1;
-		struct {
-			ushort *rx_start_ptr;
-			ushort *rx_end_ptr;
-			ushort *rx_add_ptr;
-			ushort *rx_remove_ptr;
-		} s2;
-	} u4;
-#endif
-
-#ifdef RTA			/* some fields for the remotes */
-	ushort flush_count;	/* Count of write flushes */
-	ushort txmode;		/* Modes for tx */
-	ushort rxmode;		/* Modes for rx */
-	ushort portmode;	/* Generic modes */
-	ushort column;		/* TAB3 column count */
-	ushort tx_subscript;	/* (TX) Subscript into data field */
-	ushort rx_subscript;	/* (RX) Subscript into data field */
-	PKT_ptr rx_incomplete;	/* Hold an incomplete packet here */
-	ushort modem_bits;	/* Modem bits to mask */
-	ushort lastModem;	/* Modem control lines. */
-	ushort addr;		/* Address for sub commands */
-	ushort MonitorTstate;	/* TRUE if monitoring tstop */
-#endif
 
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/qbuf.h linux-2.6.16-rc1/drivers/char/rio/qbuf.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/qbuf.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/qbuf.h	2006-01-18 13:50:33.022366984 +0000
@@ -46,11 +46,7 @@
 
 
 
-#ifdef HOST
-#define PKTS_PER_BUFFER    1
-#else
 #define PKTS_PER_BUFFER    (220 / PKT_LENGTH)
-#endif
 
 typedef struct Q_BUF Q_BUF;
 struct Q_BUF {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/riotypes.h linux-2.6.16-rc1/drivers/char/rio/riotypes.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/riotypes.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/riotypes.h	2006-01-18 13:52:31.693326256 +0000
@@ -43,9 +43,6 @@
 #endif
 #endif
 
-#ifdef INKERNEL
-
-#if !defined(MIPSAT)
 typedef unsigned short NUMBER_ptr;
 typedef unsigned short WORD_ptr;
 typedef unsigned short BYTE_ptr;
@@ -65,69 +62,6 @@
 typedef unsigned short short_ptr;
 typedef unsigned short u_short_ptr;
 typedef unsigned short ushort_ptr;
-#else
-/* MIPSAT types */
-typedef char RIO_POINTER[8];
-typedef RIO_POINTER NUMBER_ptr;
-typedef RIO_POINTER WORD_ptr;
-typedef RIO_POINTER BYTE_ptr;
-typedef RIO_POINTER char_ptr;
-typedef RIO_POINTER Channel_ptr;
-typedef RIO_POINTER FREE_LIST_ptr_ptr;
-typedef RIO_POINTER FREE_LIST_ptr;
-typedef RIO_POINTER LPB_ptr;
-typedef RIO_POINTER Process_ptr;
-typedef RIO_POINTER PHB_ptr;
-typedef RIO_POINTER PKT_ptr;
-typedef RIO_POINTER PKT_ptr_ptr;
-typedef RIO_POINTER Q_BUF_ptr;
-typedef RIO_POINTER Q_BUF_ptr_ptr;
-typedef RIO_POINTER ROUTE_STR_ptr;
-typedef RIO_POINTER RUP_ptr;
-typedef RIO_POINTER short_ptr;
-typedef RIO_POINTER u_short_ptr;
-typedef RIO_POINTER ushort_ptr;
-#endif
-
-#else				/* not INKERNEL */
-typedef unsigned char BYTE;
-typedef unsigned short WORD;
-typedef unsigned long DWORD;
-typedef short NUMBER;
-typedef short *NUMBER_ptr;
-typedef unsigned short *WORD_ptr;
-typedef unsigned char *BYTE_ptr;
-typedef unsigned char uchar;
-typedef unsigned short ushort;
-typedef unsigned int uint;
-typedef unsigned long ulong;
-typedef unsigned char u_char;
-typedef unsigned short u_short;
-typedef unsigned int u_int;
-typedef unsigned long u_long;
-typedef unsigned short ERROR;
-typedef unsigned long ID;
-typedef char *char_ptr;
-typedef Channel *Channel_ptr;
-typedef struct FREE_LIST *FREE_LIST_ptr;
-typedef struct FREE_LIST **FREE_LIST_ptr_ptr;
-typedef struct LPB *LPB_ptr;
-typedef struct Process *Process_ptr;
-typedef struct PHB *PHB_ptr;
-typedef struct PKT *PKT_ptr;
-typedef struct PKT **PKT_ptr_ptr;
-typedef struct Q_BUF *Q_BUF_ptr;
-typedef struct Q_BUF **Q_BUF_ptr_ptr;
-typedef struct ROUTE_STR *ROUTE_STR_ptr;
-typedef struct RUP *RUP_ptr;
-typedef short *short_ptr;
-typedef u_short *u_short_ptr;
-typedef ushort *ushort_ptr;
-typedef struct PKT PKT;
-typedef struct LPB LPB;
-typedef struct RUP RUP;
-#endif
-
 
 #endif				/* __riotypes__ */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/rup.h linux-2.6.16-rc1/drivers/char/rio/rup.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/rup.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/rup.h	2006-01-18 13:55:59.691705696 +0000
@@ -43,12 +43,7 @@
 #endif
 #endif
 
-#if defined( HOST ) || defined( INKERNEL )
 #define MAX_RUP          ((short) 16)
-#endif
-#ifdef RTA
-#define MAX_RUP          ((short) 1)
-#endif
 
 #define PKTS_PER_RUP     ((short) 2)	/* They are always used in pairs */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/rio/sam.h linux-2.6.16-rc1/drivers/char/rio/sam.h
--- linux.vanilla-2.6.16-rc1/drivers/char/rio/sam.h	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/rio/sam.h	2006-01-18 13:47:20.004710128 +0000
@@ -43,10 +43,6 @@
 #endif
 
 
-#if !defined( HOST ) && !defined( INKERNEL )
-#define RTA 1
-#endif
-
 #define NUM_FREE_LIST_UNITS     500
 
 #ifndef FALSE

