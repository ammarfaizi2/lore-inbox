Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSHVRZa>; Thu, 22 Aug 2002 13:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHVRZ3>; Thu, 22 Aug 2002 13:25:29 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:33981 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315167AbSHVRZY>; Thu, 22 Aug 2002 13:25:24 -0400
Date: Thu, 22 Aug 2002 10:06:24 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Paul Mackerras <paulus@au1.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] broken cfb* support in the 2.5.31-bk
In-Reply-To: <15708.14066.32752.365661@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0208220950170.8777-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That was done to push people to port there drivers to the new api.
>
> Well, what _is_ the new API?

>From the details in skeletonfb.c.

 *  I have started rewriting this driver as a example of the upcoming new API
 *  The primary goal is to remove the console code from fbdev and place it
 *  into fbcon.c. This reduces the code and makes writing a new fbdev driver
 *  easy since the author doesn't need to worry about console internals. It
 *  also allows the ability to run fbdev without a console/tty system on top
 *  of it.
 *
 *  First the roles of struct fb_info and struct display have changed. Struct
 *  display will go away. The way the the new framebuffer console code will
 *  work is that it will act to translate data about the tty/console in
 *  struct vc_data to data in a device independent way in struct fb_info. Then
 *  various functions in struct fb_ops will be called to store the device
 *  dependent state in the par field in struct fb_info and to change the
 *  hardware to that state. This allows a very clean seperation of the fbdev
 *  layer from the console layer. It also allows one to use fbdev on its own
 *  which is a bounus for embedded devices. The reason this approach works is
 *  for each framebuffer device when used as a tty/console device is allocated
 *  a set of virtual terminals to it. Only one virtual terminal can be active
 *  per framebuffer device. We already have all the data we need in struct
 *  vc_data so why store a bunch of colormaps and other fbdev specific data
 *  per virtual terminal.

 *  As you can see doing this makes the con parameter pretty much useless
 *  for struct fb_ops functions, as it should be. Also having struct
 *  fb_var_screeninfo and other data in fb_info pretty much eliminates the
 *  need for get_fix and get_var. Once all drivers use the fix, var, and cmap
 *  fbcon can be written around these fields. This will also eliminate the
 *  need to regenerate struct fb_var_screeninfo, struct fb_fix_screeninfo
 *  struct fb_cmap every time get_var, get_fix, get_cmap functions are called
 *  as many drivers do now.

See skeletonfb.c for further details.

> Anyway, you could apply this patch, for a start.  I wish you would be
> a bit more careful about details.

Done. Well the good news is I have aquired more hardware for different
platforms to test my work on :-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

