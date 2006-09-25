Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWIYJpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWIYJpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWIYJpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:45:00 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:37049 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750833AbWIYJo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:44:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       scott.bailey@eds.com, ian@beware.dropbear.id.au,
       Jeremy Higdon <jeremy@sgi.com>
Subject: [patch] qla1280 command timeout
From: Jes Sorensen <jes@sgi.com>
Date: 25 Sep 2006 05:44:57 -0400
Message-ID: <yq04puwcmau.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one is originally from Ian Dall via bugzilla.kernel.org - Ian if
you wish to add a Signed-off-by please do, couldn't add it since you
didn't leave one in bugzilla.

Anyway the patch seems obviously correct (famous last words) and it
would be nice to get into 2.6.19.

Thanks,
Jes

Original patch from Ian Dall in bugzilla. Set command timeout as
specified by the SCSI layer rather than hardcode it to 30 seconds. I
have received a couple of reports of people hitting this one with
various tape configurations and the patch looks obviously correct.
                                                                  - Jes

>From http://bugzilla.kernel.org/show_bug.cgi?id=6275

ian@beware.dropbear.id.au (Ian Dall):

The command sent to the card was using a 30second timeout regardless of the
timeout requested in the scsi command passed down from higher levels.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 drivers/scsi/qla1280.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/scsi/qla1280.c
===================================================================
--- linux-2.6.orig/drivers/scsi/qla1280.c
+++ linux-2.6/drivers/scsi/qla1280.c
@@ -2864,7 +2864,7 @@ qla1280_64bit_start_scsi(struct scsi_qla
 	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
 
 	/* Set ISP command timeout. */
-	pkt->timeout = cpu_to_le16(30);
+	pkt->timeout = cpu_to_le16(cmd->timeout_per_command/HZ);
 
 	/* Set device target ID and LUN */
 	pkt->lun = SCSI_LUN_32(cmd);
@@ -3163,7 +3163,7 @@ qla1280_32bit_start_scsi(struct scsi_qla
 	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
 
 	/* Set ISP command timeout. */
-	pkt->timeout = cpu_to_le16(30);
+	pkt->timeout = cpu_to_le16(cmd->timeout_per_command/HZ);
 
 	/* Set device target ID and LUN */
 	pkt->lun = SCSI_LUN_32(cmd);
