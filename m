Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316078AbSETPVT>; Mon, 20 May 2002 11:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316080AbSETPVS>; Mon, 20 May 2002 11:21:18 -0400
Received: from mailgw.prontomail.com ([209.185.149.10]:24807 "EHLO
	c0mailgw11.prontomail.com") by vger.kernel.org with ESMTP
	id <S316078AbSETPVS>; Mon, 20 May 2002 11:21:18 -0400
X-Version: beer 7.5.2333.0
From: "will fitzgerald" <william.fitzgerald6@beer.com>
Message-Id: <881711E8388E16A4DA8E2FCAA1BD2387@william.fitzgerald6.beer.com>
Date: Mon, 20 May 2002 16:16:55 +0100
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linux-kernel@vger.kernel.org
Subject: sk_buff extraction problem
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i'm having trouble extracting a packets source and destination 
address from the sk_buff. i want to be able to see if a packet does 
in fact pass through my router.

for no particular reason i choose dev.c and a function called 
netif_rx to do this.

at the beginning of netif_rx() i added the lines:
int this_cpu = smp_processor_id();
........
        char *p;
        int i;
        
                 //  p=   (char *) (skb->mac.ethernet);
                    p=   (char *) (skb->h.uh);

then just before return softnet_data[this_cpu].cng_level;
i added this:

for( i=0; i<8;i++){
            printk(KERN_DEBUG"netif_rx() ->ethernet: %02x ",*(p+i));
            }

it complies but as soon as i pass a packet through it the router 
freezes up.

am i even on the rigth track?

regards will.			


Beer Mail, brought to you by your friends at beer.com.
