Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbREXSP6>; Thu, 24 May 2001 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbREXSPr>; Thu, 24 May 2001 14:15:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:49273 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261684AbREXSPf>; Thu, 24 May 2001 14:15:35 -0400
Date: Thu, 24 May 2001 19:15:18 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, "Stephen C. Tweedie" <sct@redhat.com>,
        Manas Garg <mls@chakpak.net>, linux-kernel@vger.kernel.org
Subject: Re: O_TRUNC problem on a full filesystem
Message-ID: <20010524191518.A7952@redhat.com>
In-Reply-To: <3B0CF068.A6ADA562@uow.edu.au> <200105241724.f4OHOAhQ014259@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105241724.f4OHOAhQ014259@webber.adilger.int>; from adilger@turbolinux.com on Thu, May 24, 2001 at 11:24:10AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 24, 2001 at 11:24:10AM -0600, Andreas Dilger wrote:

> How have you done the ext3 preallocation code? 

Preallocation is currently disabled in ext3.  Eventually I'll probably
get it going by adding a journal prepare-commit callback to allow the
filesystem to flush preallocation before committing.

> One way to do it would be
> to only mark the blocks as used in the in-memory copy of the block bitmap
> and not write that to disk (we keep 2 copies of the block bitmap, IIRC).

Indeed; I'd need to keep 3 copies to make that work.  The state
machine just gets even uglier.  :-)  I thought about it and I might
still end up going that route.

> Did you ever benchmark ext2 with and without preallocation to see if it
> made any difference?  No point in doing extra work if there is no benefit.

The point is not just performance, but also cpu cost (which
preallocation definitely wins on) and on fragmentation if you have
multiple writers in the same directory.

Cheers,
 Stephen 
