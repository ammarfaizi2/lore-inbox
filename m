Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVAUSVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVAUSVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVAUSTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:19:40 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:3591 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262441AbVAUSSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:18:34 -0500
Date: Fri, 21 Jan 2005 19:26:56 +0100
To: Dave Airlie <airlied@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, binary search result
Message-ID: <20050121182656.GA24167@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <21d7e997050113130659da39c9@mail.gmail.com> <20050115185712.GA17372@hh.idb.hist.no> <21d7e997050116020859687c4a@mail.gmail.com> <20050116105011.GA5882@hh.idb.hist.no> <9e4733910501160304642f7882@mail.gmail.com> <21d7e99705011603072d26727a@mail.gmail.com> <9e473391050116033435e5db9c@mail.gmail.com> <21d7e99705011603415d6a6bdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705011603415d6a6bdf@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 10:41:23PM +1100, Dave Airlie wrote:
> > 
> > I'm fine with adding this code, but we still don't know if this is the
> > cause of his problem. The debug output can determine if this really is
> > the source of the problem or if it is somewhere else.
> > 
> 
> I actually doubt it is this stuff.. my guess is that it is something
> nasty like ACPI breaking int10 for X or something like that... it
> seems a lot more subtle than the usually things that break when we
> mess with the DRM :-)
> 
The search was a short one.  
2.6.9-rc1 works fine, just like 2.6.8.1
2.6.9-rc2 crashes.  I didn't find any kernel revisions between those two.

It is interesting to note that the 2.6.9 crash was a bit different.
X got a bit further according to the log.
During the test, everything stopped, but the machine wasn't completely
dead like it usually is.  Numlock actually toggled the LED, but the screen was 
black and I could not break out of X with ctrl+alt+backspace. So I tried to 
switch consoles, and the kernel died a bit more.  No more numlock LED
toggling, but sysrq+S+U+B actually worked.  The discs synced and
the thing booted.  Hm, perhaps  X always got a bit further, but
now the disc sync preserved more of the log?

Here is how it ended (I have all of it if necessary):

(==) RADEON(0): Write-combining range (0xe0000000,0x8000000)
(II) RADEON(0): Wrote: rd=12, fd=120, pd=1
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:0:8:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe0920000
(II) RADEON(0): [drm] mapped SAREA 0xe0920000 to 0xafd8c000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [pci] 8192 kB allocated with handle 0xe097d000
(II) RADEON(0): [pci] ring handle = 0xe097d000
(II) RADEON(0): [pci] Ring mapped at 0xafc8b000
(II) RADEON(0): [pci] Ring contents 0x00000000
(II) RADEON(0): [pci] ring read ptr handle = 0xe0a7e000
(II) RADEON(0): [pci] Ring read ptr mapped at 0xafc8a000
(II) RADEON(0): [pci] Ring read ptr contents 0x00000000
(II) RADEON(0): [pci] vertex/indirect buffers handle = 0xe0a7f000
(II) RADEON(0): [pci] Vertex/indirect buffers mapped at 0xafa8a000
(II) RADEON(0): [pci] Vertex/indirect buffers contents 0x00000000
(II) RADEON(0): [pci] GART texture map handle = 0xe0c7f000
(II) RADEON(0): [pci] GART Texture map mapped at 0xaf5aa000
(II) RADEON(0): [drm] register handle = 0xf6000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (1280,8191)
(II) RADEON(0): Reserved area from (0,1024) to (1280,1026)
(II) RADEON(0): Largest offscreen area available: 1280 x 7165
(II) RADEON(0): Will use back buffer at offset 0x1400000
(II) RADEON(0): Will use depth buffer at offset 0x1900000
(II) RADEON(0): Will use 100352 kb for textures at offset 0x1e00000
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
        Screen to screen bit blits
        Solid filled rectangles
        8x8 mono pattern filled rectangles
        Indirect CPU to Screen color expansion
        Solid Lines
        Scanline Image Writes
        Offscreen Pixmaps
        Setting up tile and stipple cache:
                32 128x128 slots
                32 256x256 slots
                16 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 1026)
(II) RADEON(0): Largest offscreen area available: 1280 x 7161
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(WW) RADEON(0): Option "DynamicClocks" is not used
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers


I hope this can be of help,
Helge Hafting
