Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTBFIo0>; Thu, 6 Feb 2003 03:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBFIo0>; Thu, 6 Feb 2003 03:44:26 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:36113 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S262038AbTBFIoY>; Thu, 6 Feb 2003 03:44:24 -0500
Subject: [PATCH][FBDEV]: generic fb console rotation infrastructure
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1044434293.1170.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 16:38:15 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I decided to add the Console rotation patch which I submitted before to
linux-2.5.59.  The orientation of the display is determined by the
valued of display.rotate, and the appropriate drawing functions in
display.dispsw.  If the display is rotated, fontdata will be prerotated,
and the appropriate console window dimenstions are swapped if necessary.

Currently, this is just an implementation and no hooks are provided yet
to enable/disable this.  This will require some coordination between the
console layer and fbdev.

Current limitations:

1.  cannot support a fontwidth not a multiple of 8 if rotated 180
degrees, and a fontheight not a multiple of 8 if rotated by 90 degrees. 
This is a limitation with fb_imageblit which has no support for bitmap
clipping.

2.  code for panning when rotated by 90 degrees is still buggy, so it's
disabled.

3.  minor graphics glitches.

4.  no support for hardware based rotation, but this should be easy to
add

You can test this by defining DEBUG_ROTATE in the following code
snippet:

#undef DEBUG_ROTATE
#ifdef DEBUG_ROTATE
	/*
	 * change to the appropriate orientation and 
	 * drawing function to test for rotation
	 */
	p->dispsw = &fbcon_180_dispsw;
	p->rotate = FB_VMODE_ROTATE_180
	if (p->rotate) 
		fbcon_rotate_fontdata(p->rotate, p); 
#endif

I've tested the code with several drivers including vga16fb and vesafb.

The patch is at
http://i810fb.sourceforge.net/linux-2.5.59-rotate.diff.gz


Any comments welcome.

Tony







