Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290080AbSA3QvG>; Wed, 30 Jan 2002 11:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290127AbSA3Qtf>; Wed, 30 Jan 2002 11:49:35 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:62880
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290082AbSA3Qsf>; Wed, 30 Jan 2002 11:48:35 -0500
Date: Wed, 30 Jan 2002 09:47:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130164738.GP25973@opus.bloom.county>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130154233.GK25973@opus.bloom.county> <20020130080308.D18381@work.bitmover.com> <20020130160707.GL25973@opus.bloom.county> <20020130081134.F18381@work.bitmover.com> <20020130161825.GM25973@opus.bloom.county> <20020130083756.I23269@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130083756.I23269@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:37:56AM -0800, Larry McVoy wrote:
> > Er, not the pristine tree, the linuxppc_2_4 tree, sorry.  I'll try
> > again.  One of the problems we hit frequently is that we have to move
> > files from linuxppc_2_4_devel into linuxppc_2_4, once they prove stable.
> > But just creating a normal patch, or cp'ing the files means when we pull
> > linuxppc_2_4 back into linuxppc_2_4_devel we get a file conflict, and
> > have to move one of the files (the previously existing one) into the
> > deleted dir.  How do we cleanly move just a few files from a child tree
> > into the parent?  I think this is a lot like what would happen, if Linus
> > used BK and we wanted to send him support for some platforms, but not
> > all of the other changes we have.
> 
> BitKeeper is like a distributed, replicated file system with atomic changes.
> That has certain advantages, much like a database.  What you are asking 
> violates the database rules, if I understand you properly.  Are you asking
> to move part of a changeset?  That's a no no, that's like moving the 
> increment to your bank account without the decrement to mine; the banks
> frown on that :-)
> 
> Or are you asking more about the out of order stuff, i.e., whole changesets
> are fine but not all of them.

Unfortunatly I think the PPC tree has hit both cases :)  The restriction
that everything gets moved as a changeset is fine tho. One problem is
an out-of-order (or rather a single) changeset which creates a few
files.

The other problem is we create a file (say
arch/ppc/kernel/prpmc750_setup.c) and then 4-5 changesets effect this
file (code, code, bk mv, code, code).  If this is doable in multiple
out-of-order sends to the parent, that'd probably be OK.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
