Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265484AbTLIMQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265485AbTLIMQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 07:16:53 -0500
Received: from relay.inway.cz ([212.24.128.3]:17850 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S265484AbTLIMQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:16:48 -0500
Message-ID: <3FD5BD27.5090102@scssoft.com>
Date: Tue, 09 Dec 2003 13:16:39 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6-test10 on an Opteron
References: <Pine.LNX.4.58.0312051210260.9125@home.osdl.org> <Pine.LNX.4.44.0312081857200.537-100000@puma.cabm.rutgers.edu>
In-Reply-To: <Pine.LNX.4.44.0312081857200.537-100000@puma.cabm.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananda Bhattacharya wrote:
> Hello!
> 
> 	I was wondering if anyone has had any luck with 2.6 
> on a Dual Opteron system. I have a Broadcom 5702 ethernet 
> card, and the network starts up but it seems slugish. 

Hi,

I am playing with UP opteron system (2.6.0-t11) and have noticed the 
network slowness as well..

I am able to achieve max 8MBps on 100MBps network with the
Broadcom 5705...

00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 
Gigabit Ethernet (rev 03)
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
         Memory at fa000000 (64-bit, non-prefetchable) [size=64K]

the board is MSI K8T - VIA KT800 chipset

with the 8MBps transferrate, the ftp daemon eats almost all of the
time and vmstat says that most of the time is spent inside of the 
kernel. (I am getting ~5MBps with rsync and SSH, so it is probably not
because of the proftpd)

on the sending side, the send-queue is 105168 (probably full) and on the 
receiving side the receive-queue (Recv-Q) has 65896 waiting packets.

dmesg reports:
tg3.c:v2.3 (November 5, 2003)
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 
10/100/1000BaseT Ethernet 00:0c:76:6a:b8:a7
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

[vmstat report while proftpd running]
petr@opteron:~/music$ vmstat -n 1
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  0      0   4644  21988 802820    0    0     0  8192 2647    89  1 
99  0  0
  1  0      0   4132  22240 803060    0    0     0  8688 2674   122  0 
99  0  1
  1  0      0   4196  22244 803008    0    0     0  8192 2605   121  1 
95  4  0
  0  0      0   4760  22104 802588    0    0     0  8192 2727   388  1 
94  5  0
  1  0      0   4568  22112 802804    0    0     0     0 2808   651  1 
91  8  0
  1  0      0   5176  22096 802060    0    0     0 12288 2623    87  0 
100  0  0
  1  0      0   5048  22252 802040    0    0     0  8512 2663   119  1 
97  2  0
  1  0      0   4848  22264 802220    0    0     8  8192 2655   104  0 
99  1  0
  1  0      0   4848  22164 802484    0    0     0  8192 2628    77  1 
97  2  0
  1  0      0   4592  22108 802796    0    0     0  8192 2628    56  0 
98  2  0
  1  0      0   4368  22100 803012    0    0     0  8192 2648    81  1 
98  1  0

oops, sorry for the wrapped text ..

Regards,
Petr
