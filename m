Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTJVRM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 13:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbTJVRM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 13:12:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15364 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263545AbTJVRMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 13:12:24 -0400
Date: Wed, 22 Oct 2003 18:12:21 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
In-Reply-To: <Pine.GSO.4.53.0310212348520.12783@tinos.csd.uch.gr>
Message-ID: <Pine.LNX.4.44.0310221812170.25125-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied.


On Tue, 21 Oct 2003, Panagiotis Papadakos wrote:

> I get the following errors during make bzImage
> 
>   CC      drivers/video/aty/radeon_base.o
> drivers/video/aty/radeon_base.c: In function `radeonfb_setup':
> drivers/video/aty/radeon_base.c:2225: error: `force_measure_pll'
> undeclared (first use in this function)
> drivers/video/aty/radeon_base.c:2225: error: (Each undeclared identifier
> is reported only once
> drivers/video/aty/radeon_base.c:2225: error: for each function it appears
> in.)
> drivers/video/aty/radeon_base.c: In function `__check_force_measure_pll':
> drivers/video/aty/radeon_base.c:2263: error: `force_measure_pll'
> undeclared (first use in this function)
> drivers/video/aty/radeon_base.c: At top level:
> drivers/video/aty/radeon_base.c:2263: error: `force_measure_pll'
> undeclared here (not in a function)
> drivers/video/aty/radeon_base.c:2263: error: initializer element is not
> constant
> drivers/video/aty/radeon_base.c:2263: error: (near initialization for
> `__param_force_measure_pll.arg')
> make[3]: *** [drivers/video/aty/radeon_base.o] Error 1
> make[2]: *** [drivers/video/aty] Error 2
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
> 
> and
> 
> drivers/video/fbmem.c:219: error: `radeonfb_setup' undeclared here (not in a function)
> drivers/video/fbmem.c:219: error: initializer element is not constant
> drivers/video/fbmem.c:219: error: (near initialization for `fb_drivers[0].setup')
> drivers/video/fbmem.c:219: error: initializer element is not constant
> drivers/video/fbmem.c:219: error: (near initialization for `fb_drivers[0]')
> 
> 
> So propably these should be applied:
> 
> --- radeon_base.c_old   2003-10-21 23:57:20.000000000 +0300
> +++ radeon_base.c_new   2003-10-21 23:52:24.000000000 +0300
> @@ -199,6 +199,7 @@
>  static int nomodeset = 0;
>  static int ignore_edid = 0;
>  static int mirror = 0;
> +static int force_measure_pll = 0;
>  static int panel_yres __initdata = 0;
>  static int force_dfp __initdata = 0;
>  static struct radeonfb_info *board_list = NULL;
> 
> --- fbmem.c_old 2003-10-21 23:57:46.000000000 +0300
> +++ fbmem.c_new 2003-10-21 23:51:54.000000000 +0300
> @@ -133,6 +133,7 @@
>  extern int tx3912fb_init(void);
>  extern int tx3912fb_setup(char*);
>  extern int radeonfb_init(void);
> +extern int radeonfb_setup(char *options);
>  extern int epson1355fb_init(void);
>  extern int pvr2fb_init(void);
>  extern int pvr2fb_setup(char*);
> 
> 
> 	Panagiotis Papadakos
> 
> On Tue, 21 Oct 2003, James Simmons wrote:
> 
> >
> > Okay I see people are having alot of problems in the -mm tree. I don't
> > have any problems but I'm working against Linus tree. Could people try the
> > patch against 2.6.0-test8 and tell me if they still have the same results.
> > I have a new patch here:
> >
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 

