Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279846AbRKOBe3>; Wed, 14 Nov 2001 20:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKOBeT>; Wed, 14 Nov 2001 20:34:19 -0500
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:28833 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S279617AbRKOBeM>;
	Wed, 14 Nov 2001 20:34:12 -0500
Message-ID: <3BF31C42.469BF2B2@randomlogic.com>
Date: Wed, 14 Nov 2001 17:37:06 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Stevens wrote:
> 
> Hi folks - I'm having real problems getting our new dual CPU server
> going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
> an Adaptec SCSI controller and 512Mb DDR SDRAM. I'm not a Linux newbie
> at all, but I've never tried running it on such exotic hardware before,
> and it doesn't seem happy....
> 
> I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
> kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
> type, can't reboot, can't do anything. Single user mode _does_ let me
> in, however, and this is the only progress so far.
> 
> I then tried building a custom 2.4.15-pre4 (on another machine), which
> compiled perfectly happily, and I installed this on the server. It
> panic'd due to failure to mount the root filesystem. I made an
> initrd.img, and it then got further (detecting and initialising the SCSI
> controller), but still panic'd with the same message.
> 
> I then threw down the gauntlet and installed the rawhide Athlon
> SMP kernel (based on 2.4.13) which also booted fine but HUNG at the
> login prompt, as above. Finally, I tried the i686 version, which spewed
> out tons of error messages regarding "invalid symbols" in the ext3
> module.
> 
> Either way, I'm stumped. Am I up against an Athlon / chipset problem
> here, or is something else wrong? What do I need to do to get my
> custom-built 2.4.15-pre4 rolling - why can't it mount the root
> partition?
> 

Long thread, including a some misinformation.

I have a Tyan K7 Thunder with dual 1.4GHz Thunderbirds. It took me a week to get it working, and was the initial reason I joined this list. It seems I had one
of the few Thunders on the planet that was trying to run Linux, condidering I bought the board almost as soon as they hit the stores :).

First of all, all Athlons support SMP. Neither AMD nor MoBo vendors support SMP using non-MP/XP Athlons (I've asked a real person on the phone). I selected dual
1.4GHz Thunderbirds because they were slightly faster than 1.2GHZ MP chips, less money, and I already had one at the time (from an A7V133 system that kept
crashing). XP processors are faster, lower power versions of the MP, so of course they support SMP. They all use the same EV6 bus - a point-to-point bus taken
from the DEC Alpha processor and capable of up to 400MHz operation and twice the bandwidth in SMP configurations per MHz as the Intel bus.

Second, kernels before 2.4.8 did not work worth a damn. As I recall, RH 7.1 hardly installed, let alone booted. The MP chipset was very new (and buggy - as they
all seem to be) and not all the support code was there yet when these kernels came out. The BIOS was even newer and only recently do the BIOS upgrades have
decent AGP and other chipset support in them. The kernel I finally got working in a stable way is 2.4.9ac10 with some minor tweaks to make it friendlier with my
GeForce 3, the 760MP chipset, and IDE. I also tweaked the nVidia driver because it couldn't recognize or work properly with the 760MP AGP harware. Before I
compiled my own kernel, I had no end to problems with lock-ups, often during compile time.

The only problem I still have is IDE. I can not run the IDE drive using DMA or the system will hang HARD, usually with the drive access light on. Even with DMA
disabled it might hang under high IDE usage. I will replace the IDE drive with a SCSI drive soon as the SCSI interface works perfectly and very fast. Early MP
chipsets had AGP and DMA hardware bugs, but according to AMD errata, the revision in my MoBo should not have these bugs (that doesn't mean it doesn't have them
though).

In addition, when compiling my kernel, I made sure I included the IDE and SCSI drivers in the kernel, NOT as modules. This avoids having to make a new
initrd.img every time I made a new kernel (and I made many of them, and have 6 different ones still on the machine :) and solved the issue of not mounting root.


Hope this helps.

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
