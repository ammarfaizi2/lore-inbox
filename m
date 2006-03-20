Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWCTMqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWCTMqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWCTMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:46:25 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14802 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932263AbWCTMqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:46:22 -0500
Subject: PATCH: Yet more rio cleaning (1 of 2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Mar 2006 12:52:48 +0000
Message-Id: <1142859168.20050.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove more unused headers
- Remove various typedefs
- Correct type of PaddrP (physical addresses should be ulong)
- Kill use of bcopy
- More printk cleanups
- Kill true/false
- Clean up direct access to pci BARs

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/bootpkt.h linux-2.6.16-rc6-mm2/drivers/char/rio/bootpkt.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/bootpkt.h	2006-03-19 18:19:27.317791912 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/bootpkt.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,61 +0,0 @@
-
-
-/****************************************************************************
- *******                                                              *******
- *******        B O O T    P A C K E T   H E A D E R   F I L E
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef _pkt_h
-#define _pkt_h 1
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_bootpkt_h_sccs = "@(#)bootpkt.h	1.1";
-#endif
-#endif
-
-    /*************************************************
-     * Overlayed onto the Data fields of a regular
-     * Packet
-     ************************************************/
-typedef struct BOOT_PKT BOOT_PKT;
-struct BOOT_PKT {
-	short seq_num;
-	char data[10];
-};
-
-
-#endif
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/cirrus.h linux-2.6.16-rc6-mm2/drivers/char/rio/cirrus.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/cirrus.h	2006-03-19 18:19:27.317791912 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/cirrus.h	2006-03-16 00:11:27.000000000 +0000
@@ -40,73 +40,7 @@
 #endif
 #define _cirrus_h 1
 
-
-
-/* Bit fields for particular registers */
-
-/* GCR */
-#define GCR_SERIAL	0x00	/* Configure as serial channel */
-#define GCR_PARALLEL	0x80	/* Configure as parallel channel */
-
-/* RDSR - when status read from FIFO */
-#define	RDSR_BREAK		0x08	/* Break received */
-#define RDSR_TIMEOUT    	0x80	/* No new data timeout */
-#define RDSR_SC1  	  	0x10	/* Special char 1 (tx XON) matched */
-#define RDSR_SC2  	  	0x20	/* Special char 2 (tx XOFF) matched */
-#define RDSR_SC12_MASK	  	0x30	/* Mask for special chars 1 and 2 */
-
-/* PPR */
-#define PPR_DEFAULT	0x31	/* Default value - for a 25Mhz clock gives
-				   a timeout period of 1ms */
-
-/* LIVR */
-#define	LIVR_EXCEPTION	0x07	/* Receive exception interrupt */
-
-/* CCR */
-#define	CCR_RESET	0x80	/* Reset channel */
-#define	CCR_CHANGE	0x4e	/* COR's have changed - NB always change all
-				   COR's */
-#define	CCR_WFLUSH	0x82	/* Flush transmit FIFO and TSR / THR */
-
-#define	CCR_SENDSC1	0x21	/* Send special character one */
-#define CCR_SENDSC2	0x22	/* Send special character two */
-#define CCR_SENDSC3	0x23	/* Send special character three */
-#define CCR_SENDSC4	0x24	/* Send special character four */
-
-#define CCR_TENABLE	0x18	/* Enable transmitter */
-#define	CCR_TDISABLE	0x14	/* Disable transmitter */
-#define CCR_RENABLE	0x12	/* Enable receiver */
-#define CCR_RDISABLE	0x11	/* Disable receiver */
-
-#define	CCR_READY	0x00	/* CCR is ready for another command */
-
-/* CCSR */
-#define CCSR_TXENABLE	0x08	/* Transmitter enable */
-#define CCSR_RXENABLE	0x80	/* Receiver enable */
-#define CCSR_TXFLOWOFF	0x04	/* Transmit flow off */
-#define CCSR_TXFLOWON	0x02	/* Transmit flow on */
-
-/* SVRR */
-#define	SVRR_RECEIVE	0x01	/* Receive interrupt pending */
-#define	SVRR_TRANSMIT	0x02	/* Transmit interrupt pending */
-#define	SVRR_MODEM	0x04	/* Modem interrupt pending */
-
-/* CAR */
-#define CAR_PORTS	0x03	/* Bit fields for ports */
-
-/* IER */
-#define	IER_MODEM	0x80	/* Change in modem status */
-#define	IER_RECEIVE	0x10	/* Good data / data exception */
-#define IER_TRANSMITR	0x04	/* Transmit ready (FIFO empty) */
-#define	IER_TRANSMITE	0x02	/* Transmit empty */
-#define IER_TIMEOUT	0x01	/* Timeout on no data */
-
-#define	IER_DEFAULT	0x94	/* Default values */
-#define IER_PARALLEL    0x84	/* Default for Parallel */
-#define	IER_EMPTY	0x92	/* Transmitter empty rather than ready */
-
-/* COR1 - Driver only */
-#define	COR1_INPCK	0x10	/* Check parity of received characters */
+/* Bit fields for particular registers shared with driver */
 
 /* COR1 - driver and RTA */
 #define	COR1_ODD	0x80	/* Odd parity */
@@ -222,35 +156,6 @@
 
 #define	MSVR1_HOST	0xf3	/* The bits the host wants */
 
-/* MSVR2 */
-#define	MSVR2_DSR	0x02	/* DSR output pin (DTR on Cirrus) */
-
-/* MCOR */
-#define	MCOR_CD	        0x80	/* CD (DSR on Cirrus) */
-#define	MCOR_RTS	0x40	/* RTS (CTS on Cirrus) */
-#define	MCOR_RI	        0x20	/* RI */
-#define	MCOR_DTR	0x10	/* DTR (CD on Cirrus) */
-
-#define MCOR_DEFAULT    (MCOR_CD | MCOR_RTS | MCOR_RI | MCOR_DTR)
-#define MCOR_FULLMODEM  MCOR_DEFAULT
-#define MCOR_RJ45       (MCOR_CD | MCOR_RTS | MCOR_DTR)
-#define MCOR_RESTRICTED (MCOR_CD | MCOR_RTS)
-
-/* More MCOR - H/W Handshake (flowcontrol) stuff */
-#define	MCOR_THRESH8	0x08	/* eight characters then we stop */
-#define	MCOR_THRESH9	0x09	/* nine characters then we stop */
-#define	MCOR_THRESH10	0x0A	/* ten characters then we stop */
-#define	MCOR_THRESH11	0x0B	/* eleven characters then we stop */
-
-#define	MCOR_THRESHBITS 0x0F	/* mask for ANDing out the above */
-
-#define	MCOR_THRESHOLD	MCOR_THRESH9	/* MUST BE GREATER THAN COR3_THRESHOLD */
-
-
-/* RTPR */
-#define RTPR_DEFAULT	0x02	/* Default */
-
-
 /* Defines for the subscripts of a CONFIG packet */
 #define	CONFIG_COR1	1	/* Option register 1 */
 #define	CONFIG_COR2	2	/* Option register 2 */
@@ -264,19 +169,6 @@
 #define	CONFIG_TXBAUD	10	/* Tx baud rate */
 #define	CONFIG_RXBAUD	11	/* Rx baud rate */
 
-/* Port status stuff */
-#define	IDLE_CLOSED	0	/* Closed */
-#define IDLE_OPEN	1	/* Idle open */
-#define IDLE_BREAK	2	/* Idle on break */
-
-/* Subscript of MODEM STATUS packet */
-#define	MODEM_VALUE	3	/* Current values of handshake pins */
-/* Subscript of SBREAK packet */
-#define BREAK_LENGTH	1	/* Length of a break in slices of 0.01 seconds
-				   0 = stay on break until an EBREAK command
-				   is sent */
-
-
 #define	PRE_EMPTIVE	0x80	/* Pre-emptive bit in command field */
 
 /* Packet types going from Host to remote - with the exception of OPEN, MOPEN,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/control.h linux-2.6.16-rc6-mm2/drivers/char/rio/control.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/control.h	2006-03-19 18:19:27.319791608 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/control.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,61 +0,0 @@
-
-
-/****************************************************************************
- *******                                                              *******
- *******           C O N T R O L   P A C K E T   H E A D E R S
- *******                                                              *******
- ****************************************************************************
-
- Author  : Jon Brawn
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-
-#ifndef _control_h
-#define _control_h
-
-#ifndef lint
-/* static char *_rio_control_h_sccs = "@(#)control.h	1.4"; */
-#endif
-
-#define	CONTROL		'^'
-#define IFOAD		( CONTROL + 1 )
-#define	IDENTIFY	( CONTROL + 2 )
-#define	ZOMBIE		( CONTROL + 3 )
-#define	UFOAD		( CONTROL + 4 )
-#define IWAIT		( CONTROL + 5 )
-
-#define	IFOAD_MAGIC	0xF0AD	/* of course */
-#define	ZOMBIE_MAGIC	(~0xDEAD)	/* not dead -> zombie */
-#define	UFOAD_MAGIC	0xD1E	/* kill-your-neighbour */
-#define	IWAIT_MAGIC	0xB1DE	/* Bide your time */
-
-#endif
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/defaults.h linux-2.6.16-rc6-mm2/drivers/char/rio/defaults.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/defaults.h	2006-03-19 18:19:27.320791456 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/defaults.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,51 +0,0 @@
-
-/****************************************************************************
- *******                                                              *******
- *******                     D E F A U L T S
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_defaults_h_sccs = "@(#)defaults.h	1.1";
-#endif
-#endif
-
-
-#define MILLISECOND           (int) (1000/64)	/* 15.625 low ticks */
-#define SECOND                (int) 15625	/* Low priority ticks */
-
-#define LINK_TIMEOUT          (int) (POLL_PERIOD / 2)
-
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/error.h linux-2.6.16-rc6-mm2/drivers/char/rio/error.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/error.h	2006-03-19 18:19:27.322791152 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/error.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,82 +0,0 @@
-
-/****************************************************************************
- *******                                                              *******
- *******     E R R O R  H E A D E R   F I L E
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef lint
-/* static char *_rio_error_h_sccs = "@(#)error.h	1.3"; */
-#endif
-
-#define E_NO_ERROR                       ((ushort) 0)
-#define E_PROCESS_NOT_INIT               ((ushort) 1)
-#define E_LINK_TIMEOUT                   ((ushort) 2)
-#define E_NO_ROUTE                       ((ushort) 3)
-#define E_CONFUSED                       ((ushort) 4)
-#define E_HOME                           ((ushort) 5)
-#define E_CSUM_FAIL                      ((ushort) 6)
-#define E_DISCONNECTED                   ((ushort) 7)
-#define E_BAD_RUP                        ((ushort) 8)
-#define E_NO_VIRGIN                      ((ushort) 9)
-#define E_BOOT_RUP_BUSY                  ((ushort) 10)
-
-
-
-    /*************************************************
-     * Parsed to mem_halt()
-     ************************************************/
-#define E_CHANALLOC                      ((ushort) 0x80)
-#define E_POLL_ALLOC                     ((ushort) 0x81)
-#define E_LTTWAKE                        ((ushort) 0x82)
-#define E_LTT_ALLOC                      ((ushort) 0x83)
-#define E_LRT_ALLOC                      ((ushort) 0x84)
-#define E_CIRRUS                         ((ushort) 0x85)
-#define E_MONITOR                        ((ushort) 0x86)
-#define E_PHB_ALLOC                      ((ushort) 0x87)
-#define E_ARRAY_ALLOC                    ((ushort) 0x88)
-#define E_QBUF_ALLOC                     ((ushort) 0x89)
-#define E_PKT_ALLOC                      ((ushort) 0x8a)
-#define E_GET_TX_Q_BUF                   ((ushort) 0x8b)
-#define E_GET_RX_Q_BUF                   ((ushort) 0x8c)
-#define E_MEM_OUT                        ((ushort) 0x8d)
-#define E_MMU_INIT                       ((ushort) 0x8e)
-#define E_LTT_INIT                       ((ushort) 0x8f)
-#define E_LRT_INIT                       ((ushort) 0x90)
-#define E_LINK_RUN                       ((ushort) 0x91)
-#define E_MONITOR_ALLOC                  ((ushort) 0x92)
-#define E_MONITOR_INIT                   ((ushort) 0x93)
-#define E_POLL_INIT                      ((ushort) 0x94)
-
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/func.h linux-2.6.16-rc6-mm2/drivers/char/rio/func.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/func.h	2006-03-19 18:20:51.320021632 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/func.h	2006-03-16 13:15:34.000000000 +0000
@@ -49,7 +49,7 @@
 int RIOBootRup(struct rio_info *, unsigned int, struct Host *, struct PKT *);
 int RIOBootOk(struct rio_info *, struct Host *, unsigned long);
 int RIORtaBound(struct rio_info *, unsigned int);
-void FillSlot(int, int, unsigned int, struct Host *);
+void rio_fill_host_slot(int, int, unsigned int, struct Host *);
 
 /* riocmd.c */
 int RIOFoadRta(struct Host *, struct Map *);
@@ -66,7 +66,6 @@
 int RIOWFlushMark(unsigned long, struct CmdBlk *);
 int RIORFlushEnable(unsigned long, struct CmdBlk *);
 int RIOUnUse(unsigned long, struct CmdBlk *);
-void ShowPacket(unsigned int, struct PKT *);
 
 /* rioctrl.c */
 int riocontrol(struct rio_info *, dev_t, int, caddr_t, int);
@@ -79,13 +78,11 @@
 int RIODoAT(struct rio_info *, int, int);
 caddr_t RIOCheckForATCard(int);
 int RIOAssignAT(struct rio_info *, int, caddr_t, int);
-int RIOBoardTest(paddr_t, caddr_t, unsigned char, int);
+int RIOBoardTest(unsigned long, caddr_t, unsigned char, int);
 void RIOAllocDataStructs(struct rio_info *);
 void RIOSetupDataStructs(struct rio_info *);
 int RIODefaultName(struct rio_info *, struct Host *, unsigned int);
 struct rioVersion *RIOVersid(void);
-int RIOMapin(paddr_t, int, caddr_t *);
-void RIOMapout(paddr_t, long, caddr_t);
 void RIOHostReset(unsigned int, struct DpRam *, unsigned int);
 
 /* riointr.c */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/host.h linux-2.6.16-rc6-mm2/drivers/char/rio/host.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/host.h	2006-03-19 18:20:51.321021480 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/host.h	2006-03-15 15:41:51.000000000 +0000
@@ -56,7 +56,7 @@
 	unsigned char Slot;		/* Slot */
 	caddr_t Caddr;			/* KV address of DPRAM */
 	struct DpRam *CardP;		/* KV address of DPRAM, with overlay */
-	paddr_t PaddrP;			/* Phys. address of DPRAM */
+	unsigned long PaddrP;		/* Phys. address of DPRAM */
 	char Name[MAX_NAME_LEN];	/* The name of the host */
 	unsigned int UniqueNum;		/* host unique number */
 	spinlock_t HostLock;	/* Lock structure for MPX */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/link.h linux-2.6.16-rc6-mm2/drivers/char/rio/link.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/link.h	2006-03-19 18:20:51.321021480 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/link.h	2006-03-15 15:33:43.000000000 +0000
@@ -50,8 +50,8 @@
 
 struct LPB {
 	u16 link_number;	/* Link Number */
-	Channel_ptr in_ch;	/* Link In Channel */
-	Channel_ptr out_ch;	/* Link Out Channel */
+	u16 in_ch;	/* Link In Channel */
+	u16 out_ch;	/* Link Out Channel */
 	u8 attached_serial[4];  /* Attached serial number */
 	u8 attached_host_serial[4];
 	/* Serial number of Host who
@@ -59,8 +59,8 @@
 	u16 descheduled;	/* Currently Descheduled */
 	u16 state;		/* Current state */
 	u16 send_poll;		/* Send a Poll Packet */
-	Process_ptr ltt_p;	/* Process Descriptor */
-	Process_ptr lrt_p;	/* Process Descriptor */
+	u16 ltt_p;	/* Process Descriptor */
+	u16 lrt_p;	/* Process Descriptor */
 	u16 lrt_status;		/* Current lrt status */
 	u16 ltt_status;		/* Current ltt status */
 	u16 timeout;		/* Timeout value */
@@ -71,8 +71,8 @@
 	u16 add_packet_list;	/* Add packets to here */
 	u16 remove_packet_list;	/* Send packets from here */
 
-	Channel_ptr lrt_fail_chan;	/* Lrt's failure channel */
-	Channel_ptr ltt_fail_chan;	/* Ltt's failure channel */
+	u16 lrt_fail_chan;	/* Lrt's failure channel */
+	u16 ltt_fail_chan;	/* Ltt's failure channel */
 
 	/* RUP structure for HOST to driver communications */
 	struct RUP rup;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/linux_compat.h linux-2.6.16-rc6-mm2/drivers/char/rio/linux_compat.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/linux_compat.h	2006-03-19 18:20:51.321021480 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/linux_compat.h	2006-03-16 00:05:50.000000000 +0000
@@ -25,10 +25,6 @@
 	struct termios tm;
 };
 
-#define bcopy(src, dest, n) memcpy ((dest), (src), (n))
-
-#define SEM_SIGIGNORE 0x1234
-
 extern int rio_debug;
 
 #define RIO_DEBUG_INIT         0x000001
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/list.h linux-2.6.16-rc6-mm2/drivers/char/rio/list.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/list.h	2006-03-19 18:19:27.330789936 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/list.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,56 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                      L I S T                                 *******
- *******                                                              *******
- ****************************************************************************
-
- Author  : Jeremy Rolls.
- Date    : 04-Nov-1990
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
- ***************************************************************************/
-
-#ifndef _list_h
-#define _list_h 1
-
-#ifdef SCCS_LABELS
-#ifndef lint
-static char *_rio_list_h_sccs = "@(#)list.h	1.9";
-#endif
-#endif
-
-#define PKT_IN_USE    0x1
-
-#define ZERO_PTR (ushort) 0x8000
-#define	CaD	PortP->Caddr
-
-/*
-** We can add another packet to a transmit queue if the packet pointer pointed
-** to by the TxAdd pointer has PKT_IN_USE clear in its address.
-*/
-
-#endif				/* ifndef _list.h */
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/map.h linux-2.6.16-rc6-mm2/drivers/char/rio/map.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/map.h	2006-03-19 18:19:27.335789176 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/map.h	2006-03-15 16:09:12.000000000 +0000
@@ -47,17 +47,17 @@
 #define	MAX_NAME_LEN 32
 
 struct Map {
-	uint HostUniqueNum;	/* Supporting hosts unique number */
-	uint RtaUniqueNum;	/* Unique number */
+	unsigned int HostUniqueNum;	/* Supporting hosts unique number */
+	unsigned int RtaUniqueNum;	/* Unique number */
 	/*
 	 ** The next two IDs must be swapped on big-endian architectures
 	 ** when using a v2.04 /etc/rio/config with a v3.00 driver (when
 	 ** upgrading for example).
 	 */
-	ushort ID;		/* ID used in the subnet */
-	ushort ID2;		/* ID of 2nd block of 8 for 16 port */
-	ulong Flags;		/* Booted, ID Given, Disconnected */
-	ulong SysPort;		/* First tty mapped to this port */
+	unsigned short ID;		/* ID used in the subnet */
+	unsigned short ID2;		/* ID of 2nd block of 8 for 16 port */
+	unsigned long Flags;		/* Booted, ID Given, Disconnected */
+	unsigned long SysPort;		/* First tty mapped to this port */
 	struct Top Topology[LINKS_PER_UNIT];	/* ID connected to each link */
 	char Name[MAX_NAME_LEN];	/* Cute name by which RTA is known */
 };
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/param.h linux-2.6.16-rc6-mm2/drivers/char/rio/param.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/param.h	2006-03-19 18:19:27.336789024 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/param.h	2006-03-15 15:29:19.000000000 +0000
@@ -43,18 +43,18 @@
 */
 
 struct phb_param {
-	BYTE Cmd;		/* It is very important that these line up */
-	BYTE Cor1;		/* with what is expected at the other end. */
-	BYTE Cor2;		/* to confirm that you've got it right,    */
-	BYTE Cor4;		/* check with cirrus/cirrus.h              */
-	BYTE Cor5;
-	BYTE TxXon;		/* Transmit X-On character */
-	BYTE TxXoff;		/* Transmit X-Off character */
-	BYTE RxXon;		/* Receive X-On character */
-	BYTE RxXoff;		/* Receive X-Off character */
-	BYTE LNext;		/* Literal-next character */
-	BYTE TxBaud;		/* Transmit baudrate */
-	BYTE RxBaud;		/* Receive baudrate */
+	u8 Cmd;			/* It is very important that these line up */
+	u8 Cor1;		/* with what is expected at the other end. */
+	u8 Cor2;		/* to confirm that you've got it right,    */
+	u8 Cor4;		/* check with cirrus/cirrus.h              */
+	u8 Cor5;
+	u8 TxXon;		/* Transmit X-On character */
+	u8 TxXoff;		/* Transmit X-Off character */
+	u8 RxXon;		/* Receive X-On character */
+	u8 RxXoff;		/* Receive X-Off character */
+	u8 LNext;		/* Literal-next character */
+	u8 TxBaud;		/* Transmit baudrate */
+	u8 RxBaud;		/* Receive baudrate */
 };
 
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/parmmap.h linux-2.6.16-rc6-mm2/drivers/char/rio/parmmap.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/parmmap.h	2006-03-19 18:20:51.322021328 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/parmmap.h	2006-03-15 15:32:56.000000000 +0000
@@ -47,17 +47,17 @@
 typedef struct PARM_MAP PARM_MAP;
 
 struct PARM_MAP {
-	PHB_ptr phb_ptr;	/* Pointer to the PHB array */
+	u16 phb_ptr;	/* Pointer to the PHB array */
 	u16 phb_num_ptr;	/* Ptr to Number of PHB's */
-	FREE_LIST_ptr free_list;	/* Free List pointer */
-	FREE_LIST_ptr free_list_end;	/* Free List End pointer */
-	Q_BUF_ptr_ptr q_free_list_ptr;	/* Ptr to Q_BUF variable */
+	u16 free_list;	/* Free List pointer */
+	u16 free_list_end;	/* Free List End pointer */
+	u16 q_free_list_ptr;	/* Ptr to Q_BUF variable */
 	u16 unit_id_ptr;	/* Unit Id */
-	LPB_ptr link_str_ptr;	/* Link Structure Array */
+	u16 link_str_ptr;	/* Link Structure Array */
 	u16 bootloader_1;	/* 1st Stage Boot Loader */
 	u16 bootloader_2;	/* 2nd Stage Boot Loader */
 	u16 port_route_map_ptr;	/* Port Route Map */
-	ROUTE_STR_ptr route_ptr;	/* Unit Route Map */
+	u16 route_ptr;		/* Unit Route Map */
 	u16 map_present;	/* Route Map present */
 	s16 pkt_num;		/* Total number of packets */
 	s16 q_num;		/* Total number of Q packets */
@@ -70,7 +70,7 @@
 	u16 rx_limit;		/* For high / low watermarks */
 	s16 links;		/* Links to use */
 	s16 timer;		/* Interrupts per second */
-	RUP_ptr rups;		/* Pointer to the RUPs */
+	u16 rups;		/* Pointer to the RUPs */
 	u16 max_phb;		/* Mostly for debugging */
 	u16 living;		/* Just increments!! */
 	u16 init_done;		/* Initialisation over */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/phb.h linux-2.6.16-rc6-mm2/drivers/char/rio/phb.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/phb.h	2006-03-19 18:20:51.322021328 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/phb.h	2006-03-15 16:22:54.000000000 +0000
@@ -117,7 +117,7 @@
  * the start. The pointer tx_add points to a SPACE to put a Packet.
  * The pointer tx_remove points to the next Packet to remove
  *************************************************************************/
-typedef struct PHB PHB;
+
 struct PHB {
 	u8 source;
 	u8 handshake;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/qbuf.h linux-2.6.16-rc6-mm2/drivers/char/rio/qbuf.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/qbuf.h	2006-03-19 18:19:27.350786896 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/qbuf.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,62 +0,0 @@
-
-/****************************************************************************
- *******                                                              *******
- *******       Q U E U E    B U F F E R   S T R U C T U R E S
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra / Jeremy Rolls
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef _qbuf_h
-#define _qbuf_h 1
-
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_qbuf_h_sccs = "@(#)qbuf.h	1.1";
-#endif
-#endif
-
-
-
-#define PKTS_PER_BUFFER    (220 / PKT_LENGTH)
-
-typedef struct Q_BUF Q_BUF;
-struct Q_BUF {
-	Q_BUF_ptr next;
-	Q_BUF_ptr prev;
-	PKT_ptr buf[PKTS_PER_BUFFER];
-};
-
-
-#endif
-
-
-/*********** end of file ***********/

