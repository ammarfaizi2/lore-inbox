Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbQLOBTa>; Thu, 14 Dec 2000 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOBTU>; Thu, 14 Dec 2000 20:19:20 -0500
Received: from Cantor.suse.de ([194.112.123.193]:44042 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129267AbQLOBTA>;
	Thu, 14 Dec 2000 20:19:00 -0500
Date: Fri, 15 Dec 2000 01:48:32 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: laforge@gnumonks.org, ionut@cs.columbia.edu, mhaque@haque.net,
        linux-kernel@vger.kernel.org
Subject: Re: Netfilter is broken (was Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback))
Message-ID: <20001215014832.A27064@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu> <200012141955.LAA08814@pizda.ninka.net> <20001215012000.B6775@coruscant.gnumonks.org> <200012150011.QAA12767@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012150011.QAA12767@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 14, 2000 at 04:11:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 04:11:10PM -0800, David S. Miller wrote:
>    Date: Fri, 15 Dec 2000 01:20:00 +0100
>    From: Harald Welte <laforge@gnumonks.org>
> 
>    Or is there something wrong with:
> 
>    - packet arrives in net/ipv4/ip_input.c:ip_rcv()
>    - netfilter hook NF_IP_PRE_ROUTING is called
>    - net/ipv4/netfilter/ip_conntrack_core.c:ip_conntrack_in() is called
>    - net/ipv4/netfilter/ip_conntrack_core.c:ip_ct_gather_frags() is called
>    - net/ipv4/ip_input.c:ip_defrag() is called
> 
>    Isn't the skb->dev member supposed to still point to the receiving 
>    device?
> 
> No, once you submit the packet to the defrag layer, that SKB
> instance is owned by the defrag layer.
> 
> One way to do what netfilter wants to do, but legally, is to
> simply skb_clone() the SKB before passing it into the
> defragmentation code.

What should it do with the uncloned, not defragmented copy ? 
It makes not much sense to clone it.

Also is it sure that the backtrace involves ip_rcv ? A more likely
guess is that it happens during the IP_LOCAL_OUT hook, when skb->dev 
isn't set yet, but conntrack already has to already reassemble fragments.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
