Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132111AbRAYAIp>; Wed, 24 Jan 2001 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAYAIg>; Wed, 24 Jan 2001 19:08:36 -0500
Received: from quechua.inka.de ([212.227.14.2]:9270 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132111AbRAYAIV>;
	Wed, 24 Jan 2001 19:08:21 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off ARP in linux-2.4.0
Message-Id: <E14LZxc-0003B3-00@sites.inka.de>
Date: Thu, 25 Jan 2001 01:08:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0101242303310.956-100000@u.domain.uli> you wrote:
>> -arp will do that

> 	Not in Linux 2.2+, all addresses are replied. -arp only
> means "don't talk ARP", in our case we talk through eth0, so we don't
> want to stop it, right?

why not? if you hard wire the MAC Address of your web servers to all other
hosts (i dont asume you have a lot of them on the high speed cluster
interconnect network, that would defeat the purpose totally). After all, thats
what /etc/ethers is for (for ages).

> 	They come/go from/through eth0. We don't use ifconfig eth0 -arp

why not?

> 	Run ifconfig eth0 0.0.0.0 up and you will create connections
> with saddr=shared_address (hidden=0), even when it is configured
> on loopback device.

Yes, but why dont you simply assign an ip address to eth0? It wont change the
situation if you turn ARP off. And the answer to an incoming packet will
always use the destination from the request as the source of the response.
After all you do not open outgoing connections in the cluster mode.
>>
>> Well.. another solution would be to use the ipip system instead of the arp
>> redirection, right?

> 	No. Forget about the ARP flag. This is not Linux 2.0. The

I was talking about IPIP targeting instead of MAC targeting as an alternative.

> hidden flag emulates Linux 2.0. In Linux 2.2+ all addresses are reported,
> with some exceptions: LOOPBACK and MULTICAST. The device type and
> its ARP flag are not involved in the decision.

We are talking about Linux 2.4 which has the problem not to support that
stupid hidden stuff. And it is, as i tried to explain not needed if you can do
-arp. Hey, this was quoted in the manual in the first post.

> 	The setup (think about a web cluster):

As i described a few posts ago to andi it works with -arp on eth0 instead of
hidden (after all the original question was a solution to avoid the missing
hidden syscall)

> 	- the real servers ignore/don't reply when the broadcasted
> 	probes are for VIP (hidden=1)
or they dont replay because arp is turned off... see.. its the same solution

> 2. director forwards (after scheduling) the packet to one of the
> real servers without changing it (this is not a NAT forwarding method)

it is changing the packets MAC destination address (or using an IPIP tunnel).

> 4. the real server wants to reply to the client address CIP, so it
> resolves its next hop (the uplink router):

> 	- the wrong ARP probe (hidden=0)
> 	who-has 10.0.0.1 tell 10.0.0.100

it wont. it has turned arp off and it has the address of 10.0.0.1 in the arp
table (by /etc/ethers).

> 	Where is the problem:

There is less problems in my setup than in yours.

> 	About the autoselection. Sometimes it can happen! Addresses

I dont know which auto selection you arer talking about. A tcp socket will
auto seect the source address if there was no local bind. In that case it will
ALWAYS use the local address of the device the route to the target is locked
at. Normally thats the first address of the ethernet card which is connected
to the default gateway.

> 	Complex enough?

i think you make yourself problems.

> I will not enter in more details here because, I repeat, the setups
> can be very complex.

I wonder why they get so complicated in the last few month. Somebody is
overcomplicating it. And as I said and as you can read on your own web page,
IPIP is alays available.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
