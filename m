Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSEaAOT>; Thu, 30 May 2002 20:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSEaAOR>; Thu, 30 May 2002 20:14:17 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:58506 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S312590AbSEaANf>;
	Thu, 30 May 2002 20:13:35 -0400
Subject: Re: KBuild 2.5 Impressions
From: Kenneth Johansson <ken@canit.se>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E17DZCa-0007hI-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 May 2002 02:13:12 +0200
Message-Id: <1022803993.2799.13.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-31 at 01:19, Daniel Phillips wrote:
> There is exactly one valid objection I've seen to kbuild 2.5 inclusion,
> and that is the matter of breaking up the patch.  Having done a quick
> tour through the whole patch set, I now know that there are some
> easy places to break it up:
> 
>   - Documentation is a large part of the patch and can be easily
>     broken out.
> 
>   - The makefile parser, complete with state transition tables etc,
>     lexer, and so on, breaks out cleanly (sits on top of the db
>     utilities).
> 
>   - Executable programs written in C.  Each one ends with a
>     'main' function, and there is the natural division.
> 
>   - The remaining C code breaks out into a number of separable
>     components:
> 
>       - Utilities such as environment variable parsing, canonical
>         name generation, line reading, line editing etc.
>       - The database 
>       - File utilities that use the database (e.g., walk_fs_db)
>       - Dependency generation
>       - Global Makefile construction (command generation etc)
> 
>     These tend to be common to a number of the executable programs,
>     and so have the nature of library components.  They can all go
>     under the heading 'lib', and further breakdown is probably not
>     necessary.
> 
>   - The Makefile.in patches seem to be about 30-40% of the whole
>     thing, and imho must be applied all at the same time.  However,
>     they break up nicely across subsystem lines (drivers, fs, etc)
> 
>   - The per-arch patches are already broken out, and are short.
> 
> I think that with these breakups done the thing would be sufficiently
> digestible to satisfy Linus.  Now that I think of it, Linus's request
> for a breakup is really an endorsement, and quite possibly Keith took
> it the wrong way.  (Keith, by the way, how did I do on the structural
> breakdown?  Sorry, I really couldn't spend as much time on it as it
> deserves.)

Maybe I'm the idiot here but what dose this gain you??

The reason to break up a patch is not simply to get more of them. There
is no point in splitting if you still need to use every single one of
them to make anything work. 

