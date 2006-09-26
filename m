Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWIZLWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWIZLWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWIZLWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:22:18 -0400
Received: from mail.gmx.de ([213.165.64.20]:26782 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751114AbWIZLWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:22:17 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in drivers/scsi/scsi.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 13:22:13 +0200
Message-Id: <1159269733.5935.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this overrun was spotted by coverity (cid #1403).

If type == ARRAY_SIZE(scsi_device_types), we are off by one.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/drivers/scsi/scsi.c.orig	2006-09-26 13:18:52.000000000 +0200
+++ linux-2.6.18-git5/drivers/scsi/scsi.c	2006-09-26 13:19:13.000000000 +0200
@@ -128,7 +128,7 @@ const char * scsi_device_type(unsigned t
 		return "Well-known LUN   ";
 	if (type == 0x1f)
 		return "No Device        ";
-	if (type > ARRAY_SIZE(scsi_device_types))
+	if (type >= ARRAY_SIZE(scsi_device_types))
 		return "Unknown          ";
 	return scsi_device_types[type];
 }


