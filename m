Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUFBQjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUFBQjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUFBQjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:39:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22408 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263567AbUFBQjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:39:47 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5: Device-mapper dm-io.c
Date: Wed, 2 Jun 2004 11:39:22 -0500
User-Agent: KMail/1.6
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>
References: <20040602154017.GN6302@agk.surrey.redhat.com>
In-Reply-To: <20040602154017.GN6302@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021139.22822.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 10:40 am, Alasdair G Kergon wrote:
> dm-io: device-mapper i/o library for kcopyd

Based on the dm-zero.c discussion, dm-io is going to need a similar patch.

Andrew, are these incremental patches okay, or should we resubmit the whole 
patch for these modules?

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


--- diff/drivers/md/dm-io.c	2004-06-02 11:35:48.000000000 -0500
+++ source/drivers/md/dm-io.c	2004-06-02 11:34:37.000000000 -0500
@@ -341,7 +341,8 @@
 	bio_for_each_segment(bv, bio, i) {
 		char *data = bvec_kmap_irq(bv, &flags);
 		memset(data, 0, bv->bv_len);
-		bvec_kunmap_irq(bv, &flags);
+		flush_dcache_page(bv->bv_page);
+		bvec_kunmap_irq(data, &flags);
 	}
 }
 
