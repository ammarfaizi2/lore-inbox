Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSHYKus>; Sun, 25 Aug 2002 06:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHYKus>; Sun, 25 Aug 2002 06:50:48 -0400
Received: from 203-79-122-66.cable.paradise.net.nz ([203.79.122.66]:517 "EHLO
	ruru.local") by vger.kernel.org with ESMTP id <S317170AbSHYKur>;
	Sun, 25 Aug 2002 06:50:47 -0400
Date: Sun, 25 Aug 2002 22:55:00 +1200
From: Volker Kuhlmann <list0570@paradise.net.nz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel losing time
Message-ID: <20020825105500.GE11740@paradise.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I am stuck with a kernel problem someone can hopefully shed some light
on. It's also a bug report.

Symptoms: at some stage the kernel is unable to keep time. The time
(output of date) slows right down to about 1/5th speed, or much less
with disk activity. Terminal bell is much longer duration, and lower
pitch. All timings everywhere are causing trouble, e.g. screen blanker
activating all the time. Happens with both reiserfs and ext2. It's
impossible to fix, requires a reboot. There seems to be no data
corruption on disk. The machine ismuch more sluggish, at a wild guess,
killing time in an interrupt routine and missing the ticker interrupts.

All 2.4 kernels seem to be affected, tried 2.4.10, 16, 18 (all SuSE
versions) and vanilla 2.4.19. 2.2.19 is fine.

Happens with and without running X, and also without the 8139too driver
being loaded.

Hardware: Pentium-233 MMX, Octek mainboard model Rhine 12+, VIA
chipset, by lspci: 

00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] (rev 23) 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 27) 
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
 
hda: Seagate 4G, ST34321A 
hdc: AOpen 52x cdrom, no difference if this is hdb 

Turning disk dma and unmaskirq on or off with hdparm makes little to no
difference. booting with ide=nodma apm=off acpi=off doesn't help.

Another peculiar observation: hdparm -d1 /dev/hda, hdparm -t gives
0.98M/s (seems very low even for this machine), with -d0 it gives
3.7M/s. That is, turning dma off makes the disk almost 4 times as
fast(!!). This for vanilla 2.4.19.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.orcon.net.nz/		Please do not CC list postings to me.

