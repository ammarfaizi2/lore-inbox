Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbRHAQC5>; Wed, 1 Aug 2001 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbRHAQCi>; Wed, 1 Aug 2001 12:02:38 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:18190 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267418AbRHAQCd>; Wed, 1 Aug 2001 12:02:33 -0400
Date: Wed, 1 Aug 2001 16:51:53 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010801165153.A7053@redhat.com>
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com>, <20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au> <3B60EDD3.2CE54732@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B60EDD3.2CE54732@zip.com.au>; from akpm@zip.com.au on Fri, Jul 27, 2001 at 02:28:03PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 27, 2001 at 02:28:03PM +1000, Andrew Morton wrote:

> I believe that `dirsync' would provide synchronous metadata
> operations (ie: the metadata is crashproofed on-disk when
> the syscall returns), but non-sync data.  Correct?

Not quite: dirsync would provide synchronous metadata operations on
directories, but would make no guarantees about other file types.
That way we don't have the cost of doing sync updates to the inodes or
indirect blocks of regular files --- fsync() is adequate to do that on
demand.

Of course, fsync() is also sufficient to do syncing of directory
operations on demand, but it's a bit heavyweight for that purpose,
hence the request for dirsync (either as a chattr flag or as a mount
option.)

> If, however, the application is capable of doing a nice big
> write() (setvbuf!) then really, the two things will be pretty
> much the same.

Almost --- it's the same for create+write+close+fsync, but not for
rename or for unlink (in which case there's not necessarily going to
be a data fsync to force the directory operation out to disk.)

Cheers,
 Stephen
