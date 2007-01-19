Return-Path: <linux-kernel-owner+w=401wt.eu-S932835AbXASSkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbXASSkZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXASSkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:40:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2954 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932835AbXASSkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:40:24 -0500
Date: Fri, 19 Jan 2007 19:40:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, rth@twiddle.net
Subject: Re: [PATCH] Stop making "inline" imply forced inlining.
Message-ID: <20070119184030.GQ9093@stusta.de>
References: <Pine.LNX.4.64.0701191156000.24621@CPE00045a9c397f-CM001225dbafb6> <20070119172542.GO9093@stusta.de> <Pine.LNX.4.64.0701191228200.25140@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701191228200.25140@CPE00045a9c397f-CM001225dbafb6>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 12:39:37PM -0500, Robert P. J. Day wrote:
> On Fri, 19 Jan 2007, Adrian Bunk wrote:
> 
> > On Fri, Jan 19, 2007 at 11:56:30AM -0500, Robert P. J. Day wrote:
> > >
> > >   Remove the macros that define simple "inlining" to mean forced
> > > inlining, since you can (and *should*) get that effect with the
> > > CONFIG_FORCED_INLINING kernel config variable instead.
> >
> > NAK.
> >
> > I don't see any place in the kernel where we need a non-forced
> > inline.
> 
> that's not the point.  the point is that, as it stands now, the build
> is *broken* in three ways.
> 
> first, it's broken because declaring something simply as "inline"
> *forces* it to be inlined, which flies in the face of historical
> convention and is more than a little misleading.

In the kernel it's what you should expect since it's defined this way 
for some time.

> second, it's broken because both the use of
> "__attribute__((always_inline))" all over the place and the
> CONFIG_FORCED_INLINING kernel config option imply that you indeed have
> a choice, when you clearly *don't*.  quite simply, you can play with
> that kernel config option or splash the "always_inline" attributes
> around all you want and, unbeknownst to you, none of that is making
> the *slightest* bit of difference.  that is the very *definition* of a
> "broken" build.

It's the definition of a broken option.

The solution is to remove CONFIG_FORCED_INLINING.

> and, finally, you claim that you "don't see any place in the kernel
> where we need a non-forced inline."  i have already posted an alpha
> header file that claims (rightly or wrongly) to need that freedom.
> Q.E.D.

Not Q.E.D. due to "rightly or wrongly".

It could be because Alpha uses "extern inline" and with it's old 
semantice I'd understand that always_inline might be a problem - but is 
there actually any place where Alpha uses "extern inline" with this
semantics and not in a way that it could be replaced with "static inline"?

> > We have tons of inline's in C files that should simply be removed -
> > let's do this instead.
> 
> that may be a better idea, but it doesn't address the current
> brokenness.
> 
> i'm willing to believe that this patch has zero chance of going
> anywhere.  but if you want to reject it, at least be honest about it.
> don't say, "there's no problem here."  instead, say, "yes, the build
> is broken but we don't feel like doing anything about it."

Can you give at least one concrete example of actually broken code?

The only implication I know it has caused is increased code size, but 
that's different from being "broken".

And that's not "but we don't feel like doing anything about it" - it's
"we should remove all the inline's from C files".

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

