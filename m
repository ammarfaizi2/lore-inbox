Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTJUT1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTJUT1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:27:13 -0400
Received: from a0.complang.tuwien.ac.at ([128.130.173.25]:11281 "EHLO
	a0.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263274AbTJUT1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:27:10 -0400
X-mailer: xrn 9.03-beta-14
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Re: [PATCH] ide write barrier support
To: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <IXzh.61g.5@gated-at.bofh.it>
Date: Tue, 21 Oct 2003 19:24:16 GMT
Message-ID: <2003Oct21.212416@a0.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:
>Completely disabling write back caching on IDE drives totally kills
>performance typically, they are just not meant to be driven this way.

It has a significant performance impact, but I would not call it
"totally kills performance".  In Section 7 of

http://www.complang.tuwien.ac.at/papers/czezatke%26ertl00/

you can find some numbers for ext2 with and without write-back caching
(and for other file systems without write-back caching).  The slowdown
was about a factor 1.5 for an un-tar benchmark and 1 for an rm
benchmark (and of course 1 for the read-dominated tar and find
benchmarks).

IMO the OS should turn off write-back caching on all devices that have
journaling, log-structured or soft-updated file systems mounted,
unless the OS ensures correctness through write barriers, explicit
flushes or somesuch.  I certainly turn off write-back caching on all
drives with ext3 file systems.

So I hope to see write barrier support in the Linux kernel at some
point in the future.

Concerning disk behaviour, I have certainly seen disks (with
write-back caching turned on) that don't write a block for many
seconds, while they write other, later (from the view of the CPU)
blocks.  See

http://www.complang.tuwien.ac.at/anton/hdtest/

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
