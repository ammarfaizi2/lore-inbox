Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTDNEfR (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 00:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbTDNEfR (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 00:35:17 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:63752 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262742AbTDNEfP (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 00:35:15 -0400
Date: Mon, 14 Apr 2003 05:47:00 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [FBDEV BK] Updates and fixes.
Message-ID: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As usually I have a standard diff at 
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

It is against the latest BK tree. I haven'tt tried it yet for 2.5.67

Linus, please do a

	bk pull http://fbdev.bkbits.net/fbdev-2.5

This will update the following files:

 Documentation/devices.txt        |    7 
 arch/i386/boot/compressed/misc.c |    2 
 arch/i386/boot/video.S           |   34 +
 arch/i386/kernel/setup.c         |    4 
 drivers/video/aty/aty128fb.c     |   16 
 drivers/video/cfbimgblt.c        |    4 
 drivers/video/console/fbcon.c    |  585 +++++++++++-------------
 drivers/video/console/fbcon.h    |    1 
 drivers/video/controlfb.c        |   18 
 drivers/video/edid.h             |  138 +++++
 drivers/video/fbcmap.c           |   33 -
 drivers/video/fbmem.c            |  211 ++++----
 drivers/video/fbmon.c            |  922 +++++++++++++++++++++++++++++++--------
 drivers/video/i810/i810.h        |    7 
 drivers/video/i810/i810_accel.c  |  140 +++--
 drivers/video/i810/i810_dvt.c    |    3 
 drivers/video/i810/i810_gtf.c    |    7 
 drivers/video/i810/i810_main.c   |  207 +++-----
 drivers/video/i810/i810_main.h   |    4 
 drivers/video/imsttfb.c          |    4 
 drivers/video/logo/logo.c        |   69 +-
 drivers/video/modedb.c           |  105 ++++
 drivers/video/platinumfb.c       |   28 -
 drivers/video/pm2fb.c            |   22 
 drivers/video/radeonfb.c         |   54 +-
 drivers/video/retz3fb.c          |   16 
 drivers/video/riva/fbdev.c       |  380 +++++++---------
 drivers/video/sis/sis_main.h     |   62 +-
 drivers/video/softcursor.c       |  243 ++++------
 drivers/video/tdfxfb.c           |   18 
 drivers/video/tgafb.c            |    2 
 drivers/video/tridentfb.c        |    8 
 drivers/video/vesafb.c           |   23 
 drivers/video/vga16fb.c          |    6 
 include/asm-i386/setup.h         |    1 
 include/linux/fb.h               |   29 -
 include/linux/linux_logo.h       |    2 
 include/linux/pci_ids.h          |    1 
 include/video/edid.h             |   27 +
 39 files changed, 2140 insertions(+), 1303 deletions(-)

through these ChangeSets:

<jsimmons@kozmo.(none)> (03/04/12 1.1014)
   [FBDEV] Improved speed performance. We copy many bytes of data instead of just one at a time.
   
   [IMSTT FBDEV] Fixed a bug that caused the hardware to lock up when scrolling.

<jsimmons@maxwell.earthlink.net> (03/04/11 1.1011)
   [RIVA FBDEV] Cursor fixes. Almost done. At least it looks normal most of the time.

<jsimmons@kozmo.(none)> (03/04/10 1.1009)
   [RADEON FBDEV] Compile fixes.

<jsimmons@kozmo.(none)> (03/04/10 1.1007)
   [RADEON FBDEV] Detect 8 Megs of RAM not 8 Kilobytes.

<jsimmons@kozmo.(none)> (03/04/10 1.1006)
   [FBDEV] EDID support from OpenFirmware on PPC platoforms and from the BIOS on intel platforms.

<jsimmons@maxwell.earthlink.net> (03/04/10 1.1004)
   [FBDEV] Made the upper layer code always use the cursor mask of struct fb_cursor inside struct fb_info. This moved memory management of the mask and image data to the upper layers.

<jsimmons@maxwell.earthlink.net> (03/04/10 1.1003)
   [FBDEV] Made the upper layer code always use the cursor mask of struct fb_cursor inside struct fb_info. This moved memory management of the mask and image data to the upper layers.
   
   [RADEON FBDEV] Updates for the Radeon 9100.

<jsimmons@kozmo.(none)> (03/04/04 1.998)
   [FBDEV] Killed off shutting down IRQs. We need them for some types of hardware.
   
   [FBDEV] Cleanup with FB_CUR_SETCUR and the enable field. Fix to set the cursor shape when we change the size of the cursor.
   
   [I810 FBDEV] Updates to the new cursor code.
   
   [FBDEV GENERIC CURSOR] A memcpy optimization. Also only allocate a new mask field when the size of the cursor changes.

<jsimmons@maxwell.earthlink.net> (03/04/02 1.995)
   [FBDEV] Use C99 style.

<jsimmons@kozmo.(none)> (03/04/02 1.991.1.2)
   [FBDEV SOFT CURSOR] Test to see if kmalloc failed.
   
   [FBCON] Test to see if the user priovides there own work queue.

<jsimmons@kozmo.(none)> (03/04/02 1.991.1.1)
   [FBDEV] Final cursor code cleanups. Now the burden of handling the cursor code lies on the driver side. The reason for this is that a invalid cursor might come from userland.

<jsimmons@kozmo.(none)> (03/03/31 1.990)
   [FBDEV] Massive cleanups of the cursor api.

<jsimmons@maxwell.earthlink.net> (03/03/26 1.986)
   [FBDEV] Documentation on the device numbers of /dev/fb being mulitples of 32 is no longer true. Removed that info.
   
   [FBDEV] Logo fixes. Now we can display different color logos on screens of different color depths.
   
   [VGA16 FBDEV] Small compile error. Fixed it now.

<jsimmons@maxwell.earthlink.net> (03/03/26 1.984)
   [I810 FBDEV] Driver updates.
   
   [FBCON] Reversed some of my cursor changes.

<jsimmons@kozmo.(none)> (03/03/25 1.983)
   [FBDEV] The image color depth of zero hack has been killed.

<jsimmons@maxwell.earthlink.net> (03/03/25 1.982)
   [FBCON] Now we use workqueues so framebuffer code can always work in a process context.
   
   [GENERIC CURSOR] Safety check in case kmalloc failes

<jsimmons@maxwell.earthlink.net> (03/03/25 1.981)
   [FBCON] Could be called outside of a process context. This fixes that.

<jsimmons@maxwell.earthlink.net> (03/03/25 1.979)
   [RAGE 128/CONTROL/PLATNIUM FBDEV] PPC updates.
   
   [RADEON FBDEV] PLL fix for specific type of card.


