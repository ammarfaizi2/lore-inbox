Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUH3H2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUH3H2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUH3H2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:28:19 -0400
Received: from mail.it-technology.at ([62.99.145.147]:60086 "EHLO
	mail.it-technology.at") by vger.kernel.org with ESMTP
	id S266703AbUH3H2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:28:17 -0400
Message-ID: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
Date: Mon, 30 Aug 2004 09:28:15 +0200 (CEST)
Subject: PROBLEM: fix fealnx.c hangs on SMP, 2.4.27 
From: "Peter Holik" <peter@holik.at>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static void set_rx_mode(struct net_device *dev)
{
   spinlock_t *lp = &((struct netdev_private *)dev->priv)->lock;
   unsigned long flags;
   spin_lock_irqsave(lp, flags);
   __set_rx_mode(dev);
-  spin_unlock_irqrestore(&lp, flags);
+  spin_unlock_irqrestore(lp, flags);
}



