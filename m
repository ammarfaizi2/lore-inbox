Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbTL0EiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 23:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbTL0EiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 23:38:15 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:39655 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265317AbTL0EiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 23:38:08 -0500
Date: Fri, 26 Dec 2003 22:37:23 -0600 (CST)
From: Eric Sandeen <sandeen@sgi.com>
X-X-Sender: sandeen@stout.americas.sgi.com
To: Jerry Haltom <jhaltom@feedbackplusinc.com>
cc: linux-xfs@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: XFS filesystem corruption: 2.6.0. Massive failure. With raid5
In-Reply-To: <1072425031.737.9.camel@osaka>
Message-ID: <Pine.LNX.4.44.0312262229500.31226-100000@stout.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Jerry Haltom wrote:

> This has happened twice now. Massive XFS file system corruption. The
> system is running on a 3ware card in Raid5 config. / is XFS. Cannot
> mount:
> 
> XFS: log has mismatchd uuid - can't recover
> XFS: failed to find log head
> XFS: log mount/recovery/failed

Either a corrupt log, or a misstated external log, it seems.

Ah, on irc you said only the first part of the uuid was off,
that's a bit odd.  Knowing the actual numbers would be very
helpful.  Perhaps the raid swizzled some bits?

> xfs_repair lets me know a lot of stuff, and:
> 
> * ERROR: mismathced uuid in log
> * SB: some long number
> * log: a slightly different long number

Those numbers may be important, without the real output this isn't very
helpful.

> It doesn't work.
> 
> xfs_logprint -t /dev/sda4 produces a lot of illegal type errors and ends
> up with Segmentation fault (uh oh).

Hm, so the log was in very bad shape.  I don't know how it got there;
it may or may not be xfs's fault, but it shouldn't segfault.  If you have
the core file maybe we can take a look.

> I could fix it by forcing hte logs clean, that is what I did the first
> time this happened. However, I lost a lot of files last time, and this
> shouldn't happen. So here it is for you guys. I am hanging out in #xfs
> on irc.freenode.net if anybody wants to check it out.

Sounds like you've already repaired it and whacked the log, so no use
now.  It would also be interesting to know if any I/O or other errors
occurred in the system before the problems.  You might also run without
the nvidia driver* for a while and see if things go better.

-Eric

*info gleaned from irc

