Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUKSUVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUKSUVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKSUTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:19:08 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:39562 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261574AbUKSUSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:18:34 -0500
Message-ID: <419E550B.7030107@colorfullife.com>
Date: Fri, 19 Nov 2004 21:18:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>,
       Jason McMullan <jason.mcmullan@timesys.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] MII bus API for PHY devices
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't like the polling/interrupt setup part:
- for a nic driver, there is no irq line that could be requested by 
mii_phy_irq_enable().
- if the mii bus driver uses it's own timers, then locking within the 
nics will be more difficult.

Could you make that part optional? For a nic driver, I would prefer if I 
could just call the ->startup part without the request_irq. If the nic 
irq handler notices that the nic got an event, then it would call an 
appropriate mii_bus function.

This also applies for something like /dev/phy/xy: With natsemi, it would 
be very tricky to add proper locking. The nic as an internal phy and an 
external mii bus. The internal phy is partially visible on the external 
bus and any accesses to the phy id of the internal phy on the external 
bus cause lockups. No big deal, I just move the internal phy around [the 
phy id doesn't matter], but I would prefer if I have to do that just for 
ethtool, not for multiple interfaces.

--
    Manfred
