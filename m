Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281083AbRKOVpt>; Thu, 15 Nov 2001 16:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281093AbRKOVpj>; Thu, 15 Nov 2001 16:45:39 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:48120 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281084AbRKOVp3>; Thu, 15 Nov 2001 16:45:29 -0500
Date: Thu, 15 Nov 2001 21:45:25 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Neil Brown <neilb@cse.unsw.edu.au>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: synchronous mounts
Message-ID: <20011115214525.C14221@redhat.com>
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au>; from akpm@zip.com.au on Thu, Nov 15, 2001 at 12:03:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 15, 2001 at 12:03:57AM -0800, Andrew Morton wrote:
> Linux is not syncing write() data for files on synchronously mounted
> filesystems, and it isn't syncing write() data for ext2/3 files which
> are operating under `chattr +S'.

In the past, chattr +S and mount -o sync always resulted in sync
metadata with no guarantees about data. 

I'm not sure this makes much sense, but it's what has always happened.
For directories, the behaviour is fine, in particular as it gives us
the same directory sync consistency semantics as synchronous BSD UFS.  

It's not clear to me that chattr/mount sync options make _any_ sense
for regular file metadata.  Rather than tightening up the semantics,
I'd actually prefer to restrict them so that they only apply to
directories.  Users who set the sync bits are usually doing so for
applications like MTAs where it's directory syncing which is
what matters: the apps typically fsync the files themselves, anyway.
 
> Really, generic_osync_inode() needs to be front-ended by
> an inode_operations method.

Yes.

Cheers,
 Stephen
