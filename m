Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbTDBSpL>; Wed, 2 Apr 2003 13:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbTDBSpL>; Wed, 2 Apr 2003 13:45:11 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:25871 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263117AbTDBSpI>; Wed, 2 Apr 2003 13:45:08 -0500
Date: Wed, 2 Apr 2003 19:56:32 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Framebuffer cursor updates.
Message-ID: <Pine.LNX.4.33.0304021137570.7983-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!!

  I have a new patch to fix the cursor problems. This patch Is a massive 
rewrite of the cursor handling code. I have tested it on two machines. The 
VBL irq code in fbcon.c should be moved to there respected drivers. Please 
review and test. 

Please note a change happened to the cursor api that breaks the i810 and 
NVIDIA framebuffers. A patch will be created for them very soon. Tose 
patches will be part of the next pull to linus.

P.S
   The framebuffer had 3 major issues. One was the cursor. This should fix 
the final issues with it. Yes I know that we are still using a spinlock in 
fb_get_buffer_offset but that would mean surgery to the upper layer 
console for the blank timer handlers. Yuck!!! That might still have to be 
done.
   The second issue is handling monitor limits and finding what modes are 
supported by a video card. I just recieved a nice patch from Tony for 
this. I plan to test it and pass it along after the cursor fixes.
   The 3rd issue is tilebliting. Some hardware can cache the font images 
in hardware and then just index that image by a handle. I will work on 
this next while tony works on EDID support. 

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


