Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264177AbRFNX24>; Thu, 14 Jun 2001 19:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFNX2p>; Thu, 14 Jun 2001 19:28:45 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:37509 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264177AbRFNX2c>;
	Thu, 14 Jun 2001 19:28:32 -0400
Message-ID: <3B294898.CEFE387F@candelatech.com>
Date: Thu, 14 Jun 2001 16:28:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: questions about link-level loopback, PF_PACKET and ETH_P_LOOP
In-Reply-To: <3B2926A3.C3B65EBB@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> I'm attempting to write a piece of code that will validate the physical ethernet
> link from a NIC to the nearest router/hub/switch.  What I'd like to do is to
> send out an ethernet packet addressed to me, bounce it off the
> hub/switch/router, and then read it back in.  This is all at the ethernet layer.
> 

No properly configured ethernet hub or router will return you the
same packet you sent.  You can get some of this information out of the
drivers though, as their hardware knows the link state, at least the
physical layer.

Check out Becker's mii-diag program.  There are some options
in it to dump out all kinds of neat information about the drivers
and link condition.

> The nitty-gritty on this is that I have a machine that has two NICs but only one
> IP address.  I want to do some kind of packet loopback at the ethernet layer to
> verify that my NIC transceiver is working properly.

Ping your switch.  Or use something like ethernet channel bonding.

If both ports are up, then you should be able to send a pkt
from one NIC with your other NICs MAC in it, and the switch should deliver
that pkt to your other NIC.  However, if you don't receive the packet, you
cannot determine which one of your links/NICs is bad without going to
a third party (which I suggest should be your switch itself).

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
