Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVCQW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVCQW1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVCQWYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:24:35 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:64636 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261274AbVCQWVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:21:35 -0500
From: Brett Russ <russb@emc.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 04/05] libata: support descriptor sense in ctrl page
Message-ID: <20050317221753.D65B81E4@lns1032.lss.emc.com>
Date: Thu, 17 Mar 2005 17:20:21 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_libata_control_pg_desc_bit.patch

	libata must support the descriptor format sense blocks as they
	are required to properly report results of ATA pass through
	commands as well as other SCSI commands reporting 48b LBAs.
	This patch adjusts the control mode page to properly report
	this.

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
@@ -1370,7 +1370,12 @@ static unsigned int ata_msense_caching(u
 
 static unsigned int ata_msense_ctl_mode(u8 **ptr_io, const u8 *last)
 {
-	const u8 page[] = {0xa, 0xa, 2, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+	const u8 page[] = {0xa, 0xa, 6, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+
+	/* byte 2: set the descriptor format sense data bit (bit 2)
+	 * since we need to support returning this format for SAT
+	 * commands and any SCSI commands against a 48b LBA device.
+	 */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
 	return sizeof(page);

