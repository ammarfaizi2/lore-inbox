Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLRVX0>; Mon, 18 Dec 2000 16:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQLRVXR>; Mon, 18 Dec 2000 16:23:17 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:40204 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129410AbQLRVW7>; Mon, 18 Dec 2000 16:22:59 -0500
Date: Mon, 18 Dec 2000 21:51:23 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Message-ID: <20001218215123.A19928@pcep-jamie.cern.ch>
In-Reply-To: <20001217192351.A18244@pcep-jamie.cern.ch> <Pine.LNX.4.10.10012171200310.25447-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012171200310.25447-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 17, 2000 at 12:02:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 17 Dec 2000, Jamie Lokier wrote:
> > How about using a sentinel list entry representing the current position
> > in run_task_queue's loop?
> 
> Nope.
> 
> There may be multiple concurrent run_task_queue's executing, so for now
> I've applied Andrew Morton's patch that most closely gets the old
> behaviour of having a private list.

I wasn't clear.  The sentinel is a local structure on the stack, and
only exists while run_task_queue is executing.  Another name for this is
"deletion-safe pointer".

It works very nicely with concurrent run_task_queues: each one inserts
its own sentinel and skips over the others.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
