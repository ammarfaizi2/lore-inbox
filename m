Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSDEF0v>; Fri, 5 Apr 2002 00:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312294AbSDEF0l>; Fri, 5 Apr 2002 00:26:41 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:25737 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312277AbSDEF0c>; Fri, 5 Apr 2002 00:26:32 -0500
Date: Thu, 4 Apr 2002 22:26:26 -0700
Message-Id: <200204050526.g355QQ102055@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CAD1142.82527917@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Richard Gooch wrote:
> > 
> > >       http://www.atnf.csiro.au/people/rgooch/linux/boot-scripts/
> > 
> > Around 20 seconds or less from when the kernel starts init(8) to when
> > my XDM splash screen is up, last time I checked.
> 
> eww.  You need a doctored filesystem.

Sorry. I'm not sure what you mean. Are you saying that if I had a
doctored FS, then it would be a lot faster? If so, how much? What are
your boot times?

> > > The theory was lovely.  And I tried all sorts of stuff.  But
> > > the bottom line benefit was only about 10%.  The whole thing
> > > was constrained by buffercache seek time - filesytem metadata.
> > 
> > The problem is that you're not listing the metadata blocks when
> > building the database, right? And that's because Linus didn't want
> > such hackery in the kernel. So instead we got the not-very-useful
> > readahead system call.
> 
> No, everything was listed.  pagecache, buffercache.  This
> was pre buffercache-in-pagecache.  I tried lots of stuff,
> including intermingling pagecache and buffercache reads
> in strict LBA order, buffercache first, no buffercache at
> all.  Nothing really helped.  Fact is, all those files are
> sprinkled all over the disk and a short seek is pretty much
> as expensive as a long one.

Bugger.

> > Of course, my boot scripts do the dependency stuff right (actually,
> > it's the changes I made to simpleinit(8) that make it possible).
> 
> Yes, I've looked.  It's nice stuff.  The dependencies are critial.

<blush> Thanks.

> One thing I did do a while back was to set up a new root filesystem
> on a new disk via `tar cf - | (cd /newplace ; tar xf -)'.  But
> before doing this I nobbled ext2's directory placement algorithm so
> subdirectories in the new fs go in the same blockgroup as the
> parent.  This sped boots up quite a bit.  Probably the pagecache
> preload code would work better with that setup.

Yeah. I guess this nobbling isn't likely to make it into the kernel. I
should fiddle with tar sometime to create everything in the one
directory and move stuff around to the final destination. That would
get around the ext2fs placement misfeature (in this context, anyway).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
