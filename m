Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUFQTGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUFQTGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUFQTGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:06:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:34783 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261802AbUFQTGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:06:00 -0400
Date: Thu, 17 Jun 2004 21:05:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "David S. Miller" <davem@redhat.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: igmp warning (was: Re: Linux 2.4.27-pre6)
In-Reply-To: <Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0406172058000.1495@waterleaf.sonytel.be>
References: <20040616183343.GA9940@logos.cnet> <Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And this is a new one (compared to -pre3):

| igmp.c: In function `igmpv3_newpack':
| igmp.c:279: warning: `skb' might be used uninitialized in this function

And it seems to be a real bug, not a compiler glitch:

| static struct sk_buff *igmpv3_newpack(struct net_device *dev, int size)
| {
|         struct sk_buff *skb;
                          ^^^
|         struct rtable *rt;
|         struct iphdr *pip;
|         struct igmpv3_report *pig;
|         u32     dst;
|
|         dst = IGMPV3_ALL_MCR;
|         if (ip_route_output(&rt, dst, 0, 0, dev->ifindex))
|                 return 0;
|         if (rt->rt_src == 0) {
|                 kfree_skb(skb);
                            ^^^
|                 ip_rt_put(rt);
|                 return 0;
|         }


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
