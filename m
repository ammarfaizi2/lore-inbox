Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVG0NJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVG0NJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVG0NJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:09:51 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:3908 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262241AbVG0NJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:09:42 -0400
From: Ian Campbell <ijc@hellion.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050628155158.396f676c.akpm@osdl.org>
References: <1119948144.10852.10.camel@icampbell-debian>
	 <20050628155158.396f676c.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 14:09:22 +0100
Message-Id: <1122469762.29501.253.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.3.3
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: [PATCH 1/1] cs89x0 collect tx_bytes statistics.
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 15:51 -0700, Andrew Morton wrote:
> Ian Campbell <ijc@hellion.org.uk> wrote:
> >
> > The cs89x0 driver does not collect tx_bytes statistics which breaks
> > traffic monitoring on my firewall.
> 
> The patch looks odd.  It records the length of the current outgoing frame
> in the device-global netdev structure and then, at tx interupt time it adds
> that value into the stats field.
> 
> Why not just do:

I finally got a hold of the device I needed to test this and it works
fine, not that anyone would have expected differently...

Signed-off-by: Ian Campbell <icampbell@arcom.com>

%patch
Index: 2.6/drivers/net/cs89x0.c
===================================================================
--- 2.6.orig/drivers/net/cs89x0.c	2005-07-25 16:39:53.000000000 +0100
+++ 2.6/drivers/net/cs89x0.c	2005-07-27 13:34:11.000000000 +0100
@@ -1450,6 +1450,7 @@
 	/* Write the contents of the packet */
 	outsw(dev->base_addr + TX_FRAME_PORT,skb->data,(skb->len+1) >>1);
 	spin_unlock_irq(&lp->lock);
+	lp->stats.tx_bytes += skb->len;
 	dev->trans_start = jiffies;
 	dev_kfree_skb (skb);
 


-- 
Ian Campbell
Current Noise: Enslaved - Return to Yggdrasill

Dentist, n.:
	A Prestidigitator who, putting metal in one's mouth, pulls
	coins out of one's pockets.
		-- Ambrose Bierce, "The Devil's Dictionary"

