Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSHXMjm>; Sat, 24 Aug 2002 08:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHXMjm>; Sat, 24 Aug 2002 08:39:42 -0400
Received: from mta04ps.bigpond.com ([144.135.25.136]:61676 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S315988AbSHXMjj>; Sat, 24 Aug 2002 08:39:39 -0400
Message-ID: <3D677F5B.7AD0D472@bigpond.com>
Date: Sat, 24 Aug 2002 22:43:07 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, faith@valinux.com
Subject: Re: Linux 2.4.20-pre4 blows away Xwindows with Matrox G400 and DRM
References: <3D621BF8.F1242760@bigpond.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional info at end.

Allan Duncan wrote:
> 
> It was OK with pre2, went straight to pre4.
> Upon running startx I get a fraction of a second of activity before
> I'm plunged into an instant reboot.  Inspection of the XFree86.0.log
> shows the first and last lines as:
> XFree86 Version 4.2.0 (Red Hat Linux release: 4.2.0-8) / X Window System
> (protocol Version 11, revision 0, vendor release 6600)
> Release Date: 23 January 2002
>         If the server is older than 6-12 months, or if your card is
>         newer than the above date, look for a newer version before
>         reporting problems.  (See http://www.XFree86.Org/)
> Build Operating System: Linux 2.4.17-0.13smp i686 [ELF]
> Build Host: daffy.perf.redhat.com
> ...
> (==) MGA(0): Write-combining range (0xd8000000,0x2000000)
> (II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
> (--) MGA(0): 16 DWORD fifo
> (==) MGA(0): Default visual is TrueColor
> (II) MGA(0): [drm] bpp: 16 depth: 16
> (II) MGA(0): [drm] Sarea 2200+664: 2864
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is -1, (No such device)
> drmOpenDevice: Open failed
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
>  open result is -1, (No such device)
> drmOpenDevice: Open failed
> <EOF>
> 
> A good start continues on:
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is 7, (OK)
> drmGetBusid returned ''
> (II) MGA(0): [drm] loaded kernel module for "mga" driver
> (II) MGA(0): [drm] created "mga" driver at busid "PCI:1:0:0"
> (II) MGA(0): [drm] added 8192 byte SAREA at 0xe08e2000
> (II) MGA(0): [drm] mapped SAREA 0xe08e2000 to 0x40016000
> (II) MGA(0): [drm] framebuffer handle = 0xd8000000
> (II) MGA(0): [drm] added 1 reserved context for kernel
> (II) MGA(0): [agp] Mode 0x1f000201 [AGP 0x1106/0x3099; Card 0x102b/0x0525]
> 
> Selection from my config:
> CONFIG_AGP=m
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_I810 is not set
> CONFIG_AGP_VIA=y
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_DRM=y
> # CONFIG_DRM_OLD is not set
> 
> #
> # DRM 4.1 drivers
> #
> CONFIG_DRM_NEW=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_I810 is not set
> CONFIG_DRM_MGA=m
> 
> Hardware:
> Althon 1600+ XP, Matrox G400, VIA KT266A

I have done some more digging, including the same kernel on a second host.
The second box has a K6, VIA MVP3 chipset, and a G200 with 8M, otherwise
the software versions are the same.  It works fine.  Taking the .config
used for that, I redid the kernel on the AthlonXP / VIA KT266a / G400,
almost instant reboot.


One of the crashes was a touch later, and the last few lines from
/var/log/messages was:
Aug 21 20:46:32 localhost login(pam_unix)[1063]: session opened for user alland by LOGIN(uid=0)
Aug 21 20:46:32 localhost  -- alland[1063]: LOGIN ON tty1 BY alland
Aug 21 20:50:22 localhost modprobe: modprobe: Can't locate module char-major-226
Aug 21 20:50:22 localhost modprobe: modprobe: Can't locate module char-major-226
Aug 21 20:50:22 localhost kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Aug 21 20:50:22 localhost kernel: agpgart: Maximum main memory to use for agp memory: 439M
Aug 21 20:50:22 localhost kernel: agpgart: Detected Via Apollo Pro KT266 chipset
Aug 21 20:50:22 localhost kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Aug 21 20:50:22 localhost kernel: [drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 128MB
Aug 21 20:50:22 localhost kernel: [drm] Initialized mga 3.0.2 20010321 on minor 0
Aug 21 20:57:29 localhost syslogd 1.4.1: restart.

The "char-major-226" corresponds to the /dev/dri/card0 above, and the failure point
seems to be when the drmOpenDevice succeeds on the third attempt.

I tried unsetting CONFIG_DRM, but it still fails.
