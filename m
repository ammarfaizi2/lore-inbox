Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUCPTDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUCPTDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:03:55 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:14989 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261221AbUCPTDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:03:48 -0500
Date: Tue, 16 Mar 2004 13:03:46 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040316190346.GC20793@hexapodia.org>
References: <20040315161323.GD16615@wohnheim.fh-wedel.de> <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your "what are the semantics?" arguments are mysterious to me, Horst.  I
don't know that unionfs is a good idea, but there are trivial solutions
to the problems you suggest.  The fact that a facility can be used to
create untenable situations does not mean that the facility is useless.

On Mon, Mar 15, 2004 at 03:22:41PM -0400, Horst von Brand wrote:
> =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> > On Mon, 15 March 2004 22:35:20 +0800, Ian Kent wrote:
> > > I don't understand the requirement properly. Sorry.
> > Depends on who you ask, but imo it boils down to this:
> > - Use one filesystem as backing store, usually ro.
> > - Have another filesystem on top for extra functionality, usually rw
> >   access.
> > 
> > Famous example is a rw-CDROM, where writes go to hard drive and
> > unchanged data is read from CDROM.  But it makes sense for other
> > things as well.
> 
> And what if the underlying filesystem is RW too?

Only the topmost layer of a "union stack" should be RW.  If you manage
to write to an underlying FS, it is akin to writing to the block device
underlying a normal FS -- the behavior is undefined.

> What should happen if you unite several (>= 3) filesystems?  What if
> some are RO, others RW?

Given that only the topmost is RW, it Just Works.

> What do you do if a file shows up several times, each different?

The topmost entry wins.

> Assuming one RW on top of a RO only now: What should happen when a
> file/directory is missing from the top? If the bottom one "shows through",
> you can't delete anything; if it doesn't, you win nothing (because you will
> have to keep a complete copy RW on top).

If a directory entry is missing, the next lower layer is consulted.
Delete is implemented with "white-out" directory entries -- a directory
entry in the topmost FS which has special meaning, "return -ENOENT
immediately without consulting FSs underlying me".

> IIRC, this has been discussed a couple of times before, and the consensus
> each time was that it isn't /that hard/ to do, it is /hard or impossible/
> to find a sensible, simple semantics for this. The idea was then dropped...

The semantics of BSD unionfs are fairly well-defined and useful in at
least some circumstances.

References:

J. S. Pendry and M. K. McKusick.  Union mounts in 4.4BSD-Lite.
In Proceedings of the USENIX Technical Conference on UNIX and Advanced
Computing Systems, pages 25­33, December 1995.
http://www.usenix.org/publications/library/proceedings/neworl/full_papers/mckusick.a

-andy
