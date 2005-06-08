Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVFHT6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVFHT6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFHT6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:58:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1532 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261582AbVFHT6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:58:23 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>
In-Reply-To: <20050608112801.GA31084@elte.hu>
References: <20050608112801.GA31084@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 08 Jun 2005 12:58:15 -0700
Message-Id: <1118260695.30686.2.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 13:28 +0200, Ingo Molnar wrote:

>  - fix race in usbnet.c (Eugeny S. Mints)


--- linux/drivers/usb/net/usbnet.c.orig
+++ linux/drivers/usb/net/usbnet.c
@@ -3490,6 +3490,8 @@ static void tx_complete (struct urb *urb
 
 	urb->dev = NULL;
 	entry->state = tx_done;
+	spin_lock_rt(&dev->txq.lock);
+	spin_unlock_rt(&dev->txq.lock);
 	defer_bh (dev, skb);
 }


What are these lines fixing again ? It seems rather odd that locking and
then unlocking a mutex could fix anything ..

Daniel

