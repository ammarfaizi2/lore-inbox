Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUACPoh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUACPoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:44:37 -0500
Received: from web8202.mail.in.yahoo.com ([203.199.70.115]:29265 "HELO
	web8202.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S263522AbUACPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:44:34 -0500
Message-ID: <20040103154431.40672.qmail@web8202.mail.in.yahoo.com>
Date: Sat, 3 Jan 2004 15:44:31 +0000 (GMT)
From: =?iso-8859-1?q?Mr=20Amit=20Mehrotra?= <mehrotraamit@yahoo.co.in>
Subject: PCMCIA for LC2420 with 2.6.0 kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a linux certified LC 2420 laptop with 1 GB of
memory running linux from scratch (LFS) 5.0 and I
recently moved to 2.6.0 kernel. I wanted to try a
Linksys WPC54G on linux using ndiswrapper to enable
wireless networking but I ran into a problem. PCMCIA
does not seem to work. I did not need PCMCIA before
this so I did not enable it in the previous kernels
(linux-2.4.*). I am using pcmcia-cs-3.2.7. When I
insert any card (I also tried Adaptec 1480A slimscsi)
I hear no beeps, the output of /var/log/sys.log does
not change and
cardctl status
says
Socket 0:
  no card

I know that there is no hardware problem because the
laptop is dual boot and on Windoze 2000 side, it says
new hardware found when I insert any card. Also the
power light comes on for WPC54G (does not happen for
linux).

If I look at dmesg, it looks like it detected the
Cardbus bridge:
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
Yenta: CardBus bridge found at 0000:00:08.0
[1584:3000]
Yenta: ISA IRQ list 0000, PCI irq17
Socket status: 4d41b401
cs: IO port probe 0x0c00-0x0cff: excluding 0xc00-0xc1f
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x837
0x840-0x87f
0x898-0x89f
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df
0x480-0x48f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

I posted this on comp.os.linux.portable and David
Hinds 
replied:
"Note the memory address here of 0x3fff000: for some
reason, your bridge's registers were mapped to overlay
the top 4K of system memory.

I remember this sort of problem coming up before and
I'd thought it had been fixed.  Aparently not.  It is
sometimes caused by the BIOS erroneously reporting a
memory size a bit too small; you might check the
memory map information reported in your boot logs.

I don't know enough about the appropriate parts of the
kernel to suggest a fix, unfortunately.  You should
report the bug to the linux-kernel mailing list.  It
is a bug in PCI resource allocation."

The relevant lspci output is:
00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus
Controller
        Subsystem: Uniwill Computer Corp: Unknown
device 3000
        Flags: bus master, stepping, slow devsel,
latency 168, IRQ 17
        Memory at 3fff0000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=02, subordinate=05,
sec-latency=176
        Memory window 0: 40000000-403ff000
(prefetchable)
        Memory window 1: 40400000-407ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

Amit

________________________________________________________________________
Yahoo! India Mobile: Download the latest polyphonic ringtones.
Go to http://in.mobile.yahoo.com
