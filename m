Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTEGAJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTEGAJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:09:59 -0400
Received: from [66.186.193.1] ([66.186.193.1]:27396 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id S262000AbTEGAJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:09:51 -0400
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 64.122.104.99
X-Authenticated-Timestamp: 20:27:29(EDT) on May 06, 2003
X-HELO-From: [10.134.0.76]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 64.122.104.99
Subject: DRI crash with 2.5.69, mga, Red Hat 9
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052266697.1250.15.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 17:18:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might actually be an X or Matrox driver bug, but anyway...

I saw that some DRI fixes went in to 2.5.69 so I decided to give it a
shot.  glxgears ran great, but the second gl screensaver I tried locked
up the machine hard.

(I haven't been able to get DRI-accelerated rendering working with other
kernels either.)

The last message in the system log was:
[drm:mga_dma_clear] *ERROR* mga_dma_clear called without lock held

The hardware is a P3 733 Mhz with 640 MB of RDRAM on an Intel 820
chipset, with a Matrox MGA 200 video card.  It's running Red Hat 9.0 and
the X 4.3.0 and drivers that come with that distribution.

The "busyspheres" screensaver running in the XScreensaver preview window
is what killed it, after running glxgears and the biof screensaver. 
"busyspheres" and "biof" are part of the "Really Slick Screensavers",
available from reallyslick.com

A snippet from the kernel dmesg log:

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i820 chipset
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized mga 3.1.0 20021029 on minor 0

And some perhaps-useful bits from the XFree86 log:

(--) PCI:*(1:0:0) Matrox Graphics, Inc. MGA G200 AGP rev 3, Mem @
0xf5000000/24, 0xf4800000/14, 0xf4000000/23

(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
        compiled for 4.3.0, module version = 1.0.0
        ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
        compiled for 4.3.0, module version = 1.0.0
        ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI


(II) LoadModule: "mga"
(II) Loading /usr/X11R6/lib/modules/drivers/mga_drv.o
(II) Module mga: vendor="The XFree86 Project"
        compiled for 4.3.0, module version = 1.1.0
        Module class: XFree86 Video Driver
        ABI class: XFree86 Video Driver, version 0.6

(II) MGA: driver for Matrox chipsets: mga2064w, mga1064sg, mga2164w,
        mga2164w AGP, mgag100, mgag100 PCI, mgag200, mgag200 PCI,
mgag400,
        mgag550
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset mgag200 found

(--) MGA(0): Chipset: "mgag200"
(**) MGA(0): Depth 16, (--) framebuffer bpp 16
(==) MGA(0): RGB weight 565
(==) MGA(0): Using AGP 1x mode
(--) MGA(0): Linear framebuffer at 0xF5000000
(--) MGA(0): MMIO registers at 0xF4800000
(--) MGA(0): Pseudo-DMA transfer window at 0xF4000000
(==) MGA(0): BIOS at 0xC0000
(--) MGA(0): Video BIOS info block at offset 0x07AC0
(--) MGA(0): Found and verified enhanced Video BIOS info block
(II) MGA(0): MGABios.RamdacType = 0x0
(==) MGA(0): Write-combining range (0xf5000000,0x1000000)
(--) MGA(0): VideoRAM: 8192 kByte

(==) MGA(0): Default visual is TrueColor
(II) MGA(0): [drm] bpp: 16 depth: 16
(II) MGA(0): [drm] Sarea 2200+664: 2864
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmGetBusid returned ''
(II) MGA(0): [drm] created "mga" driver at busid "PCI:1:0:0"
(II) MGA(0): [drm] added 8192 byte SAREA at 0xe88be000
(II) MGA(0): [drm] mapped SAREA 0xe88be000 to 0x4002b000
(II) MGA(0): [drm] framebuffer handle = 0xf5000000
(II) MGA(0): [drm] added 1 reserved context for kernel
(II) MGA(0): [agp] Mode 0x1f000201 [AGP 0x8086/0x2501; Card
0x102b/0x0521]
(II) MGA(0): [drm] Disabling AGP 2x PLL encoding
(II) MGA(0): [agp] 12288 kB allocated with handle 0x00000000
(II) MGA(0): [agp] WARP microcode handle = 0xf8000000
(II) MGA(0): [agp] WARP microcode mapped at 0x410e7000
(II) MGA(0): [agp] Primary DMA handle = 0xf8008000
(II) MGA(0): [agp] Primary DMA mapped at 0x410ef000
(II) MGA(0): [agp] DMA buffers handle = 0xf8108000
(II) MGA(0): [agp] DMA buffers mapped at 0x411ef000
(II) MGA(0): [drm] Added 128 65536 byte DMA buffers
(II) MGA(0): [agp] agpTexture handle = 0xf8908000
(II) MGA(0): [agp] agpTexture size: 2816 kb
(II) MGA(0): [drm] Registers handle = 0xf4800000
(II) MGA(0): [drm] Status handle = 0xe90d7000
(II) MGA(0): [agp] Status page mapped at 0x419ef000
(II) MGA(0): [dri] visual configs initialized
(II) MGA(0): Memory manager initialized to (0,0) (1024,1535)
(II) MGA(0): Largest offscreen area available: 1024 x 767
(II) MGA(0): Reserved back buffer at offset 0x300000
(II) MGA(0): Reserved depth buffer at offset 0x480000
(II) MGA(0): Reserved 2048 kb for textures at offset 0x600000
(II) MGA(0): Using XFree86 Acceleration Architecture (XAA)

I'd love it if I could get accelerated graphics running on this machine,
but so far no luck.  If more information would be helpful I'd be happy
to test and debug...


-- 
Torrey Hoffman <thoffman@arnor.net>

