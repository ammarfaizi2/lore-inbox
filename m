Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSJQQjT>; Thu, 17 Oct 2002 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbSJQQjT>; Thu, 17 Oct 2002 12:39:19 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:4030 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261567AbSJQQjO>; Thu, 17 Oct 2002 12:39:14 -0400
Date: Thu, 17 Oct 2002 09:38:37 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [ANNOUCE] fbdev changes finished.
Message-ID: <Pine.LNX.4.33.0210170919210.4730-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  I like to annouce that I just finished the final fbdev changes. They are
in the BK repository bk://fbdev.bkbits.net/fbdev-2.5. The changes are

1) Removal of all console related code in the lower level drivers. Smaller
   easier to program drivers.

2) Now you can use the framebuffer driver WITHOUT framebuffer console.
   Last night I built a kernel with MDA console and used the VESA
   framebuffer by itself. Now you can easily debug new framebuffer
   drivers. The real bonus is for embedded systems you have much smaller
   kernels.

3) I moved the agp and drm code into drivers/video. I did NOT place any
   drm code with framebuffer code at people's request. I simiple moved the
   directory from one spot to another. The main reason I did this was
   because some framebuffer drivers will need to use the agp code initialized
   before the framebuffer layer. The DRM code was moved because it makes
   sense to move it there.

4) I cleaned up the config.in for all the video stuff across all
   platforms.

You can grab the lastest BK tree at

bk://fbdev.bkbits.net/fbdev-2.5

