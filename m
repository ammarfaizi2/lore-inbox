Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267966AbTBMJTM>; Thu, 13 Feb 2003 04:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbTBMJTM>; Thu, 13 Feb 2003 04:19:12 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:30643 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267966AbTBMJTK>; Thu, 13 Feb 2003 04:19:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Thu, 13 Feb 2003 20:28:34 +1100
Message-ID: <15947.25922.785515.945307@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: message from David S. Miller on  February 12
References: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
	<1045120278.5115.0.camel@rth.ninka.net>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
cc: linux-kernel@vger.kernel.org
Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 12, davem@redhat.com wrote:
> On Wed, 2003-02-12 at 15:18, Neil Brown wrote:
> > Is this a bug, or is there some configuration I can change?
> 
> Specify the correct 'src' parameter in your 'ip' route
> command invocations.

Thanks... but I think I need a bit more help.

bartok # ./ip route show
129.94.232.0/24 via 129.94.172.66 dev eth1 
129.94.242.0/24 dev eth0  proto kernel  scope link  src 129.94.242.45 
129.94.241.0/24 via 129.94.174.2 dev eth1 
129.94.172.0/22 dev eth1  proto kernel  scope link  src 129.94.172.12 
129.94.208.0/22 dev eth2  proto kernel  scope link  src 129.94.208.2 
default via 129.94.242.1 dev eth0 
bartok # ip addr show
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:10:4b:1c:a3:a4 brd ff:ff:ff:ff:ff:ff
    inet 129.94.242.45/24 brd 129.94.242.255 scope global eth0
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:a0:c9:8f:7f:3c brd ff:ff:ff:ff:ff:ff
    inet 129.94.172.12/22 brd 129.94.242.255 scope global eth1
4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:90:27:37:bb:d5 brd ff:ff:ff:ff:ff:ff
    inet 129.94.208.2/22 brd 129.94.242.255 scope global eth2


The client in question is 129.94.211.194
It sends a UDP request to 129.94.172.12
The reply, addressed to 129.94.211.194 causes ARP requests on bartok's
eth1

Surely the route that applies is the 4th one, which seems to have a
correct 'src' parameter.

BTW, The routes were all created with 'route', not 'ip', incase it
matters.

NeilBrown
