Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWGSBbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWGSBbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWGSBbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:31:16 -0400
Received: from student.uhasselt.be ([193.190.2.1]:30213 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932449AbWGSBbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:31:15 -0400
Date: Wed, 19 Jul 2006 03:31:13 +0200
To: linux-kernel@vger.kernel.org
Cc: linux-eata@i-connect.net
Subject: [PATCH 1/2] Conversions from kmalloc+memset to k(z|c)alloc
Message-ID: <20060719013113.GF30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Conversions from kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Applies to current GIT or 2.6.18-rc2. Compile-tested with 
make allyesconfig.

 drivers/scsi/ide-scsi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index f9e913f..57f460e 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -326,17 +326,15 @@ static int idescsi_check_condition(ide_d
 	u8             *buf;
 
 	/* stuff a sense request in front of our current request */
-	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
+	pc = kzalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
 	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
-	buf = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
+	buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
 	if (pc == NULL || rq == NULL || buf == NULL) {
 		kfree(buf);
 		kfree(rq);
 		kfree(pc);
 		return -ENOMEM;
 	}
-	memset (pc, 0, sizeof (idescsi_pc_t));
-	memset (buf, 0, SCSI_SENSE_BUFFERSIZE);
 	ide_init_drive_cmd(rq);
 	rq->special = (char *) pc;
 	pc->rq = rq;
-- 
1.4.1.gd3ba6

