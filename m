Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTJUU42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTJUU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:56:28 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:53452 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S263369AbTJUUz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:55:59 -0400
Organization: 
Date: Tue, 21 Oct 2003 23:55:26 +0300 (EET DST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: James Simmons <jsimmons@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
In-Reply-To: <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.53.0310212348520.12783@tinos.csd.uch.gr>
References: <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following errors during make bzImage

  CC      drivers/video/aty/radeon_base.o
drivers/video/aty/radeon_base.c: In function `radeonfb_setup':
drivers/video/aty/radeon_base.c:2225: error: `force_measure_pll'
undeclared (first use in this function)
drivers/video/aty/radeon_base.c:2225: error: (Each undeclared identifier
is reported only once
drivers/video/aty/radeon_base.c:2225: error: for each function it appears
in.)
drivers/video/aty/radeon_base.c: In function `__check_force_measure_pll':
drivers/video/aty/radeon_base.c:2263: error: `force_measure_pll'
undeclared (first use in this function)
drivers/video/aty/radeon_base.c: At top level:
drivers/video/aty/radeon_base.c:2263: error: `force_measure_pll'
undeclared here (not in a function)
drivers/video/aty/radeon_base.c:2263: error: initializer element is not
constant
drivers/video/aty/radeon_base.c:2263: error: (near initialization for
`__param_force_measure_pll.arg')
make[3]: *** [drivers/video/aty/radeon_base.o] Error 1
make[2]: *** [drivers/video/aty] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

and

drivers/video/fbmem.c:219: error: `radeonfb_setup' undeclared here (not in a function)
drivers/video/fbmem.c:219: error: initializer element is not constant
drivers/video/fbmem.c:219: error: (near initialization for `fb_drivers[0].setup')
drivers/video/fbmem.c:219: error: initializer element is not constant
drivers/video/fbmem.c:219: error: (near initialization for `fb_drivers[0]')


So propably these should be applied:

--- radeon_base.c_old   2003-10-21 23:57:20.000000000 +0300
+++ radeon_base.c_new   2003-10-21 23:52:24.000000000 +0300
@@ -199,6 +199,7 @@
 static int nomodeset = 0;
 static int ignore_edid = 0;
 static int mirror = 0;
+static int force_measure_pll = 0;
 static int panel_yres __initdata = 0;
 static int force_dfp __initdata = 0;
 static struct radeonfb_info *board_list = NULL;

--- fbmem.c_old 2003-10-21 23:57:46.000000000 +0300
+++ fbmem.c_new 2003-10-21 23:51:54.000000000 +0300
@@ -133,6 +133,7 @@
 extern int tx3912fb_init(void);
 extern int tx3912fb_setup(char*);
 extern int radeonfb_init(void);
+extern int radeonfb_setup(char *options);
 extern int epson1355fb_init(void);
 extern int pvr2fb_init(void);
 extern int pvr2fb_setup(char*);


	Panagiotis Papadakos

On Tue, 21 Oct 2003, James Simmons wrote:

>
> Okay I see people are having alot of problems in the -mm tree. I don't
> have any problems but I'm working against Linus tree. Could people try the
> patch against 2.6.0-test8 and tell me if they still have the same results.
> I have a new patch here:
>
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
