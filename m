Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283281AbRK2UmW>; Thu, 29 Nov 2001 15:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283292AbRK2UmL>; Thu, 29 Nov 2001 15:42:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51984 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283281AbRK2UmB>; Thu, 29 Nov 2001 15:42:01 -0500
Message-ID: <3C069D6C.55C6FFC3@zip.com.au>
Date: Thu, 29 Nov 2001 12:41:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Castle <dalgoda@ix.netcom.com>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 still not making fs dirty when it should
In-Reply-To: <20011128231504.A26510@elf.ucw.cz> <3C069291.82E205F1@zip.com.au>, <3C069291.82E205F1@zip.com.au> <20011129120826.F7992@thune.mrc-home.com> <3C069919.E679F1F8@zip.com.au>,
		<3C069919.E679F1F8@zip.com.au> <20011129123522.G7992@thune.mrc-home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle wrote:
> 
> On Thu, Nov 29, 2001 at 12:22:49PM -0800, Andrew Morton wrote:
> > What happens is that the superblock is altered in-memory
> > to say "the filesystem needs checking", but it's not written
> > out to disk.
> >
> > So other things can come in, alter the fs, get written out *before*
> > the superblock and then you crash.  fsck won't be run, and the
> > filesystem is left in an inconsistent state.
> 
> Ok.  I could see this being a bad thing.
> 
> I could also see the easiest thing to implement would be updating the super
> block on mount.
> 
> However, is this a case where Linux tries not to update the superblock
> about being dirty until something has actually changed (ie, be slightly
> smarter), and that's not working, or is the superblock simply not being
> updated on mount?

Linux alters the superblock contents and marks it as needing
writeback immediately, upon mount.  But the write to disk
doesn't actually happen for up to thirty seconds.  We need to
write it to disk immediately, within mount, as soon as we've
set it to say "needs fsck".
