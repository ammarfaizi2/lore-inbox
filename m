Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbTCZTyg>; Wed, 26 Mar 2003 14:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbTCZTyg>; Wed, 26 Mar 2003 14:54:36 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:33798 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262423AbTCZTyd>; Wed, 26 Mar 2003 14:54:33 -0500
Date: Wed, 26 Mar 2003 20:05:44 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
In-Reply-To: <20030326105840.GA10201@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0303262004080.21188-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Mar 25, 2003 at 05:23:07PM +0000, James Simmons wrote:
> > > While loading X, I get this oops. The weird thing is that I don't use
> > > framebuffer. I compiled with gcc 3.2.2 but the code generated looks weird.
> > > Virgin gcc 3.2.2 on a pentium III.
> > 
> > You don't use framebuffer? Can you send me your config. 
> 
> Ok, I've found the bug, it is in fb_open() in drivers/video/fbmem.c, it
> needs this addition:
> 
>         if(fbidx >= FB_MAX)
>                 return -ENODEV;
> 
> Without it, large minor numbers result in access beyond the end of
> registered_fb.
> 
> On Debian, ls /dev/fb[67] results in:
> crw--w--w-    1 root     tty       29, 192 Nov 30  2000 /dev/fb6
> crw--w--w-    1 root     tty       29, 224 Nov 30  2000 /dev/fb7
> 
> On Red Hat this is: 
> crw-------    1 root     root      29,   7 Apr 11  2002 /dev/fb7
> crw-------    1 root     root      29,   8 Apr 11  2002 /dev/fb8
> 
> Which explains why many don't see this bug.

Ah. That explains it. I will apply the fix.


