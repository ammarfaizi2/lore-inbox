Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWEVGTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWEVGTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWEVGTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:19:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1747 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932482AbWEVGTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:19:20 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 16:18:55 +1000
Message-Id: <1060522061855.2861@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Don Dupuis" <dondster@gmail.com>
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH 002 of 2] md: Make sure bi_max_vecs is set properly in bio_split
References: <20060522161259.2792.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Else a subsequence bio_clone might make a mess.

Signed-off-by: Neil Brown <neilb@suse.de>
Cc: "Don Dupuis" <dondster@gmail.com>
Cc: Jens Axboe <axboe@suse.de>
### Diffstat output
 ./fs/bio.c |    3 +++
 1 file changed, 3 insertions(+)

diff ./fs/bio.c~current~ ./fs/bio.c
--- ./fs/bio.c~current~	2006-05-22 16:12:46.000000000 +1000
+++ ./fs/bio.c	2006-05-22 16:12:16.000000000 +1000
@@ -1103,6 +1103,9 @@ struct bio_pair *bio_split(struct bio *b
 	bp->bio1.bi_io_vec = &bp->bv1;
 	bp->bio2.bi_io_vec = &bp->bv2;
 
+	bp->bio1.bi_max_vecs = 1;
+	bp->bio2.bi_max_vecs = 1;
+
 	bp->bio1.bi_end_io = bio_pair_end_1;
 	bp->bio2.bi_end_io = bio_pair_end_2;
 
