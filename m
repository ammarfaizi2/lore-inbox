Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319170AbSHNBjB>; Tue, 13 Aug 2002 21:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319172AbSHNBjB>; Tue, 13 Aug 2002 21:39:01 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:42377 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S319170AbSHNBjA>; Tue, 13 Aug 2002 21:39:00 -0400
Date: Tue, 13 Aug 2002 20:42:41 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020814014241.GK761@cadcamlab.org>
References: <3D587483.1C459694@alphalink.com.au> <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu> <20020813204829.GJ761@cadcamlab.org> <3D59B212.DC24E231@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D59B212.DC24E231@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [I wrote]
> > sed '/dep_/s/ \$CONFIG_/ CONFIG_/g' is quite effective.  In any
> > case it is not hard to support both syntaxes - once the transition
> > is complete,

[Greg Banks]
> Does "complete" mean all the ports have also made the change and
> been merged back?

Either that, or, Linus gets tired of seeing mixed syntax in his tree,
does the 'sed' himself, and removes the compatibility parsing.  Linus
has never been afraid to force the hand of a port maintainer.
Remember what happened to the old-style Rules.make syntax just before
2.4 went gold.

Actually I suspect it would be more like the C99 thing: after the new
syntax is added, we start doing [TRIVIAL] patches to clean out the
old, and eventually once that is done we have the option of removing
the old syntax or leaving it in as a known oddity.  I'd favor removing
it, but people who maintain exarboralities for both 2.4 and 2.6 would
not thank me.

> I don't think it's good policy to have the $ and non-$ cases
> behaving differently if we can avoid it.

A good reason to excise the $ case from the tree at first opportunity.
Sure, it would cause complaints from people getting too many .rejs
from personal trees.  But dang it, it's just one line of sed.  (Or
'ed' / 'perl -wpi' for in situ editing, depending on whether or not
you're Al Viro.)

> I'm more concerned about subtle dependencies on execution order
> resulting from misuse of conditionals.

Yeah, that's the real reason 'n'!='' is Considered Harmful (and warned
about in the docs even now).

Peter
