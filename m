Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129923AbRBZULZ>; Mon, 26 Feb 2001 15:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129937AbRBZULQ>; Mon, 26 Feb 2001 15:11:16 -0500
Received: from mail1.atl.bellsouth.net ([205.152.0.28]:30605 "EHLO
	mail1.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129923AbRBZULE>; Mon, 26 Feb 2001 15:11:04 -0500
Message-ID: <3A9AB84C.A17D20AE@mandrakesoft.com>
Date: Mon, 26 Feb 2001 15:10:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: pat@isis.co.za, linux-kernel@vger.kernel.org, Alan@redhat.com
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
In-Reply-To: <3A9A30C7.3C62E34@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> I think I found the bug:
> 
> Someone (Jeff?) removed the line
> 
>         tp->advertising[phy_idx++] = reg4;
> 
> from tulip/tulip_core.c
> 
> pnic_check_duplex uses that variable :-(
> 
> There are 2 workarounds:
> 
> * change pnic_check_duplex:
> s/tp->advertising[0]/tp->mii_advertise/g
> 
> * remove the new mii_advertise variable and replace it with
> 'tp->advertising[i]'.

mii_advertise is what MII is currently advertising on the current
media.  tp->advertising is per-phy, on the other hand.

Pat, Manfred, in pnic_check_duplex, make this change:
> -        negotiated = mii_reg5 & tp->advertising[0];
> +        negotiated = mii_reg5 & tulip_mdio_read(dev, tp->phys[0], 4);

and let me know how it goes.  I'm tempted to just remove
tp->advertising[] altogether.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
