Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288948AbSATTQt>; Sun, 20 Jan 2002 14:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSATTQh>; Sun, 20 Jan 2002 14:16:37 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:57263 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S288948AbSATTQU>; Sun, 20 Jan 2002 14:16:20 -0500
From: "Robbert Kouprie" <robbert@jvb.tudelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Date: Sun, 20 Jan 2002 20:16:12 +0100
Message-ID: <005501c1a1e6$ec7e6160$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have an Abit BP6 Dual Celeron 433, 192 Mb RAM, Intel NIC on 100 Mbit,
running Debian Woody with Linux kernel 2.4.17 from source. This weekend
the network card totally locked up. No network connections were possible
anymore and system logs were full of NETDEV errors (included below).
Note the "unexpected IRQ trap" which started this. Soft rebooting the
system was not possible anymore as the system hung on these NETDEV
errors after issueing the "reboot" command. I performed a little search
on the error message and found an earlier lkml message which looks like
exactly the same problem:
http://lists.kernelnotes.de/linux-kernel/Week-of-Mon-20010618/026269.htm
l

Did anyone ever found out the problem here?

Regards,
- Robbert Kouprie


radium:/$ lspci -vx -d 8086:1229
00:0d.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev
09)
        Subsystem: Intel Corp.: Unknown device 0011
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at da020000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c800 [size=64]
        Memory at da000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
00: 86 80 29 12 07 00 90 02 09 00 00 02 08 20 00 00
10: 00 00 02 da 01 c8 00 00 00 00 00 da 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 11 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

Jan 19 01:27:16 radium kernel: unexpected IRQ trap at vector 7d
Jan 19 01:29:11 radium kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 19 01:29:11 radium kernel: eth0: Transmit timed out: status f048
0c00 at 15835657/15835685 command 000ca000.
Jan 19 01:29:11 radium kernel: eth0: Tx ring dump,  Tx queue 15835685 /
15835657:
Jan 19 01:29:11 radium kernel: eth0:     0 200ca000.
Jan 19 01:29:11 radium kernel: eth0:     1 000ca000.
Jan 19 01:29:11 radium kernel: eth0:     2 000ca000.
Jan 19 01:29:11 radium kernel: eth0:     3 000ca000.
Jan 19 01:29:11 radium kernel: eth0:     4 400ca000.
Jan 19 01:29:11 radium kernel: eth0:   = 5 000ca000.
Jan 19 01:29:11 radium kernel: eth0:     6 000ca000.
Jan 19 01:29:11 radium kernel: eth0:     7 000ca000.
Jan 19 01:29:11 radium kernel: eth0:     8 200ca000.
Jan 19 01:29:11 radium kernel: eth0:  *  9 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    10 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    11 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    12 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    13 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    14 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    15 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    16 200ca000.
Jan 19 01:29:11 radium kernel: eth0:    17 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    18 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    19 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    20 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    21 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    22 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    23 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    24 200ca000.
Jan 19 01:29:11 radium kernel: eth0:    25 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    26 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    27 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    28 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    29 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    30 000ca000.
Jan 19 01:29:11 radium kernel: eth0:    31 000ca000.
Jan 19 01:29:11 radium kernel: eth0: Printing Rx ring (next to receive
into 13805956, dirty index 13805956).
Jan 19 01:29:11 radium kernel: eth0:     0 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     1 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     2 0000a020.
Jan 19 01:29:11 radium kernel: eth0: l   3 c000a020.
Jan 19 01:29:11 radium kernel: eth0:  *= 4 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     5 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     6 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     7 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     8 0000a020.
Jan 19 01:29:11 radium kernel: eth0:     9 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    10 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    11 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    12 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    13 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    14 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    15 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    16 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    17 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    18 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    19 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    20 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    21 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    22 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    23 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    24 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    25 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    26 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    27 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    28 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    29 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    30 0000a020.
Jan 19 01:29:11 radium kernel: eth0:    31 0000a020.

Jan 19 01:30:17 radium kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 19 01:30:17 radium kernel: eth0: Transmit timed out: status f048
0c00 at 15835685/15835713 command 0001a000.
Jan 19 01:30:17 radium kernel: eth0: Tx ring dump,  Tx queue 15835713 /
15835685:
Jan 19 01:30:17 radium kernel: eth0:     0 600ca000.
Jan 19 01:30:17 radium kernel: eth0:   = 1 000ca000.
Jan 19 01:30:17 radium kernel: eth0:     2 000ca000.
Jan 19 01:30:17 radium kernel: eth0:     3 000ca000.
Jan 19 01:30:17 radium kernel: eth0:     4 400ca000.
Jan 19 01:30:17 radium kernel: eth0:  *  5 0001a000.
Jan 19 01:30:17 radium kernel: eth0:     6 0002a000.
Jan 19 01:30:17 radium kernel: eth0:     7 0003a000.
Jan 19 01:30:17 radium kernel: eth0:     8 200ca000.
Jan 19 01:30:17 radium kernel: eth0:     9 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    10 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    11 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    12 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    13 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    14 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    15 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    16 200ca000.
Jan 19 01:30:17 radium kernel: eth0:    17 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    18 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    19 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    20 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    21 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    22 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    23 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    24 200ca000.
Jan 19 01:30:17 radium kernel: eth0:    25 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    26 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    27 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    28 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    29 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    30 000ca000.
Jan 19 01:30:17 radium kernel: eth0:    31 000ca000.
Jan 19 01:30:17 radium kernel: eth0: Printing Rx ring (next to receive
into 13805956, dirty index 13805956).
Jan 19 01:30:17 radium kernel: eth0:     0 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     1 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     2 0000a020.
Jan 19 01:30:17 radium kernel: eth0: l   3 c000a020.
Jan 19 01:30:17 radium kernel: eth0:  *= 4 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     5 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     6 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     7 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     8 0000a020.
Jan 19 01:30:17 radium kernel: eth0:     9 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    10 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    11 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    12 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    13 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    14 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    15 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    16 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    17 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    18 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    19 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    20 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    21 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    22 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    23 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    24 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    25 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    26 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    27 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    28 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    29 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    30 0000a020.
Jan 19 01:30:17 radium kernel: eth0:    31 0000a020.

... And so on (2 Mb of logs available ;))

