Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131005AbRCGRtH>; Wed, 7 Mar 2001 12:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131122AbRCGRs5>; Wed, 7 Mar 2001 12:48:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41484 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131005AbRCGRsr>;
	Wed, 7 Mar 2001 12:48:47 -0500
Date: Wed, 7 Mar 2001 18:47:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit capable block device layer
Message-ID: <20010307184749.A4653@suse.de>
In-Reply-To: <Pine.LNX.4.33.0103071432230.1409-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0103071432230.1409-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Mar 07, 2001 at 02:41:17PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Rik van Riel wrote:
> Hi Linus,
> 
> how would you feel about having the block device layer 64-bit
> capable, so Linux can have block devices of more than 2GB in
> size ?
> 
> I know that 64-bit arithmetic is expensive on 32-bit platforms,
> but I have the idea there is a way around that for people who
> don't want 64-bit capable block devices.
> 
> 1. use blkoff_t for all block number arithmetic
> 
> 2. in some header file, have
> 
> #ifdef CONFIG_BLKDEV_64BIT
> typedef long long blkoff_t
> #else
> typedef long blkoff_t
> #endif
> 
> This way, people running smaller&slower machines can chose to
> do the cheaper 32-bit arithmetic and only the people using huge
> block devices will have to do the 64-bit arithmetic.
> 
> (yes, basically the same trick as we're using for PAE)

I already did this here, or something similar at least. Using
a sector_t type that is 64-bit, regardless of platform. Is it
really worth it to differentiate and use 32-bit types for old
machines?

-- 
Jens Axboe

