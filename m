Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLSA3c>; Mon, 18 Dec 2000 19:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLSA3W>; Mon, 18 Dec 2000 19:29:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46086 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129391AbQLSA3I>; Mon, 18 Dec 2000 19:29:08 -0500
Date: Mon, 18 Dec 2000 15:58:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
In-Reply-To: <20001218215123.A19928@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.10.10012181556220.4466-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2000, Jamie Lokier wrote:
> > 
> > Nope.
> > 
> > There may be multiple concurrent run_task_queue's executing, so for now
> > I've applied Andrew Morton's patch that most closely gets the old
> > behaviour of having a private list.
> 
> I wasn't clear.  The sentinel is a local structure on the stack, and
> only exists while run_task_queue is executing.  Another name for this is
> "deletion-safe pointer".

Yes, except run_task_queue removes every object it finds. So two
concurrent run_task_queues would be bad.

Sure, we could just make it skip sentinels by adding a magic flag to them,
but that is pretty ugly.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
