Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbRHAQC5>; Wed, 1 Aug 2001 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbRHAQCi>; Wed, 1 Aug 2001 12:02:38 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12046 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267405AbRHAQCb>; Wed, 1 Aug 2001 12:02:31 -0400
Date: Wed, 1 Aug 2001 17:02:30 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010801170230.B7053@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <9jpea7$s25$1@penguin.transmeta.com> <20010731025700.G28253@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010731025700.G28253@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Tue, Jul 31, 2001 at 02:57:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Chase up to the root manually, because Linux' ext2 violates SUS v2
> fsync() (which requires meta data synched BTW)

Please quote chapter and verse --- my reading of SUS shows no such
requirement.  

fsync is required to force "all currently queued I/O operations
associated with the file indicated by file descriptor fildes to the
synchronised I/O completion state."  But as you should know, directory
entries and files are NOT the same thing in Unix/SUS.  

Are we expected to fsync the metadata belonging to just the file
itself?  Or all symlinks to the file?  Or all hard links?  Answer, as
best I can determine --- just the file.  That's all SUS talks about.
There can be many ways of reaching that file in the directory
hierarchy, or there can be none, but fsync() doesn't talk at all about
the status of those dirents after the sync.

> , as has been pointed out
> (and fixed in ReiserFS and ext3)?

ext3 happens to provide the guarantee, but that's coincidental and
does not imply that I think of it as being "fixed".  It's just changed
behaviour relative to ext2.

> So, please tell my why Single Unix Specification v2 specifies EIO for
> rename. Asynchronous I/O cannot possibly trigger immediate EIO.

Yes it can --- we may need to read metadata to complete the rename,
and such reads can fail.  

Cheers,
 Stephen
