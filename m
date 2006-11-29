Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758768AbWK2EO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768AbWK2EO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbWK2EO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:14:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13532 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1758767AbWK2EO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:14:26 -0500
Subject: [PATCH 3/12] ext3 balloc: fix off-by-one against rsv_end
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Cc: Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281741490.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611281741490.29701@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 20:14:18 -0800
Message-Id: <1164773658.4341.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------------------------------------------------------
Subject: ext2 balloc: fix off-by-one against rsv_end
From: Hugh Dickins <hugh@veritas.com>

rsv_end is the last block within the reservation, so alloc_new_reservation
should accept start_block == rsv_end as success.
------------------------------------------------------
Sync up  a ext2 reservation fix in ext3

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.19-rc5-cmm/fs/ext3/balloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/ext3/balloc.c~ext3-balloc-fix-off-by-one-against-rsv_end fs/ext3/balloc.c
--- linux-2.6.19-rc5/fs/ext3/balloc.c~ext3-balloc-fix-off-by-one-against-rsv_end	2006-11-28 19:36:58.000000000 -0800
+++ linux-2.6.19-rc5-cmm/fs/ext3/balloc.c	2006-11-28 19:36:58.000000000 -0800
@@ -1148,7 +1148,7 @@ retry:
 	 * check if the first free block is within the
 	 * free space we just reserved
 	 */
-	if (start_block >= my_rsv->rsv_start && start_block < my_rsv->rsv_end)
+	if (start_block >= my_rsv->rsv_start && start_block <= my_rsv->rsv_end)
 		return 0;		/* success */
 	/*
 	 * if the first free bit we found is out of the reservable space

_


