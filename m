Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131242AbQKPR4C>; Thu, 16 Nov 2000 12:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbQKPRzv>; Thu, 16 Nov 2000 12:55:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131221AbQKPRzc>;
	Thu, 16 Nov 2000 12:55:32 -0500
Date: Thu, 16 Nov 2000 18:25:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: patch: loop remapper
Message-ID: <20001116182526.A848@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes loop work like a block remapper. It was started
yesterday due to me trying to solve the (chronic) loop deadlocks
that have plauged 2.3/2.4 for ages. It has several advantages over
the old request handling:

* loop doesn't eat request slots. This alone saves run time memory
  requirements (standard is 256 request slots per queue)
* don't have to fight block layer wrt merging, plugging, etc
* much faster, loop doesn't serialize I/O requests anymore. This also
  allows the target device elevator to work a lot better.

People having loop problems, please give this a go. It may still have
a few 'issues', but I bet they are solvable now. If you are asking
'why' when seeing this patch, I urge you to

vi drivers/block/loop.c
/do_lo_request

and have a barf bag ready.

The builtin transfer functions (none and xor) work with the changes,
but external crypto additions may not. The reason is that the raw
buf and loop buf passed to them can now be identical (the previous
version always used getblk() to get a new buffer to work on).

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11-pre5/loop-remap-2.bz2

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
