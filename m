Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269921AbRHJGO1>; Fri, 10 Aug 2001 02:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269920AbRHJGOQ>; Fri, 10 Aug 2001 02:14:16 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:5134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269916AbRHJGOL>; Fri, 10 Aug 2001 02:14:11 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 9 Aug 2001 23:13:30 -0700
Message-Id: <200108100613.f7A6DU101541@penguin.transmeta.com>
To: elenstev@mesatop.com, linux-kernel@vger.kernel.org
Subject: Re: Some dbench 32 results for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7
Newsgroups: linux.dev.kernel
In-Reply-To: <200108100502.f7A52Ve23324@thor.mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200108100502.f7A52Ve23324@thor.mesatop.com> you write:
>
>I ran dbench 32 for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7.
>Each set of three runs were performed right after a boot,
>running vmstat, and time ./dbench 32 with no pauses in
>between.  The hardware is 384 MB, 450 P3, UP, IDE disk with
>ReiserFS on all partitions. The tests were done from a
>transparent Konsole and KDE2.

Note that dbench performs best when no writeback actually takes place:
the whole benchmark is completely optimizable. As such, the best numbers
for dbench tend to be with (a) kflushd stopped, and (b) the dirty
threshold set high.

Does the numbers change if you do something like

	killall -STOP kupdated
	echo 80 64 64 256 500 6000 90 > /proc/sys/vm/bdflush

to make it less eager to write stuff out? (That just stops the
every-five-second flush, and makes the dirty balancing numbers be 80/90%
instead of the default 30/60%)

In particular, the dirty balancing worked really badly before, and was
just fixed.  I suspect that the bdflush numbers were tuned with the
badly-working case, and they might be a bit too aggressive for dbench
these days.. 

			Linus
