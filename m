Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVFWJ2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVFWJ2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFWJZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:25:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33459 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262585AbVFWJYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:24:16 -0400
Message-ID: <42BA7FB5.5020804@pobox.com>
Date: Thu, 23 Jun 2005 05:24:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: [git patch] urgent e1000 fix
Content-Type: multipart/mixed;
 boundary="------------010705020707050403070901"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010705020707050403070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from 'misc-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the spinlock fix described in the attached text.


--------------010705020707050403070901
Content-Type: text/plain;
 name="netdev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.txt"


 drivers/net/e1000/e1000_main.c |    1 +
 1 files changed, 1 insertion(+)


Mitch Williams:
  e1000: fix spinlock bug


diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -2307,6 +2307,7 @@ e1000_xmit_frame(struct sk_buff *skb, st
 	tso = e1000_tso(adapter, skb);
 	if (tso < 0) {
 		dev_kfree_skb_any(skb);
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 		return NETDEV_TX_OK;
 	}
 

--------------010705020707050403070901--
