Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKCLtE>; Fri, 3 Nov 2000 06:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQKCLsy>; Fri, 3 Nov 2000 06:48:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51873 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129148AbQKCLsl>;
	Fri, 3 Nov 2000 06:48:41 -0500
Date: Fri, 3 Nov 2000 03:33:37 -0800
Message-Id: <200011031133.DAA10265@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tytso@mit.edu
CC: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <200011031139.eA3BdMH19480@trampoline.thunk.org> (tytso@mit.edu)
Subject: Re: BUG FIX?: mm->rss is modified in some places without holding the  page_table_lock
In-Reply-To: <Pine.LNX.4.21.0010130114090.13322-100000@neo.local> <200011031139.eA3BdMH19480@trampoline.thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 3 Nov 2000 06:39:22 -0500
   From: tytso@mit.edu

   Given that we don't have a 64-bit atomic_t type, what do people
   think of Davej's patch?  (attached, below)

Broken, in 9 out of 10 places where he adds page_table_lock
acquisitions, this lock is already held --> instant deadlock.

This report is complicated by the fact that people were forgetting
that vmlist_*_{lock,unlock}(mm) was actually just spin_{lock,unlock}
on mm->page_table_lock.  I fixed that already by removing the dumb
vmlist locking macros which were causing all of this confusion.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
