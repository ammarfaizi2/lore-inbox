Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbTCZTp7>; Wed, 26 Mar 2003 14:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbTCZTp6>; Wed, 26 Mar 2003 14:45:58 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:25606 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262107AbTCZTp5>; Wed, 26 Mar 2003 14:45:57 -0500
Date: Wed, 26 Mar 2003 19:57:08 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Framebuffer fixes.
Message-ID: <Pine.LNX.4.44.0303261951090.21188-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay. Here you go. This patch is against 2.5.66 vanialla. I tested to see 
if it applied. It does. Basically I added back in the static buffers in 
accel_cursor in fbcon.c. Now the cursor will work just like it did before. 
The draw back is that if you have more than one framebuffer then the 
cursors will be messed up. So for single headed frmaebuffer systems it 
will work perfectly. It is not that big of a deal since the console layer 
is broken for multi-head and pre-emptive support anyways. Plus fbcon has 
issues as well. The proper fix would require a huge amount of work. 
I have a few updated drivers as well. Please test.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 drivers/video/aty/aty128fb.c    |   16 +-
 drivers/video/cfbimgblt.c       |    4
 drivers/video/console/fbcon.c   |  246 +++++++++++++++++++++-------------------
 drivers/video/controlfb.c       |   18 --
 drivers/video/fbmem.c           |   42 ++----
 drivers/video/i810/i810.h       |    6
 drivers/video/i810/i810_accel.c |  140 +++++++++++-----------
 drivers/video/i810/i810_dvt.c   |    3
 drivers/video/i810/i810_gtf.c   |    7 -
 drivers/video/i810/i810_main.c  |  135 +++++++++------------
 drivers/video/i810/i810_main.h  |    4
 drivers/video/logo/logo.c       |   69 +++++------
 drivers/video/platinumfb.c      |   28 +---
 drivers/video/radeonfb.c        |   10 +
 drivers/video/riva/fbdev.c      |    2
 drivers/video/softcursor.c      |   95 ++++-----------
 drivers/video/tdfxfb.c          |   18 +-
 drivers/video/tgafb.c           |    2
 drivers/video/vga16fb.c         |    4
 include/linux/fb.h              |    4
 include/linux/linux_logo.h      |    2
 21 files changed, 393 insertions(+), 462 deletions(-)


