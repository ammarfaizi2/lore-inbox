Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTAFNW3>; Mon, 6 Jan 2003 08:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbTAFNW3>; Mon, 6 Jan 2003 08:22:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42698 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266609AbTAFNW1>; Mon, 6 Jan 2003 08:22:27 -0500
Date: Mon, 6 Jan 2003 14:31:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       claus@momo.math.rwth-aachen.de, linux-tape@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [2.5 patch] re-add zft_dirty to zftape-ctl.c
Message-ID: <20030106133101.GS6114@fs.tum.de>
References: <20030104151404.GX6114@fs.tum.de> <1041712127.2036.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041712127.2036.1.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 08:28:48PM +0000, Alan Cox wrote:
> On Sat, 2003-01-04 at 15:14, Adrian Bunk wrote:
> > Hi Alan,
> > 
> > your
> > 
> >   [PATCH] rescue ftape from the ravages of that Rusty chap
> > 
> > removed zft_dirty from zftape-ctl.c in Linus' 2.5 tree. This seems to be
> > accidentially and wrong, it was the only definition of zft_dirty in the
> > whole kernel sources and now there's an error at the final linking of
> > the kernel. The patch below (against 2.5.54) re-adds it.
> 
> I disagree entirely. The zft_dirty function is junk. I accidentally missed
> removing one other reference to it when you compile it in, that is all. For some
> reason the fix to that never got into Linus tree. Remove the other use of it.

Is the patch below correct?

> Alan

cu
Adrian

--- linux-2.5.54/drivers/char/ftape/zftape/zftape-ctl.h.old	2003-01-06 14:23:51.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-ctl.h	2003-01-06 14:24:02.000000000 +0100
@@ -47,7 +47,6 @@
 extern void zft_reset_position(zft_position *pos);
 extern int  zft_check_write_access(zft_position *pos);
 extern int  zft_def_idle_state(void);
-extern int  zft_dirty(void);
 
 /*  hooks for the VFS interface 
  */
--- linux-2.5.54/drivers/char/ftape/zftape/zftape-ctl.c.old	2003-01-06 14:22:49.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-ctl.c	2003-01-06 14:23:43.000000000 +0100
@@ -790,13 +790,6 @@
 		zft_uninit_mem();
 		going_offline = 0;
 		zft_offline   = 1;
-	} else if (zft_dirty()) {
-		TRACE(ft_t_noise, "Keeping module locked in memory because:\n"
-		      KERN_INFO "header segments need updating: %s\n"
-		      KERN_INFO "tape not at BOT              : %s",
-		      (zft_volume_table_changed || zft_header_changed) 
-		      ? "yes" : "no",
-		      zft_tape_at_lbot(&zft_pos) ? "no" : "yes");
 	} else if (zft_cmpr_lock(0 /* don't load */) == 0) {
 		(*zft_cmpr_ops->reset)(); /* unlock it again */
 	}
