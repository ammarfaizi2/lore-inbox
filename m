Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268718AbUILLo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268718AbUILLo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUILLlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:41:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36094 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268707AbUILLfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:35:31 -0400
Date: Sun, 12 Sep 2004 13:35:18 +0200 (MEST)
Message-Id: <200409121135.i8CBZIMk015286@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: john.ronciak@intel.com, linux.nics@intel.com, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] E100 driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 "`__packed__' attribute ignored" warnings
in the 2.4.28-pre3 kernel's E100 ethernet driver. The changes are
new since the 2.6 E100 driver is different.

/Mikael

--- linux-2.4.28-pre3/drivers/net/e100/e100.h.~1~	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre3/drivers/net/e100/e100.h	2004-09-12 02:06:57.000000000 +0200
@@ -501,7 +501,7 @@
 	u8 scb_fc_thld;	/* Flow Control threshold */
 	u8 scb_fc_xon_xoff;	/* Flow Control XON/XOFF values */
 	u8 scb_pmdr;	/* Power Mgmt. Driver Reg */
-} d101_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d101_scb_ext;
 
 /* Changed for 82559 enhancement */
 typedef struct _d101m_scb_ext_t {
@@ -517,7 +517,7 @@
 	u32 scb_function_event_mask;	/* Cardbus Function Mask */
 	u32 scb_function_present_state;	/* Cardbus Function state */
 	u32 scb_force_event;	/* Cardbus Force Event */
-} d101m_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d101m_scb_ext;
 
 /* Changed for 82550 enhancement */
 typedef struct _d102_scb_ext_t {
@@ -536,7 +536,7 @@
 	u32 scb_function_event_mask;	/* Cardbus Function Mask */
 	u32 scb_function_present_state;	/* Cardbus Function state */
 	u32 scb_force_event;	/* Cardbus Force Event */
-} d102_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d102_scb_ext;
 
 /*
  * 82557 status control block. this will be memory mapped & will hang of the
@@ -558,7 +558,7 @@
 		d101m_scb_ext d101m_scb;	/* 82559 specific fields */
 		d102_scb_ext d102_scb;
 	} scb_ext;
-} scb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) scb_t;
 
 /* Self test
  * This is used to dump results of the self test 
@@ -566,7 +566,7 @@
 typedef struct _self_test_t {
 	u32 st_sign;	/* Self Test Signature */
 	u32 st_result;	/* Self Test Results */
-} self_test_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) self_test_t;
 
 /* 
  *  Statistical Counters 
@@ -649,39 +649,39 @@
 	u16 cb_status;	/* Command Block Status */
 	u16 cb_cmd;	/* Command Block Command */
 	u32 cb_lnk_ptr;	/* Link To Next CB */
-} cb_header_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) cb_header_t;
 
 //* Individual Address Command Block (IA_CB)*/
 typedef struct _ia_cb_t {
 	cb_header_t ia_cb_hdr;
 	u8 ia_addr[ETH_ALEN];
-} ia_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) ia_cb_t;
 
 /* Configure Command Block (CONFIG_CB)*/
 typedef struct _config_cb_t {
 	cb_header_t cfg_cbhdr;
 	u8 cfg_byte[CB_CFIG_BYTE_COUNT + CB_CFIG_D102_BYTE_COUNT];
-} config_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) config_cb_t;
 
 /* MultiCast Command Block (MULTICAST_CB)*/
 typedef struct _multicast_cb_t {
 	cb_header_t mc_cbhdr;
 	u16 mc_count;	/* Number of multicast addresses */
 	u8 mc_addr[(ETH_ALEN * MAX_MULTICAST_ADDRS)];
-} mltcst_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) mltcst_cb_t;
 
 #define UCODE_MAX_DWORDS	134
 /* Load Microcode Command Block (LOAD_UCODE_CB)*/
 typedef struct _load_ucode_cb_t {
 	cb_header_t load_ucode_cbhdr;
 	u32 ucode_dword[UCODE_MAX_DWORDS];
-} load_ucode_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) load_ucode_cb_t;
 
 /* Load Programmable Filter Data*/
 typedef struct _filter_cb_t {
 	cb_header_t filter_cb_hdr;
 	u32 filter_data[MAX_FILTER];
-} filter_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) filter_cb_t;
 
 /* NON_TRANSMIT_CB -- Generic Non-Transmit Command Block 
  */
@@ -693,7 +693,7 @@
 		mltcst_cb_t multicast;
 		filter_cb_t filter;
 	} ntcb;
-} nxmit_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) nxmit_cb_t;
 
 /*Block for queuing for postponed execution of the non-transmit commands*/
 typedef struct _nxmit_cb_entry_t {
@@ -724,7 +724,7 @@
 	u32 tbd_buf_addr;	/* Physical Transmit Buffer Address */
 	u16 tbd_buf_cnt;	/* Actual Count Of Bytes */
 	u16 padd;
-} tbd_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) tbd_t;
 
 /* d102 specific fields */
 typedef struct _tcb_ipcb_t {
@@ -743,7 +743,7 @@
 		u16 tbd_zero_size;
 	} tbd_sec_size;
 	u16 total_tcp_payload;
-} tcb_ipcb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) tcb_ipcb_t;
 
 #define E100_TBD_ARRAY_SIZE (2+MAX_SKB_FRAGS)
 
@@ -806,7 +806,7 @@
 	u32 rbd_rcb_addr;	/* Receive Buffer Address */
 	u16 rbd_sz;	/* Receive Buffer Size */
 	u16 rbd_filler1;
-} rbd_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) rbd_t;
 
 /*
  * This structure is used to maintain a FIFO access to a resource that is 
