Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUKCV4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUKCV4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKCVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:53:09 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:35799 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261925AbUKCVwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:52:23 -0500
From: Daniel Drake <dsd@gentoo.org>
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] Permit READ_BUFFER_CAPACITY in SG_IO command table
Date: Thu, 4 Nov 2004 05:35:42 +0800
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u8UiBsJ7PGbhPFD"
Message-Id: <200411040535.42286.dsd@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_u8UiBsJ7PGbhPFD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

While burning CD's on 2.6.9 with cdrdao, I noticed it complaining repeatedly:
 ERROR: Read buffer capacity failed.

It tries to read the buffer capacity (MMC command 0x5c) in order to produce a 
percentage reading of how full the buffer is.

This patch permits the READ_BUFFER_CAPACITY command again. Please apply.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--Boundary-00=_u8UiBsJ7PGbhPFD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="scsi_ioctl-permit-read-buffer-capacity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scsi_ioctl-permit-read-buffer-capacity.patch"

diff -X dontdiff -urNp linux-2.6.9-gentoo-r2/drivers/block/scsi_ioctl.c linux-dsd/drivers/block/scsi_ioctl.c
--- linux-2.6.9-gentoo-r2/drivers/block/scsi_ioctl.c	2004-11-03 21:26:28.000000000 +0000
+++ linux-dsd/drivers/block/scsi_ioctl.c	2004-11-03 22:05:07.635578808 +0000
@@ -139,6 +139,7 @@ static int verify_command(struct file *f
 		safe_for_read(GPCMD_PAUSE_RESUME),
 
 		/* CD/DVD data reading */
+		safe_for_read(GPCMD_READ_BUFFER_CAPACITY),
 		safe_for_read(GPCMD_READ_CD),
 		safe_for_read(GPCMD_READ_CD_MSF),
 		safe_for_read(GPCMD_READ_DISC_INFO),
diff -X dontdiff -urNp linux-2.6.9-gentoo-r2/include/linux/cdrom.h linux-dsd/include/linux/cdrom.h
--- linux-2.6.9-gentoo-r2/include/linux/cdrom.h	2004-11-03 17:08:47.000000000 +0000
+++ linux-dsd/include/linux/cdrom.h	2004-11-03 22:01:15.858814232 +0000
@@ -452,6 +452,7 @@ struct cdrom_generic_command
 #define GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL  0x1e
 #define GPCMD_READ_10			    0x28
 #define GPCMD_READ_12			    0xa8
+#define GPCMD_READ_BUFFER_CAPACITY	    0x5c
 #define GPCMD_READ_CDVD_CAPACITY	    0x25
 #define GPCMD_READ_CD			    0xbe
 #define GPCMD_READ_CD_MSF		    0xb9

--Boundary-00=_u8UiBsJ7PGbhPFD--
