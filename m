Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUCOXw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCOXw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:52:56 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:14990 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262849AbUCOXww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:52:52 -0500
Date: Tue, 16 Mar 2004 00:52:43 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040315235243.GA21416@wohnheim.fh-wedel.de>
References: <20040315161323.GD16615@wohnheim.fh-wedel.de> <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 March 2004 15:22:41 -0400, Horst von Brand wrote:
> =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> > On Mon, 15 March 2004 22:35:20 +0800, Ian Kent wrote:
> 
> > > I don't understand the requirement properly. Sorry.
> 
> > Depends on who you ask, but imo it boils down to this:
> > - Use one filesystem as backing store, usually ro.
> > - Have another filesystem on top for extra functionality, usually rw
> >   access.
> > 
> > Famous example is a rw-CDROM, where writes go to hard drive and
> > unchanged data is read from CDROM.  But it makes sense for other
> > things as well.
> 
> And what if the underlying filesystem is RW too? What should happen if you
> unite several (>= 3) filesystems? What if some are RO, others RW? What do
> you do if a file shows up several times, each different?
> 
> Assuming one RW on top of a RO only now: What should happen when a
> file/directory is missing from the top? If the bottom one "shows through",
> you can't delete anything; if it doesn't, you win nothing (because you will
> have to keep a complete copy RW on top).

What looks like a promising idea for this problem and others is to
have visible and invisible inodes.  All current filesystems know only
visible inodes.  Invisible ones have no dentry linking to them
directly, only indirectly through files/links with cow semantics.

Ok, when the underlying filesystem is rw, each file linked from the
caching fs has to be broken up into visible and invisible inodes.  The
visible link from both filesystems is to the invisible inode and
writes to either one have to cow.

Three or more filesystems?  No problem, same as above.
Mixed ro and rw?  No problem, same as above.
Files "showing through"?  Doesn't happen if you do the equivalent of
"cp -l" - directories are copied, files are linked.

Solves all of your problems so far.  Do you have more?

> IIRC, this has been discussed a couple of times before, and the consensus
> each time was that it isn't /that hard/ to do, it is /hard or impossible/
> to find a sensible, simple semantics for this. The idea was then dropped...

Yeah, maybe.  My personal consensus right now is that this actually
looks very simple.  Not sure how much time I will find, but it should
definitely be finished for 2.8.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
