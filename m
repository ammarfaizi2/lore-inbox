Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945892AbWKKQGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945892AbWKKQGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424272AbWKKQGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:06:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45072 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424255AbWKKQGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:06:40 -0500
Date: Sat, 11 Nov 2006 17:06:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/ether.c: NULL dereference
Message-ID: <20061111160643.GA8809@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following NULL dereference of "skb" in 
drivers/usb/gadget/ether.c:

<--  snip  -->

...
static int
rx_submit (struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
{
        struct sk_buff          *skb;
        int                     retval = -ENOMEM;
...
        if ((skb = alloc_skb (size + NET_IP_ALIGN, gfp_flags)) == 0) {
                DEBUG (dev, "no rx skb\n");
                goto enomem;
        }
...
enomem:
                defer_kevent (dev, WORK_RX_MEMORY);
        if (retval) {
                DEBUG (dev, "rx submit --> %d\n", retval);
                dev_kfree_skb_any (skb);
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

