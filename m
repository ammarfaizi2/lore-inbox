Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRDWW7M>; Mon, 23 Apr 2001 18:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbRDWW7B>; Mon, 23 Apr 2001 18:59:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37382 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132535AbRDWW6V>;
	Mon, 23 Apr 2001 18:58:21 -0400
Date: Tue, 24 Apr 2001 00:58:09 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: NWFS broken on 2.4.3 -- someone removed WRITERAW
Message-ID: <20010424005809.Y9357@suse.de>
In-Reply-To: <20010423163725.C1131@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010423163725.C1131@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Mon, Apr 23, 2001 at 04:37:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23 2001, Jeff V. Merkey wrote:
> 
> 
> Hey guys,
> 
> Whomever removed WRITERAW has broken NWFS.  WRITE requests call
> _refile_buffer() after the I/O request and take my locally created 
> buffer heads and munge them back into the linux buffer cache, causing
> massive memory corruption in the system.  These buffers don't belong 
> in Linus' buffer cache, they are owned by my LRU and ll_rw_block 
> should not be blindly filing them back into the buffer cache.
> 
> Please put something back in to allow me to write without the buffer
> heads always getting filed into Linus' buffer cache.  This has 
> broken NWFS on 2.4.3 and above.

	bh->b_end_io = my_end_io_handler;
	submit_bh(WRITE, bh);

Be a happy camper.

-- 
Jens Axboe

