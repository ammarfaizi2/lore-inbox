Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUBVJgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUBVJgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:36:13 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:26244 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261208AbUBVJgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:36:10 -0500
Date: Sun, 22 Feb 2004 01:19:06 -0800
From: Paul Jackson <pj@sgi.com>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE and locking
Message-Id: <20040222011906.43edc7f4.pj@sgi.com>
In-Reply-To: <4030ACA3.6020009@draigBrady.com>
References: <4030ACA3.6020009@draigBrady.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't answer your real question, but I can't resist
noticing that the above would be more efficient as:

  find / -type f | xargs wc >/dev/null

Several times fewer system calls, with just a few exec's of 'wc',
instead of exec'ing a 'dd' per file, and with just one read per 16 Kb,
instead of both a read and write per 512 bytes.

Granted - I'm being silly to mention this - your compact flash
device is obviously the bottleneck here.  Doesn't really matter
if the cpu spends 1% or 2% of its time outside the idle loop.


> 4. Is there a max number of files that can be cached by linux?

As long as there is no memory pressure, I suspect it keeps caching
more.

> 5. Will the files be removed at any stage from the cache
>     if there is no memory pressure?

I don't think so - stuff seems to stay in cache 'forever',
if no one else wants the memory.

> 6. Can I reserve memory for the file cache?

Not that I know of.  If it were read-only data, I might try a ram disk,
but your application apparently is read-write.

It might be (long shot, here) that just caching the directories and
inodes was enough, without caching the file contents:

  find / ! -true


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
