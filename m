Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275500AbTHNTy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275501AbTHNTy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:54:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62986 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275500AbTHNTyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:54:23 -0400
Date: Thu, 14 Aug 2003 20:54:21 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: FBDEV updates.
Message-ID: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!

  Here is the latest fbdev BK drop. It is against 2.6.0-test3. Test it out 
and tell me your results. I like to do a code drop soon. 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

bk pull http://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 Documentation/fb/neofb.txt     |   27 
 MAINTAINERS                    |    5 
 drivers/char/vt_ioctl.c        |   12 
 drivers/video/Kconfig          |  100 
 drivers/video/Makefile         |    9 
 drivers/video/asiliantfb.c     |  619 +++
 drivers/video/aty/Makefile     |    1 
 drivers/video/cfbimgblt.c      |    2 
 drivers/video/chipsfb.c        |    4 
 drivers/video/console/Makefile |   29 
 drivers/video/console/fbcon.c  |  369 -
 drivers/video/console/fbcon.h  |    2 
 drivers/video/controlfb.c      |   10 
 drivers/video/epson1355fb.c    |  967 ++--
 drivers/video/fbmem.c          |  116 
 drivers/video/g364fb.c         |   78 
 drivers/video/i810/Makefile    |    7 
 drivers/video/imsttfb.c        |    2 
 drivers/video/logo/Makefile    |   15 
 drivers/video/logo/logo.c      |    5 
 drivers/video/macfb.c          |   34 
 drivers/video/neofb.c          |  338 +
 drivers/video/platinumfb.c     |   10 
 drivers/video/pvr2fb.c         |  846 +---
 drivers/video/riva/fbdev.c     |   75 
 drivers/video/riva/nv_type.h   |   12 
 drivers/video/sis/300vtbl.h    | 2437 ++----------
 drivers/video/sis/310vtbl.h    | 2574 ++----------
 drivers/video/sis/init.c       | 1882 +++++----
 drivers/video/sis/init.h       | 2435 +++++++++++-
 drivers/video/sis/init301.c    | 8208 +++++++++++++++++++++--------------------
 drivers/video/sis/init301.h    |  222 -
 drivers/video/sis/initdef.h    |  185 
 drivers/video/sis/oem300.h     |  502 --
 drivers/video/sis/oem310.h     |   88 
 drivers/video/sis/osdef.h      |  122 
 drivers/video/sis/sis_accel.c  |   68 
 drivers/video/sis/sis_accel.h  |   27 
 drivers/video/sis/sis_main.c   | 3752 ++++++++++--------
 drivers/video/sis/sis_main.h   |  575 +-
 drivers/video/sis/vgatypes.h   |   81 
 drivers/video/sis/vstruct.h    |  138 
 drivers/video/skeletonfb.c     |   74 
 drivers/video/softcursor.c     |   72 
 drivers/video/tdfxfb.c         |   47 
 drivers/video/valkyriefb.c     |  548 --
 drivers/video/vesafb.c         |   17 
 drivers/video/vgastate.c       |    1 
 include/linux/fb.h             |   88 
 include/linux/linux_logo.h     |    4 
 include/linux/pci_ids.h        |   11 
 include/video/epson1355.h      |   64 
 include/video/neomagic.h       |  261 -
 include/video/sisfb.h          |   91 
 54 files changed, 14922 insertions(+), 13346 deletions(-)

through these ChangeSets:

<jsimmons@bohr.(none)> (03/08/11 1.1151)
   [NEOMAGIC FBDEV] Add going between graphics and VGA text mode. 

<jsimmons@host-193.int.pioneer-pra.com> (03/07/21 1.1046.1.225)
   [TDFX FBDEV] Fixes to make the image blitter work. Also the color handling code was fixed. 

<jsimmons@host-193.int.pioneer-pra.com> (03/07/15 1.1046.1.221)
   [FBCON] Always turn off the cursor in fbcon_cursor. The reason is that cursor might try to blink while we are reprogramming the hardware.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/11 1.1046.1.218)
   [IMSTT FBDEV] Free up resources when it fails.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/11 1.1046.1.217)
   [FBDEV] Makefiel cleanups.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/11 1.1046.1.216)
   [ASILIANT FBDEV] Added support for the asiliant graphics chipset.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/09 1.1046.1.211)
   [RIVA FBDEV] Support for more versions of GEFORCE 4. Also some cursor cleanup to allow it to compile.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/08 1.1046.1.208)
   [SIS FBDEV] Updates to the SiS framebuffer driver. Add support for 760 chipset, LCD scaling.

<jsimmons@kozmo.(none)> (03/07/03 1.1046.1.205)
   [NEOMAGIC FBDEV] Fixed a nasty bug in the copyarea function. It wasn't testing for the condition when both regions have the same y coordinates but are over lapping. This casued a corrpution of data. Also started ot used the macros in vga.h.

