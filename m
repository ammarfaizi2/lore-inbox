Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbRLQCQC>; Sun, 16 Dec 2001 21:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284969AbRLQCPw>; Sun, 16 Dec 2001 21:15:52 -0500
Received: from [203.94.130.164] ([203.94.130.164]:7945 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S284968AbRLQCPk>;
	Sun, 16 Dec 2001 21:15:40 -0500
Date: Mon, 17 Dec 2001 13:21:46 +1100 (EST)
From: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.1 - fix qlogic pcmcia scsi
Message-ID: <Pine.LNX.4.40.0112171318090.30472-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Small patch to fix compilation for my pcmcia scsi card, as broken by the 
bio changes.

thanks,

	/ Brett

--- drivers/scsi/qlogicfas.c.bak	Mon Dec 17 12:54:48 2001
+++ drivers/scsi/qlogicfas.c	Mon Dec 17 12:55:24 2001
@@ -467,10 +467,11 @@
 static void	    do_ql_ihandl(int irq, void *dev_id, struct pt_regs * 
regs)
 {
 	unsigned long flags;
+	struct Scsi_Host *host = dev_id;
 
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(&host->host_lock, flags);
 	ql_ihandl(irq, dev_id, regs);
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&host->host_lock, flags);
 }
 #endif
 


