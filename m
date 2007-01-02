Return-Path: <linux-kernel-owner+w=401wt.eu-S1755312AbXABPdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbXABPdg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbXABPdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:33:36 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:56600 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755312AbXABPdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:33:35 -0500
Message-ID: <459A7B4A.5060109@blueyonder.co.uk>
Date: Tue, 02 Jan 2007 15:33:30 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jarek Poplawski <jarkao2@o2.pl>
CC: linux-kernel@vger.kernel.org, Matti Aarnio <postmaster@vger.kernel.org>
Subject: Re: 2.6.19 and up to  2.6.20-rc2 Ethernet problems x86_64
References: <20061229063254.GA1628@ff.dom.local> <4595CD1B.2020102@blueyonder.co.uk> <20070102115050.GA3449@ff.dom.local>
In-Reply-To: <20070102115050.GA3449@ff.dom.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarek Poplawski wrote:
> On Sat, Dec 30, 2006 at 02:21:15AM +0000, Sid Boyce wrote:
>> Jarek Poplawski wrote:
>>> On 28-12-2006 04:23, Sid Boyce wrote:
>>>> I first saw the problem on the 64x2 box after upgrading to 2.6.19. The
>>>> network appeared OK with ifconfig and route -n, but I had no network
>>>> access. Pinging any other box, the box was responding, but no response
>>> ...
>>>> barrabas:/usr/src/linux-2.6.20-rc1-git5 # ssh Boycie ifconfig
>>>> Password:
>>>> eth0      Link encap:Ethernet  HWaddr 00:0A:E4:4E:A1:42
>>>>          inet addr:192.168.10.5  Bcast:255.255.255.255  
>>>>          Mask:255.255.255.0
>>> This Bcast isn't probably what you need.
>>>
>>> Regards,
>>> Jarek P.
>>>
>>>
>> Corrected on the one box where it was not correct, problem is still there.
> 
> There are many things to suspect yet:
> - firewall,
> - switch,
> - routing,
> - ifconfig,
> - other misonfigured box,
> - connecting
> and so on.
> 
> I think you should try with some linux networking group
> at first and if you really think it's driver then
> netdev@vger.kernel.org (instead of linux-kernel@).
> 
> If you could send full ifconfig, route -n (or ip route
> if you use additional tables) and tcpdump (all packets)
> from both boxes while pinging each other and a few words
> how it is connected (other cards, other active boxes in
> the network?) maybe something more could be found.
> 
> Cheers,
> Jarek P. 
> 
> PS: Sorry for late responding.
> 
> 
I have a problem with posting to linux-kernel and netdev, my mail got
returned as SPAM, now it just gets dropped. postmaster says the filter
is seeing a sub-string of something that is filtered.

Everything is fine with a eepro100 on the 64x2 box that gave the same
problem with a nVidia Corporation MCP51 Ethernet Controller (rev a1)
using the forcedeth module. On the x86_64 laptop the problem is with a
Broadcom NetXtreme BCM5788 using the tg3 module. Switching back to a
2.6.18.2 kernel, there is no problem.
With all configurations of cards on both, route -n is the same on all
kernels and instantly reports back. With >=2.6.19 on the laptop, netstat
-r takes a very long time before returning the information ~30 seconds,
instantly on 2.6.18.2.
Boycie:~ # netstat -r
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
192.168.10.0    *               255.255.255.0   U         0 0          0
eth0
loopback        *               255.0.0.0       U         0 0          0 lo
default         Smoothie.site   0.0.0.0         UG        0 0          0
eth0
Boycie:~ # route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
192.168.10.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         192.168.10.102  0.0.0.0         UG    0      0        0 eth0

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


