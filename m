Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKDVjY>; Sat, 4 Nov 2000 16:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKDVjO>; Sat, 4 Nov 2000 16:39:14 -0500
Received: from mta01.onebox.com ([216.33.158.208]:34554 "EHLO mta01.onebox.com")
	by vger.kernel.org with ESMTP id <S129044AbQKDVjA>;
	Sat, 4 Nov 2000 16:39:00 -0500
Date: Sat, 04 Nov 2000 13:38:25 -0800
Subject: [patch] linux channel bonding driver 
From: "brien o" <brienfwd@onebox.com>
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20001104213854.YNJW22792.mta01.onebox.com@onebox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

here's a patch to make the channel bonding driver not try to
transmit on links that are down.  there was a patch made to
2.3.x to do this via checking netif_carrier_ok().  this adds
the functionality to the 2.2.x driver code.

please cc: me in response.

brien

 
--- linux-2.2.17/drivers/net/bonding.c    Fri Nov  3 12:22:33 2000
+++ linux-2.2.17-patched/drivers/net/bonding.c    Fri Nov  3 12:24:27
2000
@@ -265,7 +265,7 @@
 
         while (good == 0) {
                 slave = queue->current_slave->dev;
 -               if (slave->flags & (IFF_UP|IFF_RUNNING)) {
 +               if ((slave->flags & (IFF_UP|IFF_RUNNING)) == (IFF_UP|IFF_RUNNING))
{
                         skb->dev = slave;
                         skb->priority = 1;
                         dev_queue_xmit(skb);


 

__________________________________________________
FREE voicemail, email, and fax...all in one place.
Sign Up Now! http://www.onebox.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
