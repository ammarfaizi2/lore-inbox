Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264722AbSKDQJU>; Mon, 4 Nov 2002 11:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264727AbSKDQJU>; Mon, 4 Nov 2002 11:09:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:45443 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264722AbSKDQJT>; Mon, 4 Nov 2002 11:09:19 -0500
Date: Mon, 4 Nov 2002 11:18:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Helio Fujimoto <fujima@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Removing the route when Ethernet link goes down
In-Reply-To: <02110412561200.01022@fujima>
Message-ID: <Pine.LNX.3.95.1021104111227.12400A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Helio Fujimoto wrote:

> Please answer this e-mail with copy to me, for I am not subscribed to the 
> list.
> 
> I am debugging an Ethernet driver in the kernel 2.4.17, which is able to 
> recognize when the Ethernet link is up or down. When the link is up, I am 
> setting the bit IFF_RUNNING to the dev->flag parameter, and when it is down 
> this bit is reset. Besides this, I am calling the routines netif_carrier_on 
> and netif_carrier_off, respectively. This makes the interface status change 
> (when I call ifconfig eth0).
> 
> However, the routing table doesn't change when link goes up or down, though 
> they do change when I set the interface up and down. I couldn't find out what 
> I could do to make the Ethernet driver work in this way, so that the routes 
> to the Ethernet link would appear only if the interface was up and running. 
> Do you have an easy (or maybe difficult) way to do this? Any routine, any 
> magic?
> 
> Thanks in advance,
> 
> Helio Fujimoto.
> 
User-mode code will reset the RTF_UP bit in the rt_flags member
of struct rtentry. This is the SIOCDELRT ioctl call. I have found
that, at least for 2.4.18 and previous, you need to delete any
previous route with the same parameters before setting any new one.
It seems that a default route ends up being set by merely setting
parameters for the interface.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


