Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266625AbUFWUW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266625AbUFWUW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUFWUW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:22:56 -0400
Received: from mail.njit.edu ([128.235.251.173]:45274 "EHLO mail-gw5.njit.edu")
	by vger.kernel.org with ESMTP id S266625AbUFWUWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:22:54 -0400
Date: Wed, 23 Jun 2004 16:22:53 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about ip_rcv() function
In-Reply-To: <20040623115027.11ef0902.davem@redhat.com>
Message-ID: <Pine.GSO.4.58.0406231615220.7099@chrome.njit.edu>
References: <20040622212403.21346.qmail@lwn.net> <Pine.GSO.4.58.0406231441500.7099@chrome.njit.edu>
 <20040623115027.11ef0902.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response.

I just want to know if my understanding of how the sk_buff structure is
correct.

When data arrives at the TCP layer it is pointed to by the data pointer
and the TCP header goes in the skb->data-skb->head area. When this packet
is passed to the IP layer, skb->tail-skb->data section will now contain
the TCP header + TCP data and now the IP header will be put in the new
skb->data-skb->head area.

Please let me know if this understanding is correct.

I also wanted to know does psk_may_pull() only check for correct header
length or does it (thought some func calls) strip off the IP header ?

Thanks,
Rahul.

On Wed, 23 Jun 2004, David S. Miller wrote:

> On Wed, 23 Jun 2004 14:45:47 -0400 (EDT)
> rahul b jain cs student <rbj2@oak.njit.edu> wrote:
>
> > can anyone explain what is the difference between the following two pieces
> > of code.
> >
> > 1. if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> >                 goto inhdr_error;
> >
> >    iph = skb->nh.iph;
> >
> > 2. if (!pskb_may_pull(skb, iph->ihl*4))
> >                 goto inhdr_error;
> >
> >    iph = skb->nh.iph;
>
> We can't dereference any of the iphdr fields (such as iph->ihl) until
> we know that at least "sizeof(struct iphdr)" bytes are there first.
>
