Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136186AbRAYVM6>; Thu, 25 Jan 2001 16:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbRAYVMs>; Thu, 25 Jan 2001 16:12:48 -0500
Received: from ja.ssi.bg ([193.68.177.189]:23300 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S135827AbRAYVMh>;
	Thu, 25 Jan 2001 16:12:37 -0500
Date: Thu, 25 Jan 2001 23:13:42 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off ARP in linux-2.4.0
In-Reply-To: <20010125180858.A32328@lina.inka.de>
Message-ID: <Pine.LNX.4.30.0101252152001.929-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 25 Jan 2001, Bernd Eckenfels wrote:

> On Thu, Jan 25, 2001 at 01:02:32PM +0200, Julian Anastasov wrote:
> > 	Hey, the world is not only Linux. Sometimes the people build
> > clusters using different hardware and software. If your solution works
> > for your setup we can't claim it is universal.
>
> It is a Linux News Group after all. So dont confuse us with Broken Operating
> Systems. And of course we don't need a Hidden flag in Linux to solve other
> Operating Systems Auto-Binding.

	I'm talking about ARP. /etc/ethers is outdated. ARP is widely
used, especially in environments with many hosts on the LAN, for dynamic
setups, etc. And the clusters are not a static configurations.

> > 	You can't always use -arp!!! Read above. Fix the manual! BTW
> > in this thread I don't see wrong docs. Which ones claim this?
>
> The Manual is OK. It claims that -arp will work and it claims that on some
> Linux Sytems it wont (i am not sure why it should not work on old kernels
> but i accept it).

	It can work only in old kernels. -arp does not work in
Linux 2.2+, in the way you want.

> > 	-arp can work if you maintain a fresh copy in /etc/ethers and
> > when you don't use ARP. But then you don't need to set -arp flag. The
> > setup will work without setting -arp to lo or eth, right? If you don't
> > use ARP why to stop it in the interface? In theory we will not see any
> > ARP packets, even from the uplink router.
>
> I am not sure about this, because of the neighbour alive discovery. I dont
> know if a hard wired ARP Address will stop that.

	If we have static MAC entry in the requestor it is used, no
ARP probes are sent. If we receive ARP probes we reply them.

> > 	You are lucky to use Linux on all hosts. May be you have one
> > extra uplink router (a Linux box)?
>
> You can turn off arp discovery on every reasonable pwerfull router. And I
> dont see a situation where you want to build a HA/HP Cluster using you ISPs
> Router as a core component and the ISP is not cooperating with you.

	But when VIP is moved on failover I'll need access to this
router in the ISP :) So, I'll need one of the following three things:
(1) the uplink router password (2) how can I send a page to the ISP
admin (3) put own router

> > 	They are not complicated more in 2.4. The current handling in 2.4
> > is same. I already said that the net maintainers are planning other
> > features for 2.4 and the hidden feature is not considered. Until then
> > there is no difference between the kernels and the hidden feature can
> > be used even in 2.4.
>
> There is no hidden Feature in 2.4, thats why we have started the thread. And
> for exactly this reason I suggested to use -arp.

	There is a reason to apply -arp in Linux 2.2+ only to devices
that can talk ARP. So, your recommendation in Linux 2.2+ can be
formulated in this way: "Use ifconfig eth0 -arp and maintain fresh copy
in /etc/ethers on all hosts" :) Your suggestion can be valid may be for
Linux 2.0 only (not tested). In 2.2+ altering the arp flag for lo or
similar devices connected only to the host system is useless. An evidence
for this behavior is the fact that when you try

ifconfig lo -arp
ifconfig lo:0 A.B.C.D netmask 255.255.255.255

you can ping this address from another host :) It is replied. Yep,
I just tried it again in 2.4 for the test :)

> Greetings
> Bernd


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
