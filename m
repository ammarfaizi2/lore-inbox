Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbREPQhY>; Wed, 16 May 2001 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262004AbREPQhO>; Wed, 16 May 2001 12:37:14 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:23303 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S261276AbREPQhF>; Wed, 16 May 2001 12:37:05 -0400
Date: Wed, 16 May 2001 12:18:15 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516121815.B16609@munchkin.spectacle-pond.org>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <990030651.932.3.camel@agate>; from miles@megapathdsl.net on Wed, May 16, 2001 at 09:30:46AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 09:30:46AM -0700, Miles Lane wrote:
> On 16 May 2001 15:28:03 +0200, Helge Hafting wrote:
> > Oystein Viggen wrote:
> > > 
> > > Quoth Helge Hafting:
> > > 
> > > > This could be extended to non-raid use - i.e. use the "raid autodetect"
> > > > partition type for non-raid as well.  The autodetect routine could
> > > > then create /dev/partitions/home, /dev/partitions/usr or
> > > > /dev/partitions/name_of_my_choice
> > > > for autodetect partitions not participating in a RAID.
> > > 
> > > What happens if I insert a hard drive from another computer which also
> > > has partitions named "home", "usr", and soforth?

With the current LABEL= support, you won't be able to mount the disks with
duplicate labels, but you can still mount them via /dev/sd<xxx>.  Obviously,
you need an escape hatch to do this.  I ran into this with having two root
partitions (to support multiple distributions or releases of distributions),
where the distribution automatically uses LABEL=.  Fortunately, it was fairly
easy to use e2label to fix things up.

> > This is the problem with all sorts of ID-based naming.  In this case
> > the kernel could simply change the conflicting names a bit,
> > and leave the cleanup to the administrator.  (Who probably
> > is around as he just inserted those disks....)
> > 
> > The current scheme have problems if you move a disk
> > from one controller to another, or in some cases
> > if you merely add a new one.  So the question becomes - 
> > what is most likely to go wrong?  And you can be
> > smart and name your partitions /usr21042001, /home03042001
> > and so on in order to minimize the risk of conflicts.
> 
> Well, a usermode solution might be to add support for having the
> filesystem utilities generate and detect partition IDs.  Then the disks
> could be moved from one controller to another, but mount could scan
> partition IDs and associate mount points on matching IDs rather than on
> /dev/hdX or /dev/sdX.

I don't see how this is any different from the current LABEL= support that is
currently in the ext2 filesystem (except I seem to recall that it doesn't work
on devfs).  Of course it would be useful for /proc/partitions to provide the
label IDs and UUIDs.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
