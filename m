Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRAXPOQ>; Wed, 24 Jan 2001 10:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbRAXPOG>; Wed, 24 Jan 2001 10:14:06 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:5649 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129774AbRAXPNx>;
	Wed, 24 Jan 2001 10:13:53 -0500
Message-ID: <3A6F00C5.F9962FCB@candelatech.com>
Date: Wed, 24 Jan 2001 09:20:21 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weis <djweis@sjdjweis.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: changing mac address of eth alias
In-Reply-To: <Pine.LNX.4.21.0101241309410.25159-100000@www.sjdjweis.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weis wrote:
> 
> On Tue, 23 Jan 2001, Ben Greear wrote:
> > David Weis wrote:
> > > what would be required to make the mac address of aliases changable,
> > > specifically for something like vrrp that shares a mac address among
> > > machines.
> >
> > Not sure you can do that, but you could use an 802.1Q vlan patch
> > and set up two different VLANs.  You can now change the MAC
> > address on a VLAN with my patch: http://scry.wanfear.com/~greear/vlan.html
> 
> I'm looking at your code, in the function
> vlan_dev_set_multicast_list() for the 2.4 tree, you enable promiscuity and
> reception of all multicast packets. Is this necessary for all cards?

Hrm, it should only turn on that particular multicast address, not go PROMISC.
I will look at that.

The change-MAC DOES turn on PROMISC, because that is the only way I could
figure out how to make sure that the underlying device passed the packets
up to the VLAN layer.  The idea is that if you are using VLANs, you are
probably using an ethernet switch, so there shouldn't be TOO much traffic
on your port that isn't destined for you...so being PROMISC shouldn't
hurt too bad.

> 
> This looks pretty close to what I was looking for, thanks for the
> pointer. Do the multicast functions have enough usefulness for things
> other than VLAN to be split out separately?

I think the advanced routing protocols (OSPF??) use multicast in their routing
decisions/management.

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
