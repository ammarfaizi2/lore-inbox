Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277013AbUKBIZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277013AbUKBIZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S451863AbUKBIZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:25:26 -0500
Received: from witte.sonytel.be ([80.88.33.193]:11482 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S382771AbUKBIZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:25:12 -0500
Date: Tue, 2 Nov 2004 09:25:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 504] m68k: smp_lock.h: Avoid recursive include
In-Reply-To: <200411020249_MC3-1-8DAD-7CF5@compuserve.com>
Message-ID: <Pine.GSO.4.61.0411020923590.23843@waterleaf.sonytel.be>
References: <200411020249_MC3-1-8DAD-7CF5@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Chuck Ebbert wrote:
> Linus Torvalds wrote:
> > This one is _totally_ broken. 
> > 
> > Not only is that include not recursive, but it immediately breaks any SMP 
> > compile because that header file _needs_ the definition of "task_struct".
> >
> > On Sun, 31 Oct 2004, Geert Uytterhoeven wrote:
> > > smp_lock.h: Avoid recursive include
> > > 
> > > --- linux-2.6.10-rc1/include/linux/smp_lock.h       2004-04-28 15:47:31.000000000 +0200
> > > +++ linux-m68k-2.6.10-rc1/include/linux/smp_lock.h  2004-10-20 22:24:05.000000000 +0200
> > > @@ -2,7 +2,6 @@
> > >  #define __LINUX_SMPLOCK_H
> > >  
> > >  #include <linux/config.h>
> > > -#include <linux/sched.h>
> 
> 
> Shouldn't you also revert cset 1.2405, also by Geert, which added
> <linux/sched.h> to reiserfs_fs.h?  Looks like that was done to fix
> breakage caused by this change.

You can discuss about that: reiserfs_fs.h used current including sched.h.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
