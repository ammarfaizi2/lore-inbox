Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWBNTlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWBNTlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWBNTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:41:25 -0500
Received: from [81.2.110.250] ([81.2.110.250]:27047 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1422762AbWBNTlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:41:24 -0500
Subject: PATCH: rio, more header cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 19:44:20 +0000
Message-Id: <1139946260.11979.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strip some of the typedef mess out
Remove a small subset of unused defines and the like

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/board.h linux-2.6.16-rc3/drivers/char/rio/board.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/board.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/board.h	2006-02-14 18:55:26.914767408 +0000
@@ -33,10 +33,6 @@
 #ifndef	__rio_board_h__
 #define	__rio_board_h__
 
-#ifdef SCCS_LABELS
-static char *_board_h_sccs_ = "@(#)board.h	1.2";
-#endif
-
 /*
 ** board.h contains the definitions for the *hardware* of the host cards.
 ** It describes the memory overlay for the dual port RAM area.
@@ -53,29 +49,29 @@
 **	The shape of the Host Control area, at offset 0x7C00, Write Only
 */
 struct s_Ctrl {
-	BYTE DpCtl;		/* 7C00 */
-	BYTE Dp_Unused2_[127];
-	BYTE DpIntSet;		/* 7C80 */
-	BYTE Dp_Unused3_[127];
-	BYTE DpTpuReset;	/* 7D00 */
-	BYTE Dp_Unused4_[127];
-	BYTE DpIntReset;	/* 7D80 */
-	BYTE Dp_Unused5_[127];
+	u8 DpCtl;		/* 7C00 */
+	u8 Dp_Unused2_[127];
+	u8 DpIntSet;		/* 7C80 */
+	u8 Dp_Unused3_[127];
+	u8 DpTpuReset;	/* 7D00 */
+	u8 Dp_Unused4_[127];
+	u8 DpIntReset;	/* 7D80 */
+	u8 Dp_Unused5_[127];
 };
 
 /*
 ** The PROM data area on the host (0x7C00), Read Only
 */
 struct s_Prom {
-	WORD DpSlxCode[2];
-	WORD DpRev;
-	WORD Dp_Unused6_;
-	WORD DpUniq[4];
-	WORD DpJahre;
-	WORD DpWoche;
-	WORD DpHwFeature[5];
-	WORD DpOemId;
-	WORD DpSiggy[16];
+	u16 DpSlxCode[2];
+	u16 DpRev;
+	u16 Dp_Unused6_;
+	u16 DpUniq[4];
+	u16 DpJahre;
+	u16 DpWoche;
+	u16 DpHwFeature[5];
+	u16 DpOemId;
+	u16 DpSiggy[16];
 };
 
 /*
@@ -90,19 +86,19 @@
 ** The top end of memory!
 */
 struct s_ParmMapS {		/* Area containing Parm Map Pointer */
-	BYTE Dp_Unused8_[DP_PARMMAP_ADDR];
-	WORD DpParmMapAd;
+	u8 Dp_Unused8_[DP_PARMMAP_ADDR];
+	u16 DpParmMapAd;
 };
 
 struct s_StartUpS {
-	BYTE Dp_Unused9_[DP_STARTUP_ADDR];
-	BYTE Dp_LongJump[0x4];
-	BYTE Dp_Unused10_[2];
-	BYTE Dp_ShortJump[0x2];
+	u8 Dp_Unused9_[DP_STARTUP_ADDR];
+	u8 Dp_LongJump[0x4];
+	u8 Dp_Unused10_[2];
+	u8 Dp_ShortJump[0x2];
 };
 
 union u_Sram2ParmMap {		/* This is the top of memory (0x7E00-0x7FFF) */
-	BYTE DpSramMem[DP_SRAM2_SIZE];
+	u8 DpSramMem[DP_SRAM2_SIZE];
 	struct s_ParmMapS DpParmMapS;
 	struct s_StartUpS DpStartUpS;
 };
@@ -111,11 +107,11 @@
 **	This is the DP RAM overlay.
 */
 struct DpRam {
-	BYTE DpSram1[DP_SRAM1_SIZE];	/* 0000 - 7BFF */
+	u8 DpSram1[DP_SRAM1_SIZE];	/* 0000 - 7BFF */
 	union u_CtrlProm DpCtrlProm;	/* 7C00 - 7DFF */
 	union u_Sram2ParmMap DpSram2ParmMap;	/* 7E00 - 7FFF */
-	BYTE DpScratch[DP_SCRATCH_SIZE];	/* 8000 - 8FFF */
-	BYTE DpSram3[DP_SRAM3_SIZE];	/* 9000 - FFFF */
+	u8 DpScratch[DP_SCRATCH_SIZE];	/* 8000 - 8FFF */
+	u8 DpSram3[DP_SRAM3_SIZE];	/* 9000 - FFFF */
 };
 
 #define	DpControl	DpCtrlProm.DpCtrl.DpCtl
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/cmdpkt.h linux-2.6.16-rc3/drivers/char/rio/cmdpkt.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/cmdpkt.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/cmdpkt.h	2006-02-14 18:55:58.674939128 +0000
@@ -55,24 +55,24 @@
 ** at Data[2] in the actual pkt!
 */
 struct BootSequence {
-	WORD NumPackets;
-	WORD LoadBase;
-	WORD CodeSize;
+	u16 NumPackets;
+	u16 LoadBase;
+	u16 CodeSize;
 };
 
 #define	BOOT_SEQUENCE_LEN	8
 
 struct SamTop {
-	BYTE Unit;
-	BYTE Link;
+	u8 Unit;
+	u8 Link;
 };
 
 struct CmdHdr {
-	BYTE PcCommand;
+	u8 PcCommand;
 	union {
-		BYTE PcPhbNum;
-		BYTE PcLinkNum;
-		BYTE PcIDNum;
+		u8 PcPhbNum;
+		u8 PcLinkNum;
+		u8 PcIDNum;
 	} U0;
 };
 
@@ -84,28 +84,28 @@
 			struct BootSequence PcBootSequence;
 		} S1;
 		struct {
-			WORD PcSequence;
-			BYTE PcBootData[RTA_BOOT_DATA_SIZE];
+			u16 PcSequence;
+			u8 PcBootData[RTA_BOOT_DATA_SIZE];
 		} S2;
 		struct {
-			WORD __crud__;
-			BYTE PcUniqNum[4];	/* this is really a uint. */
-			BYTE PcModuleTypes;	/* what modules are fitted */
+			u16 __crud__;
+			u8 PcUniqNum[4];	/* this is really a uint. */
+			u8 PcModuleTypes;	/* what modules are fitted */
 		} S3;
 		struct {
 			struct CmdHdr CmdHdr;
-			BYTE __undefined__;
-			BYTE PcModemStatus;
-			BYTE PcPortStatus;
-			BYTE PcSubCommand;	/* commands like mem or register dump */
-			WORD PcSubAddr;	/* Address for command */
-			BYTE PcSubData[64];	/* Date area for command */
+			u8 __undefined__;
+			u8 PcModemStatus;
+			u8 PcPortStatus;
+			u8 PcSubCommand;	/* commands like mem or register dump */
+			u16 PcSubAddr;	/* Address for command */
+			u8 PcSubData[64];	/* Date area for command */
 		} S4;
 		struct {
 			struct CmdHdr CmdHdr;
-			BYTE PcCommandText[1];
-			BYTE __crud__[20];
-			BYTE PcIDNum2;	/* It had to go somewhere! */
+			u8 PcCommandText[1];
+			u8 __crud__[20];
+			u8 PcIDNum2;	/* It had to go somewhere! */
 		} S5;
 		struct {
 			struct CmdHdr CmdHdr;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/link.h linux-2.6.16-rc3/drivers/char/rio/link.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/link.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/link.h	2006-02-14 18:54:40.249861552 +0000
@@ -37,38 +37,9 @@
 #ifndef _link_h
 #define _link_h 1
 
-#ifndef lint
-#ifdef SCCS_LABELS
-/* static char *_rio_link_h_sccs = "@(#)link.h	1.15"; */
-#endif
-#endif
-
-
-
 /*************************************************
  * Define the Link Status stuff
  ************************************************/
-#define LRT_ACTIVE         ((ushort) 0x01)
-#define LRT_SPARE1         ((ushort) 0x02)
-#define INTRO_RCVD         ((ushort) 0x04)
-#define FORCED_DISCONNECT  ((ushort) 0x08)
-#define LRT_SPARE2	   ((ushort) 0x80)
-
-#define TOP_OF_RTA_RAM     ((ushort) 0x7000)
-#define HOST_SERIAL_POINTER (unsigned char **) (TOP_OF_RTA_RAM - 2 * sizeof (ushort))
-
-/* Flags for ltt_status */
-#define  WAITING_ACK		(ushort) 0x0001
-#define  DATA_SENT		(ushort) 0x0002
-#define  WAITING_RUP		(ushort) 0x0004
-#define  WAITING_RETRY		(ushort) 0x0008
-#define  WAITING_TOPOLOGY	(ushort) 0x0010
-#define  SEND_SYNC		(ushort) 0x0020
-#define  FOAD_THIS_LINK		(ushort) 0x0040
-#define  REQUEST_SYNC		(ushort) 0x0080
-#define  REMOTE_DYING		(ushort) 0x0100
-#define  DIE_NOW		(ushort) 0x0200
-
 /* Boot request stuff */
 #define BOOT_REQUEST       ((ushort) 0)	/* Request for a boot */
 #define BOOT_ABORT         ((ushort) 1)	/* Abort a boot */
@@ -76,56 +47,27 @@
 					   and load address */
 #define BOOT_COMPLETED     ((ushort) 3)	/* Boot completed */
 
-/* States that a link can be in */
-#define	LINK_DISCONNECTED  ((ushort) 0)	/* Disconnected */
-#define LINK_BOOT1         ((ushort) 1)	/* Trying to send 1st stage boot */
-#define LINK_BOOT2         ((ushort) 2)	/* Trying to send 2nd stage boot */
-#define LINK_BOOT2WAIT     ((ushort) 3)	/* Waiting for selftest results */
-#define LINK_BOOT3         ((ushort) 4)	/* Trying to send 3rd stage boots */
-#define LINK_SYNC          ((ushort) 5)	/* Syncing */
-
-#define LINK_INTRO         ((ushort) 10)	/* Introductory packet */
-#define LINK_SUPPLYID      ((ushort) 11)	/* Trying to supply an ID */
-#define LINK_TOPOLOGY      ((ushort) 12)	/* Send a topology update */
-#define LINK_REQUESTID     ((ushort) 13)	/* Waiting for an ID */
-#define LINK_CONNECTED     ((ushort) 14)	/* Connected */
-
-#define LINK_INTERCONNECT  ((ushort) 20)	/* Subnets interconnected */
-
-#define LINK_SPARE	   ((ushort) 40)
-
-/*
-** Set the default timeout for link communications.
-*/
-#define	LINKTIMEOUT		(400 * MILLISECOND)
-
-/*
-** LED stuff
-*/
-#define LED_SET_COLOUR(colour)
-#define LED_OR_COLOUR(colour)
-#define LED_TIMEOUT(time)
 
 struct LPB {
-	WORD link_number;	/* Link Number */
+	u16 link_number;	/* Link Number */
 	Channel_ptr in_ch;	/* Link In Channel */
 	Channel_ptr out_ch;	/* Link Out Channel */
-	BYTE attached_serial[4];	/* Attached serial number */
-	BYTE attached_host_serial[4];
+	u8 attached_serial[4];  /* Attached serial number */
+	u8 attached_host_serial[4];
 	/* Serial number of Host who
 	   booted the other end */
-	WORD descheduled;	/* Currently Descheduled */
-	WORD state;		/* Current state */
-	WORD send_poll;		/* Send a Poll Packet */
+	u16 descheduled;	/* Currently Descheduled */
+	u16 state;		/* Current state */
+	u16 send_poll;		/* Send a Poll Packet */
 	Process_ptr ltt_p;	/* Process Descriptor */
 	Process_ptr lrt_p;	/* Process Descriptor */
-	WORD lrt_status;	/* Current lrt status */
-	WORD ltt_status;	/* Current ltt status */
-	WORD timeout;		/* Timeout value */
-	WORD topology;		/* Topology bits */
-	WORD mon_ltt;
-	WORD mon_lrt;
-	WORD WaitNoBoot;	/* Secs to hold off booting */
+	u16 lrt_status;		/* Current lrt status */
+	u16 ltt_status;		/* Current ltt status */
+	u16 timeout;		/* Timeout value */
+	u16 topology;		/* Topology bits */
+	u16 mon_ltt;
+	u16 mon_lrt;
+	u16 WaitNoBoot;	/* Secs to hold off booting */
 	PKT_ptr add_packet_list;	/* Add packets to here */
 	PKT_ptr remove_packet_list;	/* Send packets from here */
 
@@ -136,17 +78,17 @@
 	struct RUP rup;
 	struct RUP link_rup;	/* RUP for the link (POLL,
 				   topology etc.) */
-	WORD attached_link;	/* Number of attached link */
-	WORD csum_errors;	/* csum errors */
-	WORD num_disconnects;	/* number of disconnects */
-	WORD num_sync_rcvd;	/* # sync's received */
-	WORD num_sync_rqst;	/* # sync requests */
-	WORD num_tx;		/* Num pkts sent */
-	WORD num_rx;		/* Num pkts received */
-	WORD module_attached;	/* Module tpyes of attached */
-	WORD led_timeout;	/* LED timeout */
-	WORD first_port;	/* First port to service */
-	WORD last_port;		/* Last port to service */
+	u16 attached_link;	/* Number of attached link */
+	u16 csum_errors;	/* csum errors */
+	u16 num_disconnects;	/* number of disconnects */
+	u16 num_sync_rcvd;	/* # sync's received */
+	u16 num_sync_rqst;	/* # sync requests */
+	u16 num_tx;		/* Num pkts sent */
+	u16 num_rx;		/* Num pkts received */
+	u16 module_attached;	/* Module tpyes of attached */
+	u16 led_timeout;	/* LED timeout */
+	u16 first_port;		/* First port to service */
+	u16 last_port;		/* Last port to service */
 };
 
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/parmmap.h linux-2.6.16-rc3/drivers/char/rio/parmmap.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/parmmap.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/parmmap.h	2006-02-14 19:05:10.197095016 +0000
@@ -48,39 +48,39 @@
 
 struct PARM_MAP {
 	PHB_ptr phb_ptr;	/* Pointer to the PHB array */
-	WORD_ptr phb_num_ptr;	/* Ptr to Number of PHB's */
+	u16 phb_num_ptr;	/* Ptr to Number of PHB's */
 	FREE_LIST_ptr free_list;	/* Free List pointer */
 	FREE_LIST_ptr free_list_end;	/* Free List End pointer */
 	Q_BUF_ptr_ptr q_free_list_ptr;	/* Ptr to Q_BUF variable */
-	BYTE_ptr unit_id_ptr;	/* Unit Id */
+	u16 unit_id_ptr;	/* Unit Id */
 	LPB_ptr link_str_ptr;	/* Link Structure Array */
-	BYTE_ptr bootloader_1;	/* 1st Stage Boot Loader */
-	BYTE_ptr bootloader_2;	/* 2nd Stage Boot Loader */
-	WORD_ptr port_route_map_ptr;	/* Port Route Map */
+	u16 bootloader_1;	/* 1st Stage Boot Loader */
+	u16 bootloader_2;	/* 2nd Stage Boot Loader */
+	u16 port_route_map_ptr;	/* Port Route Map */
 	ROUTE_STR_ptr route_ptr;	/* Unit Route Map */
-	NUMBER_ptr map_present;	/* Route Map present */
-	NUMBER pkt_num;		/* Total number of packets */
-	NUMBER q_num;		/* Total number of Q packets */
-	WORD buffers_per_port;	/* Number of buffers per port */
-	WORD heap_size;		/* Initial size of heap */
-	WORD heap_left;		/* Current Heap left */
-	WORD error;		/* Error code */
-	WORD tx_max;		/* Max number of tx pkts per phb */
-	WORD rx_max;		/* Max number of rx pkts per phb */
-	WORD rx_limit;		/* For high / low watermarks */
-	NUMBER links;		/* Links to use */
-	NUMBER timer;		/* Interrupts per second */
+	u16 map_present;	/* Route Map present */
+	s16 pkt_num;		/* Total number of packets */
+	s16 q_num;		/* Total number of Q packets */
+	u16 buffers_per_port;	/* Number of buffers per port */
+	u16 heap_size;		/* Initial size of heap */
+	u16 heap_left;		/* Current Heap left */
+	u16 error;		/* Error code */
+	u16 tx_max;		/* Max number of tx pkts per phb */
+	u16 rx_max;		/* Max number of rx pkts per phb */
+	u16 rx_limit;		/* For high / low watermarks */
+	s16 links;		/* Links to use */
+	s16 timer;		/* Interrupts per second */
 	RUP_ptr rups;		/* Pointer to the RUPs */
-	WORD max_phb;		/* Mostly for debugging */
-	WORD living;		/* Just increments!! */
-	WORD init_done;		/* Initialisation over */
-	WORD booting_link;
-	WORD idle_count;	/* Idle time counter */
-	WORD busy_count;	/* Busy counter */
-	WORD idle_control;	/* Control Idle Process */
-	WORD tx_intr;		/* TX interrupt pending */
-	WORD rx_intr;		/* RX interrupt pending */
-	WORD rup_intr;		/* RUP interrupt pending */
+	u16 max_phb;		/* Mostly for debugging */
+	u16 living;		/* Just increments!! */
+	u16 init_done;		/* Initialisation over */
+	u16 booting_link;
+	u16 idle_count;		/* Idle time counter */
+	u16 busy_count;		/* Busy counter */
+	u16 idle_control;	/* Control Idle Process */
+	u16 tx_intr;		/* TX interrupt pending */
+	u16 rx_intr;		/* RX interrupt pending */
+	u16 rup_intr;		/* RUP interrupt pending */
 };
 
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/pkt.h linux-2.6.16-rc3/drivers/char/rio/pkt.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/pkt.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/pkt.h	2006-02-14 18:57:22.190242872 +0000
@@ -37,14 +37,6 @@
 #ifndef _pkt_h
 #define _pkt_h 1
 
-
-#ifdef SCCS_LABELS
-#ifndef lint
-/* static char *_rio_pkt_h_sccs = "@(#)pkt.h	1.8"; */
-#endif
-#endif
-
-#define MAX_TTL         0xf
 #define PKT_CMD_BIT     ((ushort) 0x080)
 #define PKT_CMD_DATA    ((ushort) 0x080)
 
@@ -70,15 +62,15 @@
 #define CONTROL_DATA_WNDW  (DATA_WNDW << 8)
 
 struct PKT {
-	BYTE dest_unit;		/* Destination Unit Id */
-	BYTE dest_port;		/* Destination POrt */
-	BYTE src_unit;		/* Source Unit Id */
-	BYTE src_port;		/* Source POrt */
-	BYTE len;
-	BYTE control;
-	BYTE data[PKT_MAX_DATA_LEN];
+	u8 dest_unit;		/* Destination Unit Id */
+	u8 dest_port;		/* Destination POrt */
+	u8 src_unit;		/* Source Unit Id */
+	u8 src_port;		/* Source POrt */
+	u8 len;
+	u8 control;
+	u8 data[PKT_MAX_DATA_LEN];
 	/* Actual data :-) */
-	WORD csum;		/* C-SUM */
+	u16 csum;		/* C-SUM */
 };
 #endif
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/port.h linux-2.6.16-rc3/drivers/char/rio/port.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/port.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/port.h	2006-02-14 19:03:04.367224064 +0000
@@ -33,91 +33,37 @@
 #ifndef	__rio_port_h__
 #define	__rio_port_h__
 
-#ifdef SCCS_LABELS
-static char *_port_h_sccs_ = "@(#)port.h	1.3";
-#endif
-
-
-#undef VPIX
-
-
-/*
-** the port data structure - one per port in the system
-*/
-
-#ifdef STATS
-struct RIOStats {
-	/*
-	 ** interrupt statistics
-	 */
-	uint BreakIntCnt;
-	uint ModemOffCnt;
-	uint ModemOnCnt;
-	uint RxIntCnt;
-	uint TxIntCnt;
-	/*
-	 ** throughput statistics
-	 */
-	uint RxCharCnt;
-	uint RxPktCnt;
-	uint RxSaveCnt;
-	uint TxCharCnt;
-	uint TxPktCnt;
-	/*
-	 ** driver entry statistics
-	 */
-	uint CloseCnt;
-	uint IoctlCnt;
-	uint OpenCnt;
-	uint ReadCnt;
-	uint WriteCnt;
-	/*
-	 ** proc statistics
-	 */
-	uint BlockCnt;
-	uint OutputCnt;
-	uint ResumeCnt;
-	uint RflushCnt;
-	uint SuspendCnt;
-	uint TbreakCnt;
-	uint TimeoutCnt;
-	uint UnblockCnt;
-	uint WflushCnt;
-	uint WFBodgeCnt;
-};
-#endif
-
 /*
 **	Port data structure
 */
 struct Port {
 	struct gs_port gs;
-	int PortNum;		/* RIO port no., 0-511 */
+	int PortNum;			/* RIO port no., 0-511 */
 	struct Host *HostP;
 	volatile caddr_t Caddr;
-	ushort HostPort;	/* Port number on host card */
-	uchar RupNum;		/* Number of RUP for port */
-	uchar ID2;		/* Second ID of RTA for port */
-	ulong State;		/* FLAGS for open & xopen */
-#define	RIO_LOPEN	0x00001	/* Local open */
-#define	RIO_MOPEN	0x00002	/* Modem open */
-#define	RIO_WOPEN	0x00004	/* Waiting for open */
-#define	RIO_CLOSING	0x00008	/* The port is being close */
-#define	RIO_XPBUSY	0x00010	/* Transparent printer busy */
-#define	RIO_BREAKING	0x00020	/* Break in progress */
-#define	RIO_DIRECT	0x00040	/* Doing Direct output */
-#define	RIO_EXCLUSIVE	0x00080	/* Stream open for exclusive use */
-#define	RIO_NDELAY	0x00100	/* Stream is open FNDELAY */
-#define	RIO_CARR_ON	0x00200	/* Stream has carrier present */
-#define	RIO_XPWANTR	0x00400	/* Stream wanted by Xprint */
-#define	RIO_RBLK	0x00800	/* Stream is read-blocked */
-#define	RIO_BUSY	0x01000	/* Stream is BUSY for write */
-#define	RIO_TIMEOUT	0x02000	/* Stream timeout in progress */
-#define	RIO_TXSTOP	0x04000	/* Stream output is stopped */
-#define	RIO_WAITFLUSH	0x08000	/* Stream waiting for flush */
-#define	RIO_DYNOROD	0x10000	/* Drain failed */
-#define	RIO_DELETED	0x20000	/* RTA has been deleted */
-#define RIO_ISSCANCODE	0x40000	/* This line is in scancode mode */
+	unsigned short HostPort;	/* Port number on host card */
+	unsigned char RupNum;		/* Number of RUP for port */
+	unsigned char ID2;		/* Second ID of RTA for port */
+	unsigned long State;		/* FLAGS for open & xopen */
+#define	RIO_LOPEN	0x00001		/* Local open */
+#define	RIO_MOPEN	0x00002		/* Modem open */
+#define	RIO_WOPEN	0x00004		/* Waiting for open */
+#define	RIO_CLOSING	0x00008		/* The port is being close */
+#define	RIO_XPBUSY	0x00010		/* Transparent printer busy */
+#define	RIO_BREAKING	0x00020		/* Break in progress */
+#define	RIO_DIRECT	0x00040		/* Doing Direct output */
+#define	RIO_EXCLUSIVE	0x00080		/* Stream open for exclusive use */
+#define	RIO_NDELAY	0x00100		/* Stream is open FNDELAY */
+#define	RIO_CARR_ON	0x00200		/* Stream has carrier present */
+#define	RIO_XPWANTR	0x00400		/* Stream wanted by Xprint */
+#define	RIO_RBLK	0x00800		/* Stream is read-blocked */
+#define	RIO_BUSY	0x01000		/* Stream is BUSY for write */
+#define	RIO_TIMEOUT	0x02000		/* Stream timeout in progress */
+#define	RIO_TXSTOP	0x04000		/* Stream output is stopped */
+#define	RIO_WAITFLUSH	0x08000		/* Stream waiting for flush */
+#define	RIO_DYNOROD	0x10000		/* Drain failed */
+#define	RIO_DELETED	0x20000		/* RTA has been deleted */
+#define RIO_ISSCANCODE	0x40000		/* This line is in scancode mode */
 #define	RIO_USING_EUC	0x100000	/* Using extended Unix chars */
 #define	RIO_CAN_COOK	0x200000	/* This line can do cooking */
 #define RIO_TRIAD_MODE  0x400000	/* Enable TRIAD special ops. */
@@ -125,15 +71,15 @@
 #define RIO_TRIAD_FUNC  0x1000000	/* Seen a function key coming in */
 #define RIO_THROTTLE_RX 0x2000000	/* RX needs to be throttled. */
 
-	ulong Config;		/* FLAGS for NOREAD.... */
-#define	RIO_NOREAD	0x0001	/* Are not allowed to read port */
-#define	RIO_NOWRITE	0x0002	/* Are not allowed to write port */
-#define	RIO_NOXPRINT	0x0004	/* Are not allowed to xprint port */
-#define	RIO_NOMASK	0x0007	/* All not allowed things */
-#define RIO_IXANY	0x0008	/* Port is allowed ixany */
-#define	RIO_MODEM	0x0010	/* Stream is a modem device */
-#define	RIO_IXON	0x0020	/* Port is allowed ixon */
-#define RIO_WAITDRAIN	0x0040	/* Wait for port to completely drain */
+	unsigned long Config;		/* FLAGS for NOREAD.... */
+#define	RIO_NOREAD	0x0001		/* Are not allowed to read port */
+#define	RIO_NOWRITE	0x0002		/* Are not allowed to write port */
+#define	RIO_NOXPRINT	0x0004		/* Are not allowed to xprint port */
+#define	RIO_NOMASK	0x0007		/* All not allowed things */
+#define RIO_IXANY	0x0008		/* Port is allowed ixany */
+#define	RIO_MODEM	0x0010		/* Stream is a modem device */
+#define	RIO_IXON	0x0020		/* Port is allowed ixon */
+#define RIO_WAITDRAIN	0x0040		/* Wait for port to completely drain */
 #define RIO_MAP_50_TO_50	0x0080	/* Map 50 baud to 50 baud */
 #define RIO_MAP_110_TO_110	0x0100	/* Map 110 baud to 110 baud */
 
@@ -142,36 +88,36 @@
 ** As LynxOS does not appear to support Hardware Flow Control .....
 ** Define our own flow control flags in 'Config'.
 */
-#define RIO_CTSFLOW	0x0200	/* RIO's own CTSFLOW flag */
-#define RIO_RTSFLOW	0x0400	/* RIO's own RTSFLOW flag */
+#define RIO_CTSFLOW	0x0200		/* RIO's own CTSFLOW flag */
+#define RIO_RTSFLOW	0x0400		/* RIO's own RTSFLOW flag */
 
 
-	struct PHB *PhbP;	/* pointer to PHB for port */
-	WORD *TxAdd;		/* Add packets here */
-	WORD *TxStart;		/* Start of add array */
-	WORD *TxEnd;		/* End of add array */
-	WORD *RxRemove;		/* Remove packets here */
-	WORD *RxStart;		/* Start of remove array */
-	WORD *RxEnd;		/* End of remove array */
-	uint RtaUniqueNum;	/* Unique number of RTA */
-	ushort PortState;	/* status of port */
-	ushort ModemState;	/* status of modem lines */
-	ulong ModemLines;	/* Modem bits sent to RTA */
-	uchar CookMode;		/* who expands CR/LF? */
-	uchar ParamSem;		/* Prevent write during param */
-	uchar Mapped;		/* if port mapped onto host */
-	uchar SecondBlock;	/* if port belongs to 2nd block
-				   of 16 port RTA */
-	uchar InUse;		/* how many pre-emptive cmds */
-	uchar Lock;		/* if params locked */
-	uchar Store;		/* if params stored across closes */
-	uchar FirstOpen;	/* TRUE if first time port opened */
-	uchar FlushCmdBodge;	/* if doing a (non)flush */
-	uchar MagicFlags;	/* require intr processing */
-#define	MAGIC_FLUSH	0x01	/* mirror of WflushFlag */
-#define	MAGIC_REBOOT	0x02	/* RTA re-booted, re-open ports */
-#define	MORE_OUTPUT_EYGOR 0x04	/* riotproc failed to empty clists */
-	uchar WflushFlag;	/* 1 How many WFLUSHs active */
+	struct PHB *PhbP;		/* pointer to PHB for port */
+	u16 *TxAdd;			/* Add packets here */
+	u16 *TxStart;			/* Start of add array */
+	u16 *TxEnd;			/* End of add array */
+	u16 *RxRemove;			/* Remove packets here */
+	u16 *RxStart;			/* Start of remove array */
+	u16 *RxEnd;			/* End of remove array */
+	unsigned int RtaUniqueNum;	/* Unique number of RTA */
+	unsigned short PortState;	/* status of port */
+	unsigned short ModemState;	/* status of modem lines */
+	unsigned long ModemLines;	/* Modem bits sent to RTA */
+	unsigned char CookMode;		/* who expands CR/LF? */
+	unsigned char ParamSem;		/* Prevent write during param */
+	unsigned char Mapped;		/* if port mapped onto host */
+	unsigned char SecondBlock;	/* if port belongs to 2nd block
+				   		of 16 port RTA */
+	unsigned char InUse;		/* how many pre-emptive cmds */
+	unsigned char Lock;		/* if params locked */
+	unsigned char Store;		/* if params stored across closes */
+	unsigned char FirstOpen;	/* TRUE if first time port opened */
+	unsigned char FlushCmdBodge;	/* if doing a (non)flush */
+	unsigned char MagicFlags;	/* require intr processing */
+#define	MAGIC_FLUSH	0x01		/* mirror of WflushFlag */
+#define	MAGIC_REBOOT	0x02		/* RTA re-booted, re-open ports */
+#define	MORE_OUTPUT_EYGOR 0x04		/* riotproc failed to empty clists */
+	unsigned char WflushFlag;	/* 1 How many WFLUSHs active */
 /*
 ** Transparent print stuff
 */
@@ -179,63 +125,55 @@
 #ifndef MAX_XP_CTRL_LEN
 #define MAX_XP_CTRL_LEN		16	/* ALSO IN DAEMON.H */
 #endif
-		uint XpCps;
+		unsigned int XpCps;
 		char XpOn[MAX_XP_CTRL_LEN];
 		char XpOff[MAX_XP_CTRL_LEN];
-		ushort XpLen;	/* strlen(XpOn)+strlen(XpOff) */
-		uchar XpActive;
-		uchar XpLastTickOk;	/* TRUE if we can process */
+		unsigned short XpLen;	/* strlen(XpOn)+strlen(XpOff) */
+		unsigned char XpActive;
+		unsigned char XpLastTickOk;	/* TRUE if we can process */
 #define	XP_OPEN		00001
 #define	XP_RUNABLE	00002
 		struct ttystatics *XttyP;
 	} Xprint;
-#ifdef VPIX
-	v86_t *StashP;
-	uint IntMask;
-	struct termss VpixSs;
-	uchar ModemStatusReg;	/* Modem status register */
-#endif
-	uchar RxDataStart;
-	uchar Cor2Copy;		/* copy of COR2 */
-	char *Name;		/* points to the Rta's name */
-#ifdef STATS
-	struct RIOStats Stat;	/* ports statistics */
-#endif
+	unsigned char RxDataStart;
+	unsigned char Cor2Copy;		/* copy of COR2 */
+	char *Name;			/* points to the Rta's name */
 	char *TxRingBuffer;
-	ushort TxBufferIn;	/* New data arrives here */
-	ushort TxBufferOut;	/* Intr removes data here */
-	ushort OldTxBufferOut;	/* Indicates if draining */
-	int TimeoutId;		/* Timeout ID */
-	uint Debug;
-	uchar WaitUntilBooted;	/* True if open should block */
-	uint statsGather;	/* True if gathering stats */
-	ulong txchars;		/* Chars transmitted */
-	ulong rxchars;		/* Chars received */
-	ulong opens;		/* port open count */
-	ulong closes;		/* port close count */
-	ulong ioctls;		/* ioctl count */
-	uchar LastRxTgl;	/* Last state of rx toggle bit */
-	spinlock_t portSem;	/* Lock using this sem */
-	int MonitorTstate;	/* Monitoring ? */
-	int timeout_id;		/* For calling 100 ms delays */
-	int timeout_sem;	/* For calling 100 ms delays */
-	int firstOpen;		/* First time open ? */
-	char *p;		/* save the global struc here .. */
+	unsigned short TxBufferIn;	/* New data arrives here */
+	unsigned short TxBufferOut;	/* Intr removes data here */
+	unsigned short OldTxBufferOut;	/* Indicates if draining */
+	int TimeoutId;			/* Timeout ID */
+	unsigned int Debug;
+	unsigned char WaitUntilBooted;	/* True if open should block */
+	unsigned int statsGather;	/* True if gathering stats */
+	unsigned long txchars;		/* Chars transmitted */
+	unsigned long rxchars;		/* Chars received */
+	unsigned long opens;		/* port open count */
+	unsigned long closes;		/* port close count */
+	unsigned long ioctls;		/* ioctl count */
+	unsigned char LastRxTgl;	/* Last state of rx toggle bit */
+	spinlock_t portSem;		/* Lock using this sem */
+	int MonitorTstate;		/* Monitoring ? */
+	int timeout_id;			/* For calling 100 ms delays */
+	int timeout_sem;		/* For calling 100 ms delays */
+	int firstOpen;			/* First time open ? */
+	char *p;			/* save the global struc here .. */
 };
 
 struct ModuleInfo {
 	char *Name;
-	uint Flags[4];		/* one per port on a module */
+	unsigned int Flags[4];		/* one per port on a module */
 };
