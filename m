Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRCPMPP>; Fri, 16 Mar 2001 07:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRCPMPF>; Fri, 16 Mar 2001 07:15:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:4581 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129051AbRCPMO6>;
	Fri, 16 Mar 2001 07:14:58 -0500
Date: Fri, 16 Mar 2001 12:11:47 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Tom Vier <thomassr@erols.com>
Cc: Denis Perchine <dyp@perchine.com>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: O_DSYNC flag for open
Message-ID: <20010316121147.B1771@redhat.com>
In-Reply-To: <01031013035702.00608@dyp.perchine.com> <20010314222642.A19634@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314222642.A19634@zero>; from thomassr@erols.com on Wed, Mar 14, 2001 at 10:26:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 14, 2001 at 10:26:42PM -0500, Tom Vier wrote:
> fdatasync() is the same as fsync(), in linux.

No, in 2.4 fdatasync does the right thing and skips the inode flush if
only the timestamps have changed.

> until fdatasync() is
> implimented (ie, syncs the data only)

fdatasync is required to sync more than just the data: it has to sync
the inode too if any fields other than the timestamps have changed.
So, for appending to files or writing new files from scratch, fsync ==
fdatasync (because each write also changes the inode size).  Only for
updating existing files in place does fdatasync behave differently.

> #ifndef O_DSYNC
> # define O_DSYNC O_SYNC
> #endif

2.4's O_SYNC actually does a fdatasync internally.  This is also the
default behaviour of HPUX, which requires you to set a sysctl variable
if you want O_SYNC to flush timestamp changes to disk.

Cheers,
 Stephen
