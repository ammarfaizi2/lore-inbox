Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293010AbSCOSAA>; Fri, 15 Mar 2002 13:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293022AbSCOR7s>; Fri, 15 Mar 2002 12:59:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293010AbSCOR7n>; Fri, 15 Mar 2002 12:59:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4 and BitKeeper
Date: Fri, 15 Mar 2002 17:58:07 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6tcnf$shg$1@penguin.transmeta.com>
In-Reply-To: <3C90E994.2030702@candelatech.com> <3C90E994.2030702@candelatech.com> <2865.1016190641@redhat.com> <20020315080408.D11940@work.bitmover.com>
X-Trace: palladium.transmeta.com 1016215168 11516 127.0.0.1 (15 Mar 2002 17:59:28 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Mar 2002 17:59:28 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020315080408.D11940@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
>
>Has anyone done this and made it work?  It would save a lot of disk space
>and performance if someone were to so.

Hey, the _sane_ way to do it is to not have all those crappy SCCS
dependencies in all the tools, but to simply make a bk work area be a
real file tree!

Larry, your argument that there are tools that are SCCS-aware is just
not sane. For each tool that is SCCS-aware, I will name a hundred that
are not, and that you're not going to fix. The only sane way to make
_everything_ bitkeeper-aware is to keep the tree checked out and to keep
the bitkeeper files somewhere else.

Right now simple things like command-line completion and

	find . -name '*.[chS]' | xargs grep xxxx

do not work, because they either don't find files or they find the wrong
ones (the internal bitkeeper files etc). 

I'd much rather have a separate working area, ie if my repository is
under ~/BK/repository/kernel/linux-2.5, then the checked out tree would
be under ~/BK/repository/kernel/linux-2.5/workarea, and I would just
have a simple symbolic link from ~/v2.5 to the workarea (and never even
_see_ the BitKeeper files unless I thought I needed to). 

None of this "special tools for normal actions" crap.

			Linus
