Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVAPKKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVAPKKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVAPKKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:10:00 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:60612 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262472AbVAPKIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:08:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mg7SoxLaYguUPC9he2Jk5UDs7Mn7/JpSEhydiHoHEGqCsGJHgoy9WAX9BsFwN/K84VM0ZskeIqgtHyA5NfCTU2gjVBLk5BBSp/FX+qX2q70ICVyhdoJ9AZRD6sDlz1knaUm2YEmoBo3LRVwErlbHMPM2i2Gwfarw7Ep6C1GmYr0=
Message-ID: <21d7e997050116020859687c4a@mail.gmail.com>
Date: Sun, 16 Jan 2005 21:08:38 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: covici@ccs.covici.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20050115185712.GA17372@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some more data:
> 2.6.10 with agp and drm (drm for radeon & matrox) - dies with X on radeon
> 2.6.10 with drm (for radeon) no agp               - runs X fine!
> 2.6.10 with agp and no drm at all                 - dies with X on radeon
> 2.6.10 no agp no drm                              - runs X, but no 3d of course
> 
> 2.6.10 with drm and no agp couldn't use matrox drm because that one
> needs agp to compile.
> 
> This is a bit strange.  I can't run X on the radoen PCI card if AGP is compiled,
> but X and the kernel is not supposed to use AGP in this case because it is a
> pci card!  Seems very strange to me, particularly considering that 2.6.8.1
> is able to run with both agp and drm.
> 
> I've mounted /var synchronously so as to get the most of the crash log.  It ends
> like this:
> 
> (II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
> (II) Loading sub module "int10"
> (II) LoadModule: "int10"
> (II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
> (II) RADEON(0): initializing int10
> (**) RADEON(0): Option "InitPrimary" "on"
> (II) Truncating PCI BIOS Length to 53248
> 
> A normal non-crashing run looks like this:
> (II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
> (II) LoadModule: "int10"
> (II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
> (II) RADEON(0): initializing int10
> (**) RADEON(0): Option "InitPrimary" "on"
> (II) Truncating PCI BIOS Length to 53248
> (--) RADEON(0): Chipset: "ATI Radeon 9200SE 5964 (AGP)" (ChipID = 0x5964)
> (--) RADEON(0): Linear framebuffer at 0xe0000000
> (--) RADEON(0): VideoRAM: 131072 kByte (64 bit DDR SDRAM)
> (II) RADEON(0): PCI card detected
> (II) Loading sub module "ddc"
> (II) LoadModule: "ddc"
> 
> (and so on)
> 
> Another item that may be interesting:
> From the log, it looks like DRM failed to load for the PCI card when
> AGP wasn't present.  Odd - it couldn't use AGP anyway.
> Maybe the explanation is that the xserver erroneously believes that it is
> an agp card?  The log contains this:
> 
> (--) Chipset ATI Radeon 9200SE 5964 (AGP) found
> 
> It _is_ an "ATI Radeon 9200 SE", but it is definitely not an AGP card.
> I don't know wether the X server is mistaken, or if it merely is a
> wrong message.  I don't think X should hang the kernel this way, even
> if it opens the AGP device by mistake.  AGP is normally in use by the
> matrox card and should be unavailable anyway.

Well the problem with a lot of ATI chips is they can be put onto
either an AGP or PCI card and work fine, so chips which are AGP chips
can end up on PCI cards...

I've cc'ed Jon Smirl who has a similiar setup (or has at least an AGP
and PCI radeon on his machine).... Jon can you try 2.6.10 on your
setup and see does it work?

it sounds like something may have broken the int10 stuff, but I've no
idea what, the only other thing I can think to recommend doing is an
binary search say starting at 2.6.9-rc1 and maybe using the -bk
snapshots to nail down exactly when it went wrong....

Dave.
