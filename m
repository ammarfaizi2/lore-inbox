Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSDXSE4>; Wed, 24 Apr 2002 14:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSDXSEz>; Wed, 24 Apr 2002 14:04:55 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:22409 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312484AbSDXSEx>;
	Wed, 24 Apr 2002 14:04:53 -0400
Message-ID: <3CC6F3BF.8050504@candelatech.com>
Date: Wed, 24 Apr 2002 11:04:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <garzik@havoc.gtf.org>
CC: "David S. Miller" <davem@redhat.com>, jd@epcnet.de,
        linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
In-Reply-To: <20020424.093515.82125943.davem@redhat.com> <721506265.avixxmail@nexxnet.epcnet.de> <20020424.095951.43413800.davem@redhat.com> <3CC6EBF1.9060902@candelatech.com> <20020424134933.A17852@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:

> On Wed, Apr 24, 2002 at 10:31:29AM -0700, Ben Greear wrote:
> 
>>Also, is there any good reason that we can't get at least a compile
>>time change into some of the drivers like tulip where we know we can
>>get at least MOST of the cards supported with a small change?
>>
> 
> The tulip patch is butt-ugly - the oversized allocation isn't needed,
> and it just flat-out turns off large packet protection.  That's really
> not what you want to do, even for the best tulip cards.  If an oversized
> gram (non-VLAN) makes it into a network which such a patched tulip
> driver, you can DoS.  So, I view the current tulip patch as unacceptable
> too -- for security reasons, we should not even take it as a compile
> time patch.  (and I recommend against using that patch on production
> machines, for the same security reasons)


I can DOS a tulip card with very small packets too ;)

The oversized allocations can be removed from the patch since they
are not needed.


> The proper tulip patch does not need to change packet allocation size
> at all (it's already plenty big enough), and it needs to copy the RX
> fragment handling code from 8139cp (which is admittedly ugly, slow path)
> or write fresh fragment handling code.  Along with that fragment
> handling code comes a safe way to do VLAN, and non-standard large MTUs
> in general.


In the general case, where the packets are only 1518 (ie no DoS or mis-configured
hardware is in effect), is there a need for the "ugly, slow path" code to run?


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