<jsimmons@kozmo.(none)> (03/06/30 1.1046.1.200)
   [LOGO] Display the correct logo for MIPS DEC workstations.

<jsimmons@kozmo.(none)> (03/06/25 1.1046.1.194)
   [FBCON] Removed the crappy ROP_COPY/ROP_XOR test for flashing the cursor. Now we disable and enable the cursor timer instead.

<jsimmons@kozmo.(none)> (03/06/24 1.1046.1.192)
   [FBDEV] Now we can use a specific hardware mapper for different hardware functionality.

<jsimmons@kozmo.(none)> (03/06/23 1.1046.1.188)
   [VGA CORE] Added needed vmalloc header.

<jsimmons@kozmo.(none)> (03/06/23 1.1046.1.185)
   [FBCON] When using 512 characters, the mouse pointer starts using the wrong complement_mask after a console reset.

<jsimmons@kozmo.(none)> (03/06/23 1.1046.1.184)
   [FBDEV] Made chipsfb/controlfb/platinumfb use the xxfb kernel command line string.

<jsimmons@maxwell.earthlink.net> (03/06/18 1.1046.1.180)
   [MAC FBDEV] Bug fixes.

<jsimmons@maxwell.earthlink.net> (03/06/15 1.1046.1.176)
   [SIS FBDEV] More updates for the SIS driver. 

<jsimmons@maxwell.earthlink.net> (03/06/14 1.1046.1.174)
   [CONTROL/PLATINUM FBDEV] Fix to match change in fb_set_var.

<jsimmons@maxwell.earthlink.net> (03/06/10 1.1046.1.170)
   [FBDEV] Fixed a issue with soft_cursor. It only worked with drivers with a pixmap.scan_align of 1. Now it will work with any.

<jsimmons@kozmo.(none)> (03/06/07 1.1046.1.164)
   [SIS FBDEV] Fixed sysnc issue.

<jsimmons@kozmo.(none)> (03/06/05 1.1046.1.160)
   [FBCON] Cleared out the struct fb_cursor we passed in. Other wise we get random data being used.

<jsimmons@kozmo.(none)> (03/05/30 1.1046.1.155)
   [FBDEV GENERIC ACCEL] Fixed why logo was not displayed for some.

<jsimmons@maxwell.earthlink.net> (03/05/24 1.1046.155.3)
   [VALKYRUE FBDEV] Ported to new api.

<jsimmons@maxwell.earthlink.net> (03/05/23 1.1046.155.1)
   [FBDEV] Updates to explain the new cursor api.

<jsimmons@maxwell.earthlink.net> (03/05/23 1.1046.1.142)
   [EPSON FRAMEBUFFER] Ported to the new api. Added support for the arm platform.

<jsimmons@maxwell.earthlink.net> (03/05/15 1.1046.84.18)
   [SIS FBDEV] SIS Framebuffer updates.
                 - Added preliminary and untested support for SiS660
                 - Added DDC support
                 - Enhanced proprietary programming API for compatibility with X driver
                   and upcoming SDL updates and upcoming vidix driver for mplayer
                 - Fixes for video bridge output on various HW combinations
                 - Fixes in TV detection
                 - Reduced source size by removing duplicated data
                 - Updated Kconfig descriptions

<jsimmons@maxwell.earthlink.net> (03/05/14 1.1046.73.2)
   [PVR2 FBDEV] Port of the Dreamcast Frambuffer to the new api.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.19)
   [FBCON] set_con2fb_map wasn't testing to see the VC we where mapping to actually exist. Now it does. 
   
           I add code to fbcon_cursor to reset the hotspot if it was changed by userland. 

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.17)
   [RIVA FBDEV] Removal of exccess variable. Kills off a few warnings.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.16)
   [VESA FBDEV] Removed the EDID code. The results where mixed. It worked for some but not for others.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.15)
   [CONSOLE] This patch fixes the problem of not being able to set the fonts on VCs other than the first one. This also was the bug that was casuing dual head (vga and mda) to lock up.

<jsimmons@kozmo.(none)> (03/05/02 1.1042.122.2)
   [FBDEV] Synced to kdev_t change.

<jsimmons@kozmo.(none)> (03/04/22 1.1042.37.2)
   [FBDEV] Moved pixmap to the kernel side of the header. Will not be needed for ioctl calls at the present time.
   
   [FBCON] Lots more optimizations.

<jsimmons@kozmo.(none)> (03/04/21 1.1042.37.1)
   [LOGO] Removed fb_ prefix. Wil be used by other drivers such as the newport driver.
   
   [G354 FBDEV] Now use the final cursor api.


