Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQKKWyV>; Sat, 11 Nov 2000 17:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129615AbQKKWyM>; Sat, 11 Nov 2000 17:54:12 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:32772 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129100AbQKKWyA>; Sat, 11 Nov 2000 17:54:00 -0500
Date: Sat, 11 Nov 2000 18:54:00 -0500
Message-Id: <200011112354.eABNs0005918@trampoline.thunk.org>
To: dpw@doc.ic.ac.uk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <y7r8zqzqt71.fsf@sytry.doc.ic.ac.uk> (message from David Wragg on
	04 Nov 2000 22:16:18 +0000)
Subject: Re: What protects f_pos?
From: tytso@mit.edu
Phone: (781) 391-3464
In-Reply-To: <y7r8zqzqt71.fsf@sytry.doc.ic.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Wragg <dpw@doc.ic.ac.uk>
   Date: 	04 Nov 2000 22:16:18 +0000

   Since f_pos of struct file is a loff_t, on 32-bit architectures it
   needs a lock to make accesses atomic (or some more sophisticated form
   of protection).  But looking in 2.4.0-test10, there doesn't seem to be
   any such lock.

   The llseek op is called with the Big Kernel Lock, but unlike in 2.2,
   the read and write ops are called without any locks held, and so
   generic_file_{read|write} make unprotected accesses to f_pos (through
   their ppos argument).

This looks like it's a bug to me....  although if you have multiple
threads hitting a file descriptor at the same time, you're pretty much
asking for trouble.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
