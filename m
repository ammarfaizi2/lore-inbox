Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWGHMX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWGHMX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWGHMX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:23:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16292 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964803AbWGHMX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:23:29 -0400
Date: Sat, 8 Jul 2006 14:23:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] fix panic when swsusp signature can't be read
Message-ID: <20060708122314.GA2471@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not panic a machine when swsusp signature can't be read.

From: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 05f70501240c6ad5f852f13c187ee55579ad7bb8
tree 1a8e0dcdc2b19c5fb782e2fb95b39af59f7c353e
parent cb0a153122dfc556ca94d0b5dc0e06813b152539
author <pavel@amd.ucw.cz> Sat, 08 Jul 2006 14:22:36 +0200
committer <pavel@amd.ucw.cz> Sat, 08 Jul 2006 14:22:36 +0200

 kernel/power/swap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 044b8e0..7d5dd97 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -311,8 +311,10 @@ static atomic_t io_done = ATOMIC_INIT(0)
 
 static int end_io(struct bio *bio, unsigned int num, int err)
 {
-	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
-		panic("I/O error reading memory image");
+	if (!test_bit(BIO_UPTODATE, &bio->bi_flags)) {
+		printk(KERN_ERR "I/O error reading swsusp image.\n"); 
+		return -EIO;
+	}
 	atomic_set(&io_done, 0);
 	return 0;
 }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
