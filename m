Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbTDJS6E (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 14:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbTDJS6E (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 14:58:04 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:20228 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264130AbTDJS6B (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 14:58:01 -0400
Date: Thu, 10 Apr 2003 20:09:41 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>, <adaplas@pol.net>
Subject: [FBDEV updates] Newest framebuffer fixes.
Message-ID: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  Here are the latest framebuffer changes. Some driver updates and a 
massive cleanup of teh cursor code. Tony please test it on the i810 
chipset. I tested it on the Riva but there is one bug I can't seem to 
find. Please test this patch. It is against 2.5.67 BK. It shoudl work 
against 2.5.67 as well. 

Please test. 

Standard patch is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

and you can do a bk pull http://fbdev.bkbits.net/fbdev-2.5

Linus, please do a

	bk pull http://gkernel.bkbits.net/fbdev-2.5

This will update the following files:

 Documentation/devices.txt       |    7 
 drivers/video/aty/aty128fb.c    |   16 -
 drivers/video/cfbimgblt.c       |    4 
 drivers/video/console/fbcon.c   |  548 ++++++++++++++++++----------------------
 drivers/video/console/fbcon.h   |    1 
 drivers/video/controlfb.c       |   18 -
 drivers/video/fbcmap.c          |   33 +-
 drivers/video/fbmem.c           |  159 ++++++-----
 drivers/video/i810/i810.h       |    6 
 drivers/video/i810/i810_accel.c |  140 +++++-----
 drivers/video/i810/i810_dvt.c   |    3 
 drivers/video/i810/i810_gtf.c   |    7 
 drivers/video/i810/i810_main.c  |  135 ++++-----
 drivers/video/i810/i810_main.h  |    4 
 drivers/video/logo/logo.c       |   69 ++---
 drivers/video/platinumfb.c      |   28 --
 drivers/video/radeonfb.c        |   10 
 drivers/video/riva/fbdev.c      |    2 
 drivers/video/softcursor.c      |  198 +++++++-------
 drivers/video/tdfxfb.c          |   18 -
 drivers/video/tgafb.c           |    2 
 drivers/video/vga16fb.c         |    6 
 include/linux/fb.h              |   16 -
 include/linux/linux_logo.h      |    2 
 24 files changed, 690 insertions(+), 742 deletions(-)

through these ChangeSets:

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


