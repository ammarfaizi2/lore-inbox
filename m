Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277083AbRJVRC6>; Mon, 22 Oct 2001 13:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277089AbRJVRCt>; Mon, 22 Oct 2001 13:02:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27909 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277083AbRJVRCl>; Mon, 22 Oct 2001 13:02:41 -0400
Date: Mon, 22 Oct 2001 13:03:16 -0400
Message-Id: <200110221703.f9MH3Gm15955@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
X-Newsgroups: linux.dev.kernel
In-Reply-To: <9qv1to$ase$1@penguin.transmeta.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9qv1to$ase$1@penguin.transmeta.com> torvalds@transmeta.com wrote:

| Yes.  "tmpfs" will consider the position in the dentry lists to be the
| "offset" in the file, and if you remove files from the directory as you
| do a readdir(), you can get the same file twice (or you can fail to see
| files).
| 
| If somebody has a good suggestion for what could be used as a reasonably
| efficient "cookie" for virtual filesystems like tmpfs, speak up.  In the
| meantime, one way to _mostly_ avoid this should be to give a big buffer
| to readdir(), so that you end up getting all entries in one go (which
| will be protected by the semaphore inside the kernel), rather than
| having to do multiple readdir() calls. 

  Generally "do it all at one go" solutions don't scale, and sooner of
later break on a large case. It's a useful work-around, but likely to
bite. And the semiphore being locked for too long, such as a slow
machine and large list, is prebably not desirable either.

  Short of having an entry in a linked list (if I glanced at the code
correctly) include a synthetic position, I don't see any better
solution. Failing to see files is less of a problem, that seems possible
with any directory structure which reuses entries, but seeing the same
entry twice is not expected behaviour.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.

