Return-Path: <linux-kernel-owner+w=401wt.eu-S1754845AbWL1NRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbWL1NRJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbWL1NRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:17:09 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:43645 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754845AbWL1NRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:17:08 -0500
Message-id: <73191133992841072@wsc.cz>
In-reply-to: <188453909150148968@wsc.cz>
Subject: [PATCH 4/4] Char: mxser_new, clean request_irq call
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 28 Dec 2006 14:17:13 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, clean request_irq call

We always set ASYNC_SHARE_IRQ, so do not test against this flag and request
shared irq directly. Also remove nonsense comment.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit ab35af25a3d01f1e07fc8de5b96f484b93a8ad2a
tree 3a79b6dba3253393371decb0c2cdd97c85580630
parent ec5dee09bf3e78d886d61168625e63280c715739
author Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 14:11:56 +0059
committer Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 14:11:56 +0059

 drivers/char/.mxser_new.c.swp |  Bin
 drivers/char/mxser_new.c      |    8 ++------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 420d23f..8da8833 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2398,13 +2398,9 @@ static int __devinit mxser_initbrd(struct mxser_board *brd,
 		outb(inb(info->ioaddr + UART_IER) & 0xf0,
 			info->ioaddr + UART_IER);
 	}
-	/*
-	 * Allocate the IRQ if necessary
-	 */
 
-	retval = request_irq(brd->irq, mxser_interrupt,
-			(brd->ports[0].flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED :
-			IRQF_DISABLED, "mxser", brd);
+	retval = request_irq(brd->irq, mxser_interrupt, IRQF_SHARED, "mxser",
+			brd);
 	if (retval) {
 		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
 			"conflict with another device.\n",
