Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbQKKQ6g>; Sat, 11 Nov 2000 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131401AbQKKQ61>; Sat, 11 Nov 2000 11:58:27 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:22788 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S131245AbQKKQ6O>; Sat, 11 Nov 2000 11:58:14 -0500
Date: Sat, 11 Nov 2000 12:58:08 -0500
Message-Id: <200011111758.eABHw8O05566@trampoline.thunk.org>
To: yakker@alacritech.com
CC: cr@sap.com, richardj_moore@uk.ibm.com, paulj@itg.ie,
        rothwell@holly-springs.nc.us, linux-kernel@vger.kernel.org
In-Reply-To: <3A0CBD16.5A07D189@alacritech.com> (yakker@alacritech.com)
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
From: tytso@mit.edu
Phone: (781) 391-3464
In-Reply-To: <200011110012.TAA22015@tsx-prime.MIT.EDU> <3A0CBD16.5A07D189@alacritech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 10 Nov 2000 19:29:26 -0800
   From: "Matt D. Robinson" <yakker@alacritech.com>

   We're planning to isolate the write functions as much as possible.
   In the past, we've been bitten by this whole concept of Linux "raw I/O".
   When I was at SGI, we were able to write to a block device directly
   through low-level driver functions that weren't inhibited by any
   locking, and that was after shutting down all processors and any
   other outstanding interrupts.  For Linux, I had given up and stuck
   with the raw I/O interpretation of kiobufs, which is just flat out
   wrong to do for dumping purposes.  Secondly, as Linus said to me a
   few weeks ago, he doesn't trust the current disk drivers to be able
   to reliably dump when a crash occurs.  Don't even ask me to go into
   all the reasons kiobufs are wrong for crash dumping.  Just read
   the code -- it'll be obvious enough.

Oh, yeah, I could have told you that from the beginning.  kiobufs were
never intended to be crash-dump friendly.  :-)   My preference would be
that each block device that was going to be doing crash dumping would
use a special busy-looping driver that's guaranteed never to fail.
(Sort of like how the serial console driver is done; it's separate from
the rest of the driver, and does not depend on interrupts working.)
Hence my comment about putting that separate bit of code in a page which
is write-protected and segregated from everything else....

							- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
