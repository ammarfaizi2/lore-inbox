Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSHODW3>; Wed, 14 Aug 2002 23:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHODW3>; Wed, 14 Aug 2002 23:22:29 -0400
Received: from zok.SGI.COM ([204.94.215.101]:63405 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316532AbSHODW2>;
	Wed, 14 Aug 2002 23:22:28 -0400
Message-ID: <3D5B1F95.AD69E0C3@alphalink.com.au>
Date: Thu, 15 Aug 2002 13:27:17 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <3D59F22E.D0DA5FC6@alphalink.com.au> <20020814142228.GB17969@cadcamlab.org> <3D5B03A9.4E3CE764@alphalink.com.au> <20020815023345.GF17969@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Greg Banks]
> > > > +    2      CONFIG_KMOD
> > > > +    2      CONFIG_MODULES
> > > > +    2      CONFIG_MODVERSIONS
> > > >      2      CONFIG_RTC
> > >
> > > What does that mean?  All I did there was to combine two toplevel
> > > menus into one.  Did this do something bad?
> >
> > Apparently.  In the stock kernel:
> >
> > warning:arch/mips/config.in:224:"CONFIG_KMOD" has overlapping definitions
> > warning:init/Config.in:19:location of previous definition
> > warning:arch/parisc/config.in:53:"CONFIG_KMOD" has overlapping definitions
> > warning:init/Config.in:19:location of previous definition
> 
> Weird.  These should have triggered all along - any idea why they
> didn't?

Because you moved the items to a menu with a different name.

GCML2 issues the overlapping-definitions warning if the same item appears
twice in such a way that both definitions can be visible at the same time.
A sub-case is where the item appears twice unconditionally in the same menu,
which was happening before your change.  Another sub-case is where the item
appears twice unconditionally in different menus, which happened after your
change.  Hence overlapping-definitions warnings for CONFIG_KMOD et al did not
appear in the diff of summaries.

GCML2 issues the different-parent warning when an item appears in two
different menu parents, regardless of conditions.  Before your change, the
two identically named menus were merged into one node (this behaviour is
very necessary for reasons too complex to go into here) so the two definitions
of CONFIG_KMOD had the same parent.  After your change, they had different
parents, hence the new warnings.

> Well, they're fixed in my tree.  It looks [trivial], but this one
> makes me uneasy.  I mean, it's such an obvious bug - the toplevel
> "Loadable module support" menu appears twice - that I almost think it
> was somehow intentional.

There are many [trivial] errors.  My favourite is CONFIG_SOUND_CMPCI_FMIO.

> > Did I mention Gordian knot?
> 
> Yes, I believe you did.  Does that make ESR Alexander the Great? (:

Given the noise of his arrival and the speed of his departure...Darius.

> > related to config.in's using the same banner for a menu and a
> > comment.
> 
> mainmenu_option next_comment ... now *there's* a bit of syntax that
> needs to change.  Even config-language.txt agrees.

That would be great, but the problem is related to the way comments are
defined in CML2, which doesn't quite fit in CML1.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
