Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbRGQN7h>; Tue, 17 Jul 2001 09:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266516AbRGQN72>; Tue, 17 Jul 2001 09:59:28 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:61932 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266514AbRGQN7Q>; Tue, 17 Jul 2001 09:59:16 -0400
Message-ID: <3B544516.FF6643E8@uow.edu.au>
Date: Wed, 18 Jul 2001 00:00:54 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
In-Reply-To: <200107171322.HAA245907@ibg.colorado.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Lessem wrote:
> 
> I tried the patch, but the machine came up in a very confused state.
> It couldn't mount proc, and other badness.

hmm..

> I made the patch against
> 2.4.6, because 2.4.7-pre6 doesn't boot at all (I guess I should send
> another message about that problem).

If it's locking up just after printing out the `NET3' banner,
don't bother - known problem with softirqs.  It'll be fixed
in the next kernel.


> >Also (but separately) try enabling the NMI watchdog with
> >the `nmi_watchdog=1' kernel boot parameter.
> 
> This worked, and I recreated the crash:

Wouldn't have a clue.  It isn't spinning on a lock.
It almost looks as if the timer interrupt isn't getting
cleared, and the CPU is never leaving the interrupt.  But
that would cause the timer interrupt count to increase like
crazy and the NMI would never have kicked in.  Nice one.

For interest's sake, could you please try booting with the
`noapic' option, and also send another NMI watchdog trace?

Thanks.
