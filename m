Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSDJJ2P>; Wed, 10 Apr 2002 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDJJ2O>; Wed, 10 Apr 2002 05:28:14 -0400
Received: from dsl-213-023-030-077.arcor-ip.net ([213.23.30.77]:47013 "EHLO
	duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S312484AbSDJJ2O>; Wed, 10 Apr 2002 05:28:14 -0400
Date: Wed, 10 Apr 2002 11:28:07 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Alexis S. L. Carvalho" <alexis@cecm.usp.br>, linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020410092807.GA4015@duron.intern.kubla.de>
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <200204100041.g3A0fSj00928@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 08:41:28PM -0400, Albert D. Cahalan wrote:
...
> While ext2 fsck doesn't guarantee anything, in practice it is far
> more reliable than ufs fsck. If you change the algorithms to be
> like those used by BSD, then you may lose some of the ability to
> recover. Remember, fsck isn't just for power failures. It tries
> to piece together a filesystem that has suffered disk corruption
> caused by attackers, kernel bugs, fdisk screwups, MS-DOS writing
> past the end of a partition, Windows NT Disk Manager, viruses,
> disk head crashes, and every other cause you can imagine. If you
> change fsck to make BSD-style assumptions about write ordering,
> you weaken the ability to deal with disasters.

I disagree. In fact the current  BSD softupdate code guarantees that all
that ever  happens is that  freed blocks are  not entered into  the free
block list. Something  fsck can fix in background on  a life system. See
M. Kirk McKusicks BSDcon 02 paper 'Running fsck in background.'

Your argument  that faulty hardware  may create havoc with  your on-disk
data structures  is something every  file system  is prone to  unless it
uses  a  raw-read-after-write  for checking  purposes.  Something  which
definitely kills disk performance.

The background  fsck capability, just  like journalling or  logging, are
typically only in needed in 24/7 systems (sure, they are nice to have in
your home  system, but do  you _REALLY_ need  them? i don't!)  and those
system  typically are  run on  proven  hardware which  is operated  well
within the specs. So please don't construct these kinds of arguments.

The fact that the BSD FFS in it's currently released version (which does
not include snapshot and background fsck capability) is considered to be
one of the more reliable file  systems around, even when softupdates are
enabled, speaks  for itself.  So please  just as  you don't  want horror
stories about Linux ext2 spread: don't do it yourself.

Alexis, if you're looking for a rewarding Linux project, don't focus too
much  on softupdates,  the majority  of linux  users/developers couldn't
care less.  I wonder  sometimes if  this is perhaps  because BSD  did it
first?

Read  M. Kirk  McKusick's  paper  on fsck  and  snapshots  (it's in  the
proceedings  of this  years BSDcon,  available from Usenix)  and try  to
implement the snapshot capability for  ext2/ext3. Everyone of us who has
to do live backups of production systems  will thank you if you get that
development started. I  found that Mr. McKusick is somebody  who is very
helpful towards people  trying to understand his work, so  you might get
help  from  him  if you  get  stuck.  OTOH  if  you avoid  the  buzzword
'softupdates' many Linux file system  hackers will be much more inclined
to help you out with the Linux part.

Yours,
  Dominik Kubla
-- 
"Those who would give up essential Liberty to purchase a little
temporary Safety deserve neither Liberty nor Safety." (Benjamin Franklin)
