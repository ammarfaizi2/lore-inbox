Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWEMX1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWEMX1K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWEMX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:27:10 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:17101
	"EHLO bifrost.lang.hm") by vger.kernel.org with ESMTP
	id S964795AbWEMX1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:27:08 -0400
Date: Sat, 13 May 2006 16:27:03 -0700 (PDT)
From: David Lang <david@lang.hm>
X-X-Sender: dlang@david.lang.hm
To: Roger Luethi <rl@hellgate.ch>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: network freeze with nforce-A939 integrated rhine card
In-Reply-To: <Pine.LNX.4.62.0605130122310.2801@qnivq.ynat.uz>
Message-ID: <Pine.LNX.4.62.0605131624090.2923@qnivq.ynat.uz>
References: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
 <20060512214109.GD2274@k3.hellgate.ch> <Pine.LNX.4.62.0605122209330.2803@qnivq.ynat.uz>
 <Pine.LNX.4.62.0605130122310.2801@qnivq.ynat.uz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2006, David Lang wrote:

> On Fri, 12 May 2006, David Lang wrote:
>
>> On Fri, 12 May 2006, Roger Luethi wrote:
>> 
>>> On Thu, 11 May 2006 22:59:44 -0700, David Lang wrote:
>
> I just confirmed this, I was able to transfer 84G with no trouble starting 
> from /dev/hdb, but starting from /dev/md0 the nic hung in less then 3G
>
> a good boot logs
> eth0: VIA Rhine II at 0xe8121000, 00:11:5b:f4:14:a3, IRQ 17.
> eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link cde1.
>
> root@david:~# ethtool eth0
> Settings for eth0:
>        Supported ports: [ TP MII ]
>        Supported link modes:   10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Supports auto-negotiation: Yes
>        Advertised link modes:  10baseT/Half 10baseT/Full
>                                100baseT/Half 100baseT/Full
>        Advertised auto-negotiation: Yes
>        Speed: 100Mb/s
>        Duplex: Full
>        Port: MII
>        PHYAD: 1
>        Transceiver: internal
>        Auto-negotiation: on
>        Supports Wake-on: pumbg
>        Wake-on: d
>        Current message level: 0x00000001 (1)
>        Link detected: yes

and here's what I get when it's hung

from syslog when it hangs
May 13 01:58:17 david kernel: attempt to access beyond end of device
May 13 01:58:17 david kernel: md0: rw=0, want=8708129352, limit=2188035584
May 13 01:58:17 david kernel: attempt to access beyond end of device
May 13 01:58:17 david kernel: md0: rw=0, want=7768925008, limit=2188035584
May 13 02:13:50 david ntpd[2589]: time reset +0.699871 s
May 13 02:16:51 david kernel: eth0: link down

from ethtool
Settings for eth0:
 	Supported ports: [ TP MII ]
 	Supported link modes:   10baseT/Half 10baseT/Full
 	                        100baseT/Half 100baseT/Full
 	Supports auto-negotiation: Yes
 	Advertised link modes:  10baseT/Half 10baseT/Full
 	                        100baseT/Half 100baseT/Full
 	Advertised auto-negotiation: Yes
 	Speed: 10Mb/s
 	Duplex: Half
 	Port: MII
 	PHYAD: 1
 	Transceiver: internal
 	Auto-negotiation: on
 	Supports Wake-on: pumbg
 	Wake-on: d
 	Current message level: 0x00000001 (1)
 	Link detected: no


from the boot with it hung.
eth0: VIA Rhine II at 0xe8121000, 00:11:5b:f4:14:a3, IRQ 17.
eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.

David Lang
