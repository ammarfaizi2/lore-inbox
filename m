Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316086AbSETPdQ>; Mon, 20 May 2002 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316083AbSETPdP>; Mon, 20 May 2002 11:33:15 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:20650 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S316082AbSETPdO>; Mon, 20 May 2002 11:33:14 -0400
Date: Mon, 20 May 2002 17:33:10 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: will fitzgerald <william.fitzgerald6@beer.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff extraction problem
In-Reply-To: <881711E8388E16A4DA8E2FCAA1BD2387@william.fitzgerald6.beer.com>
Message-ID: <Pine.GSO.4.05.10205201727150.7665-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Will,

--snip/snip

> for no particular reason i choose dev.c and a function called 
> netif_rx to do this.
> 
> at the beginning of netif_rx() i added the lines:
> int this_cpu = smp_processor_id();
> ........
>         char *p;
>         int i;
>         
>                  //  p=   (char *) (skb->mac.ethernet);
>                     p=   (char *) (skb->h.uh);
> 
> then just before return softnet_data[this_cpu].cng_level;
> i added this:
> 
> for( i=0; i<8;i++){
>             printk(KERN_DEBUG"netif_rx() ->ethernet: %02x ",*(p+i));
>             }
> 
> it complies but as soon as i pass a packet through it the router 
> freezes up.
> 
> am i even on the rigth track?

you're on the right track if you want to freeze up your machine. :)

ok, here we go:

netif_rx is called from the driver, and at this point of skbs
livetime you can just be sure about the datalink layer beeing
decapsulated (called by the driver (e.g. eth_type_trans)).

so this means: you have a valid skb->mac.ras well as the skb->data
beeing a pointer to your network layer. - and that's about it ...
if you want to know about IP headers, you should hook into the network
subsystem at the IP layer (and there's already a nice NF_HOOK
- called NF_IP_LOCAL_IN)

anyhow - try to use the infrastructure which is already there.

	my $0.02

		tm
-- 
in some way i do, and in some way i don't.

