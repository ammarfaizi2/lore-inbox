Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWJJQ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWJJQ6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWJJQ6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:58:04 -0400
Received: from twin.jikos.cz ([213.151.79.26]:41356 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750721AbWJJQ6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:58:02 -0400
Date: Tue, 10 Oct 2006 18:56:57 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Jeff Garzik <jeff@garzik.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/irda/donauboe.c broken in current git tree
Message-ID: <Pine.LNX.4.64.0610101849010.5959@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

your commit c31f28e778ab299a5035ea2bda64f245b8915d7c (which currently is 
in mainline) broke drivers/net/irda/donauboe.c, as it removes 
toshoboe_invalid_dev(), but this is called from toshoboe_interrupt() 
(your patch removed reference to it only from toshoboe_probeinterrupt().

I guess the fix below is appropriate .. ?

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff --git a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
index 636d063..14cc217 100644
--- a/drivers/net/irda/donauboe.c
+++ b/drivers/net/irda/donauboe.c
@@ -1158,9 +1158,6 @@ toshoboe_interrupt (int irq, void *dev_i
   __u8 irqstat;
   struct sk_buff *skb = NULL;
 
-  if (self == NULL && toshoboe_invalid_dev(irq))
-    return IRQ_NONE;
-
   irqstat = INB (OBOE_ISR);
 
 /* was it us */

-- 
Jiri Kosina
