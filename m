Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbQJ1So2>; Sat, 28 Oct 2000 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbQJ1SoQ>; Sat, 28 Oct 2000 14:44:16 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:54276 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S131230AbQJ1SoG>; Sat, 28 Oct 2000 14:44:06 -0400
Date: Sat, 28 Oct 2000 14:44:03 -0400 (EDT)
From: David Eger <eger@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
cc: eger@cc.gatech.edu
Subject: signal handlers not linked properly in do_fork()?
Message-ID: <Pine.LNX.4.21.0010281432490.18772-100000@su13.eastnet.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been looking at the code for do_fork() / copy_sighand() and am
mystified by the following.  It seems that copy_sighand() only sets the
new task's sig member if it is not CLONEd from the parent.  

If the signal_struct is CLONEd from the parent, it increments the parent's
signal_struct's reference count, but does not set the new task's sig
member.  I see nowhere else in do_fork() where sig is set, either.  
What gives?

-David Eger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
