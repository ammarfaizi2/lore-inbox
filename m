Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSH0TXZ>; Tue, 27 Aug 2002 15:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSH0TXZ>; Tue, 27 Aug 2002 15:23:25 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:38922 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S314149AbSH0TXY>;
	Tue, 27 Aug 2002 15:23:24 -0400
Date: Tue, 27 Aug 2002 21:27:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Steffen Persvold <sp@scali.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020827192738.GB28513@alpha.home.local>
References: <Pine.LNX.4.44.0208271934180.18659-100000@sp-laptop.isdn.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208271934180.18659-100000@sp-laptop.isdn.scali.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 08:22:03PM +0200, Steffen Persvold wrote:
 
> I have an idea that this happens because the packets are comming out of 
> order into the receiving node (i.e the bonding device is alternating 
> between each interface when sending, and when the receiving node gets the 
> packets it is possible that the first interface get packets number 0, 2, 
> 4 and 6 in one interrupt and queues it to the network stack before packet 
> 1, 3, 5 is handled on the other interface).

You pointed your finger on this exact common problem.
You can use the XOR bonding mode (modprobe bonding mode=2), which uses a
hash of mac addresses to select the outgoing interface. This is interesting
if you have lots of L2 hosts on the same network switch.

Or if you have a few hosts on the same switch, you'd better use the "nexthop"
parameter of "ip route". IIRC, it should be something like :
  ip route add <destination> nexthop dev eth0 nexthop dev eth1
but read the help, I'm not certain.

Cheers,
Willy

