Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSKFV5P>; Wed, 6 Nov 2002 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265765AbSKFV5P>; Wed, 6 Nov 2002 16:57:15 -0500
Received: from pasky.ji.cz ([62.44.12.54]:29181 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265767AbSKFV5L>;
	Wed, 6 Nov 2002 16:57:11 -0500
Date: Wed, 6 Nov 2002 23:03:47 +0100
From: Petr Baudis <pasky@ucw.cz>
To: mec@shout.net, zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021106220347.GE5219@pasky.ji.cz>
Mail-Followup-To: mec@shout.net, zippel@linux-m68k.org,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106212952.GB1035@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Nov 06, 2002 at 10:29:52PM CET, I got a letter,
where Sam Ravnborg <sam@ravnborg.org> told me, that...
> On Wed, Nov 06, 2002 at 07:52:30PM +0100, Petr Baudis wrote:
> >   Hello,
> > 
> >   this patch (against 2.5.46) introduces two special variables which make it
> > actually possible to have .so as the only product of build in some directory
> > and to link something against .so being built in another directory. The
> > variable host-cshlib-extra makes it possible to explicitly mention shared
> > objects to be built and the variable $(<foo>-linkobjs) allows user to specify
> > additional objects to link <foo> against, while not creating any dependencies
> > of <foo> on the objects.
> > 
> >   The changes are minimal while dramatically extending possibilities for
> > messing with the shared objects and they should have no unwanted side-effects,
> > and it appears to actually work for me. Please apply.
> 
> There is only one user of shared libaries today, thats Kconfig.
> And Kconfig is the only user of C++ as well.
> 
> There is quite a lot of added complexity in Makefile.lib + Makefile.build
> only to support this. Being the one that introduced it, I would like to
> see it go away again.
> Rationale behind this is that the current added complexity has an penalty
> when compiling a kernel, and I would like to move the complexity to
> the only user.
> 
> Care to try that approach?

Can't say anything about the C++ stuff, but the second user of shared libraries
is going to be lxdialog - hopefully this evening already, in my patches (it
already works, I'm only cleaning out few details now; lxdialog + mconf is also
user of both these extensions).

I don't think the complexity increase is so dramatical - theoretically, it
almost shouldn't affect the normal build, except one scan for .so extensions,
right? Maybe we could do with some less generic way here, like specifying .so
dependencies in a special variable? On the other side, moving .so processing to
the user entirely would already mean some amount of duplication now (given that
my lxdialog + mconf patch will be accepted ;-).

I personally think that the -linkobjs variable adds practically zero overhead,
while having potential to be generically useful in other places than lxdialog.
About host-cshlib-extra, if we aren't going to entirely remove .so processing,
I believe that it should go in as well, since eventual move of .so processing
to separate set of rules will probably mostly affect one step higher level of
rules / variables than this, and this variable is going to be useful in the
both cases.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
