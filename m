Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRCHMRN>; Thu, 8 Mar 2001 07:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131345AbRCHMRD>; Thu, 8 Mar 2001 07:17:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:19918 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131344AbRCHMQt>;
	Thu, 8 Mar 2001 07:16:49 -0500
Date: Thu, 8 Mar 2001 12:14:17 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit capable block device layer
Message-ID: <20010308121417.B14121@redhat.com>
In-Reply-To: <20010307184749.A4653@suse.de> <Pine.LNX.4.33.0103071504250.1409-100000@duckman.distro.conectiva> <20010307195323.D4653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010307195323.D4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 07:53:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 07, 2001 at 07:53:23PM +0100, Jens Axboe wrote:
> > 
> > OTOH, I'm not sure what problems it could give to make this
> > a compile-time option...
> 
> Plus compile time options are nasty :-). It would probably make
> bigger sense to completely skip all the merging etc for low end
> machines. I think they already do this for embedded kernels (ie
> removing ll_rw_blk.c and elevator.c). That avoids most of the
> 64-bit arithmetic anyway.

It's not just a sector-number and ll_rw_blk/elevator issue.  The limit
goes all the way up to the users of the block device, be they the
filesystem, buffer cache or block read/write layer.  

This is especially true for filesystems like XFS which need a 512-byte
blocksize.  At least with ext2 you can set the blocksize to 4kB and
get some of the benefit of larger block devices without having to
overflow the 32-bit block number.

Cheers,
 Stephen
