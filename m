Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJMU1q>; Sun, 13 Oct 2002 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbSJMU1q>; Sun, 13 Oct 2002 16:27:46 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:60395 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261742AbSJMU1o>; Sun, 13 Oct 2002 16:27:44 -0400
Date: Sun, 13 Oct 2002 13:27:08 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fbdev changes.
Message-ID: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  The final changes to the fbdev layer are at hand. One of the last
changes I wanted to purpose was to create a console driectory in
drivers/video and move all console related stuff into that directory.
The next step was to move the dri stuff into that directory with the agp
code possible. The questions I have is should we move the agp code over to
that directory. Should the DRI code move over directly or should we move
DRI driver specific code into the same directory as the fbdev driver
directories? For example in aty directory we have all the ati framebuffer
and ATI dri code. What do you think?

Second change!! We need a uiversal cursor api. I purposed some time ago a
api but nothing happend.I like to resolve this final part to remove th
last bit of console crude from the fbdev layer.

The api I suggested was :


/*
 * hardware cursor control
 */

#define FB_CUR_SETCUR   0x01
#define FB_CUR_SETPOS   0x02
#define FB_CUR_SETHOT   0x04
#define FB_CUR_SETCMAP  0x08
#define FB_CUR_SETSHAPE 0x10
#define FB_CUR_SETALL   0x1F

struct fbcurpos {
        __u16 x, y;
};

struct fbcursor {
        __u16 set;              /* what to set */
        __u16 enable;           /* cursor on/off */
        struct fbcurpos pos;    /* cursor position */
        struct fbcurpos hot;    /* cursor hot spot */
        struct fb_cmap cmap;    /* color map info */
        struct fbcurpos size;   /* cursor bit map size */
        char *image;            /* cursor image bits */
        char *mask;             /* cursor mask bits */
};

If you have any suggestion please post you purpose struct. Thank you.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

