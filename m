Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272811AbRIGTeK>; Fri, 7 Sep 2001 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272817AbRIGTeB>; Fri, 7 Sep 2001 15:34:01 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59331 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272811AbRIGTdu>; Fri, 7 Sep 2001 15:33:50 -0400
Date: Fri, 7 Sep 2001 13:33:51 -0600
Message-Id: <200109071933.f87JXp913517@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: OOPS[devfs]: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
In-Reply-To: <3B993207.787B0D5@dplanet.ch>
In-Reply-To: <3B97744E.7020007@dplanet.ch>
	<Pine.GSO.4.21.0109061454480.7097-100000@weyl.math.psu.edu>
	<200109061941.f86Jfak01921@vindaloo.ras.ucalgary.ca>
	<3B993207.787B0D5@dplanet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi writes:
> Richard Gooch wrote:
> > 
> > Alexander Viro writes:
> > >
> > >
> > > On Thu, 6 Sep 2001, Giacomo Catenazzi wrote:
> > >
> > > > Hello.
> > > >
> > > > Since yesterdey, every time I run a 2.4.9 or 2.4.10pre-4 without the
> > > > "devfs=nomount" I
> > > > have two oops + /usr, /home /boot not mounted (all (also /): ext2).
> > >
> > >       Don't use devfs. One of the known bugs - devfs passes a string
> > > to vfs_follow_link() and doesn't care to preserve it until
> > > vfs_follow_link() is done.
[I said it was fixed for UP in recent devfs patches]
> > If people could test the latest devfs patch, that would be really
> > helpful. Linus isn't applying it because he's concerned that the many
> > SD support may break something. Even if you don't have many SD's,
> > please apply the patch and send a message to the list (and Cc: me)
> > stating whether or not your system still works.
> 
> No, your patch  didn't work.
> I have still the oops.

Hm! Is this a UP or SMP kernel?

> I investigates, and the oops come in the mountall script (in init.d),
> when running: mount -avt nonfs,nosmbfs.
> (I noticed thet at this point kernel load floppy modules, but when I
> removed also the floppy module, the oops reappers.)

Hm. I've had one other bug report which initially seemed to be
devfs-related, but it was also related to the floppy driver as
well. IIRC, elsewhere Alan noted there seemed to be some problems with
the floppy driver. I suspect the bug you (and the other person) are
having is related to the floppy driver and not devfs.

Please try renaming/removing your floppy driver and see if the problem
persists. I bet it goes away. As Al mused, it was odd that the problem
only appears now. While there are known races in devfs, no-one has
ever encountered these in real life (targetted exploits are not "real
life"). So I too am surprised that suddenly there appears a problem
with devfs.

In the meantime, my tree is getting closer to the stage where I will
attempt a compile. Soon I will be able to dispel this dark cloud of
"devfs races" that Al keeps muttering about :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
