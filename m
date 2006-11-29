Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758764AbWK2EOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758764AbWK2EOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758763AbWK2EOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:14:01 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:55514 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1758761AbWK2EOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:14:00 -0500
Subject: [PATCH 1/12] ext3 balloc: reset windowsz when full
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
Date: Tue, 28 Nov 2006 20:13:54 -0800
Message-Id: <1164773634.4341.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Port a series ext2 balloc patches from Hugh to ext3/4. The first 6
patches are against ext3, and the rest are aginst ext4.


------------------------------------------------------
Subject: ext2 balloc: reset windowsz when full
From: Hugh Dickins <hugh@veritas.com>

ext2_new_blocks should reset the reservation window size to 0 when squeezing
the last blocks out of an almost full filesystem, so the retry doesn't skip
any groups with less than half that free, reporting ENOSPC too soon.

------------------------------------------------------
Sync up reservation fix from ext2

Signed-off-by: Mingming Cao <cmm@us.ibm.com>
---


---

 linux-2.6.19-rc5-cmm/fs/ext3/balloc.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN fs/ext3/balloc.c~ext3_reset_windowsz_in_full_fs fs/ext3/balloc.c
--- linux-2.6.19-rc5/fs/ext3/balloc.c~ext3_reset_windowsz_in_full_fs	2006-11-28 19:36:41.000000000 -0800
+++ linux-2.6.19-rc5-cmm/fs/ext3/balloc.c	2006-11-28 19:36:41.000000000 -0800
@@ -1552,6 +1552,7 @@ retry_alloc:
 	 */
 	if (my_rsv) {
 		my_rsv = NULL;
+		windowsz = 0;
 		group_no = goal_group;
 		goto retry_alloc;
 	}

_


