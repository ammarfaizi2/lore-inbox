Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWJAS1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWJAS1n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWJAS1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:27:43 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:36289 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932164AbWJAS1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:27:42 -0400
Date: Sun, 1 Oct 2006 19:27:38 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] - add PNP IDs for FPI based touchscreens
Message-ID: <20061001182738.GA17124@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Compaq TC1000 and Fujitsu Stylistic range of tablet machines use 
touchscreens from FPI. These are implemented as serial interfaces, 
generally exposed in the ACPIPNP information on the system. This patch 
adds them to the 8250_pnp driver tables, avoiding the need to mess 
around with setserial to set them up.

I haven't been able to confirm what FUJ02B5, FUJ02BA and FUJ02BB are. 
FUJ02B1 refers to the controller for the system hotkeys. FUJ02BC appears 
to be the last in the range - after this, they moved to Wacom-based 
systems.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
index 632f62d..71d907c 100644
--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -327,6 +327,19 @@ static const struct pnp_device_id pnp_de
 	{	"WACF004",		0	},
 	{	"WACF005",		0	},
 	{       "WACF006",              0       },
+	/* Compaq touchscreen */
+	{       "FPI2002",              0 },
+	/* Fujitsu Stylistic touchscreens */
+	{       "FUJ02B2",              0 },
+	{       "FUJ02B3",              0 },
+	/* Fujitsu Stylistic LT touchscreens */
+	{       "FUJ02B4",              0 },
+	/* Passive Fujitsu Stylistic touchscreens */
+	{       "FUJ02B6",              0 },
+	{       "FUJ02B7",              0 },
+	{       "FUJ02B8",              0 },
+	{       "FUJ02B9",              0 },
+	{       "FUJ02BC",              0 },
 	/* Rockwell's (PORALiNK) 33600 INT PNP */
 	{	"WCI0003",		0	},
 	/* Unkown PnP modems */

-- 
Matthew Garrett | mjg59@srcf.ucam.org
