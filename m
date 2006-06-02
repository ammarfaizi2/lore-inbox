Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWFBTu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWFBTu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWFBTuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:50:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35024 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932553AbWFBTtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:49:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:48:08 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 03/18] sbp2: make TSB42AA9 workaround specific
 to Momobay CX-1
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
Message-ID: <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.729) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The workarounds are not required for DViCO Momobay FX-3A and AFAIR not
for Momobay CX-2. These contain an TSB42AA9A but feature the same
firmware_revision value as the older DViCO Momobay CX-1.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c	2006-06-01 20:55:40.000000000 +0200
@@ -306,8 +306,9 @@ static const struct {
 	u32 model_id;
 	unsigned workarounds;
 } sbp2_workarounds_table[] = {
-	/* TSB42AA9 */ {
+	/* DViCO Momobay CX-1 with TSB42AA9 bridge */ {
 		.firmware_revision	= 0x002800,
+		.model_id		= 0x001010,
 		.workarounds		= SBP2_WORKAROUND_INQUIRY_36 |
 					  SBP2_WORKAROUND_MODE_SENSE_8,
 	},


