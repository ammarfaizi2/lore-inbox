Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTGCRli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbTGCRli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:41:38 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:1553 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265090AbTGCRld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:41:33 -0400
Date: Thu, 3 Jul 2003 18:55:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New fbdev updates.
Message-ID: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
   
   I have updates to the framebuffer layer. Alot of bug fixes accumlated. 
A couple of driver updates as well. I have more code to go in but haven't 
had time to add them in. Please test. This is not the final code going in 
just yet. More needs to be done. The patches are at the usual

    http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

or BK
    bk://fbdev.bkbits.net/fbdev-2.5

Note: 
   The NVIDIA driver hasn't been updated to the new cursor fixes. I 
haven't had time to fix it yet. So it doesn't compile. Also the i810 
driver might have issues with the cursor changes. 
   Skeleton i2c support is added. It hasn't been tested or even compiles 
in yet. 

 Documentation/fb/neofb.txt    |   27 
 MAINTAINERS                   |    5 
 drivers/char/vt_ioctl.c       |   12 
 drivers/video/Kconfig         |   62 
 drivers/video/Makefile        |    4 
 drivers/video/cfbimgblt.c     |    2 
 drivers/video/chipsfb.c       |    4 
 drivers/video/console/fbcon.c |  351 -
 drivers/video/console/fbcon.h |    2 
 drivers/video/controlfb.c     |   10 
 drivers/video/epson1355fb.c   |  967 +++--
 drivers/video/fbmem.c         |  105 
 drivers/video/g364fb.c        |   78 
 drivers/video/logo/logo.c     |    5 
 drivers/video/macfb.c         |   34 
 drivers/video/neofb.c         |  198 -
 drivers/video/platinumfb.c    |   10 
 drivers/video/pvr2fb.c        |  846 +---
 drivers/video/riva/fbdev.c    |    2 
 drivers/video/sis/300vtbl.h   | 2426 +++----------
 drivers/video/sis/310vtbl.h   | 2495 ++------------
 drivers/video/sis/init.c      | 1816 ++++++----
 drivers/video/sis/init.h      | 2335 ++++++++++++-
 drivers/video/sis/init301.c   | 7444 +++++++++++++++++++++---------------------
 drivers/video/sis/init301.h   |  209 -
 drivers/video/sis/initdef.h   |  169 
 drivers/video/sis/oem300.h    |  495 --
 drivers/video/sis/oem310.h    |   31 
 drivers/video/sis/osdef.h     |  122 
 drivers/video/sis/sis_accel.c |   66 
 drivers/video/sis/sis_accel.h |   10 
 drivers/video/sis/sis_main.c  | 3194 +++++++++---------
 drivers/video/sis/sis_main.h  |  509 +-
 drivers/video/sis/vgatypes.h  |   63 
 drivers/video/sis/vstruct.h   |  116 
 drivers/video/skeletonfb.c    |   74 
 drivers/video/softcursor.c    |   72 
 drivers/video/valkyriefb.c    |  548 ---
 drivers/video/vesafb.c        |   17 
 drivers/video/vgastate.c      |    1 
 include/linux/fb.h            |   88 
 include/linux/linux_logo.h    |    4 
 include/video/epson1355.h     |   64 
 include/video/neomagic.h      |  241 -
 include/video/sisfb.h         |   85 
 45 files changed, 12788 insertions(+), 12630 deletions(-)

through these ChangeSets:

<jsimmons@kozmo.(none)> (03/07/03 1.1251)
   [NEOMAGIC FBDEV] Fixed a nasty bug in the copyarea function. It wasn't testing for the condition when both regions have the same y coordinates but are over lapping. This casued a corrpution of data. Also started ot used the macros in vga.h.

<jsimmons@kozmo.(none)> (03/06/30 1.1246)
   [LOGO] Display the correct logo for MIPS DEC workstations.

<jsimmons@kozmo.(none)> (03/06/25 1.1240)
   [FBCON] Removed the crappy ROP_COPY/ROP_XOR test for flashing the cursor. Now we disable and enable the cursor timer instead.

