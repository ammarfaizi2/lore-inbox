Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOPsL>; Wed, 15 Nov 2000 10:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129187AbQKOPsB>; Wed, 15 Nov 2000 10:48:01 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:22134 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129091AbQKOPrw>; Wed, 15 Nov 2000 10:47:52 -0500
Date: Wed, 15 Nov 2000 15:17:50 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3
Message-ID: <20001115151750.B18112@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 11, 2000 at 07:22:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't see this in the ChangeLog.  Does this need backporting to
2.2.x as well?

Tim.
*/

Index: drivers/scsi/ppa.c
===================================================================
RCS file: /usr/local/src/cvsroot/linux/drivers/scsi/ppa.c,v
retrieving revision 1.5
diff -d -u -r1.5 ppa.c
--- drivers/scsi/ppa.c	2000/09/25 16:46:52	1.5
+++ drivers/scsi/ppa.c	2000/11/15 15:17:33
@@ -194,6 +194,8 @@
 	host->can_queue = PPA_CAN_QUEUE;
 	host->sg_tablesize = ppa_sg;
 	hreg = scsi_register(host, 0);
+	if(hreg == NULL)
+		continue;
 	hreg->io_port = pb->base;
 	hreg->n_io_port = ports;
 	hreg->dma_channel = -1;
Index: drivers/scsi/imm.c
===================================================================
RCS file: /usr/local/src/cvsroot/linux/drivers/scsi/imm.c,v
retrieving revision 1.7
diff -d -u -r1.7 imm.c
--- drivers/scsi/imm.c	2000/10/31 16:55:22	1.7
+++ drivers/scsi/imm.c	2000/11/15 15:17:33
@@ -198,6 +198,8 @@
 	host->can_queue = IMM_CAN_QUEUE;
 	host->sg_tablesize = imm_sg;
 	hreg = scsi_register(host, 0);
+	if(hreg == NULL)
+		continue;
 	hreg->io_port = pb->base;
 	hreg->n_io_port = ports;
 	hreg->dma_channel = -1;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
