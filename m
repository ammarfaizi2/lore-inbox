Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265359AbSJaUEW>; Thu, 31 Oct 2002 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265358AbSJaUEV>; Thu, 31 Oct 2002 15:04:21 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:10480 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265359AbSJaUEQ>; Thu, 31 Oct 2002 15:04:16 -0500
Date: Thu, 31 Oct 2002 13:03:54 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [BK fbdev updates] 
Message-ID: <Pine.LNX.4.33.0210311258040.1721-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about not producing a regular diff. The final changes really did a
number on the framebuffer console code in fbcon.c so I had some massive
work to do. I still have a massive amount of cleaning up to do. Also a lot
of drivers stil haven't been ported.

So here is the regular diff against 2.5.45

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

diffstat:

 CREDITS                                |   10
 Documentation/DocBook/kernel-api.tmpl  |    4
 MAINTAINERS                            |    7
 arch/alpha/Kconfig                     |   31
 arch/arm/Kconfig                       |   21
 arch/i386/Kconfig                      |   55
 arch/ia64/Kconfig                      |   25
 arch/m68k/Kconfig                      |    7
 arch/mips/Kconfig                      |   62
 arch/mips64/Kconfig                    |   23
 arch/parisc/Kconfig                    |   19
 arch/ppc/Kconfig                       |   22
 arch/ppc64/Kconfig                     |    7
 arch/sh/Kconfig                        |   55
 arch/sparc/Kconfig                     |   16
 arch/sparc64/Kconfig                   |   11
 arch/x86_64/Kconfig                    |   55
 drivers/Makefile                       |    3
 drivers/char/consolemap.c              |    1
 drivers/char/keyboard.c                |    1
 drivers/char/selection.c               |    1
 drivers/char/tty_io.c                  |    7
 drivers/char/vc_screen.c               |    1
 drivers/char/vt.c                      |  181
 drivers/char/vt_ioctl.c                |   58
 drivers/video/Kconfig                  |  338 -
 drivers/video/Makefile                 |   45
 drivers/video/S3triofb.c               |    2
 drivers/video/amifb.c                  |    2
 drivers/video/anakinfb.c               |   18
 drivers/video/atafb.c                  |    2
 drivers/video/aty/atyfb_base.c         |  111
 drivers/video/aty/mach64_ct.c          |    2
 drivers/video/aty/mach64_cursor.c      |    2
 drivers/video/aty/mach64_gx.c          |    2
 drivers/video/aty128fb.c               | 3165 +++++++---------
 drivers/video/cfbcopyarea.c            |  485 ++
 drivers/video/cfbfillrect.c            |  107
 drivers/video/cfbimgblt.c              |  335 +
 drivers/video/chipsfb.c                |    2
 drivers/video/clps711xfb.c             |   16
 drivers/video/console/Kconfig          |  277 +
 drivers/video/console/Makefile         |   52
 drivers/video/console/dummycon.c       |   73
 drivers/video/console/fbcon-accel.c    |  330 +
 drivers/video/console/fbcon-accel.h    |   34
 drivers/video/console/fbcon-afb.c      |  448 ++
 drivers/video/console/fbcon-afb.h      |   32
 drivers/video/console/fbcon-hga.c      |  253 +
 drivers/video/console/fbcon-ilbm.c     |  296 +
 drivers/video/console/fbcon-ilbm.h     |   32
 drivers/video/console/fbcon-iplan2p2.c |  476 ++
 drivers/video/console/fbcon-iplan2p2.h |   32
 drivers/video/console/fbcon-iplan2p4.c |  497 ++
 drivers/video/console/fbcon-iplan2p4.h |   32
 drivers/video/console/fbcon-iplan2p8.c |  534 ++
 drivers/video/console/fbcon-iplan2p8.h |   32
 drivers/video/console/fbcon-sti.c      |  289 +
 drivers/video/console/fbcon.c          | 2476 +++++++++++++
 drivers/video/console/fbcon.h          |  188
 drivers/video/console/font.h           |   53
 drivers/video/console/font_6x11.c      | 3351 +++++++++++++++++
 drivers/video/console/font_8x16.c      | 4631 ++++++++++++++++++++++++
 drivers/video/console/font_8x8.c       | 2583 +++++++++++++
 drivers/video/console/font_acorn_8x8.c |  277 +
 drivers/video/console/font_mini_4x6.c  | 2158 +++++++++++
 drivers/video/console/font_pearl_8x8.c | 2587 +++++++++++++
 drivers/video/console/font_sun12x22.c  | 6220 +++++++++++++++++++++++++++++++++
 drivers/video/console/font_sun8x16.c   |  275 +
 drivers/video/console/fonts.c          |  135
 drivers/video/console/mdacon.c         |  631 +++
 drivers/video/console/newport_con.c    |  745 +++
 drivers/video/console/prom.uni         |   11
 drivers/video/console/promcon.c        |  605 +++
 drivers/video/console/sti.h            |  289 +
 drivers/video/console/sticon.c         |  214 +
 drivers/video/console/sticore.c        |  601 +++
 drivers/video/console/vgacon.c         | 1066 +++++
 drivers/video/controlfb.c              |    2
 drivers/video/cyberfb.c                |    2
 drivers/video/dnfb.c                   |   18
 drivers/video/dummycon.c               |   74
 drivers/video/epson1355fb.c            |    2
 drivers/video/fbcmap.c                 |   92
 drivers/video/fbcon-accel.c            |  188
 drivers/video/fbcon-accel.h            |   34
 drivers/video/fbcon-afb.c              |  448 --
 drivers/video/fbcon-cfb16.c            |  319 -
 drivers/video/fbcon-cfb2.c             |  225 -
 drivers/video/fbcon-cfb24.c            |  333 -
 drivers/video/fbcon-cfb32.c            |  305 -
 drivers/video/fbcon-cfb4.c             |  229 -
 drivers/video/fbcon-cfb8.c             |  294 -
 drivers/video/fbcon-hga.c              |  253 -
 drivers/video/fbcon-ilbm.c             |  296 -
 drivers/video/fbcon-iplan2p2.c         |  476 --
 drivers/video/fbcon-iplan2p4.c         |  497 --
 drivers/video/fbcon-iplan2p8.c         |  534 --
 drivers/video/fbcon-mfb.c              |  217 -
 drivers/video/fbcon-sti.c              |  337 -
 drivers/video/fbcon-vga-planes.c       |  387 --
 drivers/video/fbcon.c                  | 2509 -------------
 drivers/video/fbgen.c                  |  313 -
 drivers/video/fbmem.c                  |  100
 drivers/video/fm2fb.c                  |   17
 drivers/video/font_6x11.c              | 3351 -----------------
 drivers/video/font_8x16.c              | 4631 ------------------------
 drivers/video/font_8x8.c               | 2583 -------------
 drivers/video/font_acorn_8x8.c         |  277 -
 drivers/video/font_mini_4x6.c          | 2158 -----------
 drivers/video/font_pearl_8x8.c         | 2587 -------------
 drivers/video/font_sun12x22.c          | 6220 ---------------------------------
 drivers/video/font_sun8x16.c           |  275 -
 drivers/video/fonts.c                  |  135
 drivers/video/g364fb.c                 |   32
 drivers/video/hgafb.c                  |  228 -
 drivers/video/hitfb.c                  |   17
 drivers/video/hpfb.c                   |   16
 drivers/video/igafb.c                  |    2
 drivers/video/imsttfb.c                |    3
 drivers/video/macfb.c                  |   22
 drivers/video/macmodes.c               |    3
 drivers/video/macmodes.h               |   70
 drivers/video/matrox/i2c-matroxfb.c    |    2
 drivers/video/matrox/matroxfb_base.c   |    4
 drivers/video/matrox/matroxfb_crtc2.c  |    4
 drivers/video/maxinefb.c               |   15
 drivers/video/mdacon.c                 |  632 ---
 drivers/video/modedb.c                 |    7
 drivers/video/neofb.c                  |   28
 drivers/video/newport_con.c            |  746 ---
 drivers/video/offb.c                   |   23
 drivers/video/platinumfb.c             |    2
 drivers/video/pm2fb.c                  |    2
 drivers/video/pm3fb.c                  |    2
 drivers/video/pmag-ba-fb.c             |   15
 drivers/video/pmagb-b-fb.c             |   15
 drivers/video/prom.uni                 |   11
 drivers/video/promcon.c                |  606 ---
 drivers/video/pvr2fb.c                 |    4
 drivers/video/q40fb.c                  |   16
 drivers/video/retz3fb.c                |    2
 drivers/video/sa1100fb.c               |    2
 drivers/video/sbusfb.c                 |    2
 drivers/video/sgivwfb.c                |   24
 drivers/video/sis/Makefile             |    2
 drivers/video/sis/sis_accel.c          |  495 ++
 drivers/video/sis/sis_main.c           |    2
 drivers/video/skeletonfb.c             |   28
 drivers/video/sstfb.c                  |    2
 drivers/video/sti-bmode.h              |  287 -
 drivers/video/sti.h                    |  289 -
 drivers/video/sticon-bmode.c           |  895 ----
 drivers/video/sticon.c                 |  215 -
 drivers/video/sticore.c                |  601 ---
 drivers/video/sticore.h                |  407 ++
 drivers/video/stifb.c                  | 1403 ++++++-
 drivers/video/sun3fb.c                 |    2
 drivers/video/tdfxfb.c                 |  377 --
 drivers/video/tgafb.c                  |    2
 drivers/video/tridentfb.c              |    2
 drivers/video/tx3912fb.c               |   16
 drivers/video/valkyriefb.c             |    2
 drivers/video/vesafb.c                 |   24
 drivers/video/vfb.c                    |   36
 drivers/video/vga16fb.c                | 1192 ++++--
 drivers/video/vgacon.c                 | 1055 -----
 drivers/video/virgefb.c                |    2
 include/linux/console.h                |    1
 include/linux/fb.h                     |  201 -
 include/linux/sisfb.h                  |   58
 include/linux/vt_kern.h                |    8
 include/video/fbcon-afb.h              |   32
 include/video/fbcon-cfb16.h            |   34
 include/video/fbcon-cfb2.h             |   32
 include/video/fbcon-cfb24.h            |   34
 include/video/fbcon-cfb32.h            |   34
 include/video/fbcon-cfb4.h             |   32
 include/video/fbcon-cfb8.h             |   34
 include/video/fbcon-hga.h              |   32
 include/video/fbcon-ilbm.h             |   32
 include/video/fbcon-iplan2p2.h         |   32
 include/video/fbcon-iplan2p4.h         |   32
 include/video/fbcon-iplan2p8.h         |   32
 include/video/fbcon-mac.h              |   32
 include/video/fbcon-mfb.h              |   32
 include/video/fbcon-vga-planes.h       |   37
 include/video/fbcon-vga.h              |   32
 include/video/fbcon.h                  |  795 ----
 include/video/font.h                   |   53
 include/video/macmodes.h               |   70
 191 files changed, 38960 insertions(+), 41494 deletions(-)

BK

bk://fbdev.bkbits.net/fbdev-2.5

Go test it out. Just note several drivers haven't been ported yet.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

