Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264101AbRFLDDT>; Mon, 11 Jun 2001 23:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264146AbRFLDDJ>; Mon, 11 Jun 2001 23:03:09 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:8447 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264101AbRFLDDD>; Mon, 11 Jun 2001 23:03:03 -0400
Message-ID: <3B258479.472F5C91@uow.edu.au>
Date: Tue, 12 Jun 2001 12:54:49 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: softirq bugs in pre2
In-Reply-To: <20010611193703.S5468@athlon.random> <Pine.LNX.4.31.0106111207350.4452-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 11 Jun 2001, Andrea Arcangeli wrote:
> >
> > Since I mentioned the copy-user latency fixes (even if offtopic with the
> > above) this is the URL for trivial merging:
> 
> The copy-user latency fixes only make sense for out-of-line copies. If
> we're going to have a conditional function call to "schedule()", we do not
> want to inline the dang thing any more - we've just destroyed our register
> set etc anyway.

It's overkill.  This adds many hundreds of scheduling points
to the kernel, of which we need only five.  It makes more
sense to simply open-code those five.

- generic_file_read/write
- read /dev/zero, /dev/mem
- memcpy_to_iovec()

This will by no means provide a low-latency kernel, but it will
fix the most common causes of poor interactivity in normal
use.

Just doing generic_file_read/write would suffice, actually.
