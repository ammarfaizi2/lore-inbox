Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWEJDEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWEJDEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWEJC4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:34 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:55613 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932429AbWEJC4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:25 -0400
Date: Tue, 9 May 2006 19:56:08 -0700
Message-Id: <200605100256.k4A2u89t031791@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] wireless tiacx gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes warnings like the following,

drivers/net/wireless/tiacx/acx_struct.h:1878: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1884: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1885: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1886: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1887: warning: 'packed' attribute ignored for field of type 'u8[28u]'
drivers/net/wireless/tiacx/acx_struct.h:1891: warning: 'packed' attribute ignored for field of type 'u8[5u]'
drivers/net/wireless/tiacx/acx_struct.h:1894: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1895: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1896: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1897: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1898: warning: 'packed' attribute ignored for field of type 'u8[5u]'
drivers/net/wireless/tiacx/acx_struct.h:1899: warning: 'packed' attribute ignored for field of type 'u8[31u]'
drivers/net/wireless/tiacx/acx_struct.h:1905: warning: 'packed' attribute ignored for field of type 'u8'
drivers/net/wireless/tiacx/acx_struct.h:1909: warning: 'packed' attribute ignored for field of type 'u8[5u]'
drivers/net/wireless/tiacx/acx_struct.h:1912: warning: 'packed' attribute ignored for field of type 'u8[28u]'

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/net/wireless/tiacx/acx_struct.h
===================================================================
--- linux-2.6.16.orig/drivers/net/wireless/tiacx/acx_struct.h
+++ linux-2.6.16/drivers/net/wireless/tiacx/acx_struct.h
@@ -474,8 +474,8 @@ DEF_IE(111_IE_DOT11_INVAL_1013,			0x1013
  * --vda
  */
 typedef struct phy_hdr {
-	u8	unknown[4] ACX_PACKED;
-	u8	acx111_unknown[4] ACX_PACKED;
+	u8	unknown[4];
+	u8	acx111_unknown[4];
 } phy_hdr_t;
 
 /* seems to be a bit similar to hfa384x_rx_frame.
@@ -537,19 +537,19 @@ time: 4 bytes:
 
 typedef struct rxbuffer {
 	u16	mac_cnt_rcvd ACX_PACKED;	/* only 12 bits are len! (0xfff) */
-	u8	mac_cnt_mblks ACX_PACKED;
-	u8	mac_status ACX_PACKED;
-	u8	phy_stat_baseband ACX_PACKED;	/* bit 0x80: used LNA (Low-Noise Amplifier) */
-	u8	phy_plcp_signal ACX_PACKED;
-	u8	phy_level ACX_PACKED;		/* PHY stat */
-	u8	phy_snr ACX_PACKED;		/* PHY stat */
+	u8	mac_cnt_mblks;
+	u8	mac_status;
+	u8	phy_stat_baseband;	/* bit 0x80: used LNA (Low-Noise Amplifier) */
+	u8	phy_plcp_signal;
+	u8	phy_level;		/* PHY stat */
+	u8	phy_snr;		/* PHY stat */
 	u32	time ACX_PACKED;		/* timestamp upon MAC rcv first byte */
 /* 4-byte (acx100) or 8-byte (acx111) phy header will be here
 ** if RX_CFG1_INCLUDE_PHY_HDR is in effect:
 **	phy_hdr_t phy			*/
-	wlan_hdr_a3_t hdr_a3 ACX_PACKED;
+	wlan_hdr_a3_t hdr_a3; 
 	/* maximally sized data part of wlan packet */
-	u8	data_a3[WLAN_A4FR_MAXLEN_WEP_FCS - WLAN_HDR_A3_LEN] ACX_PACKED;
+	u8	data_a3[WLAN_A4FR_MAXLEN_WEP_FCS - WLAN_HDR_A3_LEN];
 	/* can add hdr/data_a4 if needed */
 } rxbuffer_t;
 
