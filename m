Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbRCaPGZ>; Sat, 31 Mar 2001 10:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRCaPGP>; Sat, 31 Mar 2001 10:06:15 -0500
Received: from [213.128.193.148] ([213.128.193.148]:774 "EHLO dredd.crimea.edu")
	by vger.kernel.org with ESMTP id <S132414AbRCaPGD>;
	Sat, 31 Mar 2001 10:06:03 -0500
Date: Sat, 31 Mar 2001 19:03:14 +0400
From: Oleg Drokin <green@dredd.crimea.edu>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, david-b@pacbell.net
Subject: Re: IP layer bug?
Message-ID: <20010331190314.A27130@dredd.crimea.edu>
In-Reply-To: <20010325005731.A5243@dredd.crimea.edu> <200103301713.VAA03794@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200103301713.VAA03794@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Mar 30, 2001 at 09:13:40PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 30, 2001 at 09:13:40PM +0400, kuznet@ms2.inr.ac.ru wrote:
> >    For now I workarounded it with filling skb->cb with zeroes before
> >    netif_rx(),
> This is right. For another examples look into tunnels.
Hm. But comment in linux/skbuff.h says:
        /*
         * This is the control buffer. It is free to use for every
         * layer. Please put your private variables there. If you
         * want to keep them across layers you have to do a skb_clone()
         * first. This is owned by whoever has the skb queued ATM.
         */
Which does not imply I should clear buffer after I am passing ownership.

> > but I believe it is a kludge and networking layer should be fixed instead.
> No.

> alloc_skb() creates skb with clean cb. ip_rcv() and other protocol handlers
> do not redo this work. If device uses cb internally, it must clear it
> before handing skb to netif_rx().
Why not document it somewhere, so that others will not fall into the same trap?

Bye,
    Oleg
