Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSAMRyR>; Sun, 13 Jan 2002 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSAMRyI>; Sun, 13 Jan 2002 12:54:08 -0500
Received: from maild.telia.com ([194.22.190.101]:16089 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S286758AbSAMRyA>;
	Sun, 13 Jan 2002 12:54:00 -0500
To: Jens Axboe <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2.5: I/O errors ignored in __scsi_end_request
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jan 2002 18:53:50 +0100
Message-ID: <m2pu4euogh.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I/O errors in scsi drivers are being silently ignored in the
__scsi_end_request function in scsi_lib.c. This patch seems obvious
enough to me. (And it does work, at least for the packet writing
module.)

--- linux/drivers/scsi/scsi_lib.c.old	Sun Jan 13 18:40:44 2002
+++ linux/drivers/scsi/scsi_lib.c	Sun Jan 13 13:45:03 2002
@@ -365,7 +365,7 @@
 	 * If there are blocks left over at the end, set up the command
 	 * to queue the remainder of them.
 	 */
-	if (end_that_request_first(req, 1, sectors)) {
+	if (end_that_request_first(req, uptodate, sectors)) {
 		if (!requeue)
 			return SCpnt;
 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
