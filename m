Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRBYANw>; Sat, 24 Feb 2001 19:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRBYANi>; Sat, 24 Feb 2001 19:13:38 -0500
Received: from mail5.atl.bellsouth.net ([205.152.0.93]:40627 "EHLO
	mail5.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129736AbRBYANR>; Sat, 24 Feb 2001 19:13:17 -0500
Message-ID: <3A984E1A.DF67E730@mandrakesoft.com>
Date: Sat, 24 Feb 2001 19:13:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> <3A984BDA.190B4D8E@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Andi Kleen wrote:
> >
> > Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> >
> > > Advantages:  A de-allocation immediately followed by a reallocation is
> > > eliminated, less L1 cache pollution during interrupt handling.
> > > Potentially less DMA traffic between card and host.
> > >
> > > Disadvantages?
> >
> > You need a new mechanism to cope with low memory situations because the
> > drivers can tie up quite a bit of memory (in fact you gave up unified
> > memory management).
> 
> I think you misunderstand..  netif_rx frees the skb.  In this example:
> 
>         netif_rx(skb); /* free skb of size PKT_BUF_SZ */
>         skb = dev_alloc_skb(PKT_BUF_SZ)
> 
> an alloc of a PKT_BUF_SZ'd skb immediately follows a free of a
> same-sized skb.  100% of the time.
> 
> It seems an obvious shortcut to me, to have __netif_rx or similar
> -clear- the skb head not free it.  No changes to memory management or
> additional low memory situations created by this, AFAICS.

Sorry... I should also point out that I was thinking of tulip
architecture and similar architectures, where you have a fixed number of
Skbs allocated at all times, and that number doesn't change for the
lifetime of the driver.

Clearly not all cases would benefit from skb recycling, but there are a
number of rx-ring-based systems where this would be useful, and (AFAICS)
reduce the work needed to be done by the system, and reduce the amount
of overall DMA traffic by a bit.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
