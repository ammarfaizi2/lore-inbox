Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbQLQS4Z>; Sun, 17 Dec 2000 13:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130894AbQLQS4F>; Sun, 17 Dec 2000 13:56:05 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:26885 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130685AbQLQSz1>; Sun, 17 Dec 2000 13:55:27 -0500
Date: Sun, 17 Dec 2000 19:23:51 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Message-ID: <20001217192351.A18244@pcep-jamie.cern.ch>
In-Reply-To: <20001217034928.A410@ppc.vc.cvut.cz> <Pine.LNX.4.10.10012161859340.23256-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012161859340.23256-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 16, 2000 at 07:09:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ho humm. I'll have to check what the proper fix is. Right now the rule is
> that nobody can _ever_ remove himself from a task queue, although there is
> one bad user that does exactly that, and that means that it should be ok
> to just cache the "next" pointer in run_task_queue(), and make it look
> something like

How about using a sentinel list entry representing the current position
in run_task_queue's loop?

The sentinel's next pointer isn't invalidated by other operations on the
list, provided each operation is protected by tqueue_lock.  Each
iteration step is a matter or removing the sentinel, and inserting it in
the next position.  A task removing itself would then be perfectly ok.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
