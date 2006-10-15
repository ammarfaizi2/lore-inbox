Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWJOBkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWJOBkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 21:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWJOBkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 21:40:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:24717 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932086AbWJOBkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 21:40:13 -0400
X-Authenticated: #24128601
Date: Sun, 15 Oct 2006 03:38:24 +0200
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Radeon DRI, mtrr overlaps, wrong RAM value
Message-ID: <20061015013824.GA26893@section_eight>
Mail-Followup-To: Sebastian Kemper <sebastian_ml@gmx.net>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I wrote about this to the X.org mailing list some time ago, but noone
answered, so I hope you don't mind that I try here.

My posting to the X.org mailing list can be found here:
http://lists.freedesktop.org/archives/xorg/2006-October/018679.html

I get the following warnings once my X server starts:

mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000
mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x8000000

In Xorg.0.log I get these warnings:

(WW) RADEON(0): DRI init changed memory map, adjusting ...
(WW) RADEON(0):   MC_FB_LOCATION  was: 0xd7ffd000 is: 0xd7ffd000
(WW) RADEON(0):   MC_AGP_LOCATION was: 0xffffffc0 is: 0xe07fe000
(**) RADEON(0): GRPH_BUFFER_CNTL from 20205c5c to 203e5c5c

/proc/mtrr holds these values:
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xe0000000 (3584MB), size=  32MB: write-combining, count=2
reg02: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1

Could all this relate to lspci showing the wrong amount of RAM available
on my graphics card?

02:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon
9200 PRO] (rev 01) (prog-if 00 [VGA])
        Subsystem: Connect Components Ltd Unknown device 2801
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 11
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        I/O ports at d000 [size=256]
        Memory at e3000000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at e2000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2

It shows 256MB, but I only have 128MB. Is there a bug in the kernel that
messes up getting the memory amount?

I'm using 2.6.18 vanilla, a Sempron 32bit cpu (2400+), a nforce2
mainboard and a Radeon 9250 graphics card.

ver_linux:
Linux section_eight 2.6.18.1 #1 Sat Oct 14 21:12:07 CEST 2006 i686 AMD
Sempron(tm)   2400+ GNU/Linux

Gnu C                  4.1.1
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         rt61 lirc_serial lirc_dev

Thanks
Sebastian
