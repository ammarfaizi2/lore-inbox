Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277894AbRJRUGD>; Thu, 18 Oct 2001 16:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277868AbRJRUF5>; Thu, 18 Oct 2001 16:05:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:35590 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S278118AbRJRUEe>; Thu, 18 Oct 2001 16:04:34 -0400
Date: Thu, 18 Oct 2001 16:05:07 -0400
Message-Id: <200110182005.f9IK57506905@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
X-Newsgroups: linux.dev.kernel
In-Reply-To: <200110181632.f9IGW9i29729@schroeder.cs.wisc.edu>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110181632.f9IGW9i29729@schroeder.cs.wisc.edu> nleroy@cs.wisc.edu wrote:
| On Thursday 18 October 2001 11:17, Ville Herva wrote:
| 
| (snip)
| > That's propably beacause it syncs the writes on close().
| >
| > Perhaps you could try the trick Linus suggested in another thread, namely:
| >
| > sleep 1000 < /dev/fd0 &
| >
| > mdir
| > mcopy
| > mdir
| > mcopy
| > <do whatever>
| >
| > kill %1
| >
| > That keeps one (dummy) reference to the floppy device open until you're
| > done using it.
| 
| Perhaps there should be a pair of "mtools" added: mopen and mclose, that do 
| basically this.  That way it could be a "standard" item, documented in man 
| pages, etc., not some secret that only the l-k users know.  Thoughts?

  The change prevents use of stale data, and is a good one. mtools was a
hack from the days when some operating systems didn't speak DOS file
format, and reliability is more important than performance.

  That said, can't you just keep the drive accessed and avoid the
problem?
  sleep 3600 </dev/fd0 &
should do it. Just kill the process when you eject the floppy, or you
will get back the stale data problem.

  I don't believe the detection of a new floppy in the drive is reliable
on all systems or they would have flushed on loading a new diskette. I
seem to remember that not all drives provide the signal, at least back
when I wrote my last floppy driver (DEC Rainbow, about 20 years ago).

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
