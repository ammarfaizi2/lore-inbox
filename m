Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWI1Rf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWI1Rf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWI1RfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:35:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030305AbWI1RfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:35:10 -0400
Date: Thu, 28 Sep 2006 10:34:21 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: vda@ilport.com.ua, akpm@osdl.org, acx100-devel@lists.sourceforge.net
Subject: 2.6.18-mm1 tiacx-fix-attribute-packed-warnings for wlan
Message-ID: <20060928173421.GG26041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch tiacx-fix-attribute-packed-warnings.patch takes care of many of 
the 'packed attribute' warnings, but I noticed that some of these warnings like:

drivers/net/wireless/tiacx/wlan_compat.h:246: warning: 'packed' attribute ignored for field of type 'u8[5u]'
drivers/net/wireless/tiacx/wlan_hdr.h:476: warning: 'packed' attribute ignored for field of type 'wlanitem_u32_t'
drivers/net/wireless/tiacx/wlan_mgmt.h:253: warning: 'packed' attribute ignored for field of type 'u8'

are still present for the i386/allmodconfig build on gcc-4.1.1 for 2.6.18-mm1.  
So I made a patch for the files where it is still a problem.  This compiled
without warnings.

Signed-off-by: Judith Lebzelter <judith@osdl.org>



diff -Nur linux.nodelta/drivers/net/wireless/tiacx/wlan_compat.h linux/drivers/net/wireless/tiacx/wlan_compat.h
--- linux.nodelta/drivers/net/wireless/tiacx/wlan_compat.h	2006-09-28 09:06:00.628523695 -0700
+++ linux/drivers/net/wireless/tiacx/wlan_compat.h	2006-09-28 09:50:59.301786662 -0700
@@ -243,20 +243,20 @@
 
 /* local ether header type */
 typedef struct wlan_ethhdr {
-	u8	daddr[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	saddr[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	type __WLAN_ATTRIB_PACK__;
-} wlan_ethhdr_t;
+	u8	daddr[ETH_ALEN];
+	u8	saddr[ETH_ALEN];
+	u16	type;
+} __WLAN_ATTRIB_PACK__ wlan_ethhdr_t;
 
 /* local llc header type */
 typedef struct wlan_llc {
-	u8	dsap __WLAN_ATTRIB_PACK__;
-	u8	ssap __WLAN_ATTRIB_PACK__;
-	u8	ctl __WLAN_ATTRIB_PACK__;
-} wlan_llc_t;
+	u8	dsap;
+	u8	ssap;
+	u8	ctl;
+} __WLAN_ATTRIB_PACK__ wlan_llc_t;
 
 /* local snap header type */
 typedef struct wlan_snap {
-	u8	oui[WLAN_IEEE_OUI_LEN] __WLAN_ATTRIB_PACK__;
-	u16	type __WLAN_ATTRIB_PACK__;
-} wlan_snap_t;
+	u8	oui[WLAN_IEEE_OUI_LEN];
+	u16	type;
+} __WLAN_ATTRIB_PACK__ wlan_snap_t;
diff -Nur linux.nodelta/drivers/net/wireless/tiacx/wlan_hdr.h linux/drivers/net/wireless/tiacx/wlan_hdr.h
--- linux.nodelta/drivers/net/wireless/tiacx/wlan_hdr.h	2006-09-28 09:06:00.629523545 -0700
+++ linux/drivers/net/wireless/tiacx/wlan_hdr.h	2006-09-28 09:42:18.496905257 -0700
@@ -337,120 +337,120 @@
 ** seq: [0:3] frag#, [4:15] seq# - used for dup detection
 ** (dups from retries have same seq#) */
 typedef struct wlan_hdr {
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	a1[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a2[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a3[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-	u8	a4[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} wlan_hdr_t;
+	u16	fc;
+	u16	dur;
+	u8	a1[ETH_ALEN];
+	u8	a2[ETH_ALEN];
+	u8	a3[ETH_ALEN];
+	u16	seq;
+	u8	a4[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ wlan_hdr_t;
 
 /* Separate structs for use if frame type is known */
 typedef struct wlan_hdr_a3 {
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	a1[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a2[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	a3[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-} wlan_hdr_a3_t;
+	u16	fc;
+	u16	dur;
+	u8	a1[ETH_ALEN];
+	u8	a2[ETH_ALEN];
+	u8	a3[ETH_ALEN];
+	u16	seq;
+} __WLAN_ATTRIB_PACK__ wlan_hdr_a3_t;
 
 typedef struct wlan_hdr_mgmt {
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-} wlan_hdr_mgmt_t;
+	u16	fc;
+	u16	dur;
+	u8	da[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+	u16	seq;
+} __WLAN_ATTRIB_PACK__ wlan_hdr_mgmt_t;
 
 #ifdef NOT_NEEDED_YET
 typedef struct { /* ad-hoc peer->peer (to/from DS = 0/0) */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-} ibss;
+	u16	fc;
+	u16	dur;
+	u8	da[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+	u16	seq;
+} __WLAN_ATTRIB_PACK__ ibss;
 typedef struct { /* ap->sta (to/from DS = 0/1) */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-} fromap;
+	u16	fc;
+	u16	dur;
+	u8	da[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u16	seq;
+} __WLAN_ATTRIB_PACK__ fromap;
 typedef struct { /* sta->ap (to/from DS = 1/0) */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-} toap;
+	u16	fc;
+	u16	dur;
+	u8	bssid[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	da[ETH_ALEN];
+	u16	seq;
+} __WLAN_ATTRIB_PACK__ toap;
 typedef struct { /* wds->wds (to/from DS = 1/1), the only 4addr pkt */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	ta[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} wds;
+	u16	fc;
+	u16	dur;
+	u8	ra[ETH_ALEN];
+	u8	ta[ETH_ALEN];
+	u8	da[ETH_ALEN];
+	u16	seq;
+	u8	sa[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ wds;
 typedef struct { /* all management packets */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	da[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	sa[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u16	seq __WLAN_ATTRIB_PACK__;
-} mgmt;
-typedef struct { /* has no body, just a FCS */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	ta[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} rts;
-typedef struct { /* has no body, just a FCS */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} cts;
-typedef struct { /* has no body, just a FCS */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} ack;
+	u16	fc;
+	u16	dur;
+	u8	da[ETH_ALEN];
+	u8	sa[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+	u16	seq;
+} __WLAN_ATTRIB_PACK__ mgmt;
+typedef struct { /* has no body, just a FCS */
+	u16	fc;
+	u16	dur;
+	u8	ra[ETH_ALEN];
+	u8	ta[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ rts;
+typedef struct { /* has no body, just a FCS */
+	u16	fc;
+	u16	dur;
+	u8	ra[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ cts;
+typedef struct { /* has no body, just a FCS */
+	u16	fc;
+	u16	dur;
+	u8	ra[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ ack;
 typedef struct { /* has no body, just a FCS */
-	u16	fc __WLAN_ATTRIB_PACK__;
+	u16	fc;
 	/* NB: this one holds Assoc ID in dur field: */
-	u16	aid __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	ta[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} pspoll;
-typedef struct { /* has no body, just a FCS */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} cfend;
-typedef struct { /* has no body, just a FCS */
-	u16	fc __WLAN_ATTRIB_PACK__;
-	u16	dur __WLAN_ATTRIB_PACK__;
-	u8	ra[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	u8	bssid[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-} cfendcfack;
+	u16	aid;
+	u8	bssid[ETH_ALEN];
+	u8	ta[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ pspoll;
+typedef struct { /* has no body, just a FCS */
+	u16	fc;
+	u16	dur;
+	u8	ra[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ cfend;
+typedef struct { /* has no body, just a FCS */
+	u16	fc;
+	u16	dur;
+	u8	ra[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+} __WLAN_ATTRIB_PACK__ cfendcfack;
 #endif
 
 /* Prism header emulation (monitor mode) */
 typedef struct wlanitem_u32 {
-	u32	did __WLAN_ATTRIB_PACK__;
-	u16	status __WLAN_ATTRIB_PACK__;
-	u16	len __WLAN_ATTRIB_PACK__;
-	u32	data __WLAN_ATTRIB_PACK__;
-} wlanitem_u32_t;
+	u32	did;
+	u16	status;
+	u16	len;
+	u32	data;
+} __WLAN_ATTRIB_PACK__ wlanitem_u32_t;
 #define WLANITEM_STATUS_data_ok			0
 #define WLANITEM_STATUS_no_value		1
 #define WLANITEM_STATUS_invalid_itemname	2
@@ -470,20 +470,20 @@
 
 #define WLAN_DEVNAMELEN_MAX	16
 typedef struct wlansniffrm {
-	u32		msgcode __WLAN_ATTRIB_PACK__;
-	u32		msglen __WLAN_ATTRIB_PACK__;
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
-} wlansniffrm_t;
+	u32		msgcode;
+	u32		msglen;
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
+} __WLAN_ATTRIB_PACK__ wlansniffrm_t;
 #define WLANSNIFFFRM		0x0041
 #define WLANSNIFFFRM_hosttime	0x1041
 #define WLANSNIFFFRM_mactime	0x2041
diff -Nur linux.nodelta/drivers/net/wireless/tiacx/wlan_mgmt.h linux/drivers/net/wireless/tiacx/wlan_mgmt.h
--- linux.nodelta/drivers/net/wireless/tiacx/wlan_mgmt.h	2006-09-28 09:06:00.630523395 -0700
+++ linux/drivers/net/wireless/tiacx/wlan_mgmt.h	2006-09-28 09:42:47.731518636 -0700
@@ -199,85 +199,85 @@
 
 /* prototype structure, all IEs start with these members */
 typedef struct wlan_ie {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-} wlan_ie_t;
+	u8 eid;
+	u8 len;
+} __WLAN_ATTRIB_PACK__ wlan_ie_t;
 
 /*-- Service Set Identity (SSID)  -----------------*/
 typedef struct wlan_ie_ssid {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 ssid[1] __WLAN_ATTRIB_PACK__;	/* may be zero */
-} wlan_ie_ssid_t;
+	u8 eid;
+	u8 len;
+	u8 ssid[1];	/* may be zero */
+} __WLAN_ATTRIB_PACK__ wlan_ie_ssid_t;
 
 /*-- Supported Rates  -----------------------------*/
 typedef struct wlan_ie_supp_rates {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 rates[1] __WLAN_ATTRIB_PACK__;	/* had better be at LEAST one! */
-} wlan_ie_supp_rates_t;
+	u8 eid;
+	u8 len;
+	u8 rates[1];	/* had better be at LEAST one! */
+} __WLAN_ATTRIB_PACK__ wlan_ie_supp_rates_t;
 
 /*-- FH Parameter Set  ----------------------------*/
 typedef struct wlan_ie_fh_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u16 dwell __WLAN_ATTRIB_PACK__;
-	u8 hopset __WLAN_ATTRIB_PACK__;
-	u8 hoppattern __WLAN_ATTRIB_PACK__;
-	u8 hopindex __WLAN_ATTRIB_PACK__;
-} wlan_ie_fh_parms_t;
+	u8 eid;
+	u8 len;
+	u16 dwell;
+	u8 hopset;
+	u8 hoppattern;
+	u8 hopindex;
+} __WLAN_ATTRIB_PACK__ wlan_ie_fh_parms_t;
 
 /*-- DS Parameter Set  ----------------------------*/
 typedef struct wlan_ie_ds_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 curr_ch __WLAN_ATTRIB_PACK__;
-} wlan_ie_ds_parms_t;
+	u8 eid;
+	u8 len;
+	u8 curr_ch;
+} __WLAN_ATTRIB_PACK__ wlan_ie_ds_parms_t;
 
 /*-- CF Parameter Set  ----------------------------*/
 typedef struct wlan_ie_cf_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 cfp_cnt __WLAN_ATTRIB_PACK__;
-	u8 cfp_period __WLAN_ATTRIB_PACK__;
-	u16 cfp_maxdur __WLAN_ATTRIB_PACK__;
-	u16 cfp_durremaining __WLAN_ATTRIB_PACK__;
-} wlan_ie_cf_parms_t;
+	u8 eid;
+	u8 len;
+	u8 cfp_cnt;
+	u8 cfp_period;
+	u16 cfp_maxdur;
+	u16 cfp_durremaining;
+} __WLAN_ATTRIB_PACK__ wlan_ie_cf_parms_t;
 
 /*-- TIM ------------------------------------------*/
 typedef struct wlan_ie_tim {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 dtim_cnt __WLAN_ATTRIB_PACK__;
-	u8 dtim_period __WLAN_ATTRIB_PACK__;
-	u8 bitmap_ctl __WLAN_ATTRIB_PACK__;
-	u8 virt_bm[1] __WLAN_ATTRIB_PACK__;
-} wlan_ie_tim_t;
+	u8 eid;
+	u8 len;
+	u8 dtim_cnt;
+	u8 dtim_period;
+	u8 bitmap_ctl;
+	u8 virt_bm[1];
+} __WLAN_ATTRIB_PACK__ wlan_ie_tim_t;
 
 /*-- IBSS Parameter Set ---------------------------*/
 typedef struct wlan_ie_ibss_parms {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u16 atim_win __WLAN_ATTRIB_PACK__;
-} wlan_ie_ibss_parms_t;
+	u8 eid;
+	u8 len;
+	u16 atim_win;
+} __WLAN_ATTRIB_PACK__ wlan_ie_ibss_parms_t;
 
 /*-- Challenge Text  ------------------------------*/
 typedef struct wlan_ie_challenge {
-	u8 eid __WLAN_ATTRIB_PACK__;
-	u8 len __WLAN_ATTRIB_PACK__;
-	u8 challenge[1] __WLAN_ATTRIB_PACK__;
-} wlan_ie_challenge_t;
+	u8 eid;
+	u8 len;
+	u8 challenge[1];
+} __WLAN_ATTRIB_PACK__ wlan_ie_challenge_t;
 
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
-} wlan_ie_erp_t;
+	u8 erp;
+} __WLAN_ATTRIB_PACK__ wlan_ie_erp_t;
 
 /* Types for parsing mgmt frames */
 
@@ -431,59 +431,59 @@
 /* Warning. Several types used in below structs are
 ** in fact variable length. Use structs with such fields with caution */
 typedef struct auth_frame_body {
-	u16	auth_alg __WLAN_ATTRIB_PACK__;
-	u16	auth_seq __WLAN_ATTRIB_PACK__;
-	u16	status __WLAN_ATTRIB_PACK__;
-	wlan_ie_challenge_t challenge __WLAN_ATTRIB_PACK__;
-} auth_frame_body_t;
+	u16	auth_alg;
+	u16	auth_seq;
+	u16	status;
+	wlan_ie_challenge_t challenge;
+} __WLAN_ATTRIB_PACK__ auth_frame_body_t;
 
 typedef struct assocresp_frame_body {
-	u16	cap_info __WLAN_ATTRIB_PACK__;
-	u16	status __WLAN_ATTRIB_PACK__;
-	u16	aid __WLAN_ATTRIB_PACK__;
-	wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__;
-} assocresp_frame_body_t;
+	u16	cap_info;
+	u16	status;
+	u16	aid;
+	wlan_ie_supp_rates_t rates;
+} __WLAN_ATTRIB_PACK__ assocresp_frame_body_t;
 
 typedef struct reassocreq_frame_body {
-	u16	cap_info __WLAN_ATTRIB_PACK__;
-	u16	listen_int __WLAN_ATTRIB_PACK__;
-	u8	current_ap[ETH_ALEN] __WLAN_ATTRIB_PACK__;
-	wlan_ie_ssid_t ssid __WLAN_ATTRIB_PACK__;
+	u16	cap_info;
+	u16	listen_int;
+	u8	current_ap[ETH_ALEN];
+	wlan_ie_ssid_t ssid;
 /* access to this one is disabled since ssid_t is variable length: */
-     /* wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__; */
-} reassocreq_frame_body_t;
+     /* wlan_ie_supp_rates_t rates; */
+} __WLAN_ATTRIB_PACK__ reassocreq_frame_body_t;
 
 typedef struct reassocresp_frame_body {
-	u16	cap_info __WLAN_ATTRIB_PACK__;
-	u16	status __WLAN_ATTRIB_PACK__;
-	u16	aid __WLAN_ATTRIB_PACK__;
-	wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__;
-} reassocresp_frame_body_t;
+	u16	cap_info;
+	u16	status;
+	u16	aid;
+	wlan_ie_supp_rates_t rates;
+} __WLAN_ATTRIB_PACK__ reassocresp_frame_body_t;
 
 typedef struct deauthen_frame_body {
-	u16	reason __WLAN_ATTRIB_PACK__;
-} deauthen_frame_body_t;
+	u16	reason;
+} __WLAN_ATTRIB_PACK__ deauthen_frame_body_t;
 
 typedef struct disassoc_frame_body {
-	u16	reason __WLAN_ATTRIB_PACK__;
-} disassoc_frame_body_t;
+	u16	reason;
+} __WLAN_ATTRIB_PACK__ disassoc_frame_body_t;
 
 typedef struct probereq_frame_body {
-	wlan_ie_ssid_t ssid __WLAN_ATTRIB_PACK__;
-	wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__;
-} probereq_frame_body_t;
+	wlan_ie_ssid_t ssid;
+	wlan_ie_supp_rates_t rates;
+} __WLAN_ATTRIB_PACK__ probereq_frame_body_t;
 
 typedef struct proberesp_frame_body {
-	u8	timestamp[8] __WLAN_ATTRIB_PACK__;
-	u16	beacon_int __WLAN_ATTRIB_PACK__;
-	u16	cap_info __WLAN_ATTRIB_PACK__;
-	wlan_ie_ssid_t ssid __WLAN_ATTRIB_PACK__;
+	u8	timestamp[8];
+	u16	beacon_int;
+	u16	cap_info;
+	wlan_ie_ssid_t ssid;
 /* access to these is disabled since ssid_t is variable length: */
-     /* wlan_ie_supp_rates_t rates __WLAN_ATTRIB_PACK__; */
-     /* fhps_t	fhps __WLAN_ATTRIB_PACK__; */
-     /* dsps_t	dsps __WLAN_ATTRIB_PACK__; */
-     /* cfps_t	cfps __WLAN_ATTRIB_PACK__; */
-} proberesp_frame_body_t;
+     /* wlan_ie_supp_rates_t rates; */
+     /* fhps_t	fhps; */
+     /* dsps_t	dsps; */
+     /* cfps_t	cfps; */
+} __WLAN_ATTRIB_PACK__ proberesp_frame_body_t;
 
 
 /***********************************************************************
