Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbQLECEa>; Mon, 4 Dec 2000 21:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbQLECEV>; Mon, 4 Dec 2000 21:04:21 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:30990 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S130252AbQLECEI>;
	Mon, 4 Dec 2000 21:04:08 -0500
Date: Mon, 4 Dec 2000 20:33:39 -0500
Message-Id: <200012050133.eB51XdJ14685@snap.thunk.org>
From: tytso@mit.edu
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: kernel: waitpid(823) failed, -512
In-Reply-To: <20001203233611.A8410@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Sun, Dec 03, 2000 at 11:36:11PM +0100
From: tytso@mit.edu
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 11:36:11PM +0100, Frank van Maarseveen wrote:
> While playing with routing (zebra) and PPP I regularly see this
> message appearing. It always happens when pppd terminates a connection,
> e.g:
> Dec  3 23:09:08 mimas kernel: waitpid(823) failed, -512

This means a system call returned with an error code of -ERESTARTSYS
when a signal wasn't pending; this is a kernel bug.

However, I've looked at the code to sys_wait4 (which implements
waitpid), and I can't see where this might happen.  Just before
end_wait4, it does do something potentially dangerous in that it
leaves retval set to -ERESTARTSYS, but in all of the code paths I can
see, retval gets reset before it exits.  The only thing I can think of
is a compiler bug; what version of gcc are you using?  

Puzzled,

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
