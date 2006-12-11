Return-Path: <linux-kernel-owner+w=401wt.eu-S1762392AbWLKDnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762392AbWLKDnc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 22:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762403AbWLKDnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 22:43:32 -0500
Received: from mail.pwrlink.de ([62.245.254.98]:50165 "HELO mail.pwrlink.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762401AbWLKDnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 22:43:31 -0500
Message-ID: <457CD379.9030003@orceo.com>
Date: Mon, 11 Dec 2006 04:41:45 +0100
From: Jan Tegtmeier <jtegtmeier.deleteme@orceo.com>
Organization: orceo GmbH
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2 different assertion failed at net/ipv4/tcp.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found failed assertions in my kernel logs:

KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1173)
KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1173)
KERNEL: assertion (tp->copied_seq == tp->rcv_nxt || (flags & (MSG_PEEK | 
MSG_TRUNC))) failed at net/ipv4/tcp.c (1237)
KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1173)
KERNEL: assertion (tp->copied_seq == tp->rcv_nxt || (flags & (MSG_PEEK | 
MSG_TRUNC))) failed at net/ipv4/tcp.c (1237)
KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1173)

Sometimes there are broken log lines like the following, but all quite 
different broken:

KERNEL: assertion (tp->copied_seq == tp->rcv_nxt || (flags & (MSG_PEEK | 
MSiled at ->rcv_nxiled at->rcv_nxt iled at net->rcv_nxiled at 
net/->rcv_nxiled at net/i->riled at->rcviled at net/i->rcv_iled 
at->rcv_nxtiled at->rciled at->rcvil->rciled at net/i->rcviled at 
net->rcv_iled at net/ipv->rcv_iled at net/->rcv_iled at net/->rcv_iled 
at net/i->rcv_nxtiled at ne->rcv_nxt || iled at ne->rcv_nxiled at 
ne->rcv_nxiled at net/->rcv_nxtiled at ne->rcv_nxt iled at net->rcv_nxt 
iled at net/->rcv_nxtiled at net/->rcv_nxt iled at net/->rcv_niled at 
ne->rcv_iled at net->rcv_nxtiled at net/->rcv_nxt iled at net/->rcv_nxt 
|iled at ne->rcv_niled at net->rcv_nxiled at net/i->rcv_iled at 
net/i->rcv_nxt iled at ne->rcv_nxtiled at net/ipv4->rcv_nxt ||iled at 
net->rcv_niled at ne->rcv_nxiled at net/ipv4/->rcv_iled at 
net/->rcv_niled at n->rcv_nxt || iled at net->rcviled at ne->rcv_nxt 
iled at ->rcv_iled at ne->rcviled at n->rcv_nxtiled at net/i->rcv_nxiled 
at net/ipv->rcv_niled at net->rcv_nxt |iled at n->rcv_nxt iled at 
net->rcv_nxiled at ne->rcv_nxt || (fliled at net/i->rcv_nxt || (flailed 
at net/->rcv_nxiled at net->rcv_nxtiled at ne->rcv_nxiled at 
net/->rcv_iled at net/->rcv_nxiled at net/ipv->rcviled at ne->rcviled at 
net->rcv_nxt iled a->rcv_nxiled at net/->rcv_nxiled at net/->rcviled 
a->rcv_nxiled at n->rcv_nxiled at ne->rcv_nxtiled at net/ipv->rcv_nxt 
|iled at net/->rcv_nxiled at->rcv_nxt |iled at net->rcv_niled at 
net->rcv_nxt ||iled at net/->rcv_nxt iled at net/->rcv_niled at 
net/ipv4->rcv_iled at net/->rcv_nxt |iled at net->rcv_nxiled at 
ne->rcv_nxt || iled at net/ipv->rcv_niled at ne->rcv_niled at 
n->rcv_niled at net/i->rcv_nxiled at ne->rcv_nxtiled at ne->rcv_iled at 
net/i->rcv_nxtiled at n->rcv_nxt iled at net/ip->rcv_nxtiled at 
net->rcviled at net/ip->rcv_iled at ->rcv_iled at net/->rcv_nxt || iled 
at ne->rcv_nxt |iled at net->rcv_nxiled at net/->rcv_nxtiled at 
net/ip->rcv_nxtiled at net/->rcviled at ne->rcv_nxt ||iled at 
net->rcv_nxtiled at

Kernel/Network config:
----------------------
uname -a:
Linux nlx11 2.6.17.13 #7 SMP Tue Nov 21 21:55:19 UTC 2006 i686 GNU/Linux

Vanilla kernel with the following patches:
- bonding.patch
- enbd-2.4.32
- vserver 2.6.17.11-2.0.2
- sk98lin 8.35.2.3
- tg3-3.66f

Included network drivers/options:
CONFIG_E1000=y
CONFIG_SK98LIN=y
CONFIG_SK98LIN_NAPI=y
CONFIG_TIGON3=y

 From kernel boot messages:
<6>Ethernet Channel Bonding Driver: v3.0.3 (March 23, 2006)
<6>bonding: MII link monitoring set to 100 ms
<6>ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 17
<4>sk98lin: Network Device Driver v8.35.2.3
<4>(C)Copyright 1999-2006 Marvell(R).
<6>ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:02:00.0 to 64
<4>eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
<4>      PrefPort:A  RlmtMode:Check Link State

Characteristics:
----------------
The failed assertions are logged in bunches of a few messages over 
minutes up to spikes of a few hundred messages within seconds. This 
repeats irregular every few hours. Network traffic is very low on that 
machine, about 1-2 mbit/s. The machine is still reachable over network.

Since the first high spike the machine had 1 apache process using 100% 
userspace cputime, strace not showing any syscalls.

We have many network problems on all 5 servers using the same chipset, 
they are not reachable a few (1-5x) times a day by arping for seconds to 
minutes and self recovering sometimes without intervention. No kernel 
messages are poduces in these cases.

There is nothing about the sk98lin driver in the kernel changelogs since 
2.6.17 that sounds in any way related to this problem. Any help?

Kind Regards,
   Jan Tegtmeier

-- 
orceo GmbH, http://www.orceo.com/
