Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKCO4m>; Fri, 3 Nov 2000 09:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQKCO4c>; Fri, 3 Nov 2000 09:56:32 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:46223 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129145AbQKCO40>;
	Fri, 3 Nov 2000 09:56:26 -0500
Date: Fri, 3 Nov 2000 09:56:15 -0500
Message-Id: <200011031456.JAA21492@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: "David S. Miller" <davem@redhat.com>
CC: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: David S. Miller's message of Fri, 3 Nov 2000 03:33:37 -0800,
	<200011031133.DAA10265@pizda.ninka.net>
Subject: Re: BUG FIX?: mm->rss is modified in some places without holding the  page_table_lock
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 3 Nov 2000 03:33:37 -0800
   From: "David S. Miller" <davem@redhat.com>

      Given that we don't have a 64-bit atomic_t type, what do people
      think of Davej's patch?  (attached, below)

   Broken, in 9 out of 10 places where he adds page_table_lock
   acquisitions, this lock is already held --> instant deadlock.

   This report is complicated by the fact that people were forgetting
   that vmlist_*_{lock,unlock}(mm) was actually just spin_{lock,unlock}
   on mm->page_table_lock.  I fixed that already by removing the dumb
   vmlist locking macros which were causing all of this confusion.

Are you saying that the original bug report may not actually be a
problem?  Is ms->rss actually protected in _all_ of the right places, but
people got confused because of the syntactic sugar?

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
