Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbSLFESA>; Thu, 5 Dec 2002 23:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbSLFESA>; Thu, 5 Dec 2002 23:18:00 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:4486 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267552AbSLFER7>;
	Thu, 5 Dec 2002 23:17:59 -0500
Message-ID: <3DF026A4.5010801@candelatech.com>
Date: Thu, 05 Dec 2002 20:25:08 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Tomas Szepe <szepe@pinerecords.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
References: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 5 Dec 2002, Tomas Szepe wrote:

>>I'm not interested in rewriting the source address with netfilter based
>>on destination and/or service;  What I'm looking for is rather a way to
>>initiate two connections to the same destination host using the two
>>different source IP addresses.
>>
> 
> 
> The simple answer is that if you need a specific IP address
> associated with a "multi-honed" host, that has only one interface,
> then something is broken. And you get to keep the pieces.

> The IP addresses assigned to a multi-honed host are the addresses
> to which it will respond during ARP. The ARP (Address Resolution
> Protocol) you remember, is the protocol used to get the "hardware"
> or IEEE station address of the interface.
> 
> Any IP protocol will properly work with any IP address embedded in
> the packet from the interface that responded to the ARP.
> 
> However, the IP address inside the data-gram will usually be
> the IP address of the interface that first sent that packet.
> The IP address used is the address of the interface that met
> the necessary criteria for getting the data-gram onto the wire.
> In other words, the net-mask and the network address are the
> determining factors. If you have two or more IP addresses that
> are capable of putting the data-gram on the wire, the first one,
> i.e., the address used to initialize the interface first, will
> be the one that is used in out-going packets.

You may be able to influence this with policy-based routing and
the arp-filter code.

> 
> Since you don't bind a socket to a specific IP address when
> initiating connections, you can't chose what IP address will
> be used for those connections. However, when setting up
> a server that will accept connections, you bind that socket
> to both an IP address and a port. Therefore, a server can
> be created that accepts connections only to a specific IP
> address of a multi-honed host.

You certainly can bind to a specific IP and/or port when initiating
a connection.  You can use the local IP to do source-based routing.

I have not done exactly the thing described here, but I have done
similar things, certainly binding to ports & ips on both server
and initiator side of an IP connection.


> There is no RightWay(tm) because any attempt to choose a specific
> IP to on the wire from a machine that has only one interface, but
> is multi-honed, is broken at the start. However, you can chose where

I think you presume too much about what other people might consider
broken or not. :)


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


