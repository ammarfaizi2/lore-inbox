Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265204AbUEMWes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265204AbUEMWes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUEMWes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:34:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35289 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265204AbUEMWeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:34:44 -0400
Date: Fri, 14 May 2004 00:34:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Message-ID: <20040513223436.GI22202@fs.tum.de>
References: <20040503230911.GE7068@logos.cnet> <200405042253.11133@WOLK> <40982AC6.5050208@eyal.emu.id.au> <20040506121302.GI9636@fs.tum.de> <c7rpsg$ghd$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7rpsg$ghd$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 12:07:44AM +0000, H. Peter Anvin wrote:
> Followup to:  <20040506121302.GI9636@fs.tum.de>
> By author:    Adrian Bunk <bunk@fs.tum.de>
> In newsgroup: linux.dev.kernel
> > > >
> > > >yep. Either we backport WARN_ON ;) or simply do the attached.
> > > >
> > > >--- old/drivers/net/tg3.c	2004-05-04 14:30:22.000000000 +0200
> > > >+++ new/drivers/net/tg3.c	2004-05-04 14:49:58.000000000 +0200
> > > >@@ -51,6 +51,10 @@
> > > > #define TG3_TSO_SUPPORT	0
> > > > #endif
> > > > 
> > > >+#ifndef WARN_ON
> > > >+#define	WARN_ON(x)	do { } while (0)
> > > >+#endif
> > > 
> > > Related but off topic. Do people find the ab#define	WARN_ON(x)
> > > a macro acceptable? The fact is that not mentioning 'x' means any
> > > side-effects are not executed, meaning the author must take special
> > > care when using this macro.
> > >...
> > 
> > Do not use code with side effects in BUG_ON and WARN_ON.
> > 
> 
> Why not use the much simpler:
> 
> #ifndef WARN_ON
> # define WARN_ON(x) ((void)(x))
> #endif
> 
> Preserves side effects and everything.

AFAIR, the -tiny tree already implements some kind of empty 
BUG/PAGE_BUG/WARN_ON macros.

When optimizing for size that way, your suggestion would result in 
bigger code.

And after a quick view, I haven't seen any WARN_ON users in 2.6 that
seem to rely on side effects.

> 	-hpa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

