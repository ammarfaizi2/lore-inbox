Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSDECSw>; Thu, 4 Apr 2002 21:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311273AbSDECSn>; Thu, 4 Apr 2002 21:18:43 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29320 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311270AbSDECS1>; Thu, 4 Apr 2002 21:18:27 -0500
Date: Thu, 4 Apr 2002 19:18:21 -0700
Message-Id: <200204050218.g352ILY32221@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CACEF18.CE742314@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Joe, you're speaking to a bunch of people who reboot their
> boxes ten times an hour or more.  It's an interesting topic.
> 
> If you want to get really radical you could investigate
> Richard Gooch's boot scripts which I believe allow all the
> initscripts to be launched in parallel.  Which is a good
> thing to do.
> 
> 	http://www.atnf.csiro.au/people/rgooch/linux/boot-scripts/

Around 20 seconds or less from when the kernel starts init(8) to when
my XDM splash screen is up, last time I checked.

> Last year I developed a bunch of code which was designed to
> speed up the boot process.  It works as follows:
> 
> 1: Boot the machine, start your X server or whatever you
>    normally do.  Wait for everything to settle down.
> 
> 2: Load a kernel module and run a userspace app which dumps
>    out a directory of your pagecache and buffercache contents
>    to a database file.  It's of the form:
> 
> 	filename:page,page,page,page and
> 	device:block,block,block,
> 
>    The database file is sorted in ascending block order.
> 
> 3: Next time you reboot, load a different kernel module and
>    run a different userspace app which together walk that
>    database and preload the pagecache and buffercache.
> 
> The theory was lovely.  And I tried all sorts of stuff.  But
> the bottom line benefit was only about 10%.  The whole thing
> was constrained by buffercache seek time - filesytem metadata.

The problem is that you're not listing the metadata blocks when
building the database, right? And that's because Linus didn't want
such hackery in the kernel. So instead we got the not-very-useful
readahead system call.

> Oh well.  The best benefit was in fact from launching all
> the initscripts in parallel.  Lots of stuff broke because
> of the lack of any sort of dependency system, but it was
> appreciably quicker.

Of course, my boot scripts do the dependency stuff right (actually,
it's the changes I made to simpleinit(8) that make it possible).

> I guess the greatest benefit would come from reorganising the
> layout of the root filesystem's data and metadata so the
> pagecache prepopulation doesn't have to seek all over the place.

Or being able to preload *everything* in ascending order...

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
