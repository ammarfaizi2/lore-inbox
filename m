Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRGaQgO>; Tue, 31 Jul 2001 12:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269355AbRGaQfw>; Tue, 31 Jul 2001 12:35:52 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:6801 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269354AbRGaQfo>; Tue, 31 Jul 2001 12:35:44 -0400
Date: Tue, 31 Jul 2001 17:35:51 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Lawrence Greenfield <leg+@andrew.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010731184003.X2650@mea-ext.zmailer.org>
Message-ID: <Pine.SOL.3.96.1010731173046.24991B-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Matti Aarnio wrote:

>   The thing about filesystems, and how dimmly MTAs (should) consider
>   some performance tweaks is something I have tried to describe at
>   ZMailer's manual in part about its the queue:
> 
>       http://www.zmailer.org/zman/zadm-queues.html
> 
> On Tue, Jul 31, 2001 at 01:25:06AM -0400, Lawrence Greenfield wrote:
> ...
> > It's not as good as fsync() just doing what it's suppose to do.
> > You'll force applications that want to issue multiple link()s to issue
> > multiple lsync()s, forcing the kernel to serialize all of the disk
> > writes when the application just wants one file (and all of it's
> > associated filenames) to disk.
> > 
> > Yes, I understand that implementing fsync() so that it syncs all names
> > to reach the file is difficult.  But if you want the best performance,
> > you don't want to make applications issue multiple calls each of which
> > force their own synchronous writes.
> > 
> > Not to mention us whiny application writers won't be happy throwing
> > lsync()s all over the place.
> > 
> > Larry
> 
>    I quite agree.
> 
>    Filesystems are not, unfortunately, rollbackfull logged and committable
>    databases, even if we like to use them often in that way.

Well it depends on which file system you are talking about. NTFS is for
all intents and purposes a rollbackfull logged and committable
(relational) database and a file system at the same time. It's a shame M$
don't release the specs for it, otherwise it would be just what you are
looking for. - It will take us forever to reverse engineer the
journalling part of NTFS. You can see how long it is taking us just to
get the actual file system part.. and journalling on top of that is going
to be even worse. (Of course once we have the file system part there is
nothing to stop us doing our own thing with respect to journalling but
that's a different discussion.)

Anton

> 
>    An MTA with a fundamental design point of not using any privileged
>    programs (no suid anything!) and least esoteric technology possible
>    (for wide portability) can only use message submission means available
>    to it everywhere -- implementing the queue inside a database system
>    is definitely a possibility.   Possibly yielding higher performance
>    than one using filesystem for it, but at what cost ??
>    (I am thinking of SleepyCat DB multiaccess transaction supported
>     version.)
> 
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

