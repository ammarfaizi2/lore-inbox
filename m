Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131548AbQIDQyc>; Mon, 4 Sep 2000 12:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131352AbQIDQyW>; Mon, 4 Sep 2000 12:54:22 -0400
Received: from [10.0.0.145] ([10.0.0.145]:49416 "EHLO dukat.scot.redhat.com") by vger.kernel.org with ESMTP id <S131515AbQIDQyN>; Mon, 4 Sep 2000 12:54:13 -0400
Date: Mon, 4 Sep 2000 17:07:39 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Theodore Ts'o" <tytso@valinux.com>
Cc: Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Two VM problems for the 2.4 TODO list
Message-ID: <20000904170739.I12913@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

To be fixed for 2.4:

1) Non-atomic pte updates

   The page aging code and mprotect both modify existing ptes
   non-atomically.  That can stomp on the VM hardware on other CPUs
   setting the dirty bit on mmaped pages when using threads.  2.2 is
   vulnerable too.

2) RSS locking

   swapout holds the page_table_lock while swapping, and adjusts the
   mm->rss while holding that lock.  Other places in the mm are not 
   so careful about holding the lock, so rss (which is not an
   atomic_t) can be corrupted.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
