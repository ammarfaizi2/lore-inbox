Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUBFWcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUBFWcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:32:21 -0500
Received: from post.tau.ac.il ([132.66.16.11]:28102 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S265579AbUBFWcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:32:16 -0500
Date: Sat, 7 Feb 2004 00:32:05 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel DRI support
Message-ID: <20040206223205.GH2582@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1076105201.27023.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076105201.27023.16.camel@localhost>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.60; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 10:06:41PM +0000, David Seery wrote:
> Hello,
> 

Try the dri-devel mailing list, you'll probably have more luck with
this subject there.
Look at http://dri.sourceforge.net/cgi-bin/moin.cgi/

> I have a laptop with a Radeon IGP 320M U1 Mobility graphics card.
> 
> I've been looking for information on the bugzilla at XFree86, usenet,
> various Linux forums and the archives of this and other mailing lists.
> It's not too difficult to get the thing up and running, at the moment
> with a patched XFree86 and a patched 2.6.2 kernel.
> 
> I have two questions:
> 
> 1.  It seems like support for these nasty chipsets went into the kernel
> around 2.4.22, but it doesn't work out of the box on 2.6.2 and I needed
> to apply a patch, mostly to drivers/char/drm/radeon_cp.c, to shift the
> base of the framebuffer.  This comes from http://bugs.xfree86.org/
> show_bug.cgi?id=314.  The patch didn't apply cleanly so I did it by
> hand.
> 
> Is this correct, or should the radeon agp stuff as is?
> 
> 2.  The result is not really any faster than doing it in software.  In
> particular, it doesn't make any difference if I have mtrr write-
> combining ranges set up or not, so it seems like the AGP acceleration
> isn't really being used.
> 

Try running glxinfo and look near the top whether dri is enabled (You
also need to have it enabled in XF86Config).
I'm afraid that I don't know this card so except for the setup options
I probably can't help much with that one, sorry.

> Am I off the mark here, or is this a known problem with support for
> these IGP devices?
> 
> I've been unable to find previous responses about this.  Pardon me if
> I'm rehashing old ground.
> 
> For benchmarking purposes, I get about 450-480 fps with glxgears as
> compared with 430-450 without DRI.  Or, is there another reason I should
> be thinking about for poor performance?  (Such as, the inherent badness
> of the card, perhaps?)
> 
> Cheers,
> 
> David
> 
> Some relevant output:
> 
> dmesg | grep -i agp
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected Ati IGP320/M chipset
> agpgart: Maximum main memory to use for agp memory: 148M
> agpgart: AGP aperture is 64M @ 0xd4000000
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
> 
> dmesg | grep -i drm
> [drm] Initialized i830 1.3.2 20021108 on minor 0
> [drm] Initialized radeon 1.9.0 20020828 on minor 1
> 
> cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
> reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
> reg02: base=0xd4000000 (3392MB), size=  64MB: write-combining, count=2
> reg03: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=2
> 
> grep -i drm /var/log/XFree86.0.log        (trimmed)
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is 6, (OK)
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is 6, (OK)
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is 6, (OK)
> drmOpenDevice: minor is 1
> drmOpenDevice: node name is /dev/dri/card1
> drmOpenDevice: open result is 6, (OK)
> drmGetBusid returned ''
> (II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:5:0"
> (II) RADEON(0): [drm] added 8192 byte SAREA at 0xcc92b000
> (II) RADEON(0): [drm] mapped SAREA 0xcc92b000 to 0x44268000
> (II) RADEON(0): [drm] framebuffer handle = 0xe0000000
> (II) RADEON(0): [drm] added 1 reserved context for kernel
> (II) RADEON(0): [drm] register handle = 0xd0100000
> (II) RADEON(0): [drm] installed DRM signal handler
> (II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
> (II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
> (II) RADEON(0): [drm] dma control initialized, using IRQ 9
> (II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
> 
> grep -i agp /var/log/XFree86.0.log             (trimmed)
> (**) RADEON(0): Option "AGPMode" "4"
> (**) RADEON(0): Option "AGPFastWrite" "true"
> (II) RADEON(0): AGP card detected
> (**) RADEON(0): AGP 4x mode is configured
> (**) RADEON(0): Enabling AGP Fast Write
> (II) RADEON(0): [agp] Mode 0x0f000214 [AGP 0x1002/0xcab0; Card
> 0x1002/0x4336]
> (II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
> (II) RADEON(0): [agp] ring handle = 0xd4000000
> (II) RADEON(0): [agp] Ring mapped at 0x4426a000
> (II) RADEON(0): [agp] ring read ptr handle = 0xd4101000
> (II) RADEON(0): [agp] Ring read ptr mapped at 0x4436b000
> (II) RADEON(0): [agp] vertex/indirect buffers handle = 0xd4102000
> (II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0x4436c000
> (II) RADEON(0): [agp] GART texture map handle = 0xd4302000
> (II) RADEON(0): [agp] GART Texture map mapped at 0x4456c000
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
