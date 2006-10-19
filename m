Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946464AbWJSU2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946464AbWJSU2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946459AbWJSU16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:27:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:44183 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1946452AbWJSU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:27:44 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="5720219:sNHT20196243"
Date: Thu, 19 Oct 2006 13:27:39 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: [patch] libata: use correct map_db values for ICH8
Message-Id: <20061019132739.10e504ef.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use valid values for ICH8 map_db.  With the old values, when the 
controller was in Native mode, and SCC was 1 (drives configured for
IDE), any drive plugged into a slave port was not recognized.  For
Combined Mode (and SCC is still 1), 2 is a value value for MAP.map_value,
and needs to be recognized.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/ata/ata_piix.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 2.6-git.orig/drivers/ata/ata_piix.c
+++ 2.6-git/drivers/ata/ata_piix.c
@@ -432,9 +432,9 @@ static const struct piix_map_db ich8_map
 	.present_shift = 8,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  NA,  P1,  NA }, /* 00b (hardwired) */
+		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
 		{  RV,  RV,  RV,  RV },
-		{  RV,  RV,  RV,  RV }, /* 10b (never) */
+		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
 		{  RV,  RV,  RV,  RV },
 	},
 };
