Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUIEKkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUIEKkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 06:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUIEKkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 06:40:00 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:57241 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S266289AbUIEKj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 06:39:57 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 4/5][RFC] fbdev: Clean up framebuffer initialization
Date: Sun, 5 Sep 2004 18:40:10 +0800
User-Agent: KMail/1.5.4
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
References: <200409041108.40276.adaplas@hotpop.com> <200409051750.47987.adaplas@hotpop.com> <Pine.GSO.4.58.0409051206180.28961@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0409051206180.28961@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409051840.10202.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 September 2004 18:13, Geert Uytterhoeven wrote:
> On Sun, 5 Sep 2004, Antonino A. Daplas wrote:
> > On Sunday 05 September 2004 17:16, Geert Uytterhoeven wrote:
> > > On Sat, 4 Sep 2004, Antonino A. Daplas wrote:
> > > > Currently, the framebuffer system is initialized in a roundabout
> > > > manner. First, drivers/char/mem.c calls fbmem_init().  fbmem_init()
> > > > will then iterate over an array of individual drivers' xxxfb_init(),
> > > > then each driver registers its presence back to fbmem.  During
> > > > console_init(), drivers/char/vt.c will call fb_console_init(). fbcon
> > > > will check for registered drivers, and if any are present, will call
> > > > take_over_console() in drivers/char/vt.c.
> > > >
> > > > This patch changes the initialization sequence so it proceeds in this
> > > > manner: Each driver has its own module_init(). Each driver calls
> > > > register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of
> > > > the driver registration.  Upon notification, fbcon calls
> > > > take_over_console() in vt.c.
> > >
> > > My main concern with this change is that it will be no longer possible
> > > to change initialization order (and hence choose the primary display
> > > for systems with multiple graphics adapters) by specifying
> > > `video=xxxfb' on the kernel command line.
> >
> > I see your point.  But, can we use "fbcon=" setup options to choose which
> > fb gets mapped to what console? We already have fbcon=map:<option> so we
> > can choose which becomes the primary display. Granted the "fbcon=" setup
> > is currently broken, but if fixed, will that be a fair compromise?
>
> Yes, sounds fine.

Thanks.

>
> Just thinking of something else: right now it's possible to disable a fbdev
> by saying `video=xxxfb:off'. This can be useful if the fbdev driver doesn't
> work with your hardware. After you change, individual fbdev drivers will
> have to reimplement this theirselves in their __setup() functions.

Yes.  I hope this doesn't bite too deep.  If it does, I think we can let
fb_get_options() return an error  when the "off" option is present.  But I'm
not going to implement it unless we get a lot of complaints.

Tony 


