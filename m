Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272218AbRIKAF4>; Mon, 10 Sep 2001 20:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272209AbRIKAFq>; Mon, 10 Sep 2001 20:05:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:35089 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272213AbRIKAFd>; Mon, 10 Sep 2001 20:05:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 01:20:50 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109101439261.1034-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109101439261.1034-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911000547Z16588-26185+142@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 12:15 am, Linus Torvalds wrote:
> However, physical read-ahead really isn't the answer here. I bet you could
> cut your time down with it, agreed. But you'd hurt a lot of other loads,
> and it really depends on nice layout on disk. Plus you wouldn't even know
> where to put the data you read-ahead: you only have the physical address,
> not the logical address, and the page-cache is purely logically indexed..

You leave it in the buffer cache and the page cache checks for it there 
before deciding it has to hit the disk.

For coherency, getblk has to check for the block in the page cache.  We can 
this implement using the buffer hash chain links, currently unused for page 
cache buffers.

--
Daniel
