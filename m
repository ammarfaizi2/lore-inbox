Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbUATXOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUATXOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:14:44 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:11958 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S265830AbUATXNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:13:44 -0500
Message-Id: <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Jan 2004 10:13:31 +1100
To: JG <jg@cms.ac>, Andreas Hartmann <andihartmann@freenet.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040120123406.6684B1A9932@23.cms.ac>
References: <20040119033527.GA11493@linux.comp>
 <20040119033527.GA11493@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:33 PM 20/01/2004, JG wrote:
>i have also two boxes (one with 2.6.0, the other one 2.6.1-mm2) equipped 
>with netgear ga302t cards (x-over cable).
>i don't see a very high cpu usage, but since upgrading to 2.6.x kernels i 
>sometimes have really weird speed issues. i often only get transfer rates 
>of about ~200-300 kilobytes/second...yes, and this over a gigabit 
>interface, tested over ftp.
>i'm also running a nfs server on the 2.6.1-mm2 box, the 2.6.0 pc is the 
>client, but again, sometimes it's *very* slow. if i reboot my 2.6.1-mm2 
>box (the other one is a server which can't be rebooted) it seems to be 
>fine for some time.
>
>i didn't have such problems with 2.4.19 kernels on both pcs, there i got 
>about 30-35MB/s over ftp without any problems, so i don't think it's 
>hardware related.

IBM x335 server (dual P4 Xeons @ 2.4GHz), BCM 5702 onboard 2 x 10/100/1000, 
connected via copper 1000baseT to a Cisco Catalyst 3750 ethernet switch.
running ttcp between two hosts shows wire-rate @ 17% CPU.  gig-e is not 
using jumbo frames:

[root@mel-stglab-host31 root]# ttcp -t -l 65536 -v -b 2097152 -s -D 
-n100000 10.67.16.91
ttcp-t: buflen=65536, nbuf=100000, align=16384/0, port=5001, 
sockbufsize=2097152  tcp  -> 10.67.16.91
ttcp-t: socket
ttcp-t: sndbuf
ttcp-t: nodelay
ttcp-t: connect
ttcp-t: 6553600000 bytes in 58.42 real seconds = 109558.82 KB/sec +++
ttcp-t: 6553600000 bytes in 10.38 CPU seconds = 616723.50 KB/cpu sec
ttcp-t: 100000 I/O calls, msec/call = 0.60, calls/sec = 1711.86
ttcp-t: 0.0user 10.3sys 0:58real 17% 0i+0d 0maxrss 0+16pf 79360+131csw
ttcp-t: buffer address 0x8050000

[root@mel-stglab-host31 root]# uname -a
Linux mel-stglab-host31 2.6.0-test9 #13 SMP Mon Nov 3 17:18:17 EST 2003 
i686 i686 i386 GNU/Linux

[root@mel-stglab-host31 root]# lspci -v
[..]
03:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gigabit 
Ethernet (rev 02)
         Subsystem: IBM: Unknown device 026f
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 24
         Memory at f87f0000 (64-bit, non-prefetchable) [size=64K]
         Capabilities: [40] PCI-X non-bridge device.
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 
Enable-

03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gigabit 
Ethernet (rev 02)
         Subsystem: IBM: Unknown device 026f
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 25
         Memory at f87e0000 (64-bit, non-prefetchable) [size=64K]
         Capabilities: [40] PCI-X non-bridge device.
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 
Enable-

[root@mel-stglab-host31 asm]# ethtool -g eth0
Ring parameters for eth0:
Pre-set maximums:
RX:             511
RX Mini:        0
RX Jumbo:       255
TX:             0
Current hardware settings:
RX:             200
RX Mini:        0
RX Jumbo:       100
TX:             511

[root@mel-stglab-host31 asm]# ethtool -i eth0
driver: tg3
version: 2.2
firmware-version:
bus-info: 0000:03:01.0
[root@mel-stglab-host31 asm]# ethtool eth0
Settings for eth0:
         Supported ports: [ MII ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Advertised auto-negotiation: Yes
         Speed: 1000Mb/s
         Duplex: Full
         Port: Twisted Pair
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: g
         Wake-on: d
         Current message level: 0x000000ff (255)
         Link detected: yes
[root@mel-stglab-host31 asm]#


the only thing unusual about this kernel that i'm running is that i don't 
use HighMem; i fixup PAGE_OFFSET to 0x80000000 to avoid the performance 
overhead of PAE mode.



cheers,

lincoln.

