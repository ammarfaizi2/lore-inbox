Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUEFRaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUEFRaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUEFRaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:30:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45267 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261628AbUEFRaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:30:07 -0400
Date: Thu, 6 May 2004 14:13:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Message-ID: <20040506121302.GI9636@fs.tum.de>
References: <20040503230911.GE7068@logos.cnet> <20040504204633.GB8643@fs.tum.de> <200405042253.11133@WOLK> <40982AC6.5050208@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40982AC6.5050208@eyal.emu.id.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 09:44:06AM +1000, Eyal Lebedinsky wrote:
> Marc-Christian Petersen wrote:
> >On Tuesday 04 May 2004 22:46, Adrian Bunk wrote:
> >
> >Hi Adrian,
> >
> >
> >>drivers/net/net.o(.text+0x60293): In function `tg3_get_strings':
> >>: undefined reference to `WARN_ON'
> >>make: *** [vmlinux] Error 1
> >>There's no WARN_ON in 2.4.
> >
> >
> >yep. Either we backport WARN_ON ;) or simply do the attached.
> >
> >--- old/drivers/net/tg3.c	2004-05-04 14:30:22.000000000 +0200
> >+++ new/drivers/net/tg3.c	2004-05-04 14:49:58.000000000 +0200
> >@@ -51,6 +51,10 @@
> > #define TG3_TSO_SUPPORT	0
> > #endif
> > 
> >+#ifndef WARN_ON
> >+#define	WARN_ON(x)	do { } while (0)
> >+#endif
> 
> Related but off topic. Do people find the ab#define	WARN_ON(x)
> a macro acceptable? The fact is that not mentioning 'x' means any
> side-effects are not executed, meaning the author must take special
> care when using this macro.
>...

Do not use code with side effects in BUG_ON and WARN_ON.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