<jsimmons@kozmo.(none)> (03/06/24 1.1238)
   [FBDEV] Now we can use a specific hardware mapper for different hardware functionality.

<jsimmons@kozmo.(none)> (03/06/23 1.1234)
   [VGA CORE] Added needed vmalloc header.

<jsimmons@kozmo.(none)> (03/06/23 1.1231)
   [FBCON] When using 512 characters, the mouse pointer starts using the wrong complement_mask after a console reset.

<jsimmons@kozmo.(none)> (03/06/23 1.1230)
   [FBDEV] Made chipsfb/controlfb/platinumfb use the xxfb kernel command line string.

<jsimmons@maxwell.earthlink.net> (03/06/18 1.1226)
   [MAC FBDEV] Bug fixes.

<jsimmons@maxwell.earthlink.net> (03/06/15 1.1222)
   [SIS FBDEV] More updates for the SIS driver. 

<jsimmons@maxwell.earthlink.net> (03/06/14 1.1220)
   [CONTROL/PLATINUM FBDEV] Fix to match change in fb_set_var.

<jsimmons@maxwell.earthlink.net> (03/06/10 1.1216)
   [FBDEV] Fixed a issue with soft_cursor. It only worked with drivers with a pixmap.scan_align of 1. Now it will work with any.

<jsimmons@kozmo.(none)> (03/06/07 1.1210)
   [SIS FBDEV] Fixed sysnc issue.

<jsimmons@kozmo.(none)> (03/06/05 1.1206)
   [FBCON] Cleared out the struct fb_cursor we passed in. Other wise we get random data being used.

<jsimmons@kozmo.(none)> (03/05/30 1.1201)
   [FBDEV GENERIC ACCEL] Fixed why logo was not displayed for some.

<jsimmons@maxwell.earthlink.net> (03/05/24 1.1188.1.3)
   [VALKYRUE FBDEV] Ported to new api.

<jsimmons@maxwell.earthlink.net> (03/05/23 1.1188.1.1)
   [FBDEV] Updates to explain the new cursor api.

<jsimmons@maxwell.earthlink.net> (03/05/23 1.1188)
   [EPSON FRAMEBUFFER] Ported to the new api. Added support for the arm platform.

<jsimmons@maxwell.earthlink.net> (03/05/15 1.1127.2.18)
   [SIS FBDEV] SIS Framebuffer updates.
                 - Added preliminary and untested support for SiS660
                 - Added DDC support
                 - Enhanced proprietary programming API for compatibility with X driver
                   and upcoming SDL updates and upcoming vidix driver for mplayer
                 - Fixes for video bridge output on various HW combinations
                 - Fixes in TV detection
                 - Reduced source size by removing duplicated data
                 - Updated Kconfig descriptions

<jsimmons@maxwell.earthlink.net> (03/05/14 1.1113.1.2)
   [PVR2 FBDEV] Port of the Dreamcast Frambuffer to the new api.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1063.3.19)
   [FBCON] set_con2fb_map wasn't testing to see the VC we where mapping to actually exist. Now it does. 
   
           I add code to fbcon_cursor to reset the hotspot if it was changed by userland. 

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1063.3.17)
   [RIVA FBDEV] Removal of exccess variable. Kills off a few warnings.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1063.3.16)
   [VESA FBDEV] Removed the EDID code. The results where mixed. It worked for some but not for others.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1063.3.15)
   [CONSOLE] This patch fixes the problem of not being able to set the fonts on VCs other than the first one. This also was the bug that was casuing dual head (vga and mda) to lock up.

<jsimmons@kozmo.(none)> (03/05/02 1.1042.122.2)
   [FBDEV] Synced to kdev_t change.

<jsimmons@kozmo.(none)> (03/04/22 1.1042.37.2)
   [FBDEV] Moved pixmap to the kernel side of the header. Will not be needed for ioctl calls at the present time.
   
   [FBCON] Lots more optimizations.

<jsimmons@kozmo.(none)> (03/04/21 1.1042.37.1)
   [LOGO] Removed fb_ prefix. Wil be used by other drivers such as the newport driver.
   
   [G354 FBDEV] Now use the final cursor api.


