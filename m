Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319004AbSHEU0Q>; Mon, 5 Aug 2002 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319005AbSHEU0Q>; Mon, 5 Aug 2002 16:26:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54714 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319004AbSHEU0P>;
	Mon, 5 Aug 2002 16:26:15 -0400
Subject: [PATCH] 2.5.30-dj1
From: Paul Larson <plars@austin.ibm.com>
To: davej@suse.de
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Aug 2002 15:24:43 -0500
Message-Id: <1028579086.19435.31.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for sym53c8xx driver breakage when 
CONFIG_BROKEN_SCSI_ERROR_HANDLING is turned off.

Thanks,
Paul Larson

--- linux-dj/drivers/scsi/sym53c8xx.h	Mon Aug  5 15:42:11 2002
+++ linux-dj-symfix/drivers/scsi/sym53c8xx.h	Mon Aug  5 15:41:43 2002
@@ -89,8 +89,10 @@
 			release:        sym53c8xx_release,	\
 			info:           sym53c8xx_info, 	\
 			queuecommand:   sym53c8xx_queue_command,\
+#ifdef CONFIG_BROKEN_SCSI_ERROR_HANDLING
 			abort:          sym53c8xx_abort,	\
 			reset:          sym53c8xx_reset,	\
+#endif
 			bios_param:     scsicam_bios_param,	\
 			can_queue:      SCSI_NCR_CAN_QUEUE,	\
 			this_id:        7,			\

