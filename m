Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVA1RsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVA1RsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVA1RpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:45:06 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31165 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261495AbVA1Rlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:41:46 -0500
To: jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org
CC: mkrikis@yahoo.com
Subject: [PATCH, 2.4] fix an oops in ata_to_sense_error
From: Martins Krikis <mkrikis@yahoo.com>
Date: 28 Jan 2005 12:41:22 -0500
Message-ID: <87ekg5e9j1.fsf@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

This fixes an occasional oops in the libata-scsi code.

  Martins Krikis

--- linux-2.4.29/drivers/scsi/libata-scsi.c	2005-01-28 12:07:56.000000000 -0500
+++ linux-2.4.29-iswraid/drivers/scsi/libata-scsi.c	2005-01-28 12:14:43.000000000 -0500
@@ -283,7 +283,8 @@ void ata_to_sense_error(struct ata_queue
 	/* No immediate match */
 	if(err)
 		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
-	
+
+	i = 0;
 	/* Fall back to interpreting status bits */
 	while(stat_table[i][0] != 0xFF)
 	{