Give it a try. For people who want a diff it is avaiable at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Note it is huge and against 2.5.43. The framebuffer console system is kind
of flaky still since the api has changed alot. So alot of work will be
done on fbcon.c from now on besides porting the drivers over. Have fun.

 CREDITS                                  |   13
 Documentation/DocBook/kernel-api.tmpl    |    4
 MAINTAINERS                              |    7
 arch/alpha/config.in                     |   17
 arch/arm/config.in                       |   10
 arch/i386/config.in                      |   12
 arch/i386/vmlinux.lds.s                  |  105
 arch/ia64/config.in                      |   11
 arch/m68k/config.in                      |    7
 arch/mips/config.in                      |   11
 arch/mips64/config.in                    |   15
 arch/parisc/config.in                    |   19
 arch/ppc/config.in                       |    7
 arch/ppc64/config.in                     |    7
 arch/sh/config.in                        |   13
 arch/sparc/config.in                     |    7
 arch/sparc64/config.in                   |    4
 arch/x86_64/config.in                    |   12
 drivers/Makefile                         |    3
 drivers/char/Config.in                   |  202
 drivers/char/Makefile                    |    2
 drivers/char/agp/Config.help             |   88
 drivers/char/agp/Config.in               |   22
 drivers/char/agp/Makefile                |   24
 drivers/char/agp/agp.c                   | 1690 ----
 drivers/char/agp/agp.h                   |  377 -
 drivers/char/agp/ali-agp.c               |  265
 drivers/char/agp/amd-agp.c               |  408 -
 drivers/char/agp/frontend.c              | 1086 --
 drivers/char/agp/hp-agp.c                |  394 -
 drivers/char/agp/i460-agp.c              |  595 -
 drivers/char/agp/i810-agp.c              |  594 -
 drivers/char/agp/i8x0-agp.c              |  731 -
 drivers/char/agp/k8-agp.c                |  476 -
 drivers/char/agp/sis-agp.c               |  142
 drivers/char/agp/sworks-agp.c            |  626 -
 drivers/char/agp/via-agp.c               |  151
 drivers/char/drm/Config.help             |   39
 drivers/char/drm/Config.in               |   17
 drivers/char/drm/Makefile                |   23
 drivers/char/drm/README.drm              |   46
 drivers/char/drm/ati_pcigart.h           |  203
 drivers/char/drm/drm.h                   |  461 -
 drivers/char/drm/drmP.h                  |  908 --
 drivers/char/drm/drm_agpsupport.h        |  370
 drivers/char/drm/drm_auth.h              |  163
 drivers/char/drm/drm_bufs.h              | 1137 ---
 drivers/char/drm/drm_context.h           |  781 --
 drivers/char/drm/drm_dma.h               |  657 -
 drivers/char/drm/drm_drawable.h          |   51
 drivers/char/drm/drm_drv.h               | 1085 --
 drivers/char/drm/drm_fops.h              |  209
 drivers/char/drm/drm_init.h              |  116
 drivers/char/drm/drm_ioctl.h             |  249
 drivers/char/drm/drm_lists.h             |  230
 drivers/char/drm/drm_lock.h              |  251
 drivers/char/drm/drm_memory.h            |  467 -
 drivers/char/drm/drm_os_linux.h          |   90
 drivers/char/drm/drm_proc.h              |  633 -
 drivers/char/drm/drm_scatter.h           |  225
 drivers/char/drm/drm_stub.h              |  151
 drivers/char/drm/drm_vm.h                |  503 -
 drivers/char/drm/ffb.h                   |   15
 drivers/char/drm/ffb_context.c           |  539 -
 drivers/char/drm/ffb_drv.c               |  401 -
 drivers/char/drm/ffb_drv.h               |  276
 drivers/char/drm/gamma.h                 |  148
 drivers/char/drm/gamma_dma.c             |  833 --
 drivers/char/drm/gamma_drm.h             |   89
 drivers/char/drm/gamma_drv.c             |   55
 drivers/char/drm/gamma_drv.h             |  120
 drivers/char/drm/i810.h                  |  117
 drivers/char/drm/i810_dma.c              | 1253 ---
 drivers/char/drm/i810_drm.h              |  248
 drivers/char/drm/i810_drv.c              |   56
 drivers/char/drm/i810_drv.h              |  207
 drivers/char/drm/i830.h                  |  103
 drivers/char/drm/i830_dma.c              | 1291 ---
 drivers/char/drm/i830_drm.h              |  251
 drivers/char/drm/i830_drv.c              |   58
 drivers/char/drm/i830_drv.h              |  216
 drivers/char/drm/mga.h                   |   94
 drivers/char/drm/mga_dma.c               |  795 --
 drivers/char/drm/mga_drm.h               |  325
 drivers/char/drm/mga_drv.c               |   52
 drivers/char/drm/mga_drv.h               |  631 -
 drivers/char/drm/mga_state.c             | 1077 --
 drivers/char/drm/mga_ucode.h             |11645 -------------------------------
 drivers/char/drm/mga_warp.c              |  212
 drivers/char/drm/r128.h                  |  110
 drivers/char/drm/r128_cce.c              | 1010 --
 drivers/char/drm/r128_drm.h              |  308
 drivers/char/drm/r128_drv.c              |   55
 drivers/char/drm/r128_drv.h              |  504 -
 drivers/char/drm/r128_state.c            | 1566 ----
 drivers/char/drm/radeon.h                |  154
 drivers/char/drm/radeon_cp.c             | 1648 ----
 drivers/char/drm/radeon_drm.h            |  563 -
 drivers/char/drm/radeon_drv.c            |   53
 drivers/char/drm/radeon_drv.h            |  867 --
 drivers/char/drm/radeon_irq.c            |  256
 drivers/char/drm/radeon_mem.c            |  334
 drivers/char/drm/radeon_state.c          | 2190 -----
 drivers/char/drm/sis.h                   |   81
 drivers/char/drm/sis_drm.h               |   46
 drivers/char/drm/sis_drv.c               |   49
 drivers/char/drm/sis_drv.h               |   45
 drivers/char/drm/sis_ds.c                |  406 -
 drivers/char/drm/sis_ds.h                |  163
 drivers/char/drm/sis_mm.c                |  307
 drivers/char/drm/tdfx.h                  |   42
 drivers/char/drm/tdfx_drv.c              |   92
 drivers/video/Config.help                |  149
 drivers/video/Config.in                  |  457 -
 drivers/video/Makefile                   |   44
 drivers/video/agp/Config.help            |   88
 drivers/video/agp/Config.in              |   22
 drivers/video/agp/Makefile               |   24
 drivers/video/agp/agp.c                  | 1690 ++++
 drivers/video/agp/agp.h                  |  377 +
 drivers/video/agp/ali-agp.c              |  265
 drivers/video/agp/amd-agp.c              |  408 +
 drivers/video/agp/frontend.c             | 1086 ++
 drivers/video/agp/hp-agp.c               |  394 +
 drivers/video/agp/i460-agp.c             |  595 +
 drivers/video/agp/i810-agp.c             |  594 +
 drivers/video/agp/i8x0-agp.c             |  731 +
 drivers/video/agp/k8-agp.c               |  476 +
 drivers/video/agp/sis-agp.c              |  142
 drivers/video/agp/sworks-agp.c           |  626 +
 drivers/video/agp/via-agp.c              |  151
 drivers/video/anakinfb.c                 |  117
 drivers/video/aty/atyfb_base.c           | 2711 -------
 drivers/video/aty/mach64_ct.c            |    2
 drivers/video/aty/mach64_cursor.c        |    2
 drivers/video/aty/mach64_gx.c            |    2
 drivers/video/aty128fb.c                 | 3167 +++-----
 drivers/video/cfbcopyarea.c              |  230
 drivers/video/cfbfillrect.c              |  107
 drivers/video/cfbimgblt.c                |  335
 drivers/video/clps711xfb.c               |  452 -
 drivers/video/console/Config.help        |  149
 drivers/video/console/dummycon.c         |   74
 drivers/video/console/fbcon-accel.c      |  189
 drivers/video/console/fbcon-accel.h      |   34
 drivers/video/console/fbcon-afb.c        |  448 +
 drivers/video/console/fbcon-hga.c        |  253
 drivers/video/console/fbcon-ilbm.c       |  296
 drivers/video/console/fbcon-iplan2p2.c   |  476 +
 drivers/video/console/fbcon-iplan2p4.c   |  497 +
 drivers/video/console/fbcon-iplan2p8.c   |  534 +
 drivers/video/console/fbcon-sti.c        |  337
 drivers/video/console/fbcon-vga-planes.c |  281
 drivers/video/console/font_6x11.c        | 3351 ++++++++
 drivers/video/console/font_8x16.c        | 4631 ++++++++++++
 drivers/video/console/font_8x8.c         | 2583 ++++++
 drivers/video/console/font_acorn_8x8.c   |  277
 drivers/video/console/font_mini_4x6.c    | 2158 +++++
 drivers/video/console/font_pearl_8x8.c   | 2587 ++++++
 drivers/video/console/font_sun12x22.c    | 6220 ++++++++++++++++
 drivers/video/console/font_sun8x16.c     |  275
 drivers/video/console/fonts.c            |  135
 drivers/video/console/mdacon.c           |  632 +
 drivers/video/console/newport_con.c      |  746 +
 drivers/video/console/prom.uni           |   11
 drivers/video/console/promcon.c          |  606 +
 drivers/video/console/sti-bmode.h        |  287
 drivers/video/console/sticon-bmode.c     |  895 ++
 drivers/video/console/sticon.c           |  215
 drivers/video/console/vgacon.c           | 1062 ++
 drivers/video/dnfb.c                     |  275
 drivers/video/drm/Config.help            |   39
 drivers/video/drm/Config.in              |   17
 drivers/video/drm/Makefile               |   23
 drivers/video/drm/README.drm             |   46
 drivers/video/drm/ati_pcigart.h          |  203
 drivers/video/drm/drm.h                  |  461 +
 drivers/video/drm/drmP.h                 |  908 ++
 drivers/video/drm/drm_agpsupport.h       |  370
 drivers/video/drm/drm_auth.h             |  163
 drivers/video/drm/drm_bufs.h             | 1137 +++
 drivers/video/drm/drm_context.h          |  781 ++
 drivers/video/drm/drm_dma.h              |  657 +
 drivers/video/drm/drm_drawable.h         |   51
 drivers/video/drm/drm_drv.h              | 1085 ++
 drivers/video/drm/drm_fops.h             |  209
 drivers/video/drm/drm_init.h             |  116
 drivers/video/drm/drm_ioctl.h            |  249
 drivers/video/drm/drm_lists.h            |  230
 drivers/video/drm/drm_lock.h             |  251
 drivers/video/drm/drm_memory.h           |  467 +
 drivers/video/drm/drm_os_linux.h         |   90
 drivers/video/drm/drm_proc.h             |  633 +
 drivers/video/drm/drm_scatter.h          |  225
 drivers/video/drm/drm_stub.h             |  151
 drivers/video/drm/drm_vm.h               |  503 +
 drivers/video/drm/ffb.h                  |   15
 drivers/video/drm/ffb_context.c          |  539 +
 drivers/video/drm/ffb_drv.c              |  401 +
 drivers/video/drm/ffb_drv.h              |  276
 drivers/video/drm/gamma.h                |  148
 drivers/video/drm/gamma_dma.c            |  833 ++
 drivers/video/drm/gamma_drm.h            |   89
 drivers/video/drm/gamma_drv.c            |   55
 drivers/video/drm/gamma_drv.h            |  120
 drivers/video/drm/i810.h                 |  117
 drivers/video/drm/i810_dma.c             | 1253 +++
 drivers/video/drm/i810_drm.h             |  248
 drivers/video/drm/i810_drv.c             |   56
 drivers/video/drm/i810_drv.h             |  207
 drivers/video/drm/i830.h                 |  103
 drivers/video/drm/i830_dma.c             | 1291 +++
 drivers/video/drm/i830_drm.h             |  251
 drivers/video/drm/i830_drv.c             |   58
 drivers/video/drm/i830_drv.h             |  216
 drivers/video/drm/mga.h                  |   94
 drivers/video/drm/mga_dma.c              |  795 ++
 drivers/video/drm/mga_drm.h              |  325
 drivers/video/drm/mga_drv.c              |   52
 drivers/video/drm/mga_drv.h              |  631 +
 drivers/video/drm/mga_state.c            | 1077 ++
 drivers/video/drm/mga_ucode.h            |11645 +++++++++++++++++++++++++++++++
 drivers/video/drm/mga_warp.c             |  212
 drivers/video/drm/r128.h                 |  110
 drivers/video/drm/r128_cce.c             | 1010 ++
 drivers/video/drm/r128_drm.h             |  308
 drivers/video/drm/r128_drv.c             |   55
 drivers/video/drm/r128_drv.h             |  504 +
 drivers/video/drm/r128_state.c           | 1566 ++++
 drivers/video/drm/radeon.h               |  154
 drivers/video/drm/radeon_cp.c            | 1648 ++++
 drivers/video/drm/radeon_drm.h           |  563 +
 drivers/video/drm/radeon_drv.c           |   53
 drivers/video/drm/radeon_drv.h           |  867 ++
 drivers/video/drm/radeon_irq.c           |  256
 drivers/video/drm/radeon_mem.c           |  334
 drivers/video/drm/radeon_state.c         | 2190 +++++
 drivers/video/drm/sis.h                  |   81
 drivers/video/drm/sis_drm.h              |   46
 drivers/video/drm/sis_drv.c              |   49
 drivers/video/drm/sis_drv.h              |   45
 drivers/video/drm/sis_ds.c               |  406 +
 drivers/video/drm/sis_ds.h               |  163
 drivers/video/drm/sis_mm.c               |  307
 drivers/video/drm/tdfx.h                 |   42
 drivers/video/drm/tdfx_drv.c             |   92
 drivers/video/dummycon.c                 |   74
 drivers/video/fbcmap.c                   |   57
 drivers/video/fbcon-accel.c              |  188
 drivers/video/fbcon-accel.h              |   34
 drivers/video/fbcon-afb.c                |  448 -
 drivers/video/fbcon-cfb16.c              |  319
 drivers/video/fbcon-cfb2.c               |  225
 drivers/video/fbcon-cfb24.c              |  333
 drivers/video/fbcon-cfb32.c              |  305
 drivers/video/fbcon-cfb4.c               |  229
 drivers/video/fbcon-cfb8.c               |  294
 drivers/video/fbcon-hga.c                |  253
 drivers/video/fbcon-ilbm.c               |  296
 drivers/video/fbcon-iplan2p2.c           |  476 -
 drivers/video/fbcon-iplan2p4.c           |  497 -
 drivers/video/fbcon-iplan2p8.c           |  534 -
 drivers/video/fbcon-mfb.c                |  217
 drivers/video/fbcon-sti.c                |  337
 drivers/video/fbcon-vga-planes.c         |  387 -
 drivers/video/fbcon.c                    | 2509 ------
 drivers/video/fbgen.c                    |  217
 drivers/video/fbmem.c                    |  961 --
 drivers/video/fm2fb.c                    |   14
 drivers/video/font_6x11.c                | 3351 --------
 drivers/video/font_8x16.c                | 4631 ------------
 drivers/video/font_8x8.c                 | 2583 ------
 drivers/video/font_acorn_8x8.c           |  277
 drivers/video/font_mini_4x6.c            | 2158 -----
 drivers/video/font_pearl_8x8.c           | 2587 ------
 drivers/video/font_sun12x22.c            | 6220 ----------------
 drivers/video/font_sun8x16.c             |  275
 drivers/video/fonts.c                    |  135
 drivers/video/g364fb.c                   |  268
 drivers/video/hitfb.c                    |   14
 drivers/video/hpfb.c                     |   15
 drivers/video/macfb.c                    |  978 --
 drivers/video/macmodes.c                 |  387 -
 drivers/video/maxinefb.c                 |  192
 drivers/video/mdacon.c                   |  632 -
 drivers/video/modedb.c                   |    7
 drivers/video/neofb.c                    |   25
 drivers/video/newport_con.c              |  746 -
 drivers/video/offb.c                     |  559 -
 drivers/video/pmag-ba-fb.c               |   14
 drivers/video/pmagb-b-fb.c               |   14
 drivers/video/prom.uni                   |   11
 drivers/video/promcon.c                  |  606 -
 drivers/video/q40fb.c                    |   13
 drivers/video/sa1100fb.c                 |    2
 drivers/video/sgivwfb.c                  |   21
 drivers/video/sis/Makefile               |    2
 drivers/video/sis/sis_accel.c            |  495 +
 drivers/video/skeletonfb.c               |   20
 drivers/video/sti-bmode.h                |  287
 drivers/video/sticon-bmode.c             |  895 --
 drivers/video/sticon.c                   |  215
 drivers/video/tdfxfb.c                   |  376 -
 drivers/video/tx3912fb.c                 |   13
 drivers/video/vesafb.c                   |  386 -
 drivers/video/vfb.c                      |   17
 drivers/video/vga16fb.c                  |  943 --
 drivers/video/vgacon.c                   | 1055 --
 include/linux/fb.h                       |  546 -
 include/linux/sisfb.h                    |   58
 include/video/fbcon-cfb16.h              |   34
 include/video/fbcon-cfb2.h               |   32
 include/video/fbcon-cfb24.h              |   34
 include/video/fbcon-cfb32.h              |   34
 include/video/fbcon-cfb4.h               |   32
 include/video/fbcon-cfb8.h               |   34
 include/video/fbcon-mac.h                |   32
 include/video/fbcon-vga-planes.h         |    1
 include/video/fbcon.h                    |  795 --
 321 files changed, 82006 insertions(+), 96749 deletions(-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

