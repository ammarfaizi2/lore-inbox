Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVHCHGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVHCHGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVHCHEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:04:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262144AbVHCHDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:03:49 -0400
Date: Wed, 3 Aug 2005 00:03:03 -0700
From: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, axboe@suse.de
Subject: [10/13] [PATCH] bio_clone fix
Message-ID: <20050803070303.GY7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

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
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

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
