Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272870AbTGaIFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 04:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTGaIFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 04:05:17 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:9631 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S272870AbTGaIFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 04:05:07 -0400
Date: Thu, 31 Jul 2003 10:04:56 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: thornber@sistina.com, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: dm: v4 ioctl interface (was: Re: Linux v2.6.0-test2)
In-Reply-To: <20030730143933.5f8d1ba4.akpm@osdl.org>
Message-ID: <Pine.GSO.4.21.0307311002360.29569-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Andrew Morton wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >   o dm: v4 ioctl interface
> > 
> > This interface code contains a local `resume()' routine, which conflicts with
> > the `resume()' defined by many architectures in <asm/*.h>. The patch below
> > fixes this by renaming the local routine to `do_resume()'.
> 
> ok..
> 
> > However, after this change it still doesn't compile...
> 
> It does for me.  What is it doing wrong for you?

It fails in finding DM_DIR and other related definitions.

Apparently a very important include file is missing, the patch below fixes
this. I don't see how it could compile on ia32 though (I'm cross-compiling for
m68k):

--- linux-2.6.0-test2/drivers/md/dm-ioctl-v4.c.orig	Wed Jul 30 23:17:16 2003
+++ linux-2.6.0-test2/drivers/md/dm-ioctl-v4.c	Thu Jul 31 10:02:13 2003
@@ -14,6 +14,7 @@
 #include <linux/blk.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/dm-ioctl.h>
 
 #include <asm/uaccess.h>
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

