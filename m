Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272531AbRIFTlu>; Thu, 6 Sep 2001 15:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272530AbRIFTli>; Thu, 6 Sep 2001 15:41:38 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:38592 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272527AbRIFTlX>; Thu, 6 Sep 2001 15:41:23 -0400
Date: Thu, 6 Sep 2001 13:41:36 -0600
Message-Id: <200109061941.f86Jfak01921@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Giacomo Catenazzi <cate@dplanet.ch>, linux-kernel@vger.kernel.org
Subject: Re: OOPS[devfs]: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
In-Reply-To: <Pine.GSO.4.21.0109061454480.7097-100000@weyl.math.psu.edu>
In-Reply-To: <3B97744E.7020007@dplanet.ch>
	<Pine.GSO.4.21.0109061454480.7097-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Thu, 6 Sep 2001, Giacomo Catenazzi wrote:
> 
> > Hello.
> > 
> > Since yesterdey, every time I run a 2.4.9 or 2.4.10pre-4 without the 
> > "devfs=nomount" I
> > have two oops + /usr, /home /boot not mounted (all (also /): ext2).
> 
> 	Don't use devfs. One of the known bugs - devfs passes a string
> to vfs_follow_link() and doesn't care to preserve it until
> vfs_follow_link() is done.

Devfs-patch-v186 had my first fix for this. It removes the race on UP
entirely, and has only a small SMP race. So apply the latest devfs
patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

It was released early August.

> E.g. rmmod during the symlink traversal will end up with

Was an rmmod being performed at this time?

> 	And yes, Richard had been informed about that months ago. Sigh...

And my first patch was a month ago. And I've been fixing other races
and doing code cleanups as well. I've been sending Linus my patches
for a month now, but he hasn't applied them. Sigh...

And my current tree has half the code ripped apart as I add
refcounting and spinlocks to key places, and do proper freeing upon
unregister. My apologies for not posting it to the list, but it
doesn't compile yet, and won't for a while.

If people could test the latest devfs patch, that would be really
helpful. Linus isn't applying it because he's concerned that the many
SD support may break something. Even if you don't have many SD's,
please apply the patch and send a message to the list (and Cc: me)
stating whether or not your system still works.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
