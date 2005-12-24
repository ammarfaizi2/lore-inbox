Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVLXPOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVLXPOD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbVLXPOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:14:03 -0500
Received: from havoc.gtf.org ([69.61.125.42]:64937 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750968AbVLXPOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:14:01 -0500
Date: Sat, 24 Dec 2005 10:13:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata fix
Message-ID: <20051224151357.GA16841@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-scsi.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Tony Battersby:
      fix libata inquiry VPD for ATAPI devices

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 72ddba9..2282c04 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2044,7 +2044,7 @@ static int atapi_qc_complete(struct ata_
 	else {
 		u8 *scsicmd = cmd->cmnd;
 
-		if (scsicmd[0] == INQUIRY) {
+		if ((scsicmd[0] == INQUIRY) && ((scsicmd[1] & 0x03) == 0)) {
 			u8 *buf = NULL;
 			unsigned int buflen;
 
@@ -2058,9 +2058,6 @@ static int atapi_qc_complete(struct ata_
 	 * device.  2) Ensure response data format / ATAPI information
 	 * are always correct.
 	 */
-	/* FIXME: do we ever override EVPD pages and the like, with
-	 * this code?
-	 */
 			if (buf[2] == 0) {
 				buf[2] = 0x5;
 				buf[3] = 0x32;
