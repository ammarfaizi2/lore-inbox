Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283203AbRK2UYA>; Thu, 29 Nov 2001 15:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283267AbRK2UXt>; Thu, 29 Nov 2001 15:23:49 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64780 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283203AbRK2UXf>; Thu, 29 Nov 2001 15:23:35 -0500
Message-ID: <3C069919.E679F1F8@zip.com.au>
Date: Thu, 29 Nov 2001 12:22:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Castle <dalgoda@ix.netcom.com>
CC: kernel list <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: 2.4.14 still not making fs dirty when it should
In-Reply-To: <20011128231504.A26510@elf.ucw.cz> <3C069291.82E205F1@zip.com.au>,
		<3C069291.82E205F1@zip.com.au> <20011129120826.F7992@thune.mrc-home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle wrote:
> 
> On Thu, Nov 29, 2001 at 11:54:57AM -0800, Andrew Morton wrote:
> > Pavel Machek wrote:
> > >
> > > Hi!
> > >
> > > I still can mount / read/write, press reset, and not get fsck on next
> > > reboot. That strongly suggests kernel bug to me.
> >
> > aargh.  I thought that was fixed.  How's this look?
> 
> I'm curious:
> 
> Why would you WANT this?
> 
> I always thought that if you didn't make any fs changes, then it should NOT
> fsck.
> 

What happens is that the superblock is altered in-memory
to say "the filesystem needs checking", but it's not written
out to disk.

So other things can come in, alter the fs, get written out *before*
the superblock and then you crash.  fsck won't be run, and the
filesystem is left in an inconsistent state.

This actually happens.  On a stock RH7.1 setup, you can
hit reset as soon as you get the first login prompt.  fsck
will not be run on reboot.  If you run it by hand, fsck
finds errors.

Andreas, my one-liner was, umm, hasty.  I think you had
a decent fix for this?

-
