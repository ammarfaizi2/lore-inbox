Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWFBUac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWFBUac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWFBUac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:30:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:15059 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932216AbWFBUab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:30:31 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:28:48 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 18/18] sbp2: use __attribute__((packed)) for
 on-the-wire structures
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.df90273c07dd7503@s5r6.in-berlin.de>
Message-ID: <tkrat.9d29f76876c2d347@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
 <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
 <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
 <tkrat.96e1b392429fe277@s5r6.in-berlin.de>
 <tkrat.df90273c07dd7503@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.731) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to have worked without the attribute during all the years
just because sizes of all struct members are multiples of octlets.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.h	2006-06-01 20:55:43.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.h	2006-06-01 20:55:49.000000000 +0200
@@ -52,7 +52,7 @@ struct sbp2_command_orb {
 	u32 data_descriptor_lo;
 	u32 misc;
 	u8 cdb[12];
-};
+} __attribute__((packed));
 
 #define SBP2_LOGIN_REQUEST		0x0
 #define SBP2_QUERY_LOGINS_REQUEST	0x1
@@ -80,7 +80,7 @@ struct sbp2_login_orb {
 	u32 passwd_resp_lengths;
 	u32 status_fifo_hi;
 	u32 status_fifo_lo;
-};
+} __attribute__((packed));
 
 #define RESPONSE_GET_LOGIN_ID(value)            (value & 0xffff)
 #define RESPONSE_GET_LENGTH(value)              ((value >> 16) & 0xffff)
@@ -91,7 +91,7 @@ struct sbp2_login_response {
 	u32 command_block_agent_hi;
 	u32 command_block_agent_lo;
 	u32 reconnect_hold;
-};
+} __attribute__((packed));
 
 #define ORB_SET_LOGIN_ID(value)                 (value & 0xffff)
 
@@ -106,7 +106,7 @@ struct sbp2_query_logins_orb {
 	u32 reserved_resp_length;
 	u32 status_fifo_hi;
 	u32 status_fifo_lo;
-};
+} __attribute__((packed));
 
 #define RESPONSE_GET_MAX_LOGINS(value)          (value & 0xffff)
 #define RESPONSE_GET_ACTIVE_LOGINS(value)       ((RESPONSE_GET_LENGTH(value) - 4) / 12)
@@ -116,7 +116,7 @@ struct sbp2_query_logins_response {
 	u32 misc_IDs;
 	u32 initiator_misc_hi;
 	u32 initiator_misc_lo;
-};
+} __attribute__((packed));
 
 struct sbp2_reconnect_orb {
 	u32 reserved1;
@@ -127,7 +127,7 @@ struct sbp2_reconnect_orb {
 	u32 reserved5;
 	u32 status_fifo_hi;
 	u32 status_fifo_lo;
-};
+} __attribute__((packed));
 
 struct sbp2_logout_orb {
 	u32 reserved1;
@@ -138,7 +138,7 @@ struct sbp2_logout_orb {
 	u32 reserved5;
 	u32 status_fifo_hi;
 	u32 status_fifo_lo;
-};
+} __attribute__((packed));
 
 #define PAGE_TABLE_SET_SEGMENT_BASE_HI(value)   (value & 0xffff)
 #define PAGE_TABLE_SET_SEGMENT_LENGTH(value)    ((value & 0xffff) << 16)
@@ -146,7 +146,7 @@ struct sbp2_logout_orb {
 struct sbp2_unrestricted_page_table {
 	u32 length_segment_base_hi;
 	u32 segment_base_lo;
-};
+} __attribute__((packed));
 
 #define RESP_STATUS_REQUEST_COMPLETE		0x0
 #define RESP_STATUS_TRANSPORT_FAILURE		0x1
@@ -191,7 +191,7 @@ struct sbp2_status_block {
 	u32 ORB_offset_hi_misc;
 	u32 ORB_offset_lo;
 	u8 command_set_dependent[24];
-};
+} __attribute__((packed));
 
 /*
  * Miscellaneous SBP2 related config rom defines


