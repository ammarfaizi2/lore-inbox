Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286826AbRLVRCJ>; Sat, 22 Dec 2001 12:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286827AbRLVRB4>; Sat, 22 Dec 2001 12:01:56 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:24327 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S286826AbRLVRBq>;
	Sat, 22 Dec 2001 12:01:46 -0500
Date: Sat, 22 Dec 2001 09:34:58 +0100
From: Stefan Frank <sfr@gmx.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg ?
Message-ID: <20011222083457.GA666@asterix>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

since some time now, running the ht://dig indexing cron job locked my
machine hard (SMP, 2x866 PIII with 1G memory, Highmem(4G) enabled),
only SysReq was still working. Yesterday i enabled it again, 
and, suprise surprise, it survived the night. 

But this messsage appears in the logs:

    Dec 22 00:01:25 obelix kernel: KERNEL: assertion (tp->copied_seq ==
    tp->rcv_nxt || (flags&(MSG_PEEK|MSG_TRUNC))) failed at
    tcp.c(1520):tcp_recvmsg

    Dec 22 00:01:53 obelix last message repeated 14 times

Note that this cronjob is started at midnight.

I'm running kernel 2.4.17rc1 on a Debian Sid/Unstable box.
The web server (running on the same machine!) is debians apache 1.3.22-2 package.

Here's the output of lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Subsystem: Asustek Computer, Inc.: Unknown device 8038
        Flags: bus master, medium devsel, latency 0
        Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8038
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Flags: medium devsel
        I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2

00:0b.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c895 (rev 01)
        Subsystem: Tekram Technology Co.,Ltd.: Unknown device 3907
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b800 [size=256]
        Memory at fc000000 (32-bit, non-prefetchable) [size=256]
        Memory at fb800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(rev 40) (prog-if 00 [VGA])
        Flags: medium devsel, IRQ 11
        Memory at f4000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at 000c0000 [disabled] [size=64K]

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at b400 [size=256]
        Memory at f3800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
 
I'm using the 8139too driver built into the kernel for the Realtek card.

These modules are usually loaded:

obelix:~# lsmod
Module                  Size  Used by    Tainted: P
ide-probe-mod           8224   0  (autoclean)
ide-mod                58596   0  (autoclean) [ide-probe-mod]
ipt_TOS                 1344  13  (autoclean)
iptable_mangle          2016   0  (autoclean) (unused)
ipt_REDIRECT            1088   1  (autoclean)
ipt_MASQUERADE          1664   1  (autoclean)
iptable_nat            16756   0  (autoclean) [ipt_REDIRECT
ipt_MASQUERADE]
ipt_state                928   2  (autoclean)
ip_conntrack           16652   2  (autoclean) [ipt_REDIRECT
ipt_MASQUERADE iptable_nat ipt_state]
ipt_LOG                 3584   5  (autoclean)
ipt_limit               1344  12  (autoclean)
iptable_filter          2048   0  (autoclean) (unused)
ip_tables              11328  11  [ipt_TOS iptable_mangle ipt_REDIRECT
ipt_MASQUERADE iptable_nat ipt_state ipt_LOG ipt_limit iptable_filter]
ospm_processor          5984   0  (unused)
ospm_button             3264   0  (unused)
ospm_system             6028   0  (unused)
ospm_busmgr            11904   0  [ospm_processor ospm_button
ospm_system]
rtc                     6456   0  (autoclean)

I will try the official 2.4.17 kernel and see how it goes.

Happy Christmas to all of you !

		Stefan

-- 
Misery loves company, but company does not reciprocate.
