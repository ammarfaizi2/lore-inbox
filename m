Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSEaAtX>; Thu, 30 May 2002 20:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSEaAtW>; Thu, 30 May 2002 20:49:22 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:16862 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313202AbSEaAtS>;
	Thu, 30 May 2002 20:49:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Kenneth Johansson <ken@canit.se>
Subject: Re: KBuild 2.5 Impressions
Date: Fri, 31 May 2002 02:47:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200205302155.g4ULtEb09500@buggy.badula.org> <E17DZCa-0007hI-00@starship> <1022803993.2799.13.camel@tiger>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Daa5-0007iZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 02:13, Kenneth Johansson wrote:
> On Fri, 2002-05-31 at 01:19, Daniel Phillips wrote:
> > There is exactly one valid objection I've seen to kbuild 2.5 inclusion,
> > and that is the matter of breaking up the patch.  Having done a quick
> > tour through the whole patch set, I now know that there are some
> > easy places to break it up:
> > 
> >   - Documentation is a large part of the patch and can be easily
> >     broken out.
> > 
> >   - The makefile parser, complete with state transition tables etc,
> >     lexer, and so on, breaks out cleanly (sits on top of the db
> >     utilities).
> > 
> >   - Executable programs written in C.  Each one ends with a
> >     'main' function, and there is the natural division.
> > 
> >   - The remaining C code breaks out into a number of separable
> >     components:
> > 
> >       - Utilities such as environment variable parsing, canonical
> >         name generation, line reading, line editing etc.
> >       - The database 
> >       - File utilities that use the database (e.g., walk_fs_db)
> >       - Dependency generation
> >       - Global Makefile construction (command generation etc)
> > 
> >     These tend to be common to a number of the executable programs,
> >     and so have the nature of library components.  They can all go
> >     under the heading 'lib', and further breakdown is probably not
> >     necessary.
> > 
> >   - The Makefile.in patches seem to be about 30-40% of the whole
> >     thing, and imho must be applied all at the same time.  However,
> >     they break up nicely across subsystem lines (drivers, fs, etc)
> > 
> >   - The per-arch patches are already broken out, and are short.
> > 
> > I think that with these breakups done the thing would be sufficiently
> > digestible to satisfy Linus.  Now that I think of it, Linus's request
> > for a breakup is really an endorsement, and quite possibly Keith took
> > it the wrong way.  (Keith, by the way, how did I do on the structural
> > breakdown?  Sorry, I really couldn't spend as much time on it as it
> > deserves.)
> 
> Maybe I'm the idiot here but what dose this gain you??

It makes it faster to analyze.  I would have appreciated that in doing
my own analysis.  If Linus incorporated the whole thing without analyzing
its structure, I'd be worried.

The only problem would be that this kind of breakup and convenience of
applying the patch tend to be mutually exclusive.  I suppose that could
be solved with a script Keith's end - simply append all the broken-apart
pieces into one large patch (in fact, it seems that two of the tree
patches you need to apply for the i386 version would be better appended
together for the purpose of distribution.)

The question of how much work it is to do the breakup itself is separate.
In my experience, maintaining a system in a broken-up form tends to be
a major use of time.  It's something you want to do once, just before
inclusion, and that seems to be exactly what Linus has asked for.

> The reason to break up a patch is not simply to get more of them. There
> is no point in splitting if you still need to use every single one of
> them to make anything work. 

See above.  It's all about analyzing the structure of the patch.  To be
fair though, it took me less than an hour to get a pretty good idea of
how the current patch set is structured.

-- 
Daniel