-#endif
 
 /*
 ** This struct is required because trying to grab an entire Port structure
 ** runs into problems with differing struct sizes between driver and config.
 */
 struct PortParams {
-	uint Port;
-	ulong Config;
-	ulong State;
+	unsigned int Port;
+	unsigned long Config;
+	unsigned long State;
 	struct ttystatics *TtyP;
 };
+
+#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/phb.h linux-2.6.16-rc3/drivers/char/rio/phb.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/phb.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/phb.h	2006-02-14 19:15:54.274180416 +0000
@@ -37,13 +37,6 @@
 #ifndef _phb_h
 #define _phb_h 1
 
-#ifdef SCCS_LABELS
-#ifndef lint
-/* static char *_rio_phb_h_sccs = "@(#)phb.h	1.12"; */
-#endif
-#endif
-
-
 /*************************************************
  * Handshake asserted. Deasserted by the LTT(s)
  ************************************************/
@@ -126,21 +119,21 @@
  *************************************************************************/
 typedef struct PHB PHB;
 struct PHB {
-	WORD source;
-	WORD handshake;
-	WORD status;
-	NUMBER timeout;		/* Maximum of 1.9 seconds */
-	WORD link;		/* Send down this link */
-	WORD destination;
-	PKT_ptr_ptr tx_start;
-	PKT_ptr_ptr tx_end;
-	PKT_ptr_ptr tx_add;
-	PKT_ptr_ptr tx_remove;
-
-	PKT_ptr_ptr rx_start;
-	PKT_ptr_ptr rx_end;
-	PKT_ptr_ptr rx_add;
-	PKT_ptr_ptr rx_remove;
+	u8 source;
+	u8 handshake;
+	u8 status;
+	u16 timeout;		/* Maximum of 1.9 seconds */
+	u8 link;		/* Send down this link */
+	u8 destination;
+	u16 tx_start;
+	u16 tx_end;
+	u16 tx_add;
+	u16 tx_remove;
+
+	u16 rx_start;
+	u16 rx_end;
+	u16 rx_add;
+	u16 rx_remove;
 
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/riotypes.h linux-2.6.16-rc3/drivers/char/rio/riotypes.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/riotypes.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/riotypes.h	2006-02-14 19:16:06.658297744 +0000
@@ -43,25 +43,21 @@
 #endif
 #endif
 
-typedef unsigned short NUMBER_ptr;
-typedef unsigned short WORD_ptr;
-typedef unsigned short BYTE_ptr;
-typedef unsigned short char_ptr;
-typedef unsigned short Channel_ptr;
-typedef unsigned short FREE_LIST_ptr_ptr;
-typedef unsigned short FREE_LIST_ptr;
-typedef unsigned short LPB_ptr;
-typedef unsigned short Process_ptr;
-typedef unsigned short PHB_ptr;
-typedef unsigned short PKT_ptr;
-typedef unsigned short PKT_ptr_ptr;
-typedef unsigned short Q_BUF_ptr;
-typedef unsigned short Q_BUF_ptr_ptr;
-typedef unsigned short ROUTE_STR_ptr;
-typedef unsigned short RUP_ptr;
-typedef unsigned short short_ptr;
-typedef unsigned short u_short_ptr;
-typedef unsigned short ushort_ptr;
+typedef u16 char_ptr;
+typedef u16 Channel_ptr;
+typedef u16 FREE_LIST_ptr_ptr;
+typedef u16 FREE_LIST_ptr;
+typedef u16 LPB_ptr;
+typedef u16 Process_ptr;
+typedef u16 PHB_ptr;
+typedef u16 PKT_ptr;
+typedef u16 Q_BUF_ptr;
+typedef u16 Q_BUF_ptr_ptr;
+typedef u16 ROUTE_STR_ptr;
+typedef u16 RUP_ptr;
+typedef u16 short_ptr;
+typedef u16 u_short_ptr;
+typedef u16 ushort_ptr;
 
 #endif				/* __riotypes__ */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/rup.h linux-2.6.16-rc3/drivers/char/rio/rup.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/rup.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/rup.h	2006-02-14 18:49:31.441807512 +0000
@@ -37,14 +37,7 @@
 #ifndef _rup_h
 #define _rup_h 1
 
-#ifdef SCCS_LABELS
-#ifndef lint
-/* static char *_rio_rup_h_sccs = "@(#)rup.h	1.5"; */
-#endif
-#endif
-
 #define MAX_RUP          ((short) 16)
-
 #define PKTS_PER_RUP     ((short) 2)	/* They are always used in pairs */
 
 /*************************************************
@@ -62,13 +55,13 @@
 struct RUP {
 	PKT_ptr txpkt;		/* Outgoing packet */
 	PKT_ptr rxpkt;		/* Incoming packet */
-	WORD link;		/* Which link to send down? */
-	BYTE rup_dest_unit[2];	/* Destination unit */
-	WORD handshake;		/* For handshaking */
-	WORD timeout;		/* Timeout */
-	WORD status;		/* Status */
-	WORD txcontrol;		/* Transmit control */
-	WORD rxcontrol;		/* Receive control */
+	u16 link;		/* Which link to send down? */
+	u8 rup_dest_unit[2];	/* Destination unit */
+	u16 handshake;		/* For handshaking */
+	u16 timeout;		/* Timeout */
+	u16 status;		/* Status */
+	u16 txcontrol;		/* Transmit control */
+	u16 rxcontrol;		/* Receive control */
 };
 
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc3/drivers/char/rio/typdef.h linux-2.6.16-rc3/drivers/char/rio/typdef.h
--- linux.vanilla-2.6.16-rc3/drivers/char/rio/typdef.h	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/typdef.h	2006-02-14 19:04:26.121795480 +0000
@@ -33,23 +33,16 @@
 #ifndef __rio_typdef_h__
 #define __rio_typdef_h__
 
-#ifdef SCCS_LABELS
-static char *_typdef_h_sccs_ = "@(#)typdef.h	1.2";
-#endif
-
-#undef VPIX
-
 /*
 ** IT IS REALLY, REALLY, IMPORTANT THAT BYTES ARE UNSIGNED!
 **
 ** These types are ONLY to be used for refering to data structures
 ** on the RIO Host card!
 */
-typedef volatile unsigned char BYTE;
-typedef volatile unsigned short WORD;
-typedef volatile unsigned int DWORD;
-typedef volatile unsigned short RIOP;
-typedef volatile short NUMBER;
+typedef volatile u8 BYTE;
+typedef volatile u16 WORD;
+typedef volatile u32 DWORD;
+typedef volatile u16 RIOP;
 
 
 /*

