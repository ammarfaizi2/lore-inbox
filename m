Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276465AbRI2IuZ>; Sat, 29 Sep 2001 04:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276467AbRI2IuP>; Sat, 29 Sep 2001 04:50:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3339 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276465AbRI2IuB>; Sat, 29 Sep 2001 04:50:01 -0400
Date: Sat, 29 Sep 2001 10:40:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
Message-ID: <20010929104027.C28329@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010928224001.B1100@bug.ucw.cz> <200109290755.f8T7t7R443599@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109290755.f8T7t7R443599@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [Albert Cahalan]
> >> [Pavel Machek]
> 
> >>> I can't do that: open deleted files.
> >>
> >> Tough luck. Either use the same hack as NFS, or have such files
> >> return -EIO for all operations and give SIGBUS for mappings.
> >> Maybe just refuse to suspend when there are open deleted files.
> >> Oh, just create a name in the filesystem root and use that.
> >> Something like ".8fe4a979.swsusp" would be fine. Whatever!
> >
> > ...and break locking and similar stuff. NFS is not as good as local
> > filesystem.
> 
> Oh well. Network connections die and real-time apps fail too.
> It is important to have safe and useful behavior in the presence
> of arbitrary filesystem modifications. It is very nice to be able
> to use suspend/resume to alternate between two running kernels.
> 
> I wouldn't worry about locking. Write/discard all data on suspend,
> then examine the inode on resume. As long as the inode doesn't
> change by more than the atime, the lock can survive.

And if did? So now semantics is "it somehow works in presence of FS
modifications, but not completely"?

I look at it this way: ability to survive filesystem modifications
would be nice, but it is quite hard to do. (Probably bigger diff than
what I have, now.)

Admitedly, it would also be nice to be able for kernel *to survive
arbitrary fs modifications without suspend-to-disk* -- imagine two
machines sharing one SCSI disk. No other suspend-to-disk
implementation I know of does what you describe. So I treat problems
orthogonal. What you want is usefull (you can do forced unmount that
way), but it is not required for software suspend.
							Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
