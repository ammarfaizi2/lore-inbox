Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTEANuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbTEANuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:50:19 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:25359 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S261260AbTEANuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:50:18 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305011404.PAA17187@gw.chygwyn.com>
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
To: davem@redhat.com (David S. Miller)
Date: Thu, 1 May 2003 15:04:00 +0100 (BST)
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030501.054523.98892534.davem@redhat.com> from "David S. Miller" at May 01, 2003 05:45:23 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
>    From: Steven Whitehouse <steve@gw.chygwyn.com>
>    Date: Thu, 1 May 2003 14:27:08 +0100 (BST)
>    
>    Its got big again, so I've put it here, if you'd like it in bits rather than
>    all one lump, just shout:
> 
> Please do this because it's easier for me to evaluate small patches
> doing one thing at a time and you're also making modifications to
> things outside of decnet.
>
Ok. I'll do that later this afternoon.
 
> About update_pmtu().  You are not required to implement this.
> All of these places you see dereferencing dst->update_mtu()
> know that they have an ipv4/ipv6 route.  Or do you know some
> exception to this?
> 
I was thinking of that bit of code in ip_gre.c which I sent the fix for
recently. Unless I've missed something it calls update_pmtu on the dst
which is passed by the encapsulated protocol, although I've not actually
tested that.

Thats the reason I wasn't sure about the fix which I sent... it deleted the
duplicated call only for IPv4 rather than the one which appears to get called
for every protocol as I wasn't sure what was intended.

Either way it seems reasonable to pass this information back to the
protocol so perhaps it should say (in ipgre_tunnel_xmit()):

	if (skb->dst && skb->dst->ops->update_pmtu)
		skb->dst->ops->update_pmtu(skb->dst, mtu);
?

Steve.

