Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270919AbRICBXk>; Sun, 2 Sep 2001 21:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270942AbRICBXa>; Sun, 2 Sep 2001 21:23:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:46095 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270919AbRICBXK>; Sun, 2 Sep 2001 21:23:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: Editing-in-place of a large file
Date: Mon, 3 Sep 2001 03:30:14 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <20010902233008.Q9870@nightmaster.csn.tu-chemnitz.de> <20010902175938.D21576@work.bitmover.com>
In-Reply-To: <20010902175938.D21576@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010903012327Z16086-32383+3082@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 3, 2001 02:59 am, Larry McVoy wrote:
> > What's needed is a generalisation of sparse files and truncate().
> > They both handle similar problems.
> 
> how about 
> 
> 	fzero(int fd, off_t off, size_t len)

sys_clear :-)

> which zeros the blocks and if it can creates a holey file?
> 
> However, that's not what Bob wants, he wants to remove commercials from
> recorded TV.  So what he wants is 
> 
> 	fdelete(int fd, off_t off, size_t len)
> 
> which has the semantics of shifting the rest of the file backwards to "off".
>
> The main problem with this is if the off/len are not block aligned.  If they
> are, then this is just block twiddling, if they aren't, then this is a file
> rewrite anyway.

He could insert blank video frames to pad to the edges of blocks.  Very 
theoretical since we are ages away from having fzero/sys_clear.  Ask Al Viro 
if you want to hear the whole ugly story.  (Executive summary: it's hard 
enough handling remove/create races with just one boundary per file, now try 
it with an unbounded number.)

--
Daniel
