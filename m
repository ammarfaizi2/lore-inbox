Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbRBBRI0>; Fri, 2 Feb 2001 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRBBRIQ>; Fri, 2 Feb 2001 12:08:16 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:53795 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129061AbRBBRIC>; Fri, 2 Feb 2001 12:08:02 -0500
Message-Id: <200102021708.f12H8QC11396@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Arun Rao <rao@pixar.com>
cc: sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org
Subject: Re: Direct (unbuffered) I/O status ... 
In-Reply-To: Message from Arun Rao <rao@pixar.com> 
   of "Thu, 01 Feb 2001 15:35:44 PST." <3A79F2D0.8AA9F02D@pixar.com> 
Date: Fri, 02 Feb 2001 11:08:26 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We're trying to port some code that currently runs on SGI using the IRIX
> direct I/O facility.  From searching the web, it appears that a similar
> feature either already is or will soon be available under Linux.  Could
> anyone fill me in on what the status is?
> 
> (I know about mapping block devices to raw devices, but that alone will
> not work for the application we're contemplating: we'd like conventional
> file-system support as well as unbuffered I/O capability).
> 
> Thanks in advance!
> 
> -Arun
>

I was going to let Stephen Tweedie respond to this one, but since he has
not got to it yet...

Yes there has been talk of implementing filesystem I/O direct between user
memory and the disk device. Stephen's approach was to use similar techniques to
the raw I/O path to lock down the user pages, these would then be placed
in the address space of the inode, and the filesystem would do its usual
thing in terms of read or write. There are lots of end cases to this
which make it more complex than it sounds, what happens if there is already
data in the cache, what happens if someone memory maps the file in the
middle of the I/O and lots of other goodies.

I suspect implementing this is quite a ways off yet, and almost certainly
a 2.5 feature for quite a while before it could possibly get into a 2.4
kernel.

Stephen is the one to give a real explaination of how he sees this working
and when it might be done.

However, given the open source work SGI is doing with XFS, we are pretty much
committed to supporting O_DIRECT on Linux XFS before this. There is
a very basic implementation of O_DIRECT read in the current Linux XFS,
it has not been tested in quite some time (i.e. it may be broken), and it is
not coherent with the buffer cache. I hope we can have this cleaned up and
write implemented in the next month or so.

This would have the added advantage that even if you are moving stuff from
Irix to Linux, you could at least take your existing filesystems with you.

Steve

 
> 
> --
> Arun Rao
> Pixar Animation Studios
> 1200 Park Ave
> Emeryville, CA 94608
> (510) 752-3526
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
