Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbSAEDK1>; Fri, 4 Jan 2002 22:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287475AbSAEDKR>; Fri, 4 Jan 2002 22:10:17 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:12303 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S287478AbSAEDKJ>;
	Fri, 4 Jan 2002 22:10:09 -0500
Date: Fri, 4 Jan 2002 19:10:05 -0800 (PST)
From: Noah Romer <klevin@eskimo.com>
Reply-To: Noah Romer <klevin@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: via kt266a and agp/dri/drm support
Message-ID: <Pine.SUN.3.96.1020104165009.18050A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Shuttle AK31 Rev3 motherboard (Athlon XP 1800 cpu) and am trying
to get XWindows working. My video card is an ATI Radeon 8500 (QL). I'm 
using XFree86 4.1.99.4 (cvs). With the 2.4.7-10 kernel from Red Hat 7.2, X
will run, but w/o agp/dri/drm support. I've tried updating to the 2.4.16
kernel and the kernel at least claims to be providing agp support, but
when I run startx w/ the 2.4.16 kernel, my monitor loses sync and goes
into its power saving mode and the only thing I can do is hit crtl-alt-del
to reboot. 

The one thing that sticks out to me is that, with the 2.4.16 kernel, the
agpgart driver says the chipset is a KT266 (but not KT266A), but the drm
driver says the chipset is a KT133.

The relevant sections of dmesg output and /var/log/XFree86.0.log, running
2.4.7-10 - 
~
dmesg output (agpgart doesn't load because it doesn't recognise the
chipset):
[drm] Initialized radeon 1.1.1 20010405 on minor 0

XFree86.0.log:
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe0906000
(II) RADEON(0): [drm] mapped SAREA 0xe0906000 to 0x40017000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(EE) RADEON(0): [agp] AGP not available
(EE) RADEON(0): [drm] failed to remove DRM signal handler
(II) RADEON(0): [drm] removed 1 reserved context for kernel
DRIUnlock called when not locked
(II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xe0906000 at
0x40017000


running the 2.4.16 kernel -
dmesg output:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe8000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1

XFree86.0.log:

drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenDevice: minor is 1
drmOpenDevice: node name is /dev/dri/card1
drmOpenDevice: open result is 6, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe08cd000
(II) RADEON(0): [drm] mapped SAREA 0xe08cd000 to 0x40017000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f000211 [AGP 0x1106/0x3099; Card
0x1002/0x514c]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0xe08d0000
(II) RADEON(0): [agp] ring handle = 0xe8000000
(II) RADEON(0): [agp] Ring mapped at 0x4423a000
(II) RADEON(0): [agp] ring read ptr handle = 0xe8101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0x40019000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xe8102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0x4433b000
(II) RADEON(0): [agp] AGP texture map handle = 0xe8302000
(II) RADEON(0): [agp] AGP Texture map mapped at 0x4453b000
(II) RADEON(0): [drm] register handle = 0xed000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB AGP aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for AGP textures

Any sugestions? I've run out of ideas.

P.S. Please CC me on any responses.

--
Noah Romer              |"Calm down, it's only ones and zeros." - this message
klevin@eskimo.com       |brought to you by The Network
PGP key available       |"Time will have its say, it always does." - Celltrex
by finger or email      |from Flying to Valhalla by Charles Pellegrino


