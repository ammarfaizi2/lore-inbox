Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289149AbSAVFCe>; Tue, 22 Jan 2002 00:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289159AbSAVFCX>; Tue, 22 Jan 2002 00:02:23 -0500
Received: from mailgate.indstate.edu ([139.102.15.118]:46761 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S289149AbSAVFCM>; Tue, 22 Jan 2002 00:02:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [PATCH] fix drivers/scsi/imm.c in 2.5.3pre2
Date: Mon, 21 Jan 2002 23:25:51 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <6D914675512@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally got the imm driver to work.  I have based this patch a patch 
posted by derek@signalmarketing.com for the ppa driver.  I've tested this and 
it works for me.  Please test this and send me any questions or comments you 
may have.  If no one has any problems I'll send it to Linus.

Also, I have a longer patch that gets rid of some #includes in imm.c that are 
also in imm.h.  I moved them to imm.h.  Let me know if I should post that 
patch as well.  It is mainly cosmetic and also works for me.

Thanks,
Rich


diff -urN -X dontdiff linux/drivers/scsi/imm.c linux-rb/drivers/scsi/imm.c
--- linux/drivers/scsi/imm.c	Sat Dec  8 23:02:47 2001
+++ linux-rb/drivers/scsi/imm.c	Mon Jan 21 14:39:30 2002
@@ -998,7 +998,7 @@
     case 4:
 	if (cmd->use_sg) {
 	    /* if many buffers are available, start filling the first */
-	    cmd->SCp.buffer = (struct scatterlist *) cmd->request_buffer;
+	    cmd->SCp.buffer = (struct scatterlist *) cmd->buffer;
 	    cmd->SCp.this_residual = cmd->SCp.buffer->length;
 	    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + 
cmd->SCp.buffer->offset;
 	} else {
@@ -1007,7 +1007,7 @@
 	    cmd->SCp.this_residual = cmd->request_bufflen;
 	    cmd->SCp.ptr = cmd->request_buffer;
 	}
-	cmd->SCp.buffers_residual = cmd->use_sg;
+	cmd->SCp.buffers_residual = cmd->use_sg - 1;
 	cmd->SCp.phase++;
 	if (cmd->SCp.this_residual & 0x01)
 	    cmd->SCp.this_residual++;

