Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270198AbRHGMH2>; Tue, 7 Aug 2001 08:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270197AbRHGMHS>; Tue, 7 Aug 2001 08:07:18 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:1000 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270196AbRHGMHK>; Tue, 7 Aug 2001 08:07:10 -0400
Message-Id: <5.1.0.14.2.20010807130325.027f4cf0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 Aug 2001 13:07:17 +0100
To: Ed Tomlinson <tomlins@cam.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] using writepage to start io
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20010807113944.D229E7B53@oscar.casa.dyndns.org>
In-Reply-To: <20010807120234.D4036@redhat.com>
 <755760000.997128720@tiny>
 <01080623182601.01864@starship>
 <20010807120234.D4036@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:39 07/08/01, Ed Tomlinson wrote:
>On August 7, 2001 07:02 am, Stephen C. Tweedie wrote:
> > On Mon, Aug 06, 2001 at 11:18:26PM +0200, Daniel Phillips wrote:
> > FWIW, we've seen big performance degradations in the past when testing
> > different ext3 checkpointing modes.  You can't reuse a disk block in
> > the journal without making sure that the data in it has been flushed
> > to disk, so ext3 does regular checkpointing to flush journaled blocks
> > out.  That can interact very badly with normal VM writeback if you're
> > not careful: having two threads doing the same thing at the same time
> > can just thrash the disk.
> >
> > Parallel sync() calls from multiple processes has shown up the same
> > behaviour on ext2 in the past.  I'd definitely like to see at most one
> > thread of writeback per disk to avoid that.
>
>Be carefull here.  I have a system (solaris) at the office that has 96 drives
>on it.  Do we really want 96 writeback threads?  With 96 drives, suspect the
>bus bandwidth would be the limiting factor.

But we have that situation today already. - There is one thread running for 
each of the md devices in my file server (so I have six threads at moment 
each with the name raid1d) so if you were using the md driver extensively 
to say mirror half of your drives onto the other half you would have 48 
threads running already...

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

