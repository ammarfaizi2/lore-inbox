Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUIEJu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUIEJu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 05:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUIEJu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 05:50:57 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:36317 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S266479AbUIEJuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 05:50:35 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 4/5][RFC] fbdev: Clean up framebuffer initialization
Date: Sun, 5 Sep 2004 17:50:47 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
References: <200409041108.40276.adaplas@hotpop.com> <Pine.GSO.4.58.0409051113060.28961@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0409051113060.28961@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409051750.47987.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 September 2004 17:16, Geert Uytterhoeven wrote:
> On Sat, 4 Sep 2004, Antonino A. Daplas wrote:
> > Currently, the framebuffer system is initialized in a roundabout manner.
> > First, drivers/char/mem.c calls fbmem_init().  fbmem_init() will then
> > iterate over an array of individual drivers' xxxfb_init(), then each
> > driver registers its presence back to fbmem.  During console_init(),
> > drivers/char/vt.c will call fb_console_init(). fbcon will check for
> > registered drivers, and if any are present, will call take_over_console()
> > in drivers/char/vt.c.
> >
> > This patch changes the initialization sequence so it proceeds in this
> > manner: Each driver has its own module_init(). Each driver calls
> > register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of the
> > driver registration.  Upon notification, fbcon calls take_over_console()
> > in vt.c.
>
> My main concern with this change is that it will be no longer possible to
> change initialization order (and hence choose the primary display for
> systems with multiple graphics adapters) by specifying `video=xxxfb' on the
> kernel command line.
>

I see your point.  But, can we use "fbcon=" setup options to choose which fb
gets mapped to what console? We already have fbcon=map:<option> so we can
choose which becomes the primary display. Granted the "fbcon=" setup is
currently broken, but if fixed, will that be a fair compromise?

Tony


