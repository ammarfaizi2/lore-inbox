Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289347AbSA3QDg>; Wed, 30 Jan 2002 11:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSA3QD0>; Wed, 30 Jan 2002 11:03:26 -0500
Received: from bitmover.com ([192.132.92.2]:18597 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289359AbSA3QDN>;
	Wed, 30 Jan 2002 11:03:13 -0500
Date: Wed, 30 Jan 2002 08:03:08 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130080308.D18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130154233.GK25973@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130154233.GK25973@opus.bloom.county>; from trini@kernel.crashing.org on Wed, Jan 30, 2002 at 08:42:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> It does in some ways anyhow.  Following things downstream is rather
> painless, but one of the things we in the PPC tree hit alot is when we
> have a new file in one of the sub trees and want to move it up to the
> 'stable' tree

Summary: only an issue because Linus isn't using BK.

Details:

The source of this problem is that there is no Linux/BK tree.  To 
understand, read on.  The PPC team "tracks" the kernel using BK.
There is a paper with pictures describing what they do at 

	http://www.bitkeeper.com/tracking.ps

To do this, they have a BK repository which is the "pristine" source,
i.e., it has nothing but released code from Linus.  They import new work
into that repository using "bk import -tpatch" which takes traditional
patches.

There is a "child" repository which is a copy of the "pristine".  The
child repository is used to hold not only the pristine work but also
all the work from the PPC team.  Think of it as "Linux+PPC".

To get patches back to Linus, the PPC maintainer (used to be Cort, now
Paul) will export changes as a traditional patch from the "Linux+PPC"
repository and send them to Linus.  These changes, sometimes modified,
make their way back to the PPC team through the "pristine" tree.  That's
the source of the problem.  

So the work flow is

	patches -> pristine
		      v
		      v
		   Linux+PPC -> patches to Linus

The problem is when a file is created in the Linux+PPC tree, sent to Linus,
comes back as a patch, is imported in pristine, and then is sent to 
Linux+PPC.

BitKeeper tracks files just like a file system, by a BK form of an inode.
That file that came in as a patch is a different inode, what is logically
the same file was created twice.  Much like if you created foo and bar
and then said "mv foo bar", BitKeeper will complain at you that the file
exists already.

This problem goes away if the PPC team could send Linus BK patches and 
Linus sent out his changes as BK patches.  It doesn't require a wholesale
switch to BK, Linus can still take traditional patches and send them out,
but if he maintained a BK tree as well, the problem Troy described goes
away.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
