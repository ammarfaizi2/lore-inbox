Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQLSCEx>; Mon, 18 Dec 2000 21:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQLSCEn>; Mon, 18 Dec 2000 21:04:43 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:62989 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129319AbQLSCEY>; Mon, 18 Dec 2000 21:04:24 -0500
Date: Tue, 19 Dec 2000 02:32:40 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Message-ID: <20001219023240.A20275@pcep-jamie.cern.ch>
In-Reply-To: <20001218215123.A19928@pcep-jamie.cern.ch> <Pine.LNX.4.10.10012181556220.4466-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012181556220.4466-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 18, 2000 at 03:58:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > I wasn't clear.  The sentinel is a local structure on the stack, and
> > only exists while run_task_queue is executing.  Another name for this is
> > "deletion-safe pointer".
> 
> Yes, except run_task_queue removes every object it finds. So two
> concurrent run_task_queues would be bad.

That could work, but forget it.  I've just looked at Andrew's patch and
it's much nicer :-)

If you put a spinlock around the list operations in Andrew's version,
you'd have safe tqueue deletions again (if you felt that was worth
having).  Some tricks and you can make it a different spinlock, but I
doubt that would be a net benefit.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
