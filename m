Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283381AbRK2ShZ>; Thu, 29 Nov 2001 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283384AbRK2ShQ>; Thu, 29 Nov 2001 13:37:16 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:18425 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283381AbRK2ShM>;
	Thu, 29 Nov 2001 13:37:12 -0500
Date: Thu, 29 Nov 2001 11:36:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
Cc: Oktay Akbal <oktay.akbal@s-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16 revisited
Message-ID: <20011129113655.L29249@lynx.no>
Mail-Followup-To: "Nathan G. Grennan" <ngrennan@okcforum.org>,
	Oktay Akbal <oktay.akbal@s-tec.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0111291904190.2184-100000@omega.hbh.net> <1007057769.1528.7.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1007057769.1528.7.camel@cygnusx-1.okcforum.org>; from ngrennan@okcforum.org on Thu, Nov 29, 2001 at 12:16:07PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2001  12:16 -0600, Nathan G. Grennan wrote:
> On Thu, 2001-11-29 at 12:09, Oktay Akbal wrote:
> > Why do you think that fstab matters for root-fs ? root-fs needs to be 
> > mounted to read fstab. So autodetection must be done for root-fs.
> > And if the fs has a journal it is ext3.
> 
> Actually, I think it should respect fstab. It does mount it, then fsck
> it while mounted read-only, then remounts(key point) read-write. IMHO it
> should remount it with whatever fstab says. I realize this could be a
> little tricky, but I bet doable.

Well, then you would be wrong.  The only case where this really matters
is if you are using ext3/ext2 because all other cases will be autodetected
as only a single fs type (OK, maybe msdos/vfat, but who would use that as
root, I don't know, and it still has the same issues).

Once the root filesystem is mounted, and init (+ rc.sysinit or whatever
your startup scripts are) is run, your filesystem is in use.  How do you
expect to remount it as a different filesystem while it is in use?  Note
that _today's_ ext2 and ext3 are totally separate drivers, so you cannot
"remount" from one driver to another.  Maybe in the future it would be
possible for the ext3 filesystem driver to support ext2 (i.e. unjournaled),
but not today, and it would be even less likely to allow stopping journaling
on the filesystem once it is started (journaling is complex business).

> > If you do not want that  behaviour
> > you might use a option to lilo, but I don't know of any option to specify
> > the root-fs-tyoe. Or you need to use an initrd to mount explicit as ext2
> > and pivot-root it to / ?

Well, the lilo option you want is "rootfstype=ext2".  It is part of 2.4.15.
Put it into an "append=" statement in lilo (per kernel, or global).  Even
so, 99.9% of people who can use ext3 do not want to go back to ext2.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

