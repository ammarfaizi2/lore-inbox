Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293133AbSCOTDV>; Fri, 15 Mar 2002 14:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSCOTDB>; Fri, 15 Mar 2002 14:03:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293133AbSCOTCu>; Fri, 15 Mar 2002 14:02:50 -0500
Date: Fri, 15 Mar 2002 11:01:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
In-Reply-To: <20020315103914.M29887@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0203151039440.29289-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Larry McVoy wrote:
> 
> That is *a* sane way to do it and I'm fine with that.  But just because
> you like things to work that way does not mean we will disallow the
> other way.  I *like* the way SCCS works, I can do a "make clobber",
> which nukes all my .o's and does a "bk clean" and do a "ls" to see what
> crud I have left. 

But you could do that even more easily if your work-area was separate.

If you do a "ls" and you get nothing back, you know you didn't have any 
crud.

Having a separate work-area doesn't mean you _have_ to check the stuff 
out.

>		 I personally like going to a tree that has nothing
> but subdirectories in it, typing making, and having it do the right thing.

And you can even get this behaviour too, if you were to just expand the 
(few) tools that know about SCCS to know about BK too. 

Note that it's a lot easier to expand tools that already know about 
revision control than it is to expand tools that have never known about 
it. Just grep for SCCS and make it also look for a BK tree a few 
directories up.

> Neither I nor anyone else will force this mode of working on you.  Not now,
> not ever.  You, in turn, get to respect that some people like this mode and
> accept that it is going to remain one of the ways you can use BK forever.

But the thing is that if you do it my way, you _can_ have it both ways.

If you do it your way, you cannot.

> In addition, our bug database is going to *force* us to offer what you
> want as an option.  LINUS, READ THIS PART.

Oh, I agree - I already pointed out to Jeff that if you use the SCCS 
approach, you can never change your database, which is going to force you 
eventually to come around ;)

Note that there is another way to do all this too: it would be quite nice
(and probably not too hard) to create a filesystem that exports a BK
archive, so that you could do something like

	mount -o ro -tbk /home/BK/repository/xxxx xxx

and at least for the read-only case it should be pretty easy to make an 
intermezzo frontend to bk (ie the kernel part is already done, just the 
user-land server would be needed).

(The read-only one is the easy one to make, the read-write thing is a bit 
more involved, but potentially quite interesting)

> Try
> 
> 	bk -r grep xxxx
> 
> One gotcha, and we'll fix this now that I think of it, is that this only
> greps the revision history.

Oh, I've tried exactly that, and it doesn't work at all for a few reasons. 

Try

	bk -r grep torvalds

in a linux tree, for a flavour of one of the problems. And for a flavour 
of another, one of the things I used to do was

	em $(find . -name '*.[chS]' | xargs grep -l '<\vfs_readdir\>')

which still works, but now I need to remember about not getting SCCS and 
BitKeeper directories, which is a pain, and make sure it's all checked out 
(which is where the filesystem support could be really nice).

Note that the filesystem approach might make your migration path easier:  
you could keep the existing BK database structure (used by the server and
legacy commands)  while migrating out one tool at a time to the "separate
tree" layout. Maybe.

		Linus

