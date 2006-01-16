Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWAPXVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWAPXVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWAPXVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:21:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1626 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751267AbWAPXVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:21:52 -0500
Date: Tue, 17 Jan 2006 00:23:49 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, hch@infradead.org
Subject: Re: drivers/block/ps2esdi.c
Message-ID: <20060116232349.GX3945@suse.de>
References: <43CC0F74.9090409@linuxwireless.org> <Pine.LNX.4.58.0601161329000.24990@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601161329000.24990@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2006, Randy.Dunlap wrote:
> On Mon, 16 Jan 2006, Alejandro Bonilla Beeche wrote:
> 
> > It looks like the Linux-2.6 tree is still broken...
> >
> > Just FYI
> >
> >
> >   CC      drivers/block/loop.o
> >   CC      drivers/block/ps2esdi.o
> > In file included from drivers/block/ps2esdi.c:42:
> > include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please
> > move your driver to the new sysfs api"
> > drivers/block/ps2esdi.c: In function 'ps2esdi_getgeo':
> > drivers/block/ps2esdi.c:1064: error: dereferencing pointer to incomplete
> > type
> > drivers/block/ps2esdi.c:1065: error: dereferencing pointer to incomplete
> > type
> > drivers/block/ps2esdi.c:1066: error: dereferencing pointer to incomplete
> > type
> > make[3]: *** [drivers/block/ps2esdi.o] Error 1
> > make[2]: *** [drivers/block] Error 2
> > make[1]: *** [drivers] Error 2
> > make[1]: Leaving directory `/root/linux-2.6'
> > make: *** [debian/stamp-build-kernel] Error 2
> > debian:~/linux-2.6#
> 
> As Adrian (IIRC) pointed out last time this was posted (last week),
> this is what you can get when you enable "BROKEN".  IOW, see
>   drivers/block/Kconfig:
> 
> config BLK_DEV_PS2
> 	tristate "PS/2 ESDI hard disk support"
> 	depends on MCA && MCA_LEGACY && BROKEN
>                                         ^^^^^^
> 
> so please send patches to fix it (the driver) if you care about it.

Well this breakage is new though, Christoph looks like fallout from the
geo stuff.

diff --git a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
index 43415f6..bea75f2 100644
--- a/drivers/block/ps2esdi.c
+++ b/drivers/block/ps2esdi.c
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/hdreg.h>
 
 #include <asm/system.h>
 #include <asm/io.h>

-- 
Jens Axboe

