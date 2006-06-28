Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWF1Tr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWF1Tr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWF1Tr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:47:27 -0400
Received: from mail.gmx.de ([213.165.64.21]:40578 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751117AbWF1Tr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:47:26 -0400
X-Authenticated: #704063
Subject: [Patch] Typo in drivers/net/e1000/e1000_hw.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: jeffrey.t.kirsher@intel.com
Content-Type: text/plain
Date: Wed, 28 Jun 2006 21:47:23 +0200
Message-Id: <1151524043.26393.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

spotted by coverity (id #539), we should use the define
with which the array is defined. We use min_agc as index
for e1000_igp_2_cable_length_table[IGP02E1000_AGC_LENGTH_TABLE_SIZE]
This patch also adds the -1 to make it safe so that we dont read
past the end of the array.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/net/e1000/e1000_hw.c.orig	2006-06-28 21:46:55.000000000 +0200
+++ linux-2.6.17-git11/drivers/net/e1000/e1000_hw.c	2006-06-28 21:47:07.000000000 +0200
@@ -6012,7 +6012,7 @@ e1000_get_cable_length(struct e1000_hw *
 {
     int32_t ret_val;
     uint16_t agc_value = 0;
-    uint16_t cur_agc, min_agc = IGP01E1000_AGC_LENGTH_TABLE_SIZE;
+    uint16_t cur_agc, min_agc = IGP02E1000_AGC_LENGTH_TABLE_SIZE - 1;
     uint16_t max_agc = 0;
     uint16_t i, phy_data;
     uint16_t cable_length;


