Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWIPMTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWIPMTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWIPMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:19:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:953 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964792AbWIPMTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:19:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YuyZvRiz6LAARV6msskUd9lyKTSjjZuOt5xlrhZTQtv4Om7L2KjacluKJSB462lagIwj4ychODylDXkDiTSJ/AQIB2O0KqY/wMX+hd0tP28kD65G1UVxBlOoSiFYoZ5/0Q28a8uceF91cTuHtuenJ7uqfnwPhWKwYAYFtCpKp6U=
Message-ID: <a885b78b0609160519p16874684l1926b32236b33d16@mail.gmail.com>
Date: Sat, 16 Sep 2006 20:19:34 +0800
From: "xixi lii" <xixi.limeng@gmail.com>
To: "Holy Aavu" <holyaavu@gmail.com>
Subject: Re: UDP question.
Cc: davids@webmaster.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <bd7767e40609160059t43d401bep7d895e5d9d7f41ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a885b78b0609150007u239cf363l40dd122165f7b516@mail.gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKGECFOHAB.davids@webmaster.com>
	 <a885b78b0609151702r3b4086c4l3bb79c2e5c9ddf4a@mail.gmail.com>
	 <bd7767e40609160059t43d401bep7d895e5d9d7f41ea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/9/16, Holy Aavu <holyaavu@gmail.com>:
> On 9/16/06, xixi lii <xixi.limeng@gmail.com> wrote:
> > 2006/9/16, David Schwartz <davids@webmaster.com>:
> > >
> > > > My two adapters has two different IP address, and I bind one IP
> > > > on one socket,
> > > > do you mean that I alloc two socket and bind different IP is not
> > > > helpful?
> > >
> > >        Correct. You are still sending all the packets *to* the same place.
> > >
> > > > In fact, all the packet sent from two socket is go out by one
> > > > network adapter?
> > >
> > >        Yes, of course. Why would the kernel send traffic to a destination out an
> > > interface that doesn't go to that destination?
> > >
> > >        Suppose you have two interfaces, 1.2.3.4/8 and 10.2.3.4/8, if you are
> > > sending a packet *to* 1.2.4.5, it will go out the first interface. This
> > > applies whether the source address is 1.2.3.4 or 10.2.3.4.
> > >
> > >        By default, the kernel routes traffic based on where it is going, not which
> > > interface address it came from.
> > >
> > >        DS
> > >
> >
> > Let me explain my network environment, My program is running on a two
> > adapters machine, whose IP is 192.168.0.1/8 and 192.168.0.2/8, then,
> > my destination is two machine, whose IP is 192.168.0.3/8 and
> > 192.168.0.4/8. I use four 100M exchange and a 1000M exchange cennected
> > them to ensure the choke point is not at network  equipment.
> >
> > when I use two socket without bonding, one socket is bind
> > 192.168.0.1/8 and sendto 192.168.0.3/8, the other is bind
> > 192.168.0.2/8 and sendto 192.168.0.4/8, but, as you see, I get a
> > result that the speed of send by two adapters is equal to the only one
> > adapter's.
>
> why dont you try a different subnet for the other adapter & its dest.
> something like 192.168.1.2/8 & dest 192.168.1.4/8 ?
>
> Because whenever a packet needs to be sent out, the routing table is
> consulted. (check out the output of route / netstat -nr ) So for a
> given subnet, only the first interface encountered in the table is
> used. Remaining interfaces are used, only if the first fails fails.
>
> >
> > yesterday. I got an uncertain idea, is the problem that IP layer is
> > separate with Eth layer ? when I bind src IP, it just do helpful to IP
> > layer, not real bind the adapter? when I send, the real ethreal
> > adapter is select by IP route? If the two interface can go
> > destinnation both, IP layer will choose the frist, not use both? Am I
> > right?
>
> yes, that is what the routing table is about.
>
> > If so, when I use bonding, the adapter's physical address is the frist
> > one, Do this means that all of the packet come to my machine will go
> > through in the frist one adapter?
>
> No. It just means that the MAC address of the 2 nd card is overridden
> with the 1st one's MAC. i.e. all packets sent through 2nd NIC will
> bear the 1st MAC. The reason this is done is not to confuse network
> equipment which sends out ARP messages etc to resolve IP addresses.
> (Switches should be intelligent here, else you will have issues with
> recving packets on both interfaces).
>
Sorry, I still don't understand how can I recv packets on both
interfaces, Since the two adapters have the same MAC address, the
packet will be the same in the field of ethreal protocol, Do you means
that the switch will choose the two adapters with a balance policy, or
I must do configure on switch?

xixi
