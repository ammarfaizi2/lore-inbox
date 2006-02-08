Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWBHIPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWBHIPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWBHIPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:15:09 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:20882 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1030285AbWBHIPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:15:08 -0500
Thread-Index: AcYsh7P/F1mXaXDHRW+ImjSRDcSOBw==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Transfer-Encoding: 7bit
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43E9A86D.7070304@bfh.ch>
Date: Wed, 08 Feb 2006 09:14:37 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <mlord@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Last Patch to pdc_adma breaks debug compile
Content-Type: multipart/mixed;
	boundary="------------000008040000030803080708"
X-OriginalArrivalTime: 08 Feb 2006 08:14:37.0650 (UTC) FILETIME=[B3DDC320:01C62C87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--------------000008040000030803080708
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

The Last Patch (5. Nov. 05) to the sata pdc_adma driver removed nelem
from adma_fill_sg and introduced ata_for_each_sg.

The Problem is that nelem was forgot to be removed from the contained
VPRINTK too. The attached patch fixes this.

Patch applies against 2.6.15.1

Regards
Philippe Seewer

--------------000008040000030803080708
Content-Type: text/x-patch;
	name="pdc_adma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="pdc_adma.patch"

--- linux-2.6.15.1/drivers/scsi/pdc_adma.c.orig	2006-02-08 09:03:15.000000000 +0100
+++ linux-2.6.15.1/drivers/scsi/pdc_adma.c	2006-02-08 09:04:32.000000000 +0100
@@ -322,8 +322,8 @@ static int adma_fill_sg(struct ata_queue
 			= (pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma + i + 4);
 		i += 4;
 
-		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", nelem
-					(unsigned long)addr, len);
+		VPRINTK("Current PRD = (0x%lX, 0x%X)\n",
+			(unsigned long)addr, len);
 	}
 	return i;
 }

--------------000008040000030803080708--
