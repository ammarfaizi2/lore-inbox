Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273146AbRIJCHu>; Sun, 9 Sep 2001 22:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273139AbRIJCHk>; Sun, 9 Sep 2001 22:07:40 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:5907 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273143AbRIJCHf>; Sun, 9 Sep 2001 22:07:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 04:15:01 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org> <1299510000.1000086297@tiny> <20010910035519.B11329@athlon.random>
In-Reply-To: <20010910035519.B11329@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910020752Z16066-26184+197@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 03:55 am, Andrea Arcangeli wrote:
> getblk should unconditionally alloc a new bh entity and only care to map
> it to the right cache backing store with a pagecache hash lookup.

To feel anything like the original the new getblk has to be idempotent: 
subsequent calls return the same block.

Another issue: we need to be able to find the appropriate mapping for the 
getblk.  That means either looking it up in yet another [major][minor] vector 
or changing the type of the argument to getblk, which is not as painful as it 
sounds because it isn't used in very many places any more.

--
Daniel
