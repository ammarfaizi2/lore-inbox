Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWF0RXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWF0RXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWF0RXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:23:20 -0400
Received: from xenotime.net ([66.160.160.81]:3725 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161227AbWF0RXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:23:19 -0400
Date: Tue, 27 Jun 2006 10:25:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH, trivial] Remove about 50 unneeded
 #includes in fbdev
Message-Id: <20060627102557.e595c183.rdunlap@xenotime.net>
In-Reply-To: <9e4733910606271001u2794d1e3ocb123f3cf9476266@mail.gmail.com>
References: <9e4733910606270919n7819dbc0g8bd5c99f4b911583@mail.gmail.com>
	<20060627095127.441c543e.rdunlap@xenotime.net>
	<9e4733910606271001u2794d1e3ocb123f3cf9476266@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 13:01:16 -0400 Jon Smirl wrote:

> On 6/27/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Tue, 27 Jun 2006 12:19:07 -0400 Jon Smirl wrote:
> >
> > > Remove about 50 unneeded #includes in fbdev
> >
> > Does this that
> > (a) these drivers build without these header files explicitly #included
> 
> I checked it this way. There are 2,295 explicit includes in
> drivers/video. Do you have a tool to automatically determine which
> APIs are directly used? Many of the fbdev drivers look to be the
> victim of cut and paste and have a lot of unnecessary includes.

Nope, I don't have such a tool.  I wish we did.

> > or
> > (b) these drivers don't use *any* APIs or data from these header files?
> >
> > They may build (a) but still use the APIs, so (b) is the requirement/target.
> > (I.e., other header files could suck in the required headers.)
> >
> >
> > > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > >
> > > diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
> > > index db878fd..e498a54 100644
> > > --- a/drivers/video/aty/aty128fb.c
> > > +++ b/drivers/video/aty/aty128fb.c
> > > @@ -46,26 +46,14 @@
> > >   */
> > >
> > >
> > > -#include <linux/config.h>
> > >  #include <linux/module.h>
> > >  #include <linux/moduleparam.h>
> > > -#include <linux/kernel.h>
> > >  #include <linux/errno.h>
> > > -#include <linux/string.h>
> > > -#include <linux/mm.h>
> > > -#include <linux/tty.h>
> > > -#include <linux/slab.h>
> > > -#include <linux/vmalloc.h>
> > >  #include <linux/delay.h>
> > > -#include <linux/interrupt.h>
> > >  #include <asm/uaccess.h>
> > >   #include <linux/fb.h>
> > > -#include <linux/init.h>
> > >  #include <linux/pci.h>
> > > -#include <linux/ioport.h>
> > >  #include <linux/console.h>
> > > -#include <linux/backlight.h>
> > > -#include <asm/io.h>
> > >
> > >   #ifdef CONFIG_PPC_PMAC
> > >  #include <asm/machdep.h>
> > > diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> > > index c5185f7..5f4c76c 100644
> > > --- a/drivers/video/aty/atyfb_base.c
> > > +++ b/drivers/video/aty/atyfb_base.c
> > > @@ -49,26 +49,13 @@
> > >  ******************************************************************************/
> > >
> > >
> > > -#include <linux/config.h>
> > > -#include <linux/module.h>
> > > -#include <linux/moduleparam.h>
> > > -#include <linux/kernel.h>
> > > -#include <linux/errno.h>
> > > -#include <linux/string.h>
> > > -#include <linux/mm.h>
> > > -#include <linux/slab.h>
> > > -#include <linux/vmalloc.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/console.h>
> > >   #include <linux/fb.h>
> > > -#include <linux/init.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/interrupt.h>
> > > -#include <linux/spinlock.h>
> > > -#include <linux/wait.h>
> > >  #include <linux/backlight.h>
> > >
> > > -#include <asm/io.h>
> > >  #include <asm/uaccess.h>
> > >
> > >  #include <video/mach64.h>
> > > diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> > > index c5ecbb0..56445ea 100644
> > > --- a/drivers/video/aty/radeon_base.c
> > > +++ b/drivers/video/aty/radeon_base.c
> > > @@ -52,25 +52,6 @@
> > >
> > >  #define RADEON_VERSION       "0.2.0"
> > >
> > > -#include <linux/config.h>
> > > -#include <linux/module.h>
> > > -#include <linux/moduleparam.h>
> > > -#include <linux/kernel.h>
> > > -#include <linux/errno.h>
> > > -#include <linux/string.h>
> > > -#include <linux/mm.h>
> > > -#include <linux/tty.h>
> > > -#include <linux/slab.h>
> > > -#include <linux/delay.h>
> > > -#include <linux/time.h>
> > > -#include <linux/fb.h>
> > > -#include <linux/ioport.h>
> > > -#include <linux/init.h>
> > > -#include <linux/pci.h>
> > > -#include <linux/vmalloc.h>
> > > -#include <linux/device.h>
> > > -
> > > -#include <asm/io.h>
> > >  #include <asm/uaccess.h>
> > >
> > >   #ifdef CONFIG_PPC_OF
> > > diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
> > > index a9d0414..4855c0a 100644
> > > --- a/drivers/video/aty/radeon_i2c.c
> > > +++ b/drivers/video/aty/radeon_i2c.c
> > > @@ -1,9 +1,3 @@
> > > -#include <linux/config.h>
> > > -#include <linux/module.h>
> > > -#include <linux/kernel.h>
> > > -#include <linux/sched.h>
> > > -#include <linux/delay.h>
> > > -#include <linux/pci.h>
> > >   #include <linux/fb.h>

---
~Randy
