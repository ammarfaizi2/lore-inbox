Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131916AbQL2UxB>; Fri, 29 Dec 2000 15:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbQL2Uww>; Fri, 29 Dec 2000 15:52:52 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:36450 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131916AbQL2Uwo>; Fri, 29 Dec 2000 15:52:44 -0500
Date: Fri, 29 Dec 2000 21:21:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: vonbrand@inf.utfsm.cl, Alan.Cox@linux.org, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre3 on sparc64: Hangs on boot, "no cont in shutdown!"??
Message-ID: <20001229212146.B28549@athlon.random>
In-Reply-To: <200012261709.eBQH99D02130@pincoya.inf.utfsm.cl> <200012290559.VAA03384@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012290559.VAA03384@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 28, 2000 at 09:59:55PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 09:59:55PM -0800, David S. Miller wrote:
> 
> "make check_asm" should fix it.

It doesn't work out of the box starting from pre3 because there are a
few fields in the task struct implemented this way:

	struct list_head local_pages; int allocation_order, nr_local_pages;

that is perfectly valid C code but I wasn't aware of the check_asm.sh sed
script assumptions and so I incidentally broke sparc's `make check_asm', sorry.
To make my 2.2.x tree to work on sparc64 I temporarly broken the above line in
two for the time of `make check_asm'. I guess we can go with this patch for
2.2.x instead of doing the right fix ;)

--- 2.2.19pre3aa4/include/linux/sched.h.~1~	Fri Dec 29 20:55:57 2000
+++ 2.2.19pre3aa4/include/linux/sched.h	Fri Dec 29 21:14:32 2000
@@ -329,7 +329,8 @@
 	struct files_struct *files;
 /* memory management info */
 	struct mm_struct *mm;
-	struct list_head local_pages; int allocation_order, nr_local_pages;
+	struct list_head local_pages;
+	int allocation_order, nr_local_pages;
 	int fs_locks;
 
 /* signal handlers */

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
