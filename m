Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSFMAY4>; Wed, 12 Jun 2002 20:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317383AbSFMAYz>; Wed, 12 Jun 2002 20:24:55 -0400
Received: from [209.237.59.50] ([209.237.59.50]:30291 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317380AbSFMAYx>; Wed, 12 Jun 2002 20:24:53 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.name>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 use __dma_buffer in scsi.h
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Jun 2002 17:24:50 -0700
Message-ID: <52sn3s2ffx.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use __dma_buffer macro to align sense_buffer member of Scsi_Cmnd.

Patch is against 2.4.19-pre10.

Thanks,
  Roland

 scsi.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -Naur linux-2.4.19-pre10.orig/drivers/scsi/scsi.h linux-2.4.19-pre10/drivers/scsi/scsi.h
--- linux-2.4.19-pre10.orig/drivers/scsi/scsi.h	Wed Jun 12 15:08:52 2002
+++ linux-2.4.19-pre10/drivers/scsi/scsi.h	Wed Jun 12 16:28:21 2002
@@ -30,6 +30,7 @@
 #include <asm/hardirq.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
+#include <asm/dma_buffer.h>
 
 /*
  * These are the values that the SCpnt->sc_data_direction and 
@@ -779,7 +780,7 @@
 	struct request request;	/* A copy of the command we are
 				   working on */
 
-	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];		/* obtained by REQUEST SENSE
+	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE] __dma_buffer;		/* obtained by REQUEST SENSE
 						 * when CHECK CONDITION is
 						 * received on original command 
 						 * (auto-sense) */
