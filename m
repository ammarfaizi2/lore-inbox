Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSING7K>; Sat, 14 Sep 2002 02:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319856AbSING7K>; Sat, 14 Sep 2002 02:59:10 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:9159 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S316545AbSING7K> convert rfc822-to-8bit; Sat, 14 Sep 2002 02:59:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>, buytenh@math.leidenuniv.nl
Subject: Re: bridge-netfilter patch
Date: Sat, 14 Sep 2002 09:05:40 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200209130812.27093.bart.de.schuymer@pandora.be> <20020913144518.A31318@math.leidenuniv.nl> <20020913.112235.27948638.davem@redhat.com>
In-Reply-To: <20020913.112235.27948638.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209140905.40816.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 20:22, David S. Miller wrote:
>    From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
>    Date: Fri, 13 Sep 2002 14:45:18 +0200
>
>    > You need to remove the IPv4 bits, that copy of the MAC has to happen
>    > at a different layer, it does not belong in IPv4.  At best, everyone
>    > shouldn't eat that header copy.
>
>    What if I make the memcpy conditional on "if (skb->physindev != NULL)"?
>
> First explain to me why the copy is needed for.

memcpy(skb2->data - 16, skb->data - 16, 16);

This is for purely bridged packets.
IP connection tracking first gathers all fragments, before the bridged IP 
packets are sent out the packet is fragmented. However, since this 
fragmenting actually happens while the IP packet "is in the bridge code", no 
existing code makes sure the fragments' Ethernet headers are correctly 
filled. Now, AFAIK an Ethernet header has length 14 bytes, so don't ask me 
why the magic number 16 is used (Lennert got IP fragmenting fixed).
A nice comment in front of that copy is certainly needed...

-- 
cheers,
Bart

