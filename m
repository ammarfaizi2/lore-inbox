Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTBLXJL>; Wed, 12 Feb 2003 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267926AbTBLXJL>; Wed, 12 Feb 2003 18:09:11 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:27024 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267925AbTBLXJG>; Wed, 12 Feb 2003 18:09:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2003 10:18:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
Subject: Routing problem with udp, and a multihomed host in 2.4.20
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have three subnets.  A, B and C.

I have a Linux 2.4.20 server, named bartok, with three interfaces, one
on each subnet (so it can listen to broadcast requests everywhere).

This server has a default route pointing at A.

I have a router that routes between all these subnets, and others.

I have a client that sits on subnet B.

When my client tries to talk to bartok, it might try any of 3 IP
addresses (Due to round-robining in the DNS).

All IP addresses work find when establishing a TCP connection
e.g. telnet or ssh.
They don't for UDP. 
  e.g.   rpcinfo -u bartok mountd

If I use the address on B, it works fine (as you would expect - same
subnet).
If I use the address on A it works fine (that is the default route
interface).

But if I use the address on C, it doesn't.

What happens is:

    - request goes from client to router
    - request goes from router to bartok interface on C
    - bartok issues an ARP for client on C interface which is WRONG
    - nobody replies to the ARP because client is on B, not C.

If I turn on proxy-arp on the router I can get the reply back, but I
would rather not do that.

So why does a reply to a UDP request arriving on subnet C from some
other subnet try to ARP out on subnet C instead of being routed
normally, while replies to TCP requests get routed properly and work
fine?

Is this a bug, or is there some configuration I can change?

I have double checked the subnet masks and broadcast addresses and
they work fine.
We have rp_filter set to 0 on all interfaces.
forwarding is set to 0, but setting it to 1 makes no difference.

Thanks,
NeilBrown
