Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUAPGd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 01:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUAPGd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 01:33:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:61453 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265254AbUAPGdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:33:24 -0500
Date: Fri, 16 Jan 2004 07:33:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Joonas Koivunen <rzei@mbnet.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Duplex setting with pcnet32 driver, help appriciated
Message-ID: <20040116063321.GJ545@alpha.home.local>
References: <200401142234.27757.rzei@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401142234.27757.rzei@mbnet.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 10:34:27PM +0200, Joonas Koivunen wrote:
> Hey everone,
> 
> A friend of mine just told me that my Internet connection should be 1024/1024 
> (full duplex), not 1024(hf) shared by up- and download -- as it is at the 
> moment. The connection is HomePNA for which I've got this cheap pci card, 
> can't know who has made it. 

It's independant of your network card. The full duplex is between your modem,
router, or I don't know what and your provider. It can fully be half duplex
between this equipment and your network card.

>         Supports auto-negotiation: Yes
>         Advertised link modes:  Not reported
>         Advertised auto-negotiation: No
>         Speed: 10Mb/s
^^^^^^^^^^^^^^^^^^^^^^^^^

Your card is connected at 10 Mbps, so the other end is at 10 Mbps too. There
are very very very few hardware which support full duplex on 10 Mbps. It is
automatic for many people to think "half duplex" when they hear "10 Mbps".
So I really think that your equipment uses half duplex too. Don't worry, a
fully saturated 10 Mbps half converges to about 3.6 Mbps effective, which
is clearly enough for your usage.

> Bingo, it seems to support 10baseT/Full but is only at Half at the moment.
> # ethtool -s eth0 duplex full; ethtool eth0 | grep Duplex
>         Duplex: Half
> Damn.

It's very likely that the pcnet32 chip doesn't support full duplex on 10 Mbps.

> # ifconfig eth0 down; ethtool -s eth0 duplex full; ifconfig eth0 up; ethtool 
> eth0 | grep Duplex
>         Duplex: Half
> Still no change.

You should use ethtool on an up link preferably. Also, you can try to load
the module with "full_duplex=1" as a modprobe argument if you really want
to be sure.

Hoping this helps,
Willy

