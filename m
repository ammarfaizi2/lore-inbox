Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132074AbRADTsr>; Thu, 4 Jan 2001 14:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132069AbRADTs3>; Thu, 4 Jan 2001 14:48:29 -0500
Received: from fep03.swip.net ([130.244.199.131]:12465 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S132074AbRADTsI>; Thu, 4 Jan 2001 14:48:08 -0500
To: Tim Waugh <twaugh@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random> <20010104142043.N23469@redhat.com>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 04 Jan 2001 20:07:19 +0100
In-Reply-To: Tim Waugh's message of "Thu, 4 Jan 2001 14:20:43 +0000"
Message-ID: <m21yujuoew.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh <twaugh@redhat.com> writes:

> On Thu, Jan 04, 2001 at 02:52:29PM +0100, Andrea Arcangeli wrote:
> 
> > I think lp_check_status.
> 
> Okay.  So what about this patch instead?  If the printer is off-line
> to start with, fall into parport_write anyway (it will just time out
> and return 0).  If LP_ABORT is set, we return -EAGAIN.

If you do this, you should probably also return -EAGAIN if the printer
is out of paper, otherwise I would still lose data when the printer
goes out of paper. Currently it returns -ENOSPC in this situation. I
suppose the different return codes were meant as a way for user space
to be able to know why printing failed, so that it could take
appropriate actions, but maybe this is not used by any programs.

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
