Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWFTLvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWFTLvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWFTLu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:50:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50305 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030229AbWFTLuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:50:52 -0400
Message-Id: <20060620114817.914701000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:10 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chuck Ebbert <76306.1226@compuserve.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Brian Holty <lgeek@frontiernet.net>,
       James Bottomley <jejb@mulgrave.il.steeleye.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/13] scsi_lib.c: properly count the number of pages in scsi_req_map_sg()
Content-Disposition: inline; filename=scsi_lib.c-properly-count-the-number-of-pages-in-scsi_req_map_sg.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: James Bottomley <jejb@mulgrave.il.steeleye.com>

The calculation of nr_pages in scsi_req_map_sg() doesn't account for
the fact that the first page could have an offset that pushes the end
of the buffer onto a new page.

Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/scsi/scsi_lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.21.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.16.21/drivers/scsi/scsi_lib.c
@@ -368,7 +368,7 @@ static int scsi_req_map_sg(struct reques
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;

--
