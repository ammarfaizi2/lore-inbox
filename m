Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVAGW3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVAGW3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVAGWWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:22:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:4008 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261662AbVAGWUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:20:13 -0500
Date: Fri, 7 Jan 2005 23:20:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-os@analogic.com
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 167] Kill unused variables in the net code
In-Reply-To: <Pine.LNX.4.61.0501071636160.21727@chaos.analogic.com>
Message-ID: <Pine.GSO.4.61.0501072319480.9088@waterleaf.sonytel.be>
References: <200501072111.j07LB4EN011223@anakin.of.borg>
 <Pine.LNX.4.61.0501071636160.21727@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, linux-os wrote:
> On Fri, 7 Jan 2005, Geert Uytterhoeven wrote:
> > 2.4.28-rc2 introduced a warning in the net code on non-SMP:
> > 
> >    net/core/neighbour.c:1809: warning: unused variable `tbl'
> > 
> > The following patch fixes this.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > 
> > --- linux-2.4.29-rc1/include/linux/spinlock.h	2004-04-27 17:22:10.000000000
> > +0200
> > +++ linux-m68k-2.4.29-rc1/include/linux/spinlock.h	2005-01-07
> > 21:51:28.000000000 +0100
> > @@ -147,7 +147,7 @@
> > 
> > #define rwlock_init(lock)	do { } while(0)
> > #define read_lock(lock)	(void)(lock) /* Not "unused variable". */
> > -#define read_unlock(lock)	do { } while(0)
> > +#define read_unlock(lock)	(void)(lock) /* Not "unused variable". */
> > #define write_lock(lock)	(void)(lock) /* Not "unused variable". */
> > #define write_unlock(lock)	do { } while(0)
> But don't all you need to do is:
> 
> #define read_unlock(x)

No, since the `x' may refer to a variable that's further unused (cfr.
net/core/neighbour.c:1809).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
