Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSHOFr0>; Thu, 15 Aug 2002 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSHOFr0>; Thu, 15 Aug 2002 01:47:26 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:48911 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S316580AbSHOFrZ>; Thu, 15 Aug 2002 01:47:25 -0400
Subject: Re: 8139too cannot receive pkts in 2.4.19-rc3
From: Scott Bronson <bronson@rinspin.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <3D44E6C1.6090002@candelatech.com>
References: <3D44E6C1.6090002@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Aug 2002 22:50:10 -0700
Message-Id: <1029390611.1706.22.camel@emma>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm witnessing this too.  I have some information to add. 

kernel 2.4.20-pre2.  When I plug the RTL-8139 rev 10 soldered onto my
Shuttle FS40 motherboard into my cable modem (I'm pretty sure it's only
10baseT), I get this: 

Aug 14 22:06:37 emma kernel: 8139too Fast Ethernet driver 0.9.26 
Aug 14 22:06:37 emma kernel: eth0: RealTek RTL8139 Fast Ethernet at
0xe800, 00:30:1b:11:1b:a5, IRQ 11 
Aug 14 22:06:37 emma /etc/hotplug/net.agent: invoke ifup eth0 
Aug 14 22:06:37 emma kernel: eth0: Setting half-duplex based on
auto-negotiated partner ability 0000. 

Nothing works.  Well, maybe my machine can successfully send -- I can't
easily test that.  But it sure doesn't receive.  On the machine, the
link light turns on but the activity light remains dark.


Now, when I plug it into my 10/100 ethernet hub, these messages appear: 

Aug 14 22:21:27 emma kernel: 8139too Fast Ethernet driver 0.9.26 
Aug 14 22:21:27 emma kernel: eth0: RealTek RTL8139 Fast Ethernet at
0xe800, 00:30:1b:11:1b:a5, IRQ 11 
Aug 14 22:21:27 emma /etc/hotplug/net.agent: invoke ifup eth0 
Aug 14 22:21:27 emma kernel: eth0: Setting 100mbps half-duplex based on
auto-negotiated partner ability 40a1. 

Except that now everything works great.  The link light is on, the
activity light works, and I can send and receive packets beautifully. 

It would appear that the 2.4.20-pre2 8139too driver doesn't handle
10baseT -- it only works with 100baseT. 

Configuration: 
   RTL-8139 PCI Fast Ethernet Adapter:   module 
     Use PIO instead of MMIO:            yes 
     Support for uncommon rev. K:        yes 
     Support for older 8129/8130:        yes 
     Use older RX-reset method:          no 


I really, really want this chip to work with my cable modem.  Is there
anything I can do?

Thanks,

    - Scott




On Sun, 2002-07-28 at 23:54, Ben Greear wrote: 
> I just upgraded a SpaceWalker SV-50 machine with a builtin Realtek
> nic.  The NIC can no longer receive pkts it seems.  It can transmit
> fine, as witnessed by other machines on the network.
> 
> lspci says the realtek is:
> RTL-8139/8139C (rev 10)
> 
> The NIC is plugged into a 10bt hub.
> 
> The messages in /var/log/messages look like:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Setting half-duplex based on auto-negotiated partner ability 0000
> 
> I tested in on a 100bt-FD switch, and it failed there too, though it
> did have a message in the log about negotiating 100bt-FD.
> 
> This works in stock RH 7.3 kernel.
> 
> Thanks,
> Ben
> 
> -- 
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

