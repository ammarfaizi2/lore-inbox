Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVG1SGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVG1SGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVG1SEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:04:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2525 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261758AbVG1SDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:03:40 -0400
Date: Thu, 28 Jul 2005 11:02:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Fw: [PATCH] bio_clone fix
Message-Id: <20050728110226.4fa98645.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an important fix affecting both 2.6.11 and 2.6.12.  Anyone who is
experiencing data loss issues on MD or DM setups with those kernels should
apply.


Begin forwarded message:

Date: Thu, 28 Jul 2005 10:31:10 -0700
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: bk-commits-head@vger.kernel.org
Subject: [PATCH] bio_clone fix


tree c1d224f0fb4db22e87567e1eea45001a7b11e51f
parent 577a4f8102d54b504cb22eb021b89e957e8df18f
author Andrew Morton <akpm@osdl.org> Thu, 28 Jul 2005 15:07:18 -0700
committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 28 Jul 2005 22:38:59 -0700

[PATCH] bio_clone fix

Fix bug introduced in 2.6.11-rc2: when we clone a BIO we need to copy over the
current index into it as well.

It corrupts data with some MD setups.

See http://bugzilla.kernel.org/show_bug.cgi?id=4946

Huuuuuuuuge thanks to Matthew Stapleton <matthew4196@gmail.com> for doggedly
chasing this one down.

Acked-by: Jens Axboe <axboe@suse.de>
Cc: <linux-raid@vger.kernel.org>
Cc: <dm-devel@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

 fs/bio.c |    1 +
 1 files changed, 1 insertion(+)

diff --git a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -261,6 +261,7 @@ inline void __bio_clone(struct bio *bio,
 	 */
 	bio->bi_vcnt = bio_src->bi_vcnt;
 	bio->bi_size = bio_src->bi_size;
+	bio->bi_idx = bio_src->bi_idx;
 	bio_phys_segments(q, bio);
 	bio_hw_segments(q, bio);
 }
-
To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
