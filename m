Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135426AbRDRWWC>; Wed, 18 Apr 2001 18:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRDRWVv>; Wed, 18 Apr 2001 18:21:51 -0400
Received: from netsonic.fi ([194.29.192.20]:20492 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S135426AbRDRWVs>;
	Wed, 18 Apr 2001 18:21:48 -0400
Date: Thu, 19 Apr 2001 01:21:29 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Julian Anastasov <ja@ssi.bg>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Broken ARP (was Re: ARP responses broken!)
In-Reply-To: <Pine.LNX.4.30.0104180131330.7698-100000@u.domain.uli>
Message-ID: <Pine.LNX.4.33.0104190118540.27239-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Julian Anastasov wrote:

>
> 	Hello,
>
> Sampsa Ranta wrote:
>
> > The code I used to do the trick at my network was as simple as this,
> > in function arp_rcv, the problem is ip_dev_find that does know if there
> > are other devices with same IP address.
>
> 	I don't think this is your problem. You patch is not correct.
> In fact, you implement the same function as in "hidden" but you are
> missing some things. Please, read the "hidden" flag description in
> the kernel docs. You must solve the case where your ARP probes are sent
> always through one device due to your routing (this is out traffic,
> yes?). These probes soon or later will cause you problems because
> they change the entry in the remote hosts' ARP tables. You so carefully
> tried to advertise the address on specific interface and now the other
> hosts again talk to one card only.
>
> 	who-has 194.29.192.1 tell 194.29.192.38
>
> 	and your are dead :)
>
> 	So, please try "hidden" before going into more problems with
> these patches (I see two in this thread, and I saw so many before).

Are you referring to the arp_solicit()?

       if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
                saddr = skb->nh.iph->saddr;
       else
                saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);

Why is this hidden flag removed in 2.4 series with replacing no
functionality that would help to solve the problems?

 - Sampsa Ranta
   sampsa@netsonic.fi

