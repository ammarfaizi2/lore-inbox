Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281118AbRKOWDt>; Thu, 15 Nov 2001 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281124AbRKOWDj>; Thu, 15 Nov 2001 17:03:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21001 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281118AbRKOWDa>; Thu, 15 Nov 2001 17:03:30 -0500
Message-ID: <3BF43B8E.51A809D1@zip.com.au>
Date: Thu, 15 Nov 2001 14:02:54 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: synchronous mounts
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au>,
		<3BF376EC.EA9B03C8@zip.com.au>; from akpm@zip.com.au on Thu, Nov 15, 2001 at 12:03:57AM -0800 <20011115214525.C14221@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Thu, Nov 15, 2001 at 12:03:57AM -0800, Andrew Morton wrote:
> > Linux is not syncing write() data for files on synchronously mounted
> > filesystems, and it isn't syncing write() data for ext2/3 files which
> > are operating under `chattr +S'.
> 
> In the past, chattr +S and mount -o sync always resulted in sync
> metadata with no guarantees about data.
> 
> I'm not sure this makes much sense, but it's what has always happened.
> For directories, the behaviour is fine, in particular as it gives us
> the same directory sync consistency semantics as synchronous BSD UFS.
> 
> It's not clear to me that chattr/mount sync options make _any_ sense
> for regular file metadata.  Rather than tightening up the semantics,
> I'd actually prefer to restrict them so that they only apply to
> directories.  Users who set the sync bits are usually doing so for
> applications like MTAs where it's directory syncing which is
> what matters: the apps typically fsync the files themselves, anyway.
> 

OK, that makes sense.  Thanks.  The `mount' and `chattr' manpages
need updating...

So shall we try to nail this down?  Synchronous mounts and chattr +S
provide synchronous semantics for directory contents, diretory metadata
and directory inodes only.  And fsync() will write out a file's data,
metadata and inode?

If this is correct then there are a few places where ext2 is
syncing stuff unnecessarily - file indirect blocks, etc.  Not
very important at this stage I guess.

-
