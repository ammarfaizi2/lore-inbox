Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272059AbRH2Uqg>; Wed, 29 Aug 2001 16:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272066AbRH2Uq0>; Wed, 29 Aug 2001 16:46:26 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:57283 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S272059AbRH2UqP>; Wed, 29 Aug 2001 16:46:15 -0400
Date: Wed, 29 Aug 2001 22:52:49 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: System crashes with via82cxxx ide driver
Message-ID: <Pine.LNX.4.33.0108292239410.861-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all!

I am seeing system crashes while using the via82cxxx driver on a VIA MVP3
motherboard. I can reproduce the crashes with

	e2fsck -f -p /dev/hda3 -C 0

where hda3 is a 3 GB ext2 filesystem. e2fsck is 1.23, but it also happens
with any other version between 1.19 and 1.23, so it's unlikely to be an
e2fsck problem.

I have tried it about 10 times now, and the machine always crashes at the
moment when e2fsck reaches 75.6% percent. The machine just powers off, no
chance to read syslog or to see whether there is a kernel oops or panic.

How do I know that this is because of the via82cxxx driver? Well, it
always happens with 2.4.x and this driver enabled. It never happens to me
with 2.2.19, which has an older driver for this kind of ide controller.
But when I apply the ide backport patch to 2.2.19, giving me the via82cxxx
driver on 2.2.19, the machine once again crashes at the same 75.6% of the
e2fsck run. When I disable the driver in the kernel config, e2fsck does
not crash the machine. So it's not the newer IDE stuff in general, but
specifically this driver.

My guess is that the newer via82cxxx driver in 2.4.x stresses the chipset
in some way that it doesn't really like.

The problem also strikes during other heavy disk activity, such as
installing a multi-megabyte RPM file. The Red Hat 7.1 installation in fact
crashed twice with the same symptoms before it got through on the third
try.

I can work around the problem by not using the via8cxxx driver, but I'd
rather like to have UDMA33 for my hard disk because of the CRC error
detection.

Let me know if I should supply more information.

lspci -v output for the motherboard chipset:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
        Flags: bus master, medium devsel, latency 16
        Memory at e0000000 (32-bit, prefetchable)
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at c000

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Flags: medium devsel

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

