Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263670AbREYJmk>; Fri, 25 May 2001 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263672AbREYJma>; Fri, 25 May 2001 05:42:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:40531 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263670AbREYJmW>; Fri, 25 May 2001 05:42:22 -0400
Date: Fri, 25 May 2001 10:42:03 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Manas Garg <mls@chakpak.net>,
        linux-kernel@vger.kernel.org
Subject: Re: O_TRUNC problem on a full filesystem
Message-ID: <20010525104203.F7952@redhat.com>
In-Reply-To: <3B0CF068.A6ADA562@uow.edu.au> <200105241724.f4OHOAhQ014259@webber.adilger.int> <3B0DA651.8151AE93@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0DA651.8151AE93@uow.edu.au>; from andrewm@uow.edu.au on Fri, May 25, 2001 at 10:24:49AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 25, 2001 at 10:24:49AM +1000, Andrew Morton wrote:

> For example, when we miss the goal block we search forward
> up to 63 blocks for a *single* free block, and use that.
> Perhaps we shouldn't?

The reasoning here is that it's much cheaper to go to a single block
which is very nearby than to be forced to use that single block later
on as part of some distant file once the disk becomes fuller.  It's a
sort of opportunistic fragmentation: if we can sneak in a disk
allocation that uses the awkward block without requiring a seek (and
in all likelihood coming out of the track buffer), then we reduce the
overall impact on performance of that isolated free block.

> And perhaps the search for eight contiguous free blocks
> is no longer appropriate to current disks.  32 may be better?

I've thought about that but today we're usually allocating in 4k
chunks rather than 1k so it's normally a 32k preallocation which we
get, anyway.

Cheers,
 Stephen
