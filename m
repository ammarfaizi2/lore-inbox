Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUAXWjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUAXWjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:39:09 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:56727 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262707AbUAXWjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:39:04 -0500
Message-ID: <40124B47.9040505@yahoo.com>
Date: Sat, 24 Jan 2004 02:39:03 -0800
From: Brandon Ehle <azverkan@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan Maciej <stephanm@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Status of Athlon 64 K8V-D support was (Re: Strange pauses in 2.6.2-rc1
 / AMD64)
References: <Pine.LNX.4.44.0401212107010.24057-100000@www.princetongames.org> <40108A2B.3080605@yahoo.com> <200401241505.40566.stephanm@muc.de>
In-Reply-To: <200401241505.40566.stephanm@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan Maciej wrote:
> On Friday 23 January 2004 03:42, Brandon Ehle wrote:
> 
>>This is on a Athlon 64 3000+ on a K8V Deluxe, 1GB RAM, Gentoo for x86_64.
> 
> 
> Hi,
> 
> I am playing with the idea of getting exactly this HW config in the near 
> future. I haven't found much user reports concerning running Linux - possibly 
> Gentoo - on such a system (Athlon64 on an K8V-D mobo). Do your SATA 
> controllers work, esp. when booting an AMD64 kernel? How's the rest of the 
> on-board hardware behaving? Is it all working? What memory brand did you buy?
> 
> Thanks a lot in advance,
> 
> Stephan
> 

First off, I'm only running the 2.6 kernel and haven't even tried the
2.4 kernel on this board.

The board comes with 2 software RAID SATA controllers in addition to the
PATA ones.  I've only gotten one of the two SATA controllers (VIA) to
work, and I'm not using RAID (just a single 10,000RPM drive).  I believe
Gentoo's gentoo-dev-sources kernel has a driver for the other controller
(Promise FastTrak 378), but I haven't tried it yet because I'm already
reaching the peak of the drive with the controller I have working.  One
thing to note is that the harddrive does run about 20% slower in x86_64
kernels currently, but I'm not sure why that is.

I went with 2 matched sticks of Geil DDR433 512MB (PC-3500), but one of
the weird things about the board is that if I use the other 2 memory
slots (4 in total), the RAM will only go DDR333 instead of DDR400 (I
picked DDR433 in case I want to try overclocking someday).  I'm not sure
if that's specific to this board or if all of them have that problem
(due to the onchip memory controller).

The onboard 1000MB 3COM card (sk98lin driver) is pretty typical of all
3COM cards and fails under extremely high load cases (I've never used a
3COM card that didn't fail under my high load conditions), so I'm using
a second PCI 100MB NIC (tulip driver) to talk to my high load device and
the 1GB for my Internet connection.  I don't think it is the sk98lin
driver at fault because the card takes a nosedive under high load
conditions in Win2K too (reaching the theorhetical peak of the card).

I don't use the onboard sound as I have an Audigy 2 (OSS driver, ALSA
doesn't work), so I don't know anything about that.  All 8 USB ports
(uhci-hcd driver) work fine.  I don't have any firewire devices, but it
finds the port ok.  For video I'm running a GeForce FX 5900 Ultra
(nvidia proprietary) and that works good too (using the amd640-agp driver).

Everything hardware seems to work equally well in x86 or x86_64 mode,
but I'm not running in x86_64 mode anymore because of all the userspace
problems.  The only issue I ran into when going to x86_64 was needing to
turn off "Legacy USB Support" in the BIOS so I didn't have to pass
idle=poll on the command line which then stops me from getting the 3-5
second pauses when compiling or running benchmarks.

Gentoo was my choice of OS for x86_64 mode because none of the other
distributions have a decent sized package set for x86_64 yet, but I've
fallen back to debian-unstable (for better stability!) until more
packages support x86_64.


