Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSHMJPo>; Tue, 13 Aug 2002 05:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSHMJPo>; Tue, 13 Aug 2002 05:15:44 -0400
Received: from rj.sgi.com ([192.82.208.96]:9118 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313087AbSHMJPm>;
	Tue, 13 Aug 2002 05:15:42 -0400
Message-ID: <3D58CF5B.C33F5665@alphalink.com.au>
Date: Tue, 13 Aug 2002 19:20:27 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: [patch] config language dep_* enhancements]
Content-Type: multipart/mixed;
 boundary="------------5E5D59524D52875877476467"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5E5D59524D52875877476467
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


[Sorry, resent to lkml with attachment gzip'ed]

Kai Germaschewski wrote:
> 
> On Mon, 12 Aug 2002, Greg Banks wrote:
> 
> > But at this point in the menu tree for 14 of 17 architectures, CONFIG_SCSI has
> > not yet been defined.  The result is that CONFIG_BLK_DEV_IDESCSI only works
> > in "make config" and "make allyesconfig" precisely because of the semantic that
> > you wish to change.
> 
> But so the change would be a good thing, right? It would make the behavior
> consistent between all configuration tools,

Sorry, I don't understand what you're getting at.  Currently the behaviour is
consistent between config, menuconfig and xconfig: null-valued deps are ignored.

> CONFIG_BLK_DEV_IDESCSI would
> be not selectable in either.  So people would have to notice that this
> statement is broken and fix it.

Ah.  If you're willing to knowingly feed Linus with patches that break current
config behaviour, then OK we have a way to proceed.

> > Yes, changing the behaviour is infeasible with shell-based parsers.  However,
> > there is now a body of rules which implictly depend on the semantics.
> 
> If they do, they should be fixed. And, as I pointed out before, it is
> possible to fix even shell-based parsers.

Sorry, didn't see that.

> So you agree a bit of spring cleaning wouldn't hurt, right? ;)

Absolutely, and I have a catalogue of dust puppies to help that process ;-)

> > > It seems to me that it only encourages buggy
> > > Config.in code (since "" == "n" in other contexts like the #defines),
> >
> > And "" != "n" in other contexts, like if [];then statements.  Did I mention
> > "unorthogonal" ?
> 
> Well, you're right here. Which makes me think of my original idea as to
> define all CONFIG_* values to "n" unless they've explicitly been assign
> another value before.

CML2's semantics were that all symbols have a default which is a zero; for
booleans and tristates that means "n".  Changing from those semantics to the
ones necessary to run the gcml2 rulebase on CML1 rules was one of the most
painful parts of supporting CML1.

So I think having an explicit "n" default is a good idea, but I fail to see how
you would actually implement such a thing in a shell based parser.

> The main usage currently is "make oldconfig", though .config may be a bit
> confusing: Questions which have been answered before (even with "n") will
> not be asked again, whereas for undefined symbols, the corresponding
> question is put.
> 
> So I think the logic should really be tristate, "n","m","y", plus
> additionally a list of CONFIG_* values which have been defined (as opposed
> to just being "n" by default). 

This is precisely the CML2 semantics.

> Of course, this is a 2.5 change, 

Agreed.

> though the only potential for breakage
> are the dep_* statements which are arguably already broken. 

I don't think there's any value to gratuitously breaking 2.4's config.
That's the point of a "stable" series right?

> It shouldn't
> be too hard to come up with a script which points out the dep_* statements
> which reference symbols defined only later (or use gcml2, which I
> understand can do that already?) to see how much breakage there may be.

Ah, glad you asked, see attached output from the latest version of gcml2
(not yet released).

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
--------------5E5D59524D52875877476467
Content-Type: application/x-gzip;
 name="forward-deps.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="forward-deps.txt.gz"

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
GnefUr5U4IIKXLzmAhf/DzxcGamq7QEA

--------------5E5D59524D52875877476467--

