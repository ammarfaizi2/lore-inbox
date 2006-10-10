Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWJJRF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJJRF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWJJRF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:05:59 -0400
Received: from twin.jikos.cz ([213.151.79.26]:52109 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750808AbWJJRF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:05:59 -0400
Date: Tue, 10 Oct 2006 19:05:19 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Miles Lane <miles.lane@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc1-mm1 -- WARNING: "toshoboe_invalid_dev"
 [drivers/net/irda/donauboe.ko] undefined!
In-Reply-To: <a44ae5cd0610100912j2ddf7b17lcfea645415f352f3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610101901330.5959@twin.jikos.cz>
References: <a44ae5cd0610100912j2ddf7b17lcfea645415f352f3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Miles Lane wrote:

> This stops the "make modules_install" process.

This is not only in -mm, but also in Linus' git tree. I just sent the 
patch below to Jeff (who is the author of the commit that broke it), which 
I believe might be correct:

[PATCH] fix reference to removed toshoboe_invalid_dev() in 
drivers/net/irda/donauboe.c

commit c31f28e778ab299a5035ea2bda64f245b8915d7c (which currently is in 
mainline) broke drivers/net/irda/donauboe.c, as it removes 
toshoboe_invalid_dev(), but this is called from toshoboe_interrupt() (your 
patch removed reference to it only from toshoboe_probeinterrupt().

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
