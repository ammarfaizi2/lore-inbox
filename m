Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289708AbSBJSD2>; Sun, 10 Feb 2002 13:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289711AbSBJSDT>; Sun, 10 Feb 2002 13:03:19 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:47490
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289708AbSBJSDF>; Sun, 10 Feb 2002 13:03:05 -0500
Date: Sun, 10 Feb 2002 11:02:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>, David Lang <dlang@diginsite.com>,
        Larry McVoy <lm@bitmover.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020210180229.GI872@opus.bloom.county>
In-Reply-To: <20020209090527.B13735@work.bitmover.com> <Pine.LNX.4.44.0202091258110.25220-100000@dlang.diginsite.com> <20020209134132.J13735@work.bitmover.com> <20020209163603.B9826@lynx.turbolabs.com> <20020209155258.E18734@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209155258.E18734@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 03:52:58PM -0800, Larry McVoy wrote:
> On Sat, Feb 09, 2002 at 04:36:03PM -0700, Andreas Dilger wrote:
> > On Feb 09, 2002  13:41 -0800, Larry McVoy wrote:
> > > We don't, but we can, and we should.  "bk relink tree1 tree2" seems like 
> > > the right interface.
> > 
> > Yes, this would be great.  It should probably only do this for files in
> > SCCS and BitKeeper directories, because vim (for example) will do the
> 
> Correct.
> 
> > One thing that I've noticed (got my first linux-2.5 clone last night) is
> > that the kernel build process is somewhat broken by the fact that not
> > everything that you need to build is checked out of the repository by
> > make.
> > 
> > It appears to handle .c files ok, but it failed for all of the .h files.
> 
> This is because the dependencies are incorrect in the makefiles.  If you
> have correct dependencies in the makefiles, make will do the right thing.

Or more specifically, the 'dependancy' stage of the kernel knows
_nothing_ about SCCS.  It _might_ not be that hard to hack up the
scripts/mkdep.c program to check if an #include'd file exists (and if it
doesn't, if (any search patch)/SCCS exists, and if so, get it.

> One alternative would be to have a scripts/bk-get which takes as an arg
> the architecture[s] you want and gets the files that make sense for
> that architecture.  That would help somewhat.

If it's just a flat list of files, it'd be rather hellish to maintain
I'd think.  It _might_ not be too horrible to try and glean files from
CONFIG options (but isn't part of the point of the kernel's current dep
system to not depend on CONFIG_xxx options?) and assume all of include/
is needed.

Or kbuild-2.5 might just work since it does deps in a more 'correct'
manner.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
