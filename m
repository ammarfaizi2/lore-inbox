Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWI2Cxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWI2Cxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWI2Cxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:53:44 -0400
Received: from ns1.suse.de ([195.135.220.2]:31119 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751392AbWI2Cxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:53:38 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:53:32 +1000
Message-Id: <1060929025332.15323@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 6] md: Add error reporting to superblock write failure
References: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-09-29 11:49:00.000000000 +1000
+++ ./drivers/md/md.c	2006-09-29 11:51:39.000000000 +1000
@@ -389,8 +389,12 @@ static int super_written(struct bio *bio
 	if (bio->bi_size)
 		return 1;
 
-	if (error || !test_bit(BIO_UPTODATE, &bio->bi_flags))
+	if (error || !test_bit(BIO_UPTODATE, &bio->bi_flags)) {
+		printk("md: super_written gets error=%d, uptodate=%d\n",
+		       error, test_bit(BIO_UPTODATE, &bio->bi_flags));
+		WARN_ON(test_bit(BIO_UPTODATE, &bio->bi_flags));
 		md_error(mddev, rdev);
+	}
 
 	if (atomic_dec_and_test(&mddev->pending_writes))
 		wake_up(&mddev->sb_wait);
