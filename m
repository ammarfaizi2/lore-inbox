Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSJVOkX>; Tue, 22 Oct 2002 10:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSJVOkX>; Tue, 22 Oct 2002 10:40:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262721AbSJVOkW>;
	Tue, 22 Oct 2002 10:40:22 -0400
Date: Tue, 22 Oct 2002 07:43:49 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jens Axboe <axboe@suse.de>
cc: Suparna Bhattacharya <suparna@sparklet.in.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
In-Reply-To: <20021022094911.GE30597@suse.de>
Message-ID: <Pine.LNX.4.33L2.0210220743030.13752-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Jens Axboe wrote:

| On Tue, Oct 22 2002, Suparna Bhattacharya wrote:
| > On Mon, 21 Oct 2002 19:43:20 +0530, Christoph Hellwig wrote:
| >
| >
| > >> +
| > >> +	if ((dump_bio = kmalloc(sizeof(struct bio), GFP_KERNEL)) == NULL) { +
| > >> 	DUMP_PRINTF("Cannot allocate bio\n"); +		retval = -ENOMEM;
| > >> +		goto err2;
| > >> +	}
| > >
| > > Shouldn't you use the generic bio allocator?
| > >
| >
| > Not sure that this should come from the bio mempool. Objects
| > allocated from the mem pool are expected to be released back to
| > the pool within a reasonable period (after i/o is done), which is
| > not quite the case here.
| >
| > Dump preallocates the bio early when configured and holds on to
| > it all through the time the system is up (avoids allocs at
| > actual dump time). Doesn't seem like the right thing to hold
| > on to a bio mempool element that long.
|
| Definitely, one must not use the bio pool for long term allocations.

"must not" ?

what happens if one does do that?  [not suggesting doing that]

-- 
~Randy

