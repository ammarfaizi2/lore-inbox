Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUIEJQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUIEJQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 05:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUIEJQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 05:16:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:65230 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266459AbUIEJQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 05:16:36 -0400
Date: Sun, 5 Sep 2004 11:16:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 4/5][RFC] fbdev: Clean up framebuffer
 initialization
In-Reply-To: <200409041108.40276.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.58.0409051113060.28961@waterleaf.sonytel.be>
References: <200409041108.40276.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004, Antonino A. Daplas wrote:
> Currently, the framebuffer system is initialized in a roundabout manner.
> First, drivers/char/mem.c calls fbmem_init().  fbmem_init() will then
> iterate over an array of individual drivers' xxxfb_init(), then each driver
> registers its presence back to fbmem.  During console_init(),
> drivers/char/vt.c will call fb_console_init(). fbcon will check for
> registered drivers, and if any are present, will call take_over_console() in
> drivers/char/vt.c.
>
> This patch changes the initialization sequence so it proceeds in this
> manner: Each driver has its own module_init(). Each driver calls
> register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of the
> driver registration.  Upon notification, fbcon calls take_over_console() in
> vt.c.

My main concern with this change is that it will be no longer possible to
change initialization order (and hence choose the primary display for systems
with multiple graphics adapters) by specifying `video=xxxfb' on the kernel
command line.

That's also the reason why this was never done before.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
