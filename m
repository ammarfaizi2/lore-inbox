Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319213AbSHNFbA>; Wed, 14 Aug 2002 01:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319214AbSHNFbA>; Wed, 14 Aug 2002 01:31:00 -0400
Received: from rj.SGI.COM ([192.82.208.96]:56251 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319213AbSHNFa6>;
	Wed, 14 Aug 2002 01:30:58 -0400
Message-ID: <3D59EC31.53E5C42C@alphalink.com.au>
Date: Wed, 14 Aug 2002 15:35:45 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208132329520.32010-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Wed, 14 Aug 2002, Greg Banks wrote:
> 
> > Peter Samuelson wrote:
> > >
> > > [Greg Banks]
> > > > Does "complete" mean all the ports have also made the change and
> > > > been merged back?
> > > [...]
> > > Actually I suspect it would be more like the C99 thing: after the new
> > > syntax is added, we start doing [TRIVIAL] patches to clean out the
> > > old, and eventually once that is done we have the option of removing
> > > the old syntax or leaving it in as a known oddity. [...]
> 
> Well, I think when the switch does not change any behavior, it's actually
> okay to get it over with in one large but trivial patch. The other
> approach would be to give the new syntax the new behavior, and do the
> actual switch piecemeal, checking and fixing dep_* statements as they get
> converted.

I tend to favour the piecemeal approach but I'm not particularly fussed as
long as it actually gets done.

> It'd be nice to introduce a warning for statements where the old syntax is
> used, but that seems not possible at least in Configure, since I think
> statements like
> 
> dep_tristate '...' CONFIG_FOO m
> 
> should remain valid.

In general it seems to me that adding useful warnings to shell-based parsers
is difficult. 

> >     define_bool CONFIG_QUUX y
> >
> >     bool 'Set this symbol to ON' CONFIG_FOO
> >
> >     if [ "$CONFIG_FOO" = "y" ]; then
> >       bool 'Here QUUX is a query symbol' CONFIG_QUUX
> >     fi
> 
> Well, it's a bug.

Agreed, and there several of them in the CML1 corpus, some rather
obscure (e.g.  the define and the query happen in different Config.in
files and only for some architectures).

> Setting CONFIG_QUUX to "y" when CONFIG_FOO is "n" can be done in
> an else clause to the if statement. If you want to set a default, that's
> what defconfig is for.

Yes.

> What's nice is that you identified so many problematic cases already, so
> fixing shouldn't be hard. 

Like I said, I have a full catalogue of dust puppies ;-)

> It may still make sense to add code to
> "Configure" which recognizes a redefinition and complains or even aborts.

This would be a brutally effective way of forcing the problems to be fixed.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
