Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272114AbRHXPUI>; Fri, 24 Aug 2001 11:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRHXPT6>; Fri, 24 Aug 2001 11:19:58 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:31154 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272114AbRHXPTo>;
	Fri, 24 Aug 2001 11:19:44 -0400
Message-ID: <3B867096.3A1D7DE@candelatech.com>
Date: Fri, 24 Aug 2001 08:19:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Bernhard Busch <bbusch@biochem.mpg.de>, linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Bernhard Busch <bbusch@biochem.mpg.de> writes:
> 
> > Hi
> >
> >
> > I have tried to use ethernet  network interfaces bonding to increase
> > peformance.
> >
> > Bonding is working fine, but the performance is rather poor.
> > FTP between 2 machines ( kernel 2.4.4 and 4 port DLink 100Mbit ethernet
> > card)
> > results in a transfer rate of 3MB/s).
> >
> > Any Hints?
> 
> Bonding reorders packets, which causes frequent retransmits and stalls in TCP.
> One setup that doesn't is multipath routing (ip route .. with multiple
> nexthops over different interfaces). It'll only load balance (srcip, dstip,tos)
> tuples though, not individual flows, but then it has the advantage that
> it actually works.

Couldn't the bonding code be made to distribute pkts to one interface or
another based on a hash of the sending IP port or something?  Seems like that
would fix the reordering problem for IP packets....  It wouldn't help for
a single stream, but I'm guessing the real world problem involves many streams,
which on average should hash such that the load is balanced...

Ben

> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