@@ -601,7 +601,7 @@ typedef struct fw_stats {
 typedef struct fw_ver {
 	u16	cmd ACX_PACKED;
 	u16	size ACX_PACKED;
-	char	fw_id[20] ACX_PACKED;
+	char	fw_id[20];
 	u32	hw_id ACX_PACKED;
 } fw_ver_t;
 
@@ -800,9 +800,9 @@ typedef struct {
 /* Outside of "#ifdef PCI" because USB needs to know sizeof()
 ** of txdesc and rxdesc: */
 struct txdesc {
-	acx_ptr	pNextDesc ACX_PACKED;	/* pointer to next txdesc */
-	acx_ptr	HostMemPtr ACX_PACKED;			/* 0x04 */
-	acx_ptr	AcxMemPtr ACX_PACKED;			/* 0x08 */
+	acx_ptr	pNextDesc;	/* pointer to next txdesc */
+	acx_ptr	HostMemPtr;			/* 0x04 */
+	acx_ptr	AcxMemPtr;			/* 0x08 */
 	u32	tx_time ACX_PACKED;			/* 0x0c */
 	u16	total_length ACX_PACKED;		/* 0x10 */
 	u16	Reserved ACX_PACKED;			/* 0x12 */
@@ -812,44 +812,44 @@ struct txdesc {
 ** for driver use. amd64 blew up. We dare not use it now */
 	u32	dummy[4] ACX_PACKED;
 
-	u8	Ctl_8 ACX_PACKED;			/* 0x24, 8bit value */
-	u8	Ctl2_8 ACX_PACKED;			/* 0x25, 8bit value */
-	u8	error ACX_PACKED;			/* 0x26 */
-	u8	ack_failures ACX_PACKED;		/* 0x27 */
-	u8	rts_failures ACX_PACKED;		/* 0x28 */
-	u8	rts_ok ACX_PACKED;			/* 0x29 */
+	u8	Ctl_8;			/* 0x24, 8bit value */
+	u8	Ctl2_8;			/* 0x25, 8bit value */
+	u8	error;			/* 0x26 */
+	u8	ack_failures;		/* 0x27 */
+	u8	rts_failures;		/* 0x28 */
+	u8	rts_ok;			/* 0x29 */
 	union {
-		struct {
-			u8	rate ACX_PACKED;	/* 0x2a */
-			u8	queue_ctrl ACX_PACKED;	/* 0x2b */
-		} r1 ACX_PACKED;
+		struct ACX_PACKED {
+			u8	rate;	/* 0x2a */
+			u8	queue_ctrl;	/* 0x2b */
+		} r1;
 		struct {
 			u16	rate111 ACX_PACKED;	/* 0x2a */
-		} r2 ACX_PACKED;
-	} u ACX_PACKED;
+		} r2;
+	} u;
 	u32	queue_info ACX_PACKED;			/* 0x2c (acx100, reserved on acx111) */
 };		/* size : 48 = 0x30 */
 /* NB: acx111 txdesc structure is 4 byte larger */
 /* All these 4 extra bytes are reserved. tx alloc code takes them into account */
 
 struct rxdesc {
-	acx_ptr	pNextDesc ACX_PACKED;			/* 0x00 */
-	acx_ptr	HostMemPtr ACX_PACKED;			/* 0x04 */
-	acx_ptr	ACXMemPtr ACX_PACKED;			/* 0x08 */
+	acx_ptr	pNextDesc;			/* 0x00 */
+	acx_ptr	HostMemPtr;			/* 0x04 */
+	acx_ptr	ACXMemPtr;			/* 0x08 */
 	u32	rx_time ACX_PACKED;			/* 0x0c */
 	u16	total_length ACX_PACKED;		/* 0x10 */
 	u16	WEP_length ACX_PACKED;			/* 0x12 */
 	u32	WEP_ofs ACX_PACKED;			/* 0x14 */
 
 /* the following 16 bytes do not change when acx100 owns the descriptor */
-	u8	driverWorkspace[16] ACX_PACKED;		/* 0x18 */
+	u8	driverWorkspace[16];		/* 0x18 */
 
-	u8	Ctl_8 ACX_PACKED;
-	u8	rate ACX_PACKED;
-	u8	error ACX_PACKED;
-	u8	SNR ACX_PACKED;				/* Signal-to-Noise Ratio */
-	u8	RxLevel ACX_PACKED;
-	u8	queue_ctrl ACX_PACKED;
+	u8	Ctl_8;
+	u8	rate;
+	u8	error;
+	u8	SNR;				/* Signal-to-Noise Ratio */
+	u8	RxLevel;
+	u8	queue_ctrl;
 	u16	unknown ACX_PACKED;
 	u32	unknown2 ACX_PACKED;
 };		/* size 52 = 0x34 */
@@ -921,26 +921,26 @@ enum {
 #define INT_TRIG_CMD		0x01
 
 struct txhostdesc {
-	acx_ptr	data_phy ACX_PACKED;			/* 0x00 [u8 *] */
+	acx_ptr	data_phy;				/* 0x00 [u8 *] */
 	u16	data_offset ACX_PACKED;			/* 0x04 */
 	u16	reserved ACX_PACKED;			/* 0x06 */
 	u16	Ctl_16 ACX_PACKED;	/* 16bit value, endianness!! */
 	u16	length ACX_PACKED;			/* 0x0a */
-	acx_ptr	desc_phy_next ACX_PACKED;		/* 0x0c [txhostdesc *] */
-	acx_ptr	pNext ACX_PACKED;			/* 0x10 [txhostdesc *] */
+	acx_ptr	desc_phy_next;				/* 0x0c [txhostdesc *] */
+	acx_ptr	pNext;					/* 0x10 [txhostdesc *] */
 	u32	Status ACX_PACKED;			/* 0x14, unused on Tx */
 /* From here on you can use this area as you want (variable length, too!) */
 	u8	*data ACX_PACKED;
 };
 
 struct rxhostdesc {
-	acx_ptr	data_phy ACX_PACKED;			/* 0x00 [rxbuffer_t *] */
+	acx_ptr	data_phy;				/* 0x00 [rxbuffer_t *] */
 	u16	data_offset ACX_PACKED;			/* 0x04 */
 	u16	reserved ACX_PACKED;			/* 0x06 */
 	u16	Ctl_16 ACX_PACKED;			/* 0x08; 16bit value, endianness!! */
 	u16	length ACX_PACKED;			/* 0x0a */
-	acx_ptr	desc_phy_next ACX_PACKED;		/* 0x0c [rxhostdesc_t *] */
-	acx_ptr	pNext ACX_PACKED;			/* 0x10 [rxhostdesc_t *] */
+	acx_ptr	desc_phy_next;				/* 0x0c [rxhostdesc_t *] */
+	acx_ptr	pNext;					/* 0x10 [rxhostdesc_t *] */
 	u32	Status ACX_PACKED;			/* 0x14 */
 /* From here on you can use this area as you want (variable length, too!) */
 	rxbuffer_t *data ACX_PACKED;
@@ -960,27 +960,27 @@ struct rxhostdesc {
 typedef struct usb_txbuffer {
 	u16	desc ACX_PACKED;
 	u16	mpdu_len ACX_PACKED;
-	u8	queue_index ACX_PACKED;
-	u8	rate ACX_PACKED;
+	u8	queue_index;
+	u8	rate;
 	u32	hostdata ACX_PACKED;
-	u8	ctrl1 ACX_PACKED;
-	u8	ctrl2 ACX_PACKED;
+	u8	ctrl1;
+	u8	ctrl2;
 	u16	data_len ACX_PACKED;
 	/* wlan packet content is placed here: */
-	u8	data[WLAN_A4FR_MAXLEN_WEP_FCS] ACX_PACKED;
+	u8	data[WLAN_A4FR_MAXLEN_WEP_FCS];
 } usb_txbuffer_t;
 
 /* USB returns either rx packets (see rxbuffer) or
 ** these "tx status" structs: */
 typedef struct usb_txstatus {
 	u16	mac_cnt_rcvd ACX_PACKED;	/* only 12 bits are len! (0xfff) */
-	u8	queue_index ACX_PACKED;
-	u8	mac_status ACX_PACKED;		/* seen 0x20 on tx failure */
+	u8	queue_index;
+	u8	mac_status;		/* seen 0x20 on tx failure */
 	u32	hostdata ACX_PACKED;
-	u8	rate ACX_PACKED;
-	u8	ack_failures ACX_PACKED;
-	u8	rts_failures ACX_PACKED;
-	u8	rts_ok ACX_PACKED;
+	u8	rate;
+	u8	ack_failures;
+	u8	rts_failures;
+	u8	rts_ok;
 } usb_txstatus_t;
 
 typedef struct usb_tx {
@@ -1012,69 +1012,69 @@ typedef struct usb_rx {
 /* Config Option structs */
 
 typedef struct co_antennas {
-	u8	type ACX_PACKED;
-	u8	len ACX_PACKED;
-	u8	list[2] ACX_PACKED;
+	u8	type;
+	u8	len;
+	u8	list[2];
 } co_antennas_t;
 
 typedef struct co_powerlevels {
-	u8	type ACX_PACKED;
-	u8	len ACX_PACKED;
+	u8	type;
+	u8	len;
 	u16	list[8] ACX_PACKED;
 } co_powerlevels_t;
 
 typedef struct co_datarates {
-	u8	type ACX_PACKED;
-	u8	len ACX_PACKED;
-	u8	list[8] ACX_PACKED;
+	u8	type;
+	u8	len;
+	u8	list[8];
 } co_datarates_t;
 
 typedef struct co_domains {
-	u8	type ACX_PACKED;
-	u8	len ACX_PACKED;
-	u8	list[6] ACX_PACKED;
+	u8	type;
+	u8	len;
+	u8	list[6];
 } co_domains_t;
 
 typedef struct co_product_id {
-	u8	type ACX_PACKED;
-	u8	len ACX_PACKED;
-	u8	list[128] ACX_PACKED;
+	u8	type;
+	u8	len;
+	u8	list[128];
 } co_product_id_t;
 
 typedef struct co_manuf_id {
-	u8	type ACX_PACKED;
-	u8	len ACX_PACKED;
-	u8	list[128] ACX_PACKED;
+	u8	type;
+	u8	len;
+	u8	list[128];
 } co_manuf_t;
 
 typedef struct co_fixed {
-	char	NVSv[8] ACX_PACKED;
+	char	NVSv[8];
 /*	u16	NVS_vendor_offs;	ACX111-only */
 /*	u16	unknown;		ACX111-only */
-	u8	MAC[6] ACX_PACKED;	/* ACX100-only */
+	u8	MAC[6];	/* ACX100-only */
 	u16	probe_delay ACX_PACKED;	/* ACX100-only */
 	u32	eof_memory ACX_PACKED;
-	u8	dot11CCAModes ACX_PACKED;
-	u8	dot11Diversity ACX_PACKED;
-	u8	dot11ShortPreambleOption ACX_PACKED;
-	u8	dot11PBCCOption ACX_PACKED;
-	u8	dot11ChannelAgility ACX_PACKED;
-	u8	dot11PhyType ACX_PACKED; /* FIXME: does 802.11 call it "dot11PHYType"? */
-	u8	dot11TempType ACX_PACKED;
-	u8	table_count ACX_PACKED;
+	u8	dot11CCAModes;
+	u8	dot11Diversity;
+	u8	dot11ShortPreambleOption;
+	u8	dot11PBCCOption;
+	u8	dot11ChannelAgility;
+	u8	dot11PhyType; /* FIXME: does 802.11 call it "dot11PHYType"? */
+	u8	dot11TempType;
+	u8	table_count;
 } co_fixed_t;
 
 typedef struct acx111_ie_configoption {
 	u16			type ACX_PACKED;
 	u16			len ACX_PACKED;
 /* Do not access below members directly, they are in fact variable length */
-	co_fixed_t		fixed ACX_PACKED;
-	co_antennas_t		antennas ACX_PACKED;
-	co_powerlevels_t	power_levels ACX_PACKED;
-	co_datarates_t		data_rates ACX_PACKED;
-	co_domains_t		domains ACX_PACKED;
-	co_product_id_t		product_id ACX_PACKED;
-	co_manuf_t		manufacturer ACX_PACKED;
+	co_fixed_t		fixed; 
+	co_antennas_t		antennas;
+	co_powerlevels_t	power_levels;
+	co_datarates_t		data_rates;
+	co_domains_t		domains;
+	co_product_id_t		product_id;
+	co_manuf_t		manufacturer;
 	u8			_padding[4];
 } acx111_ie_configoption_t;
 
@@ -1522,15 +1522,15 @@ typedef struct acx100_ie_queueconfig {
 	u16	len ACX_PACKED;
 	u32	AreaSize ACX_PACKED;
 	u32	RxQueueStart ACX_PACKED;
-	u8	QueueOptions ACX_PACKED;
-	u8	NumTxQueues ACX_PACKED;
-	u8	NumRxDesc ACX_PACKED;	 /* for USB only */
-	u8	pad1 ACX_PACKED;
+	u8	QueueOptions;
+	u8	NumTxQueues;
+	u8	NumRxDesc;	 /* for USB only */
+	u8	pad1;
 	u32	QueueEnd ACX_PACKED;
 	u32	HostQueueEnd ACX_PACKED; /* QueueEnd2 */
 	u32	TxQueueStart ACX_PACKED;
-	u8	TxQueuePri ACX_PACKED;
-	u8	NumTxDesc ACX_PACKED;
+	u8	TxQueuePri;
+	u8	NumTxDesc;
 	u16	pad2 ACX_PACKED;
 } acx100_ie_queueconfig_t;
 
@@ -1542,16 +1542,16 @@ typedef struct acx111_ie_queueconfig {
 	u32	rx1_queue_address ACX_PACKED;
 	u32	reserved1 ACX_PACKED;
 	u32	tx1_queue_address ACX_PACKED;
-	u8	tx1_attributes ACX_PACKED;
+	u8	tx1_attributes;
 	u16	reserved2 ACX_PACKED;
-	u8	reserved3 ACX_PACKED;
+	u8	reserved3;
 } acx111_ie_queueconfig_t;
 
 typedef struct acx100_ie_memconfigoption {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
 	u32	DMA_config ACX_PACKED;
-	acx_ptr	pRxHostDesc ACX_PACKED;
+	acx_ptr	pRxHostDesc;
 	u32	rx_mem ACX_PACKED;
 	u32	tx_mem ACX_PACKED;
 	u16	RxBlockNum ACX_PACKED;
@@ -1563,27 +1563,27 @@ typedef struct acx111_ie_memoryconfig {
 	u16	len ACX_PACKED;
 	u16	no_of_stations ACX_PACKED;
 	u16	memory_block_size ACX_PACKED;
-	u8	tx_rx_memory_block_allocation ACX_PACKED;
-	u8	count_rx_queues ACX_PACKED;
-	u8	count_tx_queues ACX_PACKED;
-	u8	options ACX_PACKED;
-	u8	fragmentation ACX_PACKED;
+	u8	tx_rx_memory_block_allocation;
+	u8	count_rx_queues; 
+	u8	count_tx_queues;
+	u8	options;
+	u8	fragmentation;
 	u16	reserved1 ACX_PACKED;
-	u8	reserved2 ACX_PACKED;
+	u8	reserved2;
 
 	/* start of rx1 block */
-	u8	rx_queue1_count_descs ACX_PACKED;
-	u8	rx_queue1_reserved1 ACX_PACKED;
-	u8	rx_queue1_type ACX_PACKED; /* must be set to 7 */
-	u8	rx_queue1_prio ACX_PACKED; /* must be set to 0 */
-	acx_ptr	rx_queue1_host_rx_start ACX_PACKED;
+	u8	rx_queue1_count_descs;
+	u8	rx_queue1_reserved1;
+	u8	rx_queue1_type; /* must be set to 7 */
+	u8	rx_queue1_prio; /* must be set to 0 */
+	acx_ptr	rx_queue1_host_rx_start;
 	/* end of rx1 block */
 
 	/* start of tx1 block */
-	u8	tx_queue1_count_descs ACX_PACKED;
-	u8	tx_queue1_reserved1 ACX_PACKED;
-	u8	tx_queue1_reserved2 ACX_PACKED;
-	u8	tx_queue1_attributes ACX_PACKED;
+	u8	tx_queue1_count_descs;
+	u8	tx_queue1_reserved1;
+	u8	tx_queue1_reserved2;
+	u8	tx_queue1_attributes;
 	/* end of tx1 block */
 } acx111_ie_memoryconfig_t;
 
@@ -1612,7 +1612,7 @@ typedef struct acx111_ie_feature_config 
 typedef struct acx111_ie_tx_level {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
-	u8	level ACX_PACKED;
+	u8	level;
 } acx111_ie_tx_level_t;
 
 #define PS_CFG_ENABLE		0x80
@@ -1632,20 +1632,20 @@ typedef struct acx111_ie_tx_level {
 typedef struct acx100_ie_powersave {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
-	u8	wakeup_cfg ACX_PACKED;
-	u8	listen_interval ACX_PACKED; /* for EACH_ITVL: wake up every "beacon units" interval */
-	u8	options ACX_PACKED;
-	u8	hangover_period ACX_PACKED; /* remaining wake time after Tx MPDU w/ PS bit, in values of 1/1024 seconds */
+	u8	wakeup_cfg;
+	u8	listen_interval; /* for EACH_ITVL: wake up every "beacon units" interval */
+	u8	options;
+	u8	hangover_period; /* remaining wake time after Tx MPDU w/ PS bit, in values of 1/1024 seconds */
 	u16	enhanced_ps_transition_time ACX_PACKED; /* rem. wake time for Enh. PS */
 } acx100_ie_powersave_t;
 
 typedef struct acx111_ie_powersave {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
-	u8	wakeup_cfg ACX_PACKED;
-	u8	listen_interval ACX_PACKED; /* for EACH_ITVL: wake up every "beacon units" interval */
-	u8	options ACX_PACKED;
-	u8	hangover_period ACX_PACKED; /* remaining wake time after Tx MPDU w/ PS bit, in values of 1/1024 seconds */
+	u8	wakeup_cfg;
+	u8	listen_interval; /* for EACH_ITVL: wake up every "beacon units" interval */
+	u8	options;
+	u8	hangover_period; /* remaining wake time after Tx MPDU w/ PS bit, in values of 1/1024 seconds */
 	u32	beacon_rx_time ACX_PACKED;
 	u32	enhanced_ps_transition_time ACX_PACKED; /* rem. wake time for Enh. PS */
 } acx111_ie_powersave_t;
@@ -1678,8 +1678,8 @@ typedef struct acx100_scan {
 	u16	count ACX_PACKED;	/* number of scans to do, 0xffff == continuous */
 	u16	start_chan ACX_PACKED;
 	u16	flags ACX_PACKED;	/* channel list mask; 0x8000 == all channels? */
-	u8	max_rate ACX_PACKED;	/* max. probe rate */
-	u8	options ACX_PACKED;	/* bit mask, see defines above */
+	u8	max_rate;	/* max. probe rate */
+	u8	options;	/* bit mask, see defines above */
 	u16	chan_duration ACX_PACKED;
 	u16	max_probe_delay ACX_PACKED;
 } acx100_scan_t;			/* length 0xc */
@@ -1698,17 +1698,17 @@ typedef struct acx100_scan {
 #define ACX111_SCAN_MOD_OFDM	0x40
 typedef struct acx111_scan {
 	u16	count ACX_PACKED;		/* number of scans to do */
-	u8	channel_list_select ACX_PACKED; /* 0: scan all channels, 1: from chan_list only */
+	u8	channel_list_select; /* 0: scan all channels, 1: from chan_list only */
 	u16	reserved1 ACX_PACKED;
-	u8	reserved2 ACX_PACKED;
-	u8	rate ACX_PACKED;		/* rate for probe requests (if active scan) */
-	u8	options ACX_PACKED;		/* bit mask, see defines above */
+	u8	reserved2;
+	u8	rate;		/* rate for probe requests (if active scan) */
+	u8	options;		/* bit mask, see defines above */
 	u16	chan_duration ACX_PACKED;	/* min time to wait for reply on one channel (in TU) */
 						/* (active scan only) (802.11 section 11.1.3.2.2) */
 	u16	max_probe_delay ACX_PACKED;	/* max time to wait for reply on one channel (active scan) */
 						/* time to listen on a channel (passive scan) */
-	u8	modulation ACX_PACKED;
-	u8	channel_list[26] ACX_PACKED;	/* bits 7:0 first byte: channels 8:1 */
+	u8	modulation;
+	u8	channel_list[26];	/* bits 7:0 first byte: channels 8:1 */
 						/* bits 7:0 second byte: channels 16:9 */
 						/* 26 bytes is enough to cover 802.11a */
 } acx111_scan_t;
@@ -1748,50 +1748,50 @@ typedef struct acx111_cmd_radiocalib {
 ** - variable length fields shown only in comments */
 typedef struct acx_template_tim {
 	u16	size ACX_PACKED;
-	u8	tim_eid ACX_PACKED;	/* 00 1 TIM IE ID * */
-	u8	len ACX_PACKED;		/* 01 1 Length * */
-	u8	dtim_cnt ACX_PACKED;	/* 02 1 DTIM Count */
-	u8	dtim_period ACX_PACKED;	/* 03 1 DTIM Period */
-	u8	bitmap_ctrl ACX_PACKED;	/* 04 1 Bitmap Control * (except bit0) */
+	u8	tim_eid;	/* 00 1 TIM IE ID * */
+	u8	len;		/* 01 1 Length * */
+	u8	dtim_cnt;	/* 02 1 DTIM Count */
+	u8	dtim_period;	/* 03 1 DTIM Period */
+	u8	bitmap_ctrl;	/* 04 1 Bitmap Control * (except bit0) */
 					/* 05 n Partial Virtual Bitmap * */
-	u8	variable[0x100 - 1-1-1-1-1] ACX_PACKED;
+	u8	variable[0x100 - 1-1-1-1-1];
 } acx_template_tim_t;
 
 typedef struct acx_template_probereq {
 	u16	size ACX_PACKED;
 	u16	fc ACX_PACKED;		/* 00 2 fc * */
 	u16	dur ACX_PACKED;		/* 02 2 Duration */
-	u8	da[6] ACX_PACKED;	/* 04 6 Destination Address * */
-	u8	sa[6] ACX_PACKED;	/* 0A 6 Source Address * */
-	u8	bssid[6] ACX_PACKED;	/* 10 6 BSSID * */
+	u8	da[6];	/* 04 6 Destination Address * */
+	u8	sa[6];	/* 0A 6 Source Address * */
+	u8	bssid[6];	/* 10 6 BSSID * */
 	u16	seq ACX_PACKED;		/* 16 2 Sequence Control */
 					/* 18 n SSID * */
 					/* nn n Supported Rates * */
-	u8	variable[0x44 - 2-2-6-6-6-2] ACX_PACKED;
+	u8	variable[0x44 - 2-2-6-6-6-2];
 } acx_template_probereq_t;
 
 typedef struct acx_template_proberesp {
 	u16	size ACX_PACKED;
 	u16	fc ACX_PACKED;		/* 00 2 fc * (bits [15:12] and [10:8] per 802.11 section 7.1.3.1) */
 	u16	dur ACX_PACKED;		/* 02 2 Duration */
-	u8	da[6] ACX_PACKED;	/* 04 6 Destination Address */
-	u8	sa[6] ACX_PACKED;	/* 0A 6 Source Address */
-	u8	bssid[6] ACX_PACKED;	/* 10 6 BSSID */
+	u8	da[6];	/* 04 6 Destination Address */
+	u8	sa[6];	/* 0A 6 Source Address */
+	u8	bssid[6];	/* 10 6 BSSID */
 	u16	seq ACX_PACKED;		/* 16 2 Sequence Control */
-	u8	timestamp[8] ACX_PACKED;/* 18 8 Timestamp */
+	u8	timestamp[8];/* 18 8 Timestamp */
 	u16	beacon_interval ACX_PACKED; /* 20 2 Beacon Interval * */
 	u16	cap ACX_PACKED;		/* 22 2 Capability Information * */
 					/* 24 n SSID * */
 					/* nn n Supported Rates * */
 					/* nn 1 DS Parameter Set * */
-	u8	variable[0x54 - 2-2-6-6-6-2-8-2-2] ACX_PACKED;
+	u8	variable[0x54 - 2-2-6-6-6-2-8-2-2];
 } acx_template_proberesp_t;
 #define acx_template_beacon_t acx_template_proberesp_t
 #define acx_template_beacon acx_template_proberesp
 
 typedef struct acx_template_nullframe {
 	u16	size ACX_PACKED;
-	struct wlan_hdr_a3 hdr ACX_PACKED;
+	struct wlan_hdr_a3 hdr;
 } acx_template_nullframe_t;
 
 
@@ -1801,27 +1801,27 @@ typedef struct acx_template_nullframe {
 ** as opposed to acx100, acx111 dtim interval is AFTER rates_basic111.
 ** NOTE: took me about an hour to get !@#$%^& packing right --> struct packing is eeeeevil... */
 typedef struct acx_joinbss {
-	u8	bssid[ETH_ALEN] ACX_PACKED;
+	u8	bssid[ETH_ALEN];
 	u16	beacon_interval ACX_PACKED;
 	union {
 		struct {
-			u8	dtim_interval ACX_PACKED;
-			u8	rates_basic ACX_PACKED;
-			u8	rates_supported ACX_PACKED;
-		} acx100 ACX_PACKED;
+			u8	dtim_interval;
+			u8	rates_basic;
+			u8	rates_supported;
+		} acx100;
 		struct {
 			u16	rates_basic ACX_PACKED;
-			u8	dtim_interval ACX_PACKED;
-		} acx111 ACX_PACKED;
-	} u ACX_PACKED;
-	u8	genfrm_txrate ACX_PACKED;	/* generated frame (bcn, proberesp, RTS, PSpoll) tx rate */
-	u8	genfrm_mod_pre ACX_PACKED;	/* generated frame modulation/preamble:
+			u8	dtim_interval;
+		} acx111;
+	} u;
+	u8	genfrm_txrate;	/* generated frame (bcn, proberesp, RTS, PSpoll) tx rate */
+	u8	genfrm_mod_pre;	/* generated frame modulation/preamble:
 						** bit7: PBCC, bit6: OFDM (else CCK/DQPSK/DBPSK)
 						** bit5: short pre */
-	u8	macmode ACX_PACKED;	/* BSS Type, must be one of ACX_MODE_xxx */
-	u8	channel ACX_PACKED;
-	u8	essid_len ACX_PACKED;
-	char	essid[IW_ESSID_MAX_SIZE] ACX_PACKED;
+	u8	macmode;	/* BSS Type, must be one of ACX_MODE_xxx */
+	u8	channel;
+	u8	essid_len;
+	char	essid[IW_ESSID_MAX_SIZE];
 } acx_joinbss_t;
 
 #define JOINBSS_RATES_1		0x01
@@ -1862,7 +1862,7 @@ typedef struct mem_read_write {
 typedef struct firmware_image {
 	u32	chksum ACX_PACKED;
 	u32	size ACX_PACKED;
-	u8	data[1] ACX_PACKED; /* the byte array of the actual firmware... */
+	u8	data[1]; /* the byte array of the actual firmware... */
 } firmware_image_t;
 
 typedef struct acx_cmd_radioinit {
@@ -1874,42 +1874,42 @@ typedef struct acx100_ie_wep_options {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
 	u16	NumKeys ACX_PACKED;	/* max # of keys */
-	u8	WEPOption ACX_PACKED;	/* 0 == decrypt default key only, 1 == override decrypt */
-	u8	Pad ACX_PACKED;		/* used only for acx111 */
+	u8	WEPOption;	 /* 0 == decrypt default key only, 1 == override decrypt */
+	u8	Pad;		/* used only for acx111 */
 } acx100_ie_wep_options_t;
 
 typedef struct ie_dot11WEPDefaultKey {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
-	u8	action ACX_PACKED;
-	u8	keySize ACX_PACKED;
-	u8	defaultKeyNum ACX_PACKED;
-	u8	key[29] ACX_PACKED;	/* check this! was Key[19] */
+	u8	action;
+	u8	keySize;
+	u8	defaultKeyNum;
+	u8	key[29];	/* check this! was Key[19] */
 } ie_dot11WEPDefaultKey_t;
 
 typedef struct acx111WEPDefaultKey {
-	u8	MacAddr[ETH_ALEN] ACX_PACKED;
+	u8	MacAddr[ETH_ALEN];
 	u16	action ACX_PACKED;	/* NOTE: this is a u16, NOT a u8!! */
 	u16	reserved ACX_PACKED;
-	u8	keySize ACX_PACKED;
-	u8	type ACX_PACKED;
-	u8	index ACX_PACKED;
-	u8	defaultKeyNum ACX_PACKED;
-	u8	counter[6] ACX_PACKED;
-	u8	key[32] ACX_PACKED;	/* up to 32 bytes (for TKIP!) */
+	u8	keySize;
+	u8	type;
+	u8	index;
+	u8	defaultKeyNum;
+	u8	counter[6];
+	u8	key[32];	/* up to 32 bytes (for TKIP!) */
 } acx111WEPDefaultKey_t;
 
 typedef struct ie_dot11WEPDefaultKeyID {
 	u16	type ACX_PACKED;
 	u16	len ACX_PACKED;
-	u8	KeyID ACX_PACKED;
+	u8	KeyID;
 } ie_dot11WEPDefaultKeyID_t;
 
 typedef struct acx100_cmd_wep_mgmt {
-	u8	MacAddr[ETH_ALEN] ACX_PACKED;
+	u8	MacAddr[ETH_ALEN];
 	u16	Action ACX_PACKED;
 	u16	KeySize ACX_PACKED;
-	u8	Key[29] ACX_PACKED; /* 29*8 == 232bits == WEP256 */
+	u8	Key[29]; /* 29*8 == 232bits == WEP256 */
 } acx100_cmd_wep_mgmt_t;
 
 /* UNUSED?
@@ -1927,7 +1927,7 @@ typedef struct acx_ie_generic {
 		u16	aid;
 		/* UNUSED? struct defaultkey dkey ACX_PACKED; */
 		/* generic member for quick implementation of commands */
-		u8	bytes[32] ACX_PACKED;
+		u8	bytes[32];
 	} m ACX_PACKED;
 } acx_ie_generic_t;
 
Index: linux-2.6.16/drivers/net/wireless/tiacx/wlan_compat.h
===================================================================
--- linux-2.6.16.orig/drivers/net/wireless/tiacx/wlan_compat.h
+++ linux-2.6.16/drivers/net/wireless/tiacx/wlan_compat.h
@@ -243,20 +243,20 @@ typedef void irqreturn_t;
 
 /* local ether header type */
 typedef struct wlan_ethhdr {
-	u8	daddr[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	saddr[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	daddr[ETH_ALEN];
+	u8	saddr[ETH_ALEN];
 	u16	type __WLAN_ATTRIB_PACK__;
 } wlan_ethhdr_t;
 
 /* local llc header type */
 typedef struct wlan_llc {
-	u8	dsap __WLAN_ATTRIB_PACK__;
-	u8	ssap __WLAN_ATTRIB_PACK__;
-	u8	ctl __WLAN_ATTRIB_PACK__;
+	u8	dsap;
+	u8	ssap;
+	u8	ctl;
 } wlan_llc_t;
 
 /* local snap header type */
 typedef struct wlan_snap {
-	u8	oui[WLAN_IEEE_OUI_LEN] __WLAN_ATTRIB_PACK__;
+	u8	oui[WLAN_IEEE_OUI_LEN];
 	u16	type __WLAN_ATTRIB_PACK__;
 } wlan_snap_t;
Index: linux-2.6.16/drivers/net/wireless/tiacx/wlan_hdr.h
===================================================================
--- linux-2.6.16.orig/drivers/net/wireless/tiacx/wlan_hdr.h
+++ linux-2.6.16/drivers/net/wireless/tiacx/wlan_hdr.h
@@ -339,29 +339,29 @@ IEEE16(WF_FSTYPE_CFACK_CFPOLL,		0x70)
 typedef struct wlan_hdr {
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	a1[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a2[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a3[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	a1[ETH_ALEN];
+	u8	a2[ETH_ALEN];
+	u8	a3[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
-	u8	a4[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	a4[ETH_ALEN];
 } wlan_hdr_t;
 
 /* Separate structs for use if frame type is known */
 typedef struct wlan_hdr_a3 {
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	a1[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a2[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a3[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	a1[ETH_ALEN];
+	u8	a2[ETH_ALEN];
+	u8	a3[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
 } wlan_hdr_a3_t;
 
 typedef struct wlan_hdr_mgmt {
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	da[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
 } wlan_hdr_mgmt_t;
 
@@ -369,78 +369,78 @@ typedef struct wlan_hdr_mgmt {
 typedef struct { /* ad-hoc peer->peer (to/from DS = 0/0) */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	da[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
 } ibss;
 typedef struct { /* ap->sta (to/from DS = 0/1) */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	da[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+	u8	sa[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
 } fromap;
 typedef struct { /* sta->ap (to/from DS = 1/0) */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	bssid[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	da[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
 } toap;
 typedef struct { /* wds->wds (to/from DS = 1/1), the only 4addr pkt */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	ta[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	ra[ETH_ALEN];
+	u8	ta[ETH_ALEN];
+	u8	da[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	sa[ETH_ALEN];
 } wds;
 typedef struct { /* all management packets */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	da[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
 	u16	seq __WLAN_ATTRIB_PACK__;
 } mgmt;
 typedef struct { /* has no body, just a FCS */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	ta[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	ra[ETH_ALEN];
+	u8	ta[ETH_ALEN];
 } rts;
 typedef struct { /* has no body, just a FCS */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	ra[ETH_ALEN];
 } cts;
 typedef struct { /* has no body, just a FCS */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	ra[ETH_ALEN];
 } ack;
 typedef struct { /* has no body, just a FCS */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	/* NB: this one holds Assoc ID in dur field: */
 	u16	aid __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	ta[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	bssid[ETH_ALEN];
+	u8	ta[ETH_ALEN];
 } pspoll;
 typedef struct { /* has no body, just a FCS */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	ra[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
 } cfend;
 typedef struct { /* has no body, just a FCS */
 	u16	fc __WLAN_ATTRIB_PACK__;
 	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
+	u8	ra[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
 } cfendcfack;
 #endif
 
@@ -472,17 +472,17 @@ typedef struct wlanitem_u32 {
 typedef struct wlansniffrm {
 	u32		msgcode __WLAN_ATTRIB_PACK__;
 	u32		msglen __WLAN_ATTRIB_PACK__;
-	u8		devname[WLAN_DEVNAMELEN_MAX] __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	hosttime __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	mactime __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	channel __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	rssi __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	sq __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	signal __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	noise __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	rate __WLAN_ATTRIB_PACK__;
-	wlanitem_u32_t	istx __WLAN_ATTRIB_PACK__;	/* tx? 0:no 1:yes */
-	wlanitem_u32_t	frmlen __WLAN_ATTRIB_PACK__;
+	u8		devname[WLAN_DEVNAMELEN_MAX];
+	wlanitem_u32_t	hosttime;
+	wlanitem_u32_t	mactime;
+	wlanitem_u32_t	channel;
+	wlanitem_u32_t	rssi;
+	wlanitem_u32_t	sq;
+	wlanitem_u32_t	signal;
+	wlanitem_u32_t	noise;
+	wlanitem_u32_t	rate;
+	wlanitem_u32_t	istx;	/* tx? 0:no 1:yes */
+	wlanitem_u32_t	frmlen;
 } wlansniffrm_t;
 #define WLANSNIFFFRM		0x0041
 #define WLANSNIFFFRM_hosttime	0x1041
Index: linux-2.6.16/drivers/net/wireless/tiacx/wlan_mgmt.h
===================================================================
--- linux-2.6.16.orig/drivers/net/wireless/tiacx/wlan_mgmt.h
+++ linux-2.6.16/drivers/net/wireless/tiacx/wlan_mgmt.h
@@ -199,84 +199,84 @@ IEEE16(WF_MGMT_CAP_CCKOFDM,	0x2000)
 
 /* prototype structure, all IEs start with these members */
 typedef struct wlan_ie {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
 } wlan_ie_t;
 
 /*-- Service Set Identity (SSID)  -----------------*/
 typedef struct wlan_ie_ssid {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 ssid[1] __WLAN_ATTRIB_PACK__;	/* may be zero */
+	u8 eid;
+	u8 len;
+	u8 ssid[1];	/* may be zero */
 } wlan_ie_ssid_t;
 
 /*-- Supported Rates  -----------------------------*/
 typedef struct wlan_ie_supp_rates {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 rates[1] __WLAN_ATTRIB_PACK__;	/* had better be at LEAST one! */
+	u8 eid;
+	u8 len;
+	u8 rates[1];	/* had better be at LEAST one! */
 } wlan_ie_supp_rates_t;
 
 /*-- FH Parameter Set  ----------------------------*/
 typedef struct wlan_ie_fh_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
 	u16 dwell __WLAN_ATTRIB_PACK__;
-	u8 hopset __WLAN_ATTRIB_PACK__;
-	u8 hoppattern __WLAN_ATTRIB_PACK__;
-	u8 hopindex __WLAN_ATTRIB_PACK__;
+	u8 hopset; 
+	u8 hoppattern;
+	u8 hopindex;
 } wlan_ie_fh_parms_t;
 
 /*-- DS Parameter Set  ----------------------------*/
 typedef struct wlan_ie_ds_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 curr_ch __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
+	u8 curr_ch;
 } wlan_ie_ds_parms_t;
 
 /*-- CF Parameter Set  ----------------------------*/
 typedef struct wlan_ie_cf_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 cfp_cnt __WLAN_ATTRIB_PACK__;
-	u8 cfp_period __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
+	u8 cfp_cnt;
+	u8 cfp_period;
 	u16 cfp_maxdur __WLAN_ATTRIB_PACK__;
 	u16 cfp_durremaining __WLAN_ATTRIB_PACK__;
 } wlan_ie_cf_parms_t;
 
 /*-- TIM ------------------------------------------*/
 typedef struct wlan_ie_tim {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 dtim_cnt __WLAN_ATTRIB_PACK__;
-	u8 dtim_period __WLAN_ATTRIB_PACK__;
-	u8 bitmap_ctl __WLAN_ATTRIB_PACK__;
-	u8 virt_bm[1] __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
+	u8 dtim_cnt;
+	u8 dtim_period;
+	u8 bitmap_ctl;
+	u8 virt_bm[1];
 } wlan_ie_tim_t;
 
 /*-- IBSS Parameter Set ---------------------------*/
 typedef struct wlan_ie_ibss_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
 	u16 atim_win __WLAN_ATTRIB_PACK__;
 } wlan_ie_ibss_parms_t;
 
 /*-- Challenge Text  ------------------------------*/
 typedef struct wlan_ie_challenge {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 challenge[1] __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
+	u8 challenge[1];
 } wlan_ie_challenge_t;
 
 /*-- ERP (42) -------------------------------------*/
 typedef struct wlan_ie_erp {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
+	u8 eid;
+	u8 len;
 	/* bit 0:Non ERP present
 	**     1:Use Protection
 	**     2:Barker Preamble mode
 	**     3-7:reserved */
-	u8 erp __WLAN_ATTRIB_PACK__;
+	u8 erp;
 } wlan_ie_erp_t;
 
 /* Types for parsing mgmt frames */
@@ -434,21 +434,21 @@ typedef struct auth_frame_body {
 	u16	auth_alg __WLAN_ATTRIB_PACK__;
 	u16	auth_seq __WLAN_ATTRIB_PACK__;
 	u16	status __WLAN_ATTRIB_PACK__;
-	wlan_ie_challenge_t challenge __WLAN_ATTRIB_PACK__;
+	wlan_ie_challenge_t challenge;
 } auth_frame_body_t;
 
 typedef struct assocresp_frame_body {
 	u16	cap_info __WLAN_ATTRIB_PACK__;
 	u16	status __WLAN_ATTRIB_PACK__;
 	u16	aid __WLAN_ATTRIB_PACK__;
-	wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__;
+	wlan_ie_supp_rates_t rates;
 } assocresp_frame_body_t;
 
 typedef struct reassocreq_frame_body {
 	u16	cap_info __WLAN_ATTRIB_PACK__;
 	u16	listen_int __WLAN_ATTRIB_PACK__;
-	u8	current_ap[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	wlan_ie_ssid_t ssid __WLAN_ATTRIB_PACK__;
+	u8	current_ap[ETH_ALEN];
+	wlan_ie_ssid_t ssid;
 /* access to this one is disabled since ssid_t is variable length: */
      /* wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__; */
 } reassocreq_frame_body_t;
@@ -457,7 +457,7 @@ typedef struct reassocresp_frame_body {
 	u16	cap_info __WLAN_ATTRIB_PACK__;
 	u16	status __WLAN_ATTRIB_PACK__;
 	u16	aid __WLAN_ATTRIB_PACK__;
-	wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__;
+	wlan_ie_supp_rates_t rates;
 } reassocresp_frame_body_t;
 
 typedef struct deauthen_frame_body {
@@ -469,15 +469,15 @@ typedef struct disassoc_frame_body {
 } disassoc_frame_body_t;
 
 typedef struct probereq_frame_body {
-	wlan_ie_ssid_t ssid __WLAN_ATTRIB_PACK__;
-	wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__;
+	wlan_ie_ssid_t ssid;
+	wlan_ie_supp_rates_t rates;
 } probereq_frame_body_t;
 
 typedef struct proberesp_frame_body {
-	u8	timestamp[8] __WLAN_ATTRIB_PACK__;
+	u8	timestamp[8];
 	u16	beacon_int __WLAN_ATTRIB_PACK__;
 	u16	cap_info __WLAN_ATTRIB_PACK__;
-	wlan_ie_ssid_t ssid __WLAN_ATTRIB_PACK__;
+	wlan_ie_ssid_t ssid; 
 /* access to these is disabled since ssid_t is variable length: */
      /* wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__; */
      /* fhps_t	fhps __WLAN_ATTRIB_PACK__; */
Index: linux-2.6.16/drivers/net/wireless/tiacx/usb.c
===================================================================
--- linux-2.6.16.orig/drivers/net/wireless/tiacx/usb.c
+++ linux-2.6.16/drivers/net/wireless/tiacx/usb.c
@@ -281,7 +281,7 @@ acxusb_s_issue_cmd_timeo_debug(
 	struct {
 		u16	cmd ACX_PACKED;
 		u16	status ACX_PACKED;
-		u8	data[1] ACX_PACKED;
+		u8	data[1];
 	} *loc;
 	const char *devname;
 	int acklen, blocklen, inpipe, outpipe;
