Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVF0Uvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVF0Uvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVF0Uve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:51:34 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:614 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261754AbVF0Us1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:48:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnHjymqffD3nLwDoJp5kl7hsS+Uu5g0B+NBDf8od1A1CVF0bsloNZMA8xidKIuChSB/IS4xQPkRJjP9DD10B9VHk1vT8EAa70tesJaUz9V0tFGI4161j1u4ipKKZaIQu6WE39/oH5aECd6hwJ3UdJyJ6hzSAJno4Vtc+0jAdXJk=
Message-ID: <c295378405062713485b7e071d@mail.gmail.com>
Date: Mon, 27 Jun 2005 13:48:23 -0700
From: "Jason R. Martin" <nsxfreddy@gmail.com>
Reply-To: "Jason R. Martin" <nsxfreddy@gmail.com>
To: John Jasen <jjasen@realityfailure.org>
Subject: Re: bonding driver issues: slave interface not coming up
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0506271620160.12410@bushido>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0506271620160.12410@bushido>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, John Jasen <jjasen@realityfailure.org> wrote:
> 
> Hello;
> 
> In short, using redhat enterprise 4, we're attempting to bond two tg3
> gigabit cards in XOR mode.
> 
> These cards are plugged into a cisco 2970 switch, configured with
> etherchannel bonding in src-dst-mac, which looks to be mode 2.
> 
> The problem area is, upon boot, the first slave NIC does not come up.
> Furthermore, running ethtool against the slave yields the following message:
> 
> [root@XXX ~]# ethtool eth0
> Settings for eth0:
> Cannot get device settings: Resource temporarily unavailable
>          Supports Wake-on: g
>          Wake-on: d
>          Current message level: 0x000000ff (255)
>          Link detected: no
> 
> Now, curiously enough, after boot, logging in and bringing down the
> bonding interface, then bringing it back up will activate both
> interfaces. ie:
> 
> ifdown bond0
> ifup bond0
> 
> ethtool eth0
> [root@XXX ~]# ethtool eth0
> Settings for eth0:
>          Supported ports: [ MII ]
>          Supported link modes:   10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Half 1000baseT/Full
>          Supports auto-negotiation: Yes
>          Advertised link modes:  Not reported
>          Advertised auto-negotiation: No
>          Speed: 1000Mb/s
>          Duplex: Full
>          Port: Twisted Pair
>          PHYAD: 1
>          Transceiver: internal
>          Auto-negotiation: off
>          Supports Wake-on: g
>          Wake-on: d
>          Current message level: 0x000000ff (255)
>          Link detected: yes
> 
> Attempts at debugging that we've taken and their results:
> 
> duplex/speed forced on both switch and card: no effect
> turning off spanning tree protocol: no effect
> enabling fastport: no effect
> switching from tg3 to bcm5700 drivers: no effect
> attempting to down and up the interface in /etc/rc.d/init.d/network: no
> effect
> attempting a script that runs after network and irqbalance to do the
> same thing: no effect
> putting something in rc.local to do the same: works, our current ugly
> workaround
> breaking the bond, using the interfaces as two independent NICS: works
> restarting the bond0 interface manually: works
> 
> This problem also manifests on more than one system, which would seem to
> preclude possible cable, host, or port problems.
> 
> Any ideas, or any further information I can send you to help diagnose?
> Any help would be much appreciated.

What's in /proc/net/bonding/bond0?

You'll probably have better luck getting help with this issue on
netdev@vger.kernel.org and bonding-devel@lists.sourceforge.net.

Jason
