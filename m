Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136050AbRD0Ohq>; Fri, 27 Apr 2001 10:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136058AbRD0Ohg>; Fri, 27 Apr 2001 10:37:36 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:10506
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136050AbRD0OhU>; Fri, 27 Apr 2001 10:37:20 -0400
Date: Fri, 27 Apr 2001 10:36:44 -0400
From: Chris Mason <mason@suse.com>
To: Pavel Machek <pavel@suse.cz>, viro@math.psu.edu,
        kernel list <linux-kernel@vger.kernel.org>,
        jack@atrey.karlin.mff.cuni.cz
cc: torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
Message-ID: <221900000.988382204@tiny>
In-Reply-To: <20010427002853.A11426@bug.ucw.cz>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, April 27, 2001 12:28:54 AM +0200 Pavel Machek <pavel@suse.cz>
wrote:

> Okay, so what about following patch, followed by attempt to debug it?
> [I'd really like to get patch it; killing user's data without good
> reason seems evil to me, and this did quite a lot of damage to my
> $HOME.]

2.4.4-pre8 does have the patch to keep write_inode from syncing a
bad_inode.        In the short term this is the best way to go.

For debugging further, it is probably best to put the warning in when
marking the inode dirty, and randomly returning bad_inodes from read_inode.
I'll give this a try next week.  

My guess is that UPDATE_ATIME is the offending caller, the follow_link path
in open_namei is at least one place that should trigger it.

-chris



