Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbRBLPMV>; Mon, 12 Feb 2001 10:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRBLPML>; Mon, 12 Feb 2001 10:12:11 -0500
Received: from [199.202.147.246] ([199.202.147.246]:52752 "EHLO
	norton.miranda.com") by vger.kernel.org with ESMTP
	id <S129135AbRBLPL4>; Mon, 12 Feb 2001 10:11:56 -0500
Message-ID: <3A87FD00.1040309@cam.org>
Date: Mon, 12 Feb 2001 10:10:56 -0500
From: "Justin F. Knotzke" <shampoo@cam.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17 i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: protocol fe11 is buggy, dev eth0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I am running kernel 2.2.17 and my logs are littered with:

"protocol fe11 is buggy, dev eth0." I managed to locate where in the 
source code this line gets printed. However I can't say much more then that.

	Any ideas if this has been fixed? Please cc to my address since I am not 
on the list.

	Justin.



This msg comes from the kernel (as syslog mentions), more precisely from
$(LK_SRC_ROOT)/net/core/dev.c (usually $(LK_SRC_ROOT)=/usr/src/linux) :

       /* More sensible variant. skb->nh should be correctly
          set by sender, so that the second statement is
          just protection against buggy protocols.
       */
       skb2->mac.raw = skb2->data;

       if (skb2->nh.raw < skb2->data || skb2->nh.raw >= skb2->tail) {
               if (net_ratelimit())
                       printk(KERN_DEBUG "protocol %04x is buggy, dev
%s\n", skb2->protocol, dev->name);
               skb2->nh.raw = skb2->data;
               if (dev->hard_header)
                       skb2->nh.raw += dev->hard_header_len;
       }

-- 
Justin F. Knotzke
shampoo@cam.org
pgp public key http://www.shampoo.ca/pubkey.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
