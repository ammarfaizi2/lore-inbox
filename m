Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288651AbSANCMy>; Sun, 13 Jan 2002 21:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288643AbSANCMp>; Sun, 13 Jan 2002 21:12:45 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:49936 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288639AbSANCM1>; Sun, 13 Jan 2002 21:12:27 -0500
Message-ID: <3C423CB9.7BB04345@zip.com.au>
Date: Sun, 13 Jan 2002 18:04:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108142117.F3221@inspiron.school.suse.de> <Pine.LNX.3.96.1020113193700.17441G-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> Finally, I doubt that any of this will address my biggest problem with
> Linux, which is that as memory gets cheap a program doing significant disk
> writing can get buffers VERY full (perhaps a while CD worth) before the
> kernel decides to do the write, at which point the system becomes
> non-responsive for seconds at a time while the disk light comes on and
> stays on. That's another problem, and I did play with some patches this
> weekend without making myself really happy :-( Another topic,
> unfortunately.

/proc/sys/vm/bdflush: Decreasing the kupdate interval from five
seconds, decreasing the nfract and nfract_sync setting in there
should smooth this out.  The -aa patches add start and stop
levels for bdflush as well, which means that bdflush can be the
one who blocks on IO rather than your process.  And it means that
the request queue doesn't get 100% drained as soon as the writer
hits nfract_sync.

All very interesting and it will be fun to play with when it
*finally* gets merged.

But with the current elevator design, disk read latencies will
still be painful.

-
